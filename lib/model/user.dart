import 'package:cloud_firestore/cloud_firestore.dart';

//import 'cart_item.dart';

class UserModel{
  static const NAME = 'name';
  static const FIRSTNAME = 'firstname';
  static const TEL="tel";
  static const ISOPHONE="isophone";
  static const EMAIL = 'email';
  static const ID = 'userId';
  static const STRIPE_ID = 'stripeId';
  static const ACTIVE_CARD = 'activeCard';
  //static const CART = "cart";
  //static const LAT="lat";
  //static const LNG="lng";
  static const ETAT="etat";
  static const DESC="desc";
  static const CITY="city";
  static const SUBURB="suburb";
  static const NEIGHBOURHOOD="neighbourhood";
  static const ROAD="road";
  static const ADRESSDESC="adressdesc";
  static const GEOPOINT="geopoint";
  static const ISDARKMODE="isdarkmode";


  String _name;
  String _firstname;
  String _tel;
  String _isophone;
  String _email;
  String _id;
  String _stripeId;
  String _activeCard;
  int _priceSum = 0;
  //String _lat;
  //String _lng;
  String _etat;
  String _desc;
  String _city;
  String _suburb;
  String _neighbourhood;
  String _road;
  String _adressdesc;
  bool _isdarkmode;






//  GETTERS
  String get name => _name;
  String get firstname=>_firstname;
  String get tel=>_tel;
  String get isophone=>_isophone;
  String get email => _email;
  String get id => _id;
  String get stripeId => _stripeId;
  String get activeCard => _activeCard;
  bool get isdarkmode=>_isdarkmode;

  //String get lat=>_lat;
  //String get lng=>_lng;
  String get etat=> _etat;
  String get desc=> _desc;
  String get city=>_city;
  String get suburb=>_suburb;
  String get neighbourhood=>_neighbourhood;
  String get road=>_road;
  String get adressdesc=>_adressdesc;

  // public variables
  GeoPoint geopoint;
  //List<CartItemModel> cart;
 // int totalCartPrice;


  UserModel.fromSnapshot(DocumentSnapshot snap){
    _email = snap.data()[EMAIL];
    _name = snap.data()[NAME];
    _firstname=snap.data()[FIRSTNAME];
    _tel=snap.data()[TEL];
    _isophone=snap.data()[ISOPHONE];
    _isdarkmode=snap.data()[ISDARKMODE];
    _id = snap.data()[ID];
    _stripeId = snap[STRIPE_ID] ?? null;
    //_lat= snap[LAT] ?? null;
    //_lng=snap[LNG] ?? null;
    _etat=snap[ETAT] ?? null;
    _desc=snap[DESC] ?? null;
    _city=snap[CITY] ?? null;
    _suburb=snap[SUBURB] ?? null;
    _neighbourhood=snap[NEIGHBOURHOOD] ?? null;
    _road=snap[ROAD] ?? null;
    _adressdesc=snap[ADRESSDESC] ?? null;
    geopoint=snap[GEOPOINT]?? null;

    _activeCard = snap[ACTIVE_CARD] ?? null;

  }



}