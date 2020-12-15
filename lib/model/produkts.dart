import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dextroecom/model/colors.dart';
import 'package:dextroecom/model/tailles.dart';

class
Products{
  static const PRODID="prodId";
  static const NAME = "name";
  static const PRICE = "price";
  static const IMAGE = "image";
  static const OLDPRICE = "oldPrice";
  static const PRODESC = "prodDesc";
  static const CREATEDON = "createdOn";
  static const CATEGORY= "categorie";
  static const RANK="rank";
  static const STOCK="stok";
  static const COLOR = "color";
  static const TAILLE = "taille";

  String _prodId;
  String _name;
  String _price;
  String _image;
  String _oldPrice;
  String _prodDesc;
  Timestamp _createdOn;
  String _categorie;
  int _rank;
  int _stok;


//   getters
  String get prodId=>_prodId;
  String get name => _name;
  String get price => _price;
  String get image => _image;
  String get odlPrice => _oldPrice;
  String get prodDesc => _prodDesc;
  Timestamp get createdOn=>_createdOn;
  String get categorie=>_categorie;
  int get rank=>_rank;
  int get stok=>_stok;

  List<ColorModel> color;
  List<TaillesModel> taille;

  Products.fromSnapshot(DocumentSnapshot snapshot){
    _prodId=snapshot.data()[PRODID];
    _name = snapshot.data()[NAME];
    _price = snapshot.data()[PRICE].toString();
    _image = snapshot.data()[IMAGE];
    _oldPrice=snapshot.data()[OLDPRICE].toString();
    _prodDesc=snapshot.data()[PRODESC];
    _createdOn=snapshot.data()[CREATEDON];
    _categorie=snapshot.data()[CATEGORY];
    _rank=snapshot.data()[RANK];
    _stok=snapshot.data()[STOCK];
    color = _convertColor(snapshot.data()[COLOR]?? []);
    taille = _convertTaille(snapshot.data()[TAILLE]?? []);
  }
  List<ColorModel> _convertColor(List color){
    List<ColorModel> convertedColor = [];
    for(Map colorItem in color){
      convertedColor.add(ColorModel.fromMap(colorItem));
    }
    return convertedColor;
  }
  List<TaillesModel> _convertTaille(List taille){
    List<TaillesModel> convertedTaille = [];
    for(Map tailleItem in taille){
      convertedTaille.add(TaillesModel.fromMap(tailleItem ));
    }
    return convertedTaille;
  }

}