import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dextroecom/model/user.dart';
import 'package:dextroecom/screens/cartDetails.dart';
import 'package:dextroecom/screens/homePage.dart';
import 'package:dextroecom/screens/myorders.dart';
import 'package:dextroecom/services/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'myAccount.dart';

class Favorites extends StatefulWidget {
  final darkMode;
  Favorites({this.darkMode});
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  bool liked = false;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
 // FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User currentUser;
  UserModel user;
  UserModel get userModel => user;

  @override
  void initState() {

    loadCurrentUser();
    super.initState();

  }


  void loadCurrentUser() {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {

      this.currentUser = auth.currentUser;
      String userUid=currentUser.uid;
      getUseC(userId:userUid);

    }

  }
  Future<void> getUseC({String userId})async{
    UserService userService = UserService();
    user= await userService.getUserById(userId);


  }

  @override
  Widget build(BuildContext context) {
    CollectionReference favorites = FirebaseFirestore.instance.collection('favorites');
    return Scaffold(
      backgroundColor: widget.darkMode==true?  Color.fromRGBO(18, 18, 18, 1.0):Color.fromRGBO(254,234,230, 1.0),
      appBar: AppBar(
        elevation: 10,
        iconTheme: IconThemeData(color:widget.darkMode?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),),
        backgroundColor: widget.darkMode?  Color.fromRGBO(33, 33, 33, 1.0):Color.fromRGBO(254,219,208, 1.0),
        centerTitle: true,
        title: Text("Mes articles favoris", style: TextStyle(color:widget.darkMode?   Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0), fontFamily: 'MontserratBold', fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: favorites.where("userId", isEqualTo: currentUser.uid).orderBy("upDatedOn", descending: false).snapshots(),

          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children:
                    snapshot.data.docs.map((DocumentSnapshot document) {
                  return Card(
                    color:  widget.darkMode?  Color.fromRGBO(33, 33, 33, 0.65):Color.fromRGBO(254,219,208, 0.78),
                    elevation: 10.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(
                         // document.data()['full_name']
                          "${document.data()['image']}",
                        ),
                        title: Text(document.data()['name'],  style: TextStyle(
                          color: widget.darkMode? Color.fromRGBO(205, 220, 57, 1.0):Color.fromRGBO(0,051,51,1.0),
                          fontWeight: FontWeight.w500,fontFamily: 'MontserratBold',
                        ),),
                        subtitle: Text("FCFA ${document.data()['price']}", style: TextStyle(
                            fontSize: 16,
                            color:  widget.darkMode? Color.fromRGBO(221, 44, 0, 1.0):Color.fromRGBO(0,051,51,1.0),fontFamily: 'MontserratBold',
                            fontWeight: FontWeight.w400),),
                        trailing: IconButton(
                          color: liked ? Colors.grey : Colors.red,
                          icon: liked
                              ? Icon(
                                  Icons.favorite_border,
                                )
                              : Icon(Icons.favorite),
                          onPressed: () async {
                            setState(() {
                              // liked = !liked;
                             FirebaseFirestore.instance
                                  .collection("favorites")
                                  .doc(document.id)
                                  .delete();
                            });
                            Fluttertoast.showToast(
                              backgroundColor:  widget.darkMode?   Color.fromRGBO(3, 218, 213, 1.0):Colors.red,
                                msg: "Supprimé des Favoris",
                                toastLength: Toast.LENGTH_LONG);
                          },
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            } else {
              return Container();
            }
          },
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
                              builder: (context) => MyOrders(darkMode: widget.darkMode)));
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
                              .push(MaterialPageRoute(builder: (context) => MyAccount(darkMode: widget.darkMode)));
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
}
