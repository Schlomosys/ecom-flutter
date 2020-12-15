import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dextroecom/model/cartItems.dart';
import 'package:dextroecom/model/favorites.dart';
import 'package:dextroecom/model/produkts.dart';
import 'package:dextroecom/model/rank.dart';
import 'package:flutter/services.dart';

class ProductsServices{
  String collection = "products";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;



  Future<List<Products>> getProducts()async =>
      _firestore.collection(collection).get().then((result){
        List<Products> productsList = [];
        print("=== Product RESULT SIZE ${result.docs.length}");
        for(DocumentSnapshot item in result.docs){
          productsList.add(Products.fromSnapshot(item));
          print(" PRODUCTS length ${productsList.length}");
        }
        return productsList;
      });



  Future<List<Products>> getRecentsProducts() async {
    List<Products> productsRecentList = [];
      var result = await
    _firestore.collection(collection)

        .orderBy('createdOn', descending: false)
        .limit(25)
        .get();
      for(DocumentSnapshot item in result.docs){
        productsRecentList.add(Products.fromSnapshot(item));
        print(" okkk RECENTS PRODUCTS length ${productsRecentList.length}");
      }


      return productsRecentList;
  }


  Future<List<Products>> getSimilarProducts(String categorie) async {
    List<Products> productsRecentList = [];
    var result = await
    _firestore.collection(collection)
        .where("categorie", isEqualTo: categorie)
        //.orderBy('createdOn', descending: false)
        .limit(25)
        .get();
    for(DocumentSnapshot item in result.docs){
      productsRecentList.add(Products.fromSnapshot(item));
      print(" okkk RECENTS PRODUCTS length ${productsRecentList.length}");
    }
    return productsRecentList;
  }

  // ignore: missing_return
  Future<List<String>> getProductsImages() async {
    List<String> productsImg = [];
    var result = await
    _firestore.collection(collection)
    //.where("address.country", isEqualTo: "USA")
        .orderBy('createdOn', descending: false)
        .limit(5)
        .get();
    for(DocumentSnapshot item in result.docs){
      productsImg.add(Products.fromSnapshot(item).image);
      print(" okkk Vedette Products Images ${productsImg.length}");
    }
    return productsImg;
  }


  Future <int> updateRanking(String prodId) async
  {
    int rank=0;
    int noteEtoil=1;
    //print(prodId);

    List<int> note = [];
    var resulta = await _firestore.collection("ranking")
        .where("prodId", isEqualTo: prodId)
        .get();
    //print(resulta.size.toString());
    for(DocumentSnapshot item in resulta.docs){
      note.add(Rank.fromSnapshot(item).rank);
      rank=rank+(Rank.fromSnapshot(item).rank);}
      print(" RAnk ${rank}");
      print(" nombre de votes ${note.length}");

    int nbVotes=note.length;
    double rnk=(rank/nbVotes);
    int vte=rnk.toInt();
    noteEtoil=vte;
    print(" RAnk ${noteEtoil}");
    return noteEtoil;
    //updateProdDetails(prodId, noteEtoil);
  }
  void updateProductDetails(Map<String, dynamic> values){
    _firestore.collection(collection).doc(values["id"]).update(values);
  }
  Future<void> updaterProdDetails(Map<String, dynamic> values)async{
    await  _firestore.collection(collection).doc(values["id"]).update(values);
  }
  Future <void> updateProdDetails(String prodId, int note) async{
    /*_firestore.collection(collection).doc(prodId)
        .update({"rank": note}).then((_) {
    print("success update!");
    });*/
    var a;
    var prodQuery = await      _firestore.collection(collection).where("prodId", isEqualTo: prodId).get();
    if(prodQuery != null){
      for (int i = 0; i < prodQuery.docs.length; i++) {
        //if(prodQuery.doc)
        a = prodQuery.docs[i].id;
        //print(a);
      }
      print(a);
    }

    CollectionReference products = FirebaseFirestore.instance.collection(collection);
    DocumentReference product = products.doc(a);
   //var document = _firestore.collection(collection);
    try {
      product.update({"rank": note} );
      print("successfully updated ");
    } on PlatformException catch (error) {
      print("error updating  $error");

    }


  }


  Future <int> favoritesCheck(String prodId, String userID) async
  {
    int fav=0;
    var favCheckQuery = await      _firestore.collection("favorites").where("prodId", isEqualTo: prodId).get();
    if(favCheckQuery !=null){

      for(DocumentSnapshot item in favCheckQuery.docs){
        // productsImg.add(Products.fromSnapshot(item).image);
        if(Favorite.fromSnapshot(item).userId==userID){
          print('deja fav');
          fav=1;
          print(fav.toString());
          return fav;
        }
        // print(" okkk Vedette Products Images ${productsImg.length}");
      }

    }
    return fav;

    //print(prodId);

    //updateProdDetails(prodId, noteEtoil);
  }
  Future<Products> getOneProduct(String prodId) async{
    List<Products> producto=[];
   // var a;
    var prodQuery = await      _firestore.collection(collection).where("prodId", isEqualTo: prodId).get();
    for(DocumentSnapshot item in prodQuery.docs){
      producto.add(Products.fromSnapshot(item));
      print(" PRODUCT OnE length ${producto.length}");
    }

    Products prod=producto[0];
    return prod;


  }


  Future <int> returnMontant(String userID) async
  {
    int montantTT=0;
    //List<int> totalMont=[];

    var montantCheckQuery = await      _firestore.collection("cartItems").where("userId", isEqualTo: userID).get();
    if(montantCheckQuery !=null){

      for(DocumentSnapshot item in montantCheckQuery.docs){

        var Qte=int.parse(CartItems.fromSnapshot(item).quantity);
        montantTT=montantTT+(CartItems.fromSnapshot(item).price*Qte);
      }

    }
    return montantTT ;

  }

  Future<List<CartItems>> getCartitems(String userID) async {
    List<CartItems> CartItemsList = [];
    var result = await      _firestore.collection("cartItems").where("userId", isEqualTo: userID).get();
    for(DocumentSnapshot item in result.docs){
      CartItemsList.add(CartItems.fromSnapshot(item));
      print(" okkk RECENTS PRODUCTS length ${CartItemsList.length}");
    }
    return CartItemsList ;
  }

  Future <void> deleteCart(String userID) async
  {

    var cart = await      _firestore.collection("cartItems").where("userId", isEqualTo: userID).get();
    if(cart !=null){

      for(DocumentSnapshot item in cart.docs){
        item.reference.delete();
      }
      print("panier detruit");

    }

  }
}