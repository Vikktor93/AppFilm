import 'Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
          ],
        ),
        Container(
          width: 350,
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (text) {
                    if (text.length == 0) {
                      return "Este campo correo es requerido";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 50,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: 'Ingrese su Correo',
                    labelText: 'Correo',
                    counterText: '',
                    icon:
                        Icon(Icons.email, size: 25.0, color: Colors.blueGrey[800]),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                  onSaved: (text) => _correo = text,
                ),
                TextFormField(
                  validator: (text) {
                    if (text.length == 0) {
                      return "Este campo contraseña es requerido";
                    //} else if (text.length <= 5) {
                      //return "Su contraseña debe ser al menos de 5 caracteres";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  maxLength: 20,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: 'Ingrese su Contraseña',
                    labelText: 'Contraseña',
                    counterText: '',
                    icon: Icon(Icons.lock, size: 25.0, color: Colors.blueGrey[800]),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                  onSaved: (text) => _contrasena = text,
                ),
                IconButton(
                  onPressed: () {
                    if (_key.currentState.validate()) {
                      _key.currentState.save();
                      _handleSignIn(_correo, _contrasena).then((user){
                        openExplorer();
                      });
                    }
                  },
                  icon: Icon(
                    Icons.arrow_forward,
                    size: 42.0,
                    color: Colors.blue[800],
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(),
        FacebookSignInButton(
          text: "Conectar con Facebook", 
          onPressed: () {
            _handleSignInFB().then((user){
              openExplorer();
            });
          }
        ),
      ],
    );
  }

  Future<FirebaseUser> _handleSignIn(String mail, String pass) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.signInWithEmailAndPassword(email: mail, password:pass);

    return user;
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