
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:dextroecom/model/colors.dart';

import 'package:dextroecom/model/tailles.dart';
import 'package:dextroecom/model/user.dart';

import 'package:dextroecom/screens/homePage.dart';
import 'package:dextroecom/screens/myorders.dart';

import 'package:dextroecom/services/user.dart';
import 'package:dextroecom/ui/FloatIconBouton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:dextroecom/ui/sameTypeProducts.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:dextroecom/services/products.dart';
import 'dart:math';

import 'myAccount.dart';
import 'cartDetails.dart';
class ProductInfosDetails extends StatefulWidget {
  final productDetailsName;
  final productDetailsImage;
  final productDetailsoldPrice;
  final productDetailsPrice;
  final productDetailsDesc;
  final productDetailUserId;
  final productDetailProdId;

  final productCategory;
  final List<ColorModel> colors;
  final List<TaillesModel> tailles;
  final darkMode;



  ProductInfosDetails (
      {this.productDetailsName,
      this.productDetailsImage,
      this.productDetailsoldPrice,
      this.productDetailsPrice,
      this.productDetailsDesc,
        this.productDetailUserId,
      this.productDetailProdId,
        this.productCategory,
        this.colors,
        this.tailles,
        this.darkMode

     // this.productDetailsQty
  });

  @override
  _ProductInfosDetailsState createState() => _ProductInfosDetailsState();
}

class _ProductInfosDetailsState extends State<ProductInfosDetails> {
  bool liked = false;

  String reduction;
  Random random = new Random();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User currentUser;
  UserModel user;

  UserModel get userModel => user;
  //String colors;

  String dropdownValue1 ;
  String dropdownValue2;
  String dropValue2;
  String dropValue1;
  String dropdownValue3 = '1';
  List<String> couleur = <String>[];
  List<String> tailles = <String>[];





  @override
  void initState() {
    _loadCurrentUser();
   checkFAv();
    dropdowns();
    super.initState();

    // _loadCurrentUser();
  }

  //check favorites
  Future<void> checkFAv() async
  {
    ProductsServices productsServices = ProductsServices();
    int favChck= await productsServices.favoritesCheck(widget.productDetailProdId, widget.productDetailUserId);
    if(favChck==0){
      this.liked=false;
      print("pas favoris");
    }else if(favChck==1)
      {
        this.liked=true;
        print("mein favoris");
      }
    setState(() {});
  }

  Future<void> dropdowns() async
  {

    if(widget.colors.isNotEmpty){
      for (var i = 0; i < widget.colors.length; i++) {
        couleur.add(widget.colors[i].color);
      }
      dropValue1=couleur[0];
       setState(() {

      });
    }

    if(widget.tailles.isNotEmpty){
      for (var i = 0; i < widget.tailles.length; i++) {

        tailles.add(widget.tailles[i].taille);
      }
      dropValue2=tailles[0];
      setState(() {

      });
    }
    //setState(() {});
  }

  void _loadCurrentUser() {
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

    setState(() {});

  }
  void _showRatingDialog() {

    showDialog(
      barrierColor:widget.darkMode?Color.fromRGBO(3, 218, 213, 0.25):Color.fromRGBO(68,44,46,0.25) ,
        context: context,
        barrierDismissible: true,
        builder: (context) {

          return RatingDialog(

            icon: const Image(
              image:  AssetImage('images/logoOne.png'),
              width: 100,
              height: 100,
            ),
                //colors: Colors.red), // set your own image/icon widget

            title: "Notez nous!",
            description:
            "Donnez nous votre avis.",
            submitButton: "Envoyer",
            //alternativeButton: "Contact us instead?", // optional
            //positiveComment: "We are so happy to hear :)", // optional
           // negativeComment: "We're sad to hear :(", // optional
            accentColor: Colors.red, // optional
            /*onSubmitPressed: (int rating) {
              print("onSubmitPressed: rating = $rating");
              // TODO: open the app's page on Google Play / Apple App Store
            },*/
            onSubmitPressed: (int rating) async {
              DocumentReference ref =
              await FirebaseFirestore.instance.collection('ranking').add({
                'id':random.nextInt(10000)+5,
                'prodId':widget.productDetailProdId,
                'userId': widget.productDetailUserId,
                'rank': rating,
                'createOn':Timestamp.now(),

                //userId':
              });
              setState(() {

              });
              ProductsServices productsServices = ProductsServices();
              int note= await productsServices.updateRanking(widget.productDetailProdId);
              print("THE NOTE IS $note");
             // UserService userService = UserService();
              productsServices.updateProdDetails(widget.productDetailProdId, note);
             /* productsServices.updateProductDetails({
                "id":widget.productDetailProdId,
                "rank":note,
              });*/
              /*productsServices.updaterDetails({
                "id": userId,
                "activeCard": paymentMethod
              });*/


              Fluttertoast.showToast(
                msg: "Notez nous",
              );
            },
            onAlternativePressed: () {
              print("onAlternativePressed: do something");
              // TODO: maybe you want the user to contact you instead of rating a bad review
            },
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    var oldP=int.parse(widget.productDetailsoldPrice);
    print(oldP.toString());
    var priceR=int.parse(widget.productDetailsPrice);
    int saved=oldP-priceR;
    reduction=saved.toString();
    print(reduction);
    return Scaffold(
      backgroundColor: widget.darkMode==true?  Color.fromRGBO(18, 18, 18, 1.0):Color.fromRGBO(254,234,230, 1.0),
      appBar: AppBar(
        elevation: 10,
        iconTheme: IconThemeData(color:widget.darkMode?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),),
        backgroundColor: widget.darkMode?  Color.fromRGBO(33, 33, 33, 1.0):Color.fromRGBO(254,219,208, 1.0),
        title: Text("KAKUTA SHOP",  style: TextStyle(color: widget.darkMode?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0), fontFamily: 'MontserratBold',),),
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.shopping_cart_sharp, color: widget.darkMode?Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),),
            onPressed: () {

              //List<CartItemModel> panier=user.cart;

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CartProducts(
                    cartProductName: widget.productDetailsName,
                    cartProductImage: widget.productDetailsImage,
                   cartProductPrice: widget.productDetailsPrice,
                    darkMode: widget.darkMode,
                  ),
                    //builder: (context) => CartScreen(panier, user)
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                child: Text(
                  "${widget.productDetailsName}",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'MontserratBold',
                      fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                child: IconButton(
                  color: liked ? Colors.red : Colors.grey,
                  icon: liked
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  onPressed: () async {
                    ProductsServices productsServices = ProductsServices();
                    int favChck= await productsServices.favoritesCheck(widget.productDetailProdId, widget.productDetailUserId);
                    print("FavCheck is equal to $favChck");
                    if(favChck==0){
                      //var prix= int.parse(widget.productDetailsPrice);
                      DocumentReference ref =
                      await FirebaseFirestore.instance.collection('favorites').add({
                        'prodId':widget.productDetailProdId,
                        'name': widget.productDetailsName,
                        'image': widget.productDetailsImage,
                        'price': widget.productDetailsPrice,
                        'userId':widget.productDetailUserId,
                        'upDatedOn':Timestamp.now()
                      });
                      setState(() {
                        liked = !liked;

                      });
                      print(ref.id);
                      Fluttertoast.showToast(
                          msg: "Produit ajouté à vos favoris",
                          toastLength: Toast.LENGTH_LONG);

                    }
                    else if(favChck==1)
                    {
                      setState(() {
                        liked = true;

                      });

                      Fluttertoast.showToast(
                          msg: "Vous avez déja ajouter ce article à vos favoris",
                          toastLength: Toast.LENGTH_LONG);

                    }


                  },
                ),
              ),
            ],
          ),
        Container(
          height: 150.0,
          child: Carousel(
            dotSize: 4.0,
            dotSpacing: 15.0,
            dotColor: Colors.purple,
            indicatorBgPadding: 5.0,
            dotBgColor: Colors.black54.withOpacity(0),
            borderRadius: true,
            radius: Radius.circular(25),
            moveIndicatorFromBottom: 180.0,
            noRadiusForIndicator: true,
            images: [
              Image.network(
                widget.productDetailsImage,
                  fit: BoxFit.cover, width: 1000.0
              ),
            ],
          ),
        ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[

            ],
          ),
          // --------------- Size , Color ,Quantity Buttons------------------
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Couleur",
                        style: TextStyle(
                            color:widget.darkMode?Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MontserratBold',
                            fontSize: 16.0),
                      ),
                      DropdownButton<String>(
                        dropdownColor: widget.darkMode?  Color.fromRGBO(33, 33, 33, 0.78):Color.fromRGBO(254,219,208, 0.90),
                        value: dropValue1,
                        icon: Icon(Icons.keyboard_arrow_down_sharp),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.redAccent),
                        underline: Container(
                          height: 2,
                          color:widget.darkMode?Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropValue1=newValue;
                            dropdownValue1 = newValue;
                          });
                        },
                        items:couleur.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )

                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Taille",
                        style: TextStyle(
                            color: widget.darkMode?Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MontserratBold',
                            fontSize: 16.0),
                      ),
                      DropdownButton<String>(
                        dropdownColor: widget.darkMode?  Color.fromRGBO(33, 33, 33, 0.78):Color.fromRGBO(254,219,208, 0.90),
                        value:dropValue2,
                        icon: Icon(Icons.keyboard_arrow_down_sharp),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.redAccent),
                        underline: Container(
                          height: 2,
                          color:widget.darkMode?Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropValue2=newValue;
                            print(dropValue2);
                            dropdownValue2 = newValue;
                          });
                        },
                        items:tailles.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Quantité",
                        style: TextStyle(
                            color: widget.darkMode?Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'MontserratBold',
                            fontSize: 16.0),
                      ),
                      DropdownButton<String>(
                        dropdownColor:  widget.darkMode?  Color.fromRGBO(33, 33, 33, 0.78):Color.fromRGBO(254,219,208, 0.90),
                        value: dropdownValue3,
                        icon: Icon(Icons.keyboard_arrow_down_sharp),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.redAccent),
                        underline: Container(
                          height: 2,
                          color: widget.darkMode?Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue3 = newValue;
                          });
                        },
                        items:<String>['1', '2', '3', '4'].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ------------------- Price Details ------------------

          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 30.0),
            child: Row(
              children: <Widget>[
                Text("Ancien Prix. :  ", style: TextStyle(
                  //color: Color.fromRGBO(153,204,51, 1.0),
                  color: widget.darkMode? Color.fromRGBO(221, 44, 0, 1.0):Color.fromRGBO(0,051,51,1.0),//Color.fromRGBO(0,051,51,1.0),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  // fontStyle: FontStyle.italic,
                ),),
                Text(
                  " ${widget.productDetailsoldPrice} FCFA",
                  style: TextStyle(
                      color: widget.darkMode? Color.fromRGBO(205, 220, 57, 1.0):Color.fromRGBO(0,051,51,1.0),
                      fontFamily: 'MontserratBold',
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.lineThrough),
                ),


              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 30.0),
            child: Row(
              children: <Widget>[
                Text("Prix :  " , style: TextStyle(
                  //color: Color.fromRGBO(153,204,51, 1.0),
                  color: widget.darkMode? Color.fromRGBO(221, 44, 0, 1.0):Color.fromRGBO(0,051,51,1.0),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  // fontStyle: FontStyle.italic,
                ),),
                Text(
                  "  ${widget.productDetailsPrice} FCFA",
                  style: TextStyle(
                    color: widget.darkMode? Color.fromRGBO(205, 220, 57, 1.0):Color.fromRGBO(0,051,51,1.0),fontFamily: 'MontserratBold',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 30.0),
            child: Row(
              children: <Widget>[
                Text("Ristourne:  ", style: TextStyle(
            //color: Color.fromRGBO(153,204,51, 1.0),
            color: widget.darkMode? Color.fromRGBO(221, 44, 0, 1.0):Color.fromRGBO(0,051,51,1.0),
            fontSize: 16,
            fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
            // fontStyle: FontStyle.italic,
          ),),
                Text(
                  //" FCFA ${widget.productDetailsoldPrice - widget.productDetailsPrice} Inclusive all taxes",
                  "  ${reduction} FCFA TTC",
                  style: TextStyle(
                    color: widget.darkMode? Color.fromRGBO(205, 220, 57, 1.0):Color.fromRGBO(0,051,51,1.0),fontFamily: 'MontserratBold',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          //  ---------------------- Add to Cart Buttons ------------

          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 12.0),
            child:
            Material(
              elevation: 5,
              color: widget.darkMode? Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(207,102,121, 0.60),
              borderRadius: BorderRadius.circular(32.0),
              child: MaterialButton(
                onPressed: () async {

                  var prix= int.parse(widget.productDetailsPrice);
                  DocumentReference ref = await FirebaseFirestore.instance.collection('cartItems').add({
                    'name': widget.productDetailsName,
                    'image': widget.productDetailsImage,
                    'price': prix,
                    'userId':widget.productDetailUserId,
                    'upDatedOn':Timestamp.now(),
                    'color':dropdownValue1,
                    'size':dropdownValue2,
                    'quantity':dropdownValue3,

                  });
                  setState(() {

                  });

                  Fluttertoast.showToast(
                    msg: "Product ajouté à votre panier",
                  );
                },
                minWidth: 200.0,
                height: 45.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FloatingIconButton(

                      icon: Icons.add_shopping_cart_outlined,
                      onPressed: (){

                      },
                      buttonColor: Colors.lightGreen,
                    ),
                    Text(
                      "Ajouter au panier",
                      style: TextStyle(
                        //color: Color.fromRGBO(153,204,51, 1.0),
                        color: widget.darkMode? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MontserratBold',
                        // fontStyle: FontStyle.italic,
                      ),

                    ),

                  ],
                ),
              ),
            ),
          ),
          //============================================== RANKING button
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 12.0),
            child:Material(
              elevation: 5,
              color:widget.darkMode? Color.fromRGBO(187, 134, 252, 0.60):Color.fromRGBO(207,102,121, 0.60),
              borderRadius: BorderRadius.circular(32.0),
              child: MaterialButton(
                onPressed: () async {
                  _showRatingDialog();
                },
                minWidth: 200.0,
                height: 45.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FloatIconBouton(
                      heroTag: "sava@",
                      icon: Icons.star_half,
                      onPressed: (){
                        _showRatingDialog();
                      },
                      buttonColor: Colors.orange,
                    ),
                    Text(
                      "Noter le  produit",
                      style: TextStyle(
                        color: widget.darkMode? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MontserratBold',
                        // fontStyle: FontStyle.italic,
                      ),

                    ),

                  ],
                ),
              ),
            ),

          ),
          // -------Product Infos-----
          Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 20.0, bottom: 20.0),
            child: ListTile(
              title: Text(
                "À propos de ce produit"
                ,
                  style: TextStyle(
                    color:widget.darkMode? Color.fromRGBO(187, 134, 252, 1.0):Color.fromRGBO(55,71,79, 1.0),
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'MontserratBold',
                    // fontStyle: FontStyle.italic,
                  )
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text("${widget.productDetailsDesc}",
                    style: TextStyle(
                      color:widget.darkMode?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      // fontStyle: FontStyle.italic,
                    ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
          Padding(
            child: Text(
              "Produits similaires",
                style: TextStyle(
                  color:widget.darkMode? Color.fromRGBO(221, 44, 0, 1.0):Color.fromRGBO(55,71,79, 1.0),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'MontserratBold',
                  // fontStyle: FontStyle.italic,
                )
            ),
            padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
          ),
          Container(
            height: 400.0,
            padding: const EdgeInsets.only(bottom: 20.0),
            child: SameTypeProducts(widget.productCategory, widget.productDetailUserId, widget.darkMode),
          ),
        ],
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
                              builder: (context) => MyOrders(darkMode: widget.darkMode,)));
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
