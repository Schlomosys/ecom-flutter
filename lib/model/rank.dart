import 'package:cloud_firestore/cloud_firestore.dart';

class
Rank{
  static const PRODID="prodId";
  static const USERID = "userId";
  static const CREATEON = "createOn";
  static const RANK="rank";
  static const ID="id";

  String _prodId;
  String _userId;
  Timestamp _createOn;
  int _rank;
  String _id;



//   getters
  String get prodId=>_prodId;
  String get userId => _userId;
  Timestamp get createOn=>_createOn;
  int get rank=>_rank;
  String get id=>_id;



  Rank.fromSnapshot(DocumentSnapshot snapshot){
    _id=snapshot.data()[ID].toString();
    _prodId=snapshot.data()[PRODID];
    _userId = snapshot.data()[USERID];
    _createOn=snapshot.data()[CREATEON];
    _rank=snapshot.data()[RANK];
  }

}