import 'package:cloud_firestore/cloud_firestore.dart';

//import 'cartItems.dart';


class OrderModel {
  static const ID = "id";
  static const DESCRIPTION = "description";
  static const CART = "cart";
  static const USER_ID = "userId";
  static const TOTAL = "total";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";

  String _id;
  String _description;
  String _userId;
  String _status;
  int _createdAt;
  int _total;

//  getters
  String get id => _id;

  String get description => _description;

  String get userId => _userId;

  String get status => _status;

  int get total => _total;

  int get createdAt => _createdAt;

  // public variable
  List cart;

  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _description = snapshot.data()[DESCRIPTION];
    _total = snapshot.data()[TOTAL];
    _status = snapshot.data()[STATUS];
    _userId = snapshot.data()[USER_ID];
    _createdAt = snapshot.data()[CREATED_AT];
    cart = snapshot.data()[CART];
  }
}

/*class OrderModel {
  static const ID = "id";
  static const DESCRIPTION = "description";
 // static const CART = "cart";
  static const USER_ID = "userId";
  static const TOTAL = "total";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";
  static const CART = "cart";


  String _id;
  String _description;
  String _userId;
  String _status;
  int _createdAt;
  int _total;*/

//  getters
 /* String get id => _id;

  String get description => _description;

  String get userId => _userId;

  String get status => _status;

  int get total => _total;

  int get createdAt => _createdAt;
  List<CartItems> cart;*/

  // public variable
 // List cart;

 /* OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _description = snapshot.data()[DESCRIPTION];
    _total = snapshot.data()[TOTAL];
    _status = snapshot.data()[STATUS];
    _userId = snapshot.data()[USER_ID];
    _createdAt = snapshot.data()[CREATED_AT];
    cart = _convertCartItems(snapshot.data()[CART]?? []);*/
    //cart = snapshot.data()[CART];
 /* }

  List<CartItems> _convertCartItems(List cart){
    List<CartItems> convertedCart = [];
    for(Map cartItem in cart){
      convertedCart.add(CartItems.fromMap(cartItem));
    }
    return convertedCart;
  }

}*/