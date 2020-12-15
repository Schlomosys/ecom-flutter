

import 'package:dextroecom/userGenesis/userCreation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'homePage.dart';
import 'package:international_phone_input/international_phone_input.dart';

import 'nominatim_location.dart';
class MyRegistrationPage extends StatefulWidget {

  @override
  MyRegistrationState createState() => MyRegistrationState();
}

BuildContext dialogContext;

showAlertDialog(BuildContext context){
  AlertDialog alert=AlertDialog(
    backgroundColor: Color.fromRGBO(254,234,230, 0.80),
    content: new Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 5),child:Text("Chargement" )),
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
class MyRegistrationState extends State<MyRegistrationPage> {
  GlobalKey<FormState> _userLoginFormKey = GlobalKey();


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _prenomController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _postalCodeController = TextEditingController();
  UserCreation userCreation = UserCreation();

  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth;
  User currentUser;

  bool isUserSignedIn = false;
  String email, password, username, prenom;
  bool hidePaswd=true;
  bool hidePassConf=true;
  bool showProgress = false;
  bool loading = false;

  bool isLogedin = false;
  bool logGoogle=false;

  final GlobalKey<ScaffoldState>  _key = GlobalKey<ScaffoldState>();
  bool _autoValidate=false;
  ///Telephone
  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    print(number);
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      visible = true;
      confirmedNumber = internationalizedPhoneNumber;
    });
  }
  ///telephjone

  @override
  void initState() {
    super.initState();
    initApp();
    _loadCurrentUser();
  }

  void initApp() async {
    FirebaseApp defaultApp = await Firebase.initializeApp();
    _auth = FirebaseAuth.instanceFor(app: defaultApp);
    checkIfUserIsSignedIn();
  }

  void checkIfUserIsSignedIn() async {
   // var userSignedIn = await _googleSignIn.isSignedIn();
    bool userSignedIn = await _googleSignIn.isSignedIn();
    if(userSignedIn==true){
      setState(() {
        isUserSignedIn = userSignedIn;
        logGoogle = true;
      });}
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {

      setState(() {
        //isUserSignedIn = userSignedIn;
        isLogedin = true;
      });
    }
    if ( logGoogle || isLogedin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }

  }
  void _loadCurrentUser() {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {

      this.currentUser = auth.currentUser;
    }

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        key: _key,

        backgroundColor: Color.fromRGBO(254,234,230, 1.0),
        body:
        SafeArea(
            child: SingleChildScrollView(
              child:Stack(
                children: <Widget>[
                  Container(

                    height: 410,
                    width: 430,
                    decoration: BoxDecoration(
                      //color:Color.fromRGBO(254,219,208, 0.80),
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

                          height: MediaQuery.of(context).size.height/2.4,
                          width: MediaQuery.of(context).size.width/3,
                          decoration: BoxDecoration(
                            //color:Color.fromRGBO(254,219,208, 0.80),
                            image: DecorationImage(
                              image:
                              AssetImage('images/logoOne.png'),
                            ),),),

                        Container(
                         // color:Color.fromRGBO(254,219,208, 0.80),
                          child: Form(
                            key: _userLoginFormKey,
                            child: Padding(
                              padding: const EdgeInsets.only(top:5.0,bottom:15,left: 10,right: 10),
                              child: Card(
                                color:Color.fromRGBO(238,238,238, 1.0),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text("Créer un compte",style:TextStyle(fontWeight: FontWeight.w800,fontSize: 25, color: Color.fromRGBO(68,44,46, 1.0),),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:15.0,right: 14,left: 14,bottom: 8),
                                      child:
                                      TextFormField(
                                        controller: _nameController,
                                        keyboardType: TextInputType.name,
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          username= value;
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .all(
                                                Radius.circular(15)),
                                          ),
                                            hintText: "Nom",
                                            labelText: "Nom",
                                          hintStyle: TextStyle(fontSize: 15) ,
                                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                        ),
                                        cursorColor:Colors.blue,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(RegExp(r"\d+([\.]\d+)?")),
                                          // .singleLineFormatter,
                                        ],
                                        // ignore: missing_return
                                        validator: (val){
                                          if (val.isEmpty)
                                          {
                                            return "Entrez votre nom s\'il vous plaît";
                                          }
                                        },
                                        onSaved: (val) {
                                          _nameController.text = val;
                                        },
                                        autocorrect: true,



                                      ),),
                                    Padding(
                                      padding: const EdgeInsets.only(top:15.0,right: 14,left: 14,bottom: 8),
                                      child:
                                      TextFormField(
                                        controller: _prenomController,
                                        keyboardType: TextInputType.name,
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          prenom= value;
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .all(
                                                Radius.circular(15)),
                                          ),
                                            hintText: "Prénom",
                                            labelText: "Prénom",
                                          hintStyle: TextStyle(fontSize: 15) ,
                                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                        ),
                                        cursorColor:Colors.red,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(RegExp(r"\d+([\.]\d+)?")),
                                          // .singleLineFormatter,
                                        ],
                                        // ignore: missing_return
                                        validator: (val){
                                          if (val.isEmpty)
                                          {
                                            return "Entrez votre Prénom SVP!";
                                          }
                                        },
                                        onSaved: (val) {
                                          _prenomController.text = val;
                                        },
                                        autocorrect: true,



                                      ),),
                                    Padding(
                                      padding: const EdgeInsets.only(top:15.0,right: 14,left: 14,bottom: 8),
                                      child:
                                      TextFormField(
                                        controller: _emailController,
                                        keyboardType: TextInputType.emailAddress,
                                        textAlign: TextAlign.center,
                                        onChanged: (value) {
                                          email = value;
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius
                                                .all(
                                                Radius.circular(15)),
                                          ),
                                            hintText: "E-mail",
                                            labelText: "E-mail",
                                          hintStyle: TextStyle(fontSize: 15) ,
                                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                        ),
                                        cursorColor:Colors.blue,

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
                                        onSaved: (val) {
                                          _emailController.text = val;
                                        },
                                        autocorrect: true,



                                      ),),
                                    Padding(padding: const EdgeInsets.only(top:15.0,right: 14,left: 14,bottom: 8),
                                    child:
                                    InternationalPhoneInput(
                                      decoration: InputDecoration.collapsed(hintText: '(123) 123-1234'),
                                      onPhoneNumberChange: onPhoneNumberChange,
                                      initialPhoneNumber: phoneNumber,
                                      initialSelection: phoneIsoCode,
                                      enabledCountries: ['+233', '+1', '+229'],
                                      showCountryCodes: false,
                                      showCountryFlags: true,
                                    ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top:5.0,right: 14,left: 14,bottom: 8),
                                      child: TextFormField(
                                          controller: _passwordController,
                                          obscureText: hidePaswd,
                                          textAlign: TextAlign.center,
                                          onChanged: (value) {
                                            password = value; //get value from textField
                                          },
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .all(
                                                    Radius.circular(15)),
                                              ),
                                              prefixIcon: Icon(
                                                Icons.lock,
                                                color: Colors.blueGrey,
                                              ),
                                              suffixIcon: IconButton(
                                                icon: Icon(

                                                  Icons.remove_red_eye,
                                                  color: hidePaswd ? Colors.red: Colors.blueGrey,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    hidePaswd = !hidePaswd;
                                                  });
                                                },
                                              ),
                                              hintText: "Mot de passe",
                                              labelText: "Mot de passe"

                                          ),
                                          cursorColor:Colors.red,
                                          // ignore: missing_return
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "Le champ du mot de passe ne peut pas être vide";
                                            } else if (value.length < 6) {
                                              return "le mot de passe doit contenir au moins 6 caractères";
                                            }
                                            return null;
                                          },
                                          onSaved: (val) {
                                            _passwordController.text = val;
                                          },
                                          autocorrect: true,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.deny(RegExp(r"\d+([\.]\d+)?")),
                                            // .singleLineFormatter,
                                          ]

                                      ),),
                                    Padding(
                                      padding: const EdgeInsets.only(top:5.0,right: 14,left: 14,bottom: 8),
                                      child: TextFormField(
                                          controller: _confirmPasswordController,
                                          obscureText: hidePassConf,
                                          textAlign: TextAlign.center,
                                          onChanged: (value) {
                                            //password = value; //get value from textField
                                          },
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius
                                                    .all(
                                                    Radius.circular(15)),
                                              ),

                                              prefixIcon: Icon(
                                                Icons.lock,
                                                color: Colors.blueGrey,
                                              ),
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  //hidePass ?
                                                  Icons.remove_red_eye,
                                                  color: hidePassConf? Colors.red: Colors.blueGrey,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    hidePassConf = !hidePassConf;
                                                  });
                                                },
                                              ),
                                              hintText: "Confirmer votre Mot de Passe",
                                              labelText: "Confirmer votre Mot de Passe"

                                          ),
                                          cursorColor:Colors.blue,
                                          // ignore: missing_return
                                          validator: (val) {
                                            if (val.length < 6) {
                                              return "Votre Mot de passe doit être d'au moins six caractères";
                                            } else if (val.isEmpty) {
                                              return "Votre Mot de passe ne peut pas être vide ";
                                            } else if (_passwordController.text != val) {
                                              return "Les mots de passe ne correspondent pas";
                                            }
                                            // return "";
                                          },
                                          onSaved: (val) {
                                            _confirmPasswordController.text = val;
                                          },
                                          autocorrect: true,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.deny(RegExp(r"\d+([\.]\d+)?")),
                                            // .singleLineFormatter,
                                          ]

                                      ),),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Material(
                                      elevation: 5,
                                      color: Colors.lightBlue,
                                      borderRadius: BorderRadius.circular(32.0),
                                      child: MaterialButton(
                                        onPressed: () async {
                                          if (_userLoginFormKey.currentState.validate()) {
//    If all data are correct then save data to out variables
                                            _userLoginFormKey.currentState.save();
                                           ;
                                            FirebaseAuth auth = FirebaseAuth.instance;
                                            if (auth.currentUser == null) {

                                              try {
                                                showAlertDialog(context);
                                                final newuser = await _auth.createUserWithEmailAndPassword(
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
                                                         // content: Text(err.message),
                                                          content: Text("Une compte existe déja avec cette adresse email",  style: TextStyle(
                                                            color: Color(0xFF666666),
                                                            fontSize: 17.0,
                                                            fontFamily: "WorkSansMedium",
                                                            fontStyle: FontStyle.normal,
                                                          ),),
                                                          actions: [
                                                            FlatButton(
                                                              child: Text("OK"),
                                                              onPressed: () {
                                                                _nameController.text="";
                                                                _prenomController.text="";
                                                                _emailController.text="";
                                                                _confirmPasswordController.text="";
                                                              _passwordController.text="";
                                                              Navigator.pop(dialogContext);


                                                              Navigator.of(context).pop();
                                                              },
                                                            )
                                                          ],
                                                        );
                                                      });
                                                });
                                                print('');
                                                //print(newuser.toString());
                                                if (newuser != null) {
                                                  // FirebaseAuth auth = FirebaseAuth.instance;
                                                  print("user created");

                                                  try{
                                                    String userId=auth.currentUser.uid;
                                                    String name= _nameController.text.toString();
                                                    String email=_emailController.text;
                                                    String firstname=_prenomController.text;
                                                    userCreation.createUser(name, firstname, phoneNumber, phoneIsoCode, false,  email, userId, "nope", "nope");

                                                  }catch(e){
                                                    print(e.toString());
                                                  }
                                                  showAlertDialog(context);
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => Nominatim(userId: auth.currentUser.uid,)),
                                                        (Route<dynamic> route) => false,
                                                  );
                                                }
                                              } catch (e) {}
                                            }
                                            else if(auth.currentUser !=null){
                                              Fluttertoast.showToast(
                                                  msg: "Vous avez déja un compte",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,

                                                  backgroundColor: Colors.blueAccent,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);

                                            }
                                          } else {

                                            setState(() {
                                              _autoValidate = true;
                                            });
                                          }


                                        },
                                        minWidth: 200.0,
                                        height: 45.0,
                                        child: Text(
                                          "Créer un compte",
                                          style:
                                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 25,),

                                    Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Container(
                                                padding: EdgeInsets.all(50),
                                                child: Align(
                                                    alignment: Alignment.center,
                                                    child: FlatButton(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20),
                                                        ),
                                                        onPressed: () {
                                                          onGoogleSignIn(context);
                                                        },
                                                        color: isUserSignedIn ? Colors.green : Colors.blueAccent,
                                                        child: Padding(
                                                            padding: EdgeInsets.all(10),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Icon(Icons.account_circle, color: Colors.white),
                                                                SizedBox(width: 10),
                                                                Text(
                                                                    isUserSignedIn ? 'You\'re logged in with Google' : 'Signin with Google',
                                                                    style: TextStyle(color: Colors.white))
                                                              ],
                                                            )
                                                        )
                                                    )
                                                ))
                                          ],
                                        )
                                    ),

                                    SizedBox(height: 10,),

                                  ],),
                              ),),
                          ),),
                      ],),
                  ),


                ],
              ),

            ))
    );
  }

  Future<User> _handleSignIn() async {
    User usera;
    bool userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      isUserSignedIn = userSignedIn;
    });

    if (isUserSignedIn) {
      usera = _auth.currentUser;
    }
    else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      usera = (await _auth.signInWithCredential(credential)).user;
      userSignedIn = await _googleSignIn.isSignedIn();
      setState(() {
        isUserSignedIn = userSignedIn;
        try{
          String userId=usera.uid;
          String name= usera.displayName;
          String email=usera.email;
          String firstname=_prenomController.text;
          userCreation.createUser(name,firstname, phoneNumber, phoneIsoCode, false,  email, userId, "nope", "nope");

        }catch(e){
          print(e.toString());
        }
      });
    }

    return usera;
  }

  void onGoogleSignIn(BuildContext context) async {

    showAlertDialog(context);
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


}