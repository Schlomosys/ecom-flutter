import 'package:cloud_firestore/cloud_firestore.dart';

class
CartItems {


  static const IMAGE = "image";
  static const NAME = "name";
  static const PRICE = "price";
  static const UPDATEDON = "upDatedOn";
  static const USERID = "userId";
  static const COLOR = "color";
  static const SIZE = "size";
  static const QUANTITY = "quantity";


  String _image;
  String _name;
  Timestamp _upDatedOn;
  int _price;
  String _userId;
  String _color;
  String _size;
  String _quantity;


//   getters
  String get image => _image;

  String get name => _name;

  Timestamp get upDatedOn => _upDatedOn;

  int get price => _price;

  String get userId => _userId;

  String get color => _color;

  String get size => _size;

  String get quantity => _quantity;


  CartItems.fromSnapshot(DocumentSnapshot snapshot){
    _image = snapshot.data()[IMAGE];
    _name = snapshot.data()[NAME];
    _userId = snapshot.data()[USERID];
    _upDatedOn = snapshot.data()[UPDATEDON];
    _price = snapshot.data()[PRICE];
    _color = snapshot.data()[COLOR];
    _size = snapshot.data()[SIZE];
    _quantity = snapshot.data()[QUANTITY];
  }

  CartItems.fromMap(Map data){
    _image = data[IMAGE];
    _name = data[NAME];
    _userId = data[USERID];
    _upDatedOn = data[UPDATEDON];
    _price = data[PRICE];
    _color = data[COLOR];
    _size = data[SIZE];
    _quantity = data[QUANTITY];
  }


  Map toMap() => {
 IMAGE: _image,
 NAME :_name,
  USERID:_userId,
 UPDATEDON: _upDatedOn,
  PRICE:_price,
  COLOR :_color,
 SIZE:_size,
 QUANTITY:_quantity,
  };




























}