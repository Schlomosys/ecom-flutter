import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dextroecom/model/cartItems.dart';

import 'package:dextroecom/model/user.dart';

import 'package:dextroecom/services/products.dart';
import 'package:dextroecom/services/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dextroecom/services/order.dart';

import 'package:flutter/rendering.dart';

class MyOrders extends StatefulWidget {
  final darkMode;
  MyOrders({this.darkMode});
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  CollectionReference ref = FirebaseFirestore.instance.collection("orders");
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  OrderServices _orderServices = OrderServices();
  User currentUser;
  UserModel user;
  UserModel get userModel => user;
  int montantTotal=0;
  List<CartItems> cartItemsList;

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
      print(userUid);
      ProductsServices productsService = ProductsServices();
      getMontantTotal();
      getCartItems();
      getUseC(userId:userUid);
    }

  }
  Future<void>getMontantTotal() async{
    ProductsServices productsService = ProductsServices();
    montantTotal= await productsService.returnMontant(currentUser.uid);
    setState(() {});
    print("montant total= $montantTotal");
  }

  Future<void>getCartItems() async{
    ProductsServices productsService = ProductsServices();
    cartItemsList= await productsService.getCartitems(currentUser.uid);
    setState(() {});
    print("cartImens Ok====(>");
  }

  Future<void> getUseC({String userId})async{


    UserService userService = UserService();

    user= await userService.getUserById(userId);
    setState(() {});
    print(user.id);


  }

  @override
  Widget build(BuildContext context) {
    CollectionReference orders = FirebaseFirestore.instance.collection('orders');
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: widget.darkMode==true?  Color.fromRGBO(18, 18, 18, 1.0):Color.fromRGBO(254,234,230, 1.0),
      appBar: AppBar(
        elevation: 10,
        iconTheme: IconThemeData(color:widget.darkMode?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),),
        backgroundColor: widget.darkMode?  Color.fromRGBO(33, 33, 33, 1.0):Color.fromRGBO(254,219,208, 1.0),
        centerTitle: true,
        title: Text("Mes commandes",   style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,  color:  widget.darkMode? Color.fromRGBO(255, 61, 0, 1.0):Color.fromRGBO(93,64,55,1.0)),),
        actions: <Widget>[

        ],
      ),
      body:
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child:StreamBuilder<QuerySnapshot>(
            stream: orders.where("userId", isEqualTo: currentUser.uid).orderBy("createdAt", descending: false).snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {

                return Column(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {

                    return Container(
                      width: double.infinity,
                      height:250 ,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color:widget.darkMode?  Color.fromRGBO(189, 189, 189, 0.65):Color.fromRGBO(255,229,127, 0.78),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ]),
                      child: Card(
                          color:  widget.darkMode?  Color.fromRGBO(33, 33, 33, 0.65):Color.fromRGBO(254,219,208, 0.78),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                "Commande Numéro: ",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color:widget.darkMode?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),
                                                    fontWeight: FontWeight.w400,
                                                  fontFamily: 'MontserratBold',),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),

                                            Container(
                                              child: Text(
                                              DateTime.fromMillisecondsSinceEpoch(document.data()['createdAt']).toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: widget.darkMode? Color.fromRGBO(205, 220, 57, 1.0):Color.fromRGBO(0,051,51,1.0),fontFamily: 'MontserratBold',
                                                    fontWeight: FontWeight.w400),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              child: Text(
                                                " Pour un total de ${document.data()['total']} FCFA",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color:widget.darkMode?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),fontFamily: 'MontserratBold',
                                                    fontWeight: FontWeight.w400),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                " Libel: ${document.data()['description']}",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: widget.darkMode? Color.fromRGBO(205, 220, 57, 1.0):Color.fromRGBO(0,051,51,1.0),fontFamily: 'MontserratBold',
                                                    fontWeight: FontWeight.w400),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    " Statut: ${document.data()['status']} ",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color:widget.darkMode?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),fontFamily: 'MontserratBold',
                                                        fontWeight: FontWeight.w400),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Container(
                                                  child:  RaisedButton(
                                                    color: document.data()['status']=='complete'? Colors.green: Colors.red,
                                                    onPressed: () {},
                                                   // textColor:document.data()['status']=='complete'? Colors.green: Colors.red,
                                                    padding: const EdgeInsets.all(0.0),
                                                    child: Container(

                                                      padding: const EdgeInsets.all(2.0),
                                                      child:
                                                      const Text('', style: TextStyle(fontSize: 20)),
                                                    ),
                                                  ),
                                                ),



                                              ],
                                            ),
                                            Container(
                                                alignment: Alignment.center,
                                                child:  OutlineButton(
                                                  color: Color(0xFF0D47A1),
                                                  textColor:Colors.red ,
                                                  onPressed: () {
                                                  },
                                                  child: Text('Annuler la commamde'),
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),


                                      ],
                                    ),

                                  ],
                                )
                              ],
                            ),
                          )),
                    );
                  }).toList(),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      )

     // bottomNavigationBar:
    );
  }
}
