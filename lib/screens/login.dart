import 'dart:async';


import 'package:dextroecom/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';

import 'package:dextroecom/splash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'nominatim_location.dart';
class MyLoginPage extends StatefulWidget {
  @override
  LoginPageWidgetState createState() => LoginPageWidgetState();
}
BuildContext dialogContext;

showAlertDialog(BuildContext context){
  AlertDialog alert=AlertDialog(
    backgroundColor: Color.fromRGBO(254,234,230, 0.80),
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 5),child:Text("Chargement")),
      ],),
  );
  showDialog(barrierDismissible: false,
    context:context,
    builder:(BuildContext context){
      dialogContext = context;
      return alert;
    },
  );
}


class LoginPageWidgetState extends State<MyLoginPage> {
  GlobalKey<FormState> _userLoginFormKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth;
  User currentUser;

  bool isUserSignedIn = false;
  String email, password;
  bool hidePaswd=true;
  bool showProgress = false;
  bool loading = false;

  bool isLogedin = false;
  bool logGoogle=false;

  bool isNewUser ;
  Timer _timer;
  double _progress;
  bool isEmailInv=false;
  bool _autoValidate = false;
  bool _success;

  @override
  void initState() {
    initApp();

    super.initState();

  }

  void initApp() async {
    FirebaseApp defaultApp = await Firebase.initializeApp();
    _auth = FirebaseAuth.instanceFor(app: defaultApp);
    checkIfUserIsSignedIn();
  }

  void checkIfUserIsSignedIn() async {
    var userSignedIn = await _googleSignIn.isSignedIn();
   if(userSignedIn !=null){
    setState(() {
      isUserSignedIn = userSignedIn;
      logGoogle = true;
    });}
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {

      setState(() {

        this.currentUser = auth.currentUser;
        isLogedin = true;
      });
    }
    if ( logGoogle==false || isLogedin) {

     try{
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Splash()),
            (Route<dynamic> route) => false,
      );}
      catch( e)
        {

        }
    }

  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
        key: _key,
        backgroundColor: Color.fromRGBO(254,234,230, 1.0),
        //backgroundColor:Color.fromRGBO(255,249,196, 1.0),

        body:
        SafeArea(
            child: SingleChildScrollView(
                child:Stack(
                  children: <Widget>[
                    Container(
                      height: 410,
                      width: 430,
                      //height: 110,
                      //width: MediaQuery.of(context).size.width/3,
                      decoration: BoxDecoration(

                        image: DecorationImage(
                          image: AssetImage('images/background2.png'),
                          fit: BoxFit.contain,
                        ),
                      ),

                    ),
                    SingleChildScrollView(

                      child:Column(

                        children: <Widget>[
                          Container(


                            //height: MediaQuery.of(context).size.height/2.4,
                           // width: MediaQuery.of(context).size.width/3,
                            height: MediaQuery.of(context).size.height/2.4,
                            width: MediaQuery.of(context).size.width/3,
                            decoration: BoxDecoration(
                             // color: Color.fromRGBO(254,219,208, 1.0),

                              image: DecorationImage(
                                image:
                                AssetImage('images/logoOne.png'),
                              ),),),

                          Container(
                           // color:Color.fromRGBO(254,219,208, 0.80),
                            child:AutofillGroup(
                            child: Form(
                              key: _userLoginFormKey,
                              //autovalidateMode: AutovalidateMode.always,
                              child: Padding(
                                padding: const EdgeInsets.only(top:5.0,bottom:15,left: 10,right: 10),
                                child: Card(
                                  color:Color.fromRGBO(238,238,238, 1.0),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text("S'identifier",style:TextStyle(fontWeight: FontWeight.w800,fontSize: 25, color: Color.fromRGBO(68,44,46, 1.0),),),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                                        child: Material(
                                          borderRadius: BorderRadius.circular(10.0),
                                          color: Colors.grey.withOpacity(0.3),
                                          elevation: 0.0,
                                          child: Padding(
                                        padding: const EdgeInsets.only(top:15.0,right: 14,left: 14,bottom: 8),
                                        child:
                                        TextFormField(
                                        controller: _emailController,
                                        autofillHints: [AutofillHints.email],
                                        keyboardType: TextInputType.emailAddress,
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          email = value;
                                        },
                                        decoration: InputDecoration(


                                          prefixIcon: Icon(
                                            Icons.mail_rounded,
                                            color: Colors.blueGrey,
                                          ),
                                          hintText: "E-mail",
                                          labelText: "E-mail",
                                          hintStyle: TextStyle(fontSize: 15,color: Color.fromRGBO(68,44,46, 1.0)) ,
                                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                           // errorText: isEmailInv ? "" : "*Le champ de l' e-mail ne peut pas être vide"
                                        ),
                                            cursorColor:Colors.blue,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.deny(RegExp(r"\d+([\.]\d+)?")),
                                              // .singleLineFormatter,
                                            ],
                                        // ignore: missing_return
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              Pattern pattern =
                                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                              RegExp regex = new RegExp(pattern);
                                              if (!regex.hasMatch(value))
                                                return 'Entrez une adresse email valide SVP';
                                              else
                                                return null;
                                            }
                                          },
                                        onSaved: (value) {
                                          _emailController.text = value;
                                        },
                                        autocorrect: true,



                                      ),),
                              ),
                            ),


                                      Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                                        child: Material(
                                          borderRadius: BorderRadius.circular(10.0),
                                          color: Colors.grey.withOpacity(0.3),
                                          elevation: 0.0,
                                          child: Padding(
                                        padding: const EdgeInsets.only(top:15.0,right: 14,left: 14,bottom: 8),
                                        child:  TextFormField(
                                            controller: _passwordController,
                                            autofillHints: [AutofillHints.password],
                                            obscureText: hidePaswd,
                                          textAlign: TextAlign.center,
                                          onChanged: (value) {
                                            password = value;
                                          },
                                            decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.lock,
                                                  color: Colors.blueGrey,
                                                ),
                                                suffixIcon: IconButton(
                                                  icon: Icon(

                                                    Icons.remove_red_eye,
                                                    color: hidePaswd? Colors.red: Colors.blueGrey,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      hidePaswd = !hidePaswd;
                                                    });
                                                  },
                                                ),
                                                hintText: "Mot de Passe",
                                                labelText: "Mot de Passe"

                                            ),
                                            cursorColor:Colors.black,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "Le champ du mot de passe ne peut pas être vide";
                                              } else if (value.length < 6) {
                                                return "le mot de passe doit contenir au moins 6 caractères";
                                              }
                                              return null;
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter.deny(RegExp(r"\d+([\.]\d+)?")),
                                                 // .singleLineFormatter,
                                            ]

                                        ),),
                              ),
                            ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Material(
                                        elevation: 5,
                                        color: Colors.lightBlue,
                                        borderRadius: BorderRadius.circular(32.0),
                                        child: MaterialButton(
                                          onPressed:() async {
                                            if (_userLoginFormKey.currentState.validate()) {

                                              _userLoginFormKey.currentState.save();

                                              try {
                                                showAlertDialog(context);
                                                final  newUser = await _auth.signInWithEmailAndPassword(
                                                    email: email, password: password).catchError((err) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          backgroundColor: Color.fromRGBO(254,234,230, 0.80),
                                                          title: Text("Une erreur inattendue s'est produite" ,style: TextStyle(
                                                              color: Colors.red,
                                                          fontSize: 19.0,
                                                          fontFamily: "Montserrat",
                                                          fontStyle: FontStyle.normal,
                                                        ),),
                                                          //content: Text(err.message),
                                                          content: Text("Nom d'utilisateur ou mot de passe erroné",  style: TextStyle(
                                                            color: Color.fromRGBO(68,44,46, 1.0),
                                                            fontSize: 17.0,
                                                            fontFamily: "WorkSansMedium",
                                                            fontStyle: FontStyle.normal,
                                                          ),),
                                                          actions: [
                                                            FlatButton(

                                                              child: Text("OK", style: TextStyle(
                                                            color: Color(0xFF666666),
                                                        fontSize: 17.0,
                                                        fontFamily: "WorkSansMedium",
                                                        fontStyle: FontStyle.normal,
                                                        )),
                                                              onPressed: () {
                                                                _emailController.text="";
                                                                _passwordController.text="";
                                                                Navigator.pop(dialogContext);


                                                                Navigator.of(context).pop();
                                                              },
                                                            )
                                                          ],
                                                        );
                                                      });
                                                });
                                                print('odho');

                                                if (newUser != null) {
                                                  print('user find');
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => Splash()),
                                                        (Route<dynamic> route) => false,
                                                  );
                                                }
                                                else {
                                                  setState(() {
                                                    _success = false;
                                                  });
                                                }
                                              } on FirebaseAuthException catch  (e) {
                                                if (e.code == 'invalid-email') {
                                                  // Do something :D
                                                }
                                              }
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: "Nom d'utilisateur ou mot de passe erroné",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,

                                                  backgroundColor: Colors.blueAccent,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);

                                              setState(() {
                                                _autoValidate = true;
                                              });
                                            }


                                          } ,
                                          minWidth: 200.0,
                                          height: 45.0,
                                          child: Text(
                                            "Connexion",
                                            style:
                                            TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20,),

                                      Container(
                                        child: Text(
                                          "Nouveau sur Kakuta Shop? ",
                                          style: TextStyle(
                                            color: Color.fromRGBO(68,44,46, 1.0),
                                            fontSize: 14.0,
                                            fontFamily: "WorkSansMedium",
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 25,),

                                      Material(
                                        elevation: 5,
                                        color: Colors.amberAccent,
                                        borderRadius: BorderRadius.circular(32.0),
                                        child: MaterialButton(
                                            onPressed: () {


                                              Navigator.of(context).push(
                                                  MaterialPageRoute(builder: (context) => MyRegistrationPage()));
                                            },
                                          minWidth: 200.0,
                                          height: 45.0,
                                          child: Text(
                                            "Ouvrir un compte",
                                            style:
                                            TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                                          ),
                                        ),
                                      ),


                                      SizedBox(height: 25,),

                                      Padding(
                                        padding: EdgeInsets.only(top: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                gradient: new LinearGradient(
                                                    colors: [
                                                      Colors.black12,
                                                      Colors.black54,
                                                    ],
                                                    begin: const FractionalOffset(0.0, 0.0),
                                                    end: const FractionalOffset(1.0, 1.0),
                                                    stops: [0.0, 1.0],
                                                    tileMode: TileMode.clamp),
                                              ),
                                              width: 100.0,
                                              height: 1.0,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                              child: Text(
                                                "Ou",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(68,44,46, 1.0),
                                                    fontSize: 14.0,
                                                    fontFamily: "WorkSansMedium"),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                gradient: new LinearGradient(
                                                    colors: [
                                                      Colors.black54,
                                                      Colors.black12,
                                                    ],
                                                    begin: const FractionalOffset(0.0, 0.0),
                                                    end: const FractionalOffset(1.0, 1.0),
                                                    stops: [0.0, 1.0],
                                                    tileMode: TileMode.clamp),
                                              ),
                                              width: 100.0,
                                              height: 1.0,
                                            ),
                                          ],
                                        ),
                                      ),

                                      Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text( isUserSignedIn ? 'Vous êtes connecté avec Google' : 'Connectez vous avec Google',),
                                              SizedBox(height: 10,),
                                              Container(
                                                padding: EdgeInsets.all(0),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child:  GoogleButton( onPressed: () {
                                                      onGoogleSignIn(context);
                                                    },),
                                                  )),

                                            ],
                                          )
                                      ),


                                    ],),
                                ),),
                            )


                          ),//autofil

                            ),
                        ],),
                    ),


                  ],
                ),

    ))
    );
  }

  Future<User> _handleSignIn() async {
    User user;
    bool userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      isUserSignedIn = userSignedIn;
    });

    if (isUserSignedIn) {
      user = _auth.currentUser;
    }
    else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      user = (await _auth.signInWithCredential(credential)).user;
      userSignedIn = await _googleSignIn.isSignedIn();
      setState(() {
        isUserSignedIn = userSignedIn;
      });
    }

    return user;
  }

  void onGoogleSignIn(BuildContext context) async {
    User user = await _handleSignIn();
    _showLoadingIndicator();
    var userSignedIn = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
             // WelcomeUserWidget(user, _googleSignIn)),
        Nominatim()),
    );

    setState(() {
      isUserSignedIn = userSignedIn == null ? true : false;
    });
  }

  _showLoadingIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                width: 20.0,
              ),
              Text("Chargement!")
            ],
          ),
        );
      },
    );
  }
}

class WelcomeUserWidget extends StatelessWidget {

  GoogleSignIn _googleSignIn;
  User _user;

  WelcomeUserWidget(User user, GoogleSignIn signIn) {
    _user = user;
    _googleSignIn = signIn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: Container(
            color: Colors.white,
            padding: EdgeInsets.all(50),
            child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                        child: Image.network(
                            _user.photoURL,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover
                        )
                    ),
                    SizedBox(height: 20),
                    Text('Welcome,', textAlign: TextAlign.center),
                    Text(_user.displayName, textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                    SizedBox(height: 20),
                    FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {
                          _googleSignIn.signOut();
                          Navigator.pop(context, false);
                        },
                        color: Colors.redAccent,
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.exit_to_app, color: Colors.white),
                                SizedBox(width: 10),
                                Text('Log out of Google', style: TextStyle(color: Colors.white))
                              ],
                            )
                        )
                    )
                  ],
                )
            )
        )
    );
  }
}