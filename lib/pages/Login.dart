import 'Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget{
  
  LoginState createState(){
    return LoginState();
  }

}

class LoginState extends State<Login>{

  GlobalKey<FormState> _key = GlobalKey();

  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  String _correo;
  String _contrasena;
  String mensaje = '';

  bool _logueado = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:  _logueado ? Home() : loginForm(),
//      body: loginForm(),
    );
  }

  Widget loginForm() {

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/img/film1.png'),
      ),
    );

    final correo = TextFormField(
      validator: (text) {
        if (text.length == 0) {
            return "Este campo correo es requerido";
          }
            return null;
        },
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: '',
      maxLength: 50,
      onSaved: (text) =>
                      _correo = text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        hintText: 'Ingrese su Correo',
        //labelText: 'Correo',
        icon: Icon(Icons.email, size: 25.0, color: Colors.redAccent[400]),    
      ),  
    );


    final contrasena = TextFormField(
      validator: (text) {
                    if (text.length == 0) {
                      return "Contraseña es requerida";
                    //} else if (text.length <= 5) {
                      //return "Su contraseña debe ser al menos de 5 caracteres";
                    }
                    return null;
        },
      keyboardType: TextInputType.text,
      autofocus: false,
      initialValue: '',
      obscureText: true,
      onSaved: (text) =>
                      _contrasena = text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        hintText: 'Ingrese su Contraseña',
        //labelText: 'Contraseña',
        icon: Icon(Icons.lock, size: 25.0, color: Colors.redAccent[400]),
      ),
    );


    final loginButton = IconButton(
                   onPressed: () => _signIn(context)
                              .then((FirebaseUser user) => print(user))
                              .catchError((e) => print(e)),
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 40.0,
                    color: Colors.redAccent[400],
                  ),
                );
   
    final facebook = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      FlatButton(    
          onPressed: () {
            _handleSignInFB().then((user){
              openExplorer();
            });
          },
          child: Image.asset('assets/img/fb.png', height: 60.0, width: 60.0,)
      ),

      FlatButton(    
          onPressed: () {
            _handleSignInFB().then((user){
              openExplorer();
            });
          },
          child: Image.asset('assets/img/tw.png', height: 50.0, width: 50.0,)
      ),
      
    ],
  );
    
    
    
    
    
    
    

    final forgotLabel = FlatButton(
      child: Text(
        'No tienes cuenta? Registrate',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            correo,
            SizedBox(height: 8.0),
            contrasena,
            SizedBox(height: 24.0),
            loginButton,
            SizedBox(height: 15.0),
             Divider(),
             SizedBox(height: 8.0),
            facebook,
            forgotLabel
          ],
        ),
      ),
    );
}
    
   GoogleSignIn _googlSignIn = new GoogleSignIn();
   Future<FirebaseUser> _signIn(BuildContext context) async {
    final GoogleSignInAccount googleUser = await _googlSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =await googleUser.authentication;
    //final FirebaseAuth _auth = FirebaseAuth.instance;
    //final FirebaseUser user = await _auth.signInWithEmailAndPassword(email: mail, password:pass);

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new Home(),
      ),
    );
  }

  Future<FirebaseUser> _handleSignInFB() async {
    final facebookLogin = FacebookLogin();
    final FacebookLoginResult result = await facebookLogin.logInWithReadPermissions(['email']);
    final AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);

    FirebaseUser user = await _fAuth.signInWithCredential(credential);
    return user;

  }


  openExplorer(){
    setState((){
      _logueado = true;
    });
  }

}





