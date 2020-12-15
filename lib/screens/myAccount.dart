import 'package:dextroecom/screens/cartDetails.dart';
import 'package:dextroecom/screens/homePage.dart';
import 'package:dextroecom/screens/login.dart';
import 'package:dextroecom/screens/myorders.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';


class MyAccount extends StatefulWidget {
  final darkMode;
  MyAccount({this.darkMode});
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User currentUser;
  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  void _loadCurrentUser() {

    User user = firebaseAuth.currentUser;

    setState(() {
      // call setState to rebuild the view
      this.currentUser = user;
    });
  }

  String userName() {
    if (currentUser != null) {
      if (currentUser.displayName == null) {
        return currentUser.email.replaceAll('@gmail.com', '');
      }
      return currentUser.displayName;
    } else {
      return "";
    }
  }

  String email() {
    if (currentUser != null) {
      return currentUser.email;
    } else {
      return "Guest User";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.darkMode==true?  Color.fromRGBO(18, 18, 18, 1.0):Color.fromRGBO(254,234,230, 1.0),
      appBar: AppBar(
        elevation: 10,
        iconTheme: IconThemeData(color:widget.darkMode?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),),
        backgroundColor: widget.darkMode?  Color.fromRGBO(33, 33, 33, 1.0):Color.fromRGBO(254,219,208, 1.0),
        centerTitle: true,

        title: Text("Mon compte", style: TextStyle(color:widget.darkMode?   Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0), fontFamily: 'MontserratBold', fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 20.0),
              child: Text(
                "Infos utilisateur",
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: widget.darkMode?Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0), fontFamily: 'MontserratBold',),
                textAlign:TextAlign.center,
              ),
            ),
            Card(
              color: widget.darkMode?  Color.fromRGBO(33, 33, 33, 0.78):Color.fromRGBO(254,219,208, 0.90),
              elevation: 5.0,
              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: Text(
                      "Nom:",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: widget.darkMode?Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0), fontFamily: "BigShouldersStencilText"),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: Text(
                      "${userName()}",
                      style: TextStyle(
                          color: widget.darkMode? Color.fromRGBO(205, 220, 57, 1.0):Color.fromRGBO(0,051,51,1.0),
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: Text(
                      "Email:",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: widget.darkMode?Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0), fontFamily: "BigShouldersStencilText"),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                    child: Text(
                      "${email()}",
                      style: TextStyle(
                          color: widget.darkMode? Color.fromRGBO(205, 220, 57, 1.0):Color.fromRGBO(0,051,51,1.0),
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ),
                  Divider(
                    height: 2.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width*0.4,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(0.0),
              ),
              child: ListTile(
                title: Center(
                  child: Text(
                    "Déconnexion",
                    style: TextStyle(color:widget.darkMode? Color.fromRGBO(254,219,208, 1.0): Colors.white),

                  ),
                ),
              ),
              onPressed: () {
                firebaseAuth.signOut().then((user) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MyLoginPage()));
                }).catchError((e) => print(e.toString()));
              },
              color:widget.darkMode? Color.fromRGBO(234, 128, 252, 0.90):Color.fromRGBO(130,119,23, 1.0),
            ),
          ],
        ),
      ),
        bottomNavigationBar: Container(
          height: 66.0,
          child: BottomAppBar(
            color:widget.darkMode? Color.fromRGBO(58, 58, 58, 0.90):Color.fromRGBO(254,219,208, 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                    children:<Widget>[
                      IconButton(
                        icon: Icon(Icons.home, color:widget.darkMode? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0)),
                        onPressed: () {

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                                (Route<dynamic> route) => false,
                          );
                        },
                      ),
                      Text(
                        'Accueil',
                        style: TextStyle(color:widget.darkMode? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0)),
                      ),
                    ]
                ),
                Column(
                    children:<Widget>[
                      IconButton(
                        icon: Icon(Icons.shopping_bag_sharp, color:widget.darkMode? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0)),
                        onPressed: () {

                          setState(() {});
                          Navigator.of(context).push(MaterialPageRoute(//CartScreen
                              builder: (context) => MyOrders()));
                        },
                      ),
                      Text(
                        'Mes commandes',
                        style: TextStyle(color:widget.darkMode? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0)),
                      ),
                    ]
                ),
                Column(
                    children:<Widget>[
                      IconButton(
                        icon: Icon(Icons.shopping_cart, color:widget.darkMode? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0)),
                        onPressed: () {

                          setState(() {});
                          Navigator.of(context).push(MaterialPageRoute(//CartScreen
                              builder: (context) => CartProducts(darkMode: widget.darkMode,)));
                        },
                      ),
                      Text(
                        'Mon Panier',
                        style: TextStyle(color:widget.darkMode? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0)),
                      ),
                    ]
                ),
                Column(
                    children:<Widget>[
                      IconButton(
                        icon: Icon(Icons.account_box,color:widget.darkMode? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0)),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => MyAccount()));
                        },
                      ),
                      Text(
                        'Mon compte',
                        style: TextStyle(color:widget.darkMode? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0)),
                      ),
                    ]
                ),




              ],
            ),
          ),
        )
    );
  }

  TextStyle _btnStyle() {
    return TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    );
  }
}
