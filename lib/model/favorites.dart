import 'package:cloud_firestore/cloud_firestore.dart';

class
Favorite{
  static const PRODID="prodId";
  static const USERID = "userId";
  static const UPDATEDON = "upDatedOn";
  static const NAME="name";
  static const IMAGE="image";
  static const PRICE="price";



  String _prodId;
  String _userId;
  Timestamp _upDatedOn;
  String _name;
  String _image;
  String _price;



//   getters
  String get prodId=>_prodId;
  String get userId => _userId;
  Timestamp get upDatedOn=>_upDatedOn;
  String get name=>_name;
  String get image=>_image;
  String get price=>_price;



  Favorite.fromSnapshot(DocumentSnapshot snapshot){
    //_id=snapshot.data()[ID].toString();
    _prodId=snapshot.data()[PRODID];
    _userId = snapshot.data()[USERID];
    _upDatedOn=snapshot.data()[UPDATEDON];
    _name=snapshot.data()[NAME];
    _image=snapshot.data()[IMAGE];
    _price=snapshot.data()[PRICE];
  }

}