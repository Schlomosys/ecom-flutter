import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dextroecom/model/cartItems.dart';

import 'package:dextroecom/model/user.dart';
import 'package:dextroecom/paymentProcess/paymentStripe.dart';

import 'package:dextroecom/services/products.dart';
import 'package:dextroecom/services/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:dextroecom/services/order.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/rendering.dart';

class CartProducts extends StatefulWidget {
  final cartProductName;
  final cartProductImage;
  final cartProductPrice;
  final darkMode;

  CartProducts({
    this.cartProductName,
    this.cartProductImage,
    this.cartProductPrice,
    this.darkMode
  });

  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  CollectionReference ref = FirebaseFirestore.instance.collection("cartItems");
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
    CollectionReference cartItems = FirebaseFirestore.instance.collection('cartItems');
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: widget.darkMode==true?  Color.fromRGBO(18, 18, 18, 1.0):Color.fromRGBO(254,234,230, 1.0),
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color:widget.darkMode?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),),
        backgroundColor: widget.darkMode?  Color.fromRGBO(33, 33, 33, 1.0):Color.fromRGBO(254,219,208, 1.0),
        centerTitle: true,
        title: Text("Votre  panier",  style: TextStyle(color:widget.darkMode?   Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0), fontFamily: 'MontserratBold', fontSize: 18),),
        actions: <Widget>[

        ],
      ),
      body:
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child:StreamBuilder<QuerySnapshot>(
            stream: cartItems.where("userId", isEqualTo: currentUser.uid).orderBy("upDatedOn", descending: false).snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {

                return Column(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {

                    return Container(
                      width: double.infinity,
                      height:140 ,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Color(0xFFfae3e2).withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ]),
                      child: Card(
                          color:  widget.darkMode?  Color.fromRGBO(33, 33, 33, 0.78):Color.fromRGBO(254,219,208, 0.90),
                          elevation: 8,
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
                                Container(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Center(
                                        child: Image.network(
                                          "${document.data()['image']}",
                                          width: 100,
                                          height: 100,
                                        )),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                "${document.data()['name']}",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color:  widget.darkMode? Color.fromRGBO(221, 44, 0, 1.0):Color.fromRGBO(0,051,51,1.0),fontFamily: 'MontserratBold',
                                                    fontWeight: FontWeight.w400),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              child: Text(
                                                "Prix: ${document.data()['price']} FCFA",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: widget.darkMode? Color.fromRGBO(221, 44, 0, 1.0):Color.fromRGBO(0,051,51,1.0),fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w400),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                " Couleur: ${document.data()['color']}",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color:  widget.darkMode? Color.fromRGBO(221, 44, 0, 1.0):Color.fromRGBO(0,051,51,1.0),fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w400),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                " Taille: ${document.data()['size']} ",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: widget.darkMode? Color.fromRGBO(221, 44, 0, 1.0):Color.fromRGBO(0,051,51,1.0),fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w400),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                " Qté: ${document.data()['quantity']}",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: widget.darkMode? Color.fromRGBO(221, 44, 0, 1.0):Color.fromRGBO(0,051,51,1.0),fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.w400),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Container(
                                            alignment: Alignment.centerRight,
                                            child:  IconButton(
                                              icon: Icon(
                                                Icons.delete_outline,
                                                color: widget.darkMode?   Color.fromRGBO(3, 218, 213, 1.0):Colors.red,
                                              ),  onPressed: () async {
                                              setState(() {
                                                FirebaseFirestore.instance.collection("cartItems").doc(document.id).delete();

                                                montantTotal=montantTotal-document.data()['price'];
                                              });
                                              Fluttertoast.showToast(
                                                  msg: "Produit supprimé du panier",
                                                  toastLength: Toast.LENGTH_LONG);
                                            },
                                            ))
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
     ,
      bottomNavigationBar: Container(
        height: 95,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Total: ",
                      style: TextStyle(
                          color:  widget.darkMode? Color.fromRGBO(221, 44, 0, 1.0):Color.fromRGBO(0,051,51,1.0),fontFamily: 'Montserrat',
                          fontSize: 22,
                          fontWeight: FontWeight.w400)),
                  TextSpan(
                      text:"${montantTotal} FCFA",
                      //text: " \$${montantTotal / 100}",
                      style: TextStyle(
                          color:widget.darkMode?Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),fontFamily: 'MontserratBold',
                          fontSize: 22,
                          fontWeight: FontWeight.normal)),
                ]),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.amber),
                child: FlatButton(
                    onPressed: () {
                      if (montantTotal == 0) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                //this right here
                                child: Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Votre panier est vide',
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                        return;
                      }
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              backgroundColor: widget.darkMode?  Color.fromRGBO(33, 33, 33, 0.78):Color.fromRGBO(254,219,208, 0.90),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0)),

                              child: Container(
                                height:205,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Vous serez débiter ${montantTotal} FCFA à la livraison!',
                                      style: TextStyle(
                                          color:  widget.darkMode? Color.fromRGBO(200, 157, 0, 1.0):Color.fromRGBO(0,051,51,1.0),fontFamily: 'MontserratBold',
                                          fontSize: 22,
                                          fontWeight: FontWeight.w400,

                                        ),

                                          textAlign: TextAlign.center
                                      ),
                                      SizedBox(
                                        width: 320.0,
                                        child: RaisedButton(
                                          onPressed: () async {
                                            var uuid = Uuid();
                                            String id = uuid.v4();
                                            OrderServices _orderServices = OrderServices();
                                            _orderServices.createOrder(
                                                userId: currentUser.uid,
                                                id: id,
                                                description: "Achat de produit",
                                                status: "complete",
                                                totalPrice: montantTotal,
                                                cart: cartItemsList);

                                            double mountant=montantTotal.toDouble();

                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(builder: (context) => PaymentStripe(currentUser.email,mountant,"BJ",user.name,"Lovealy", currentUser.uid, widget.darkMode)),
                                                  (Route<dynamic> route) => false,
                                            );
                                          },
                                          child: Text(
                                            "Accepter",
                                            style:
                                            TextStyle(color: Colors.white, fontFamily: 'MontserratBold'),
                                          ),
                                          color: Colors.green,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 320.0,
                                        //height: 100,
                                        child: RaisedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Reffuser",
                                              style: TextStyle(
                                                  color: Colors.white, fontFamily: 'MontserratBold'),
                                            ),
                                            color: Colors.red),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child:
                  Text(
                  "Passer au payement",
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'MontserratBold',   fontWeight: FontWeight.normal, fontSize:20),
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }



}
