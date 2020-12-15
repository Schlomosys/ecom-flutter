import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dextroecom/model/user.dart';
import 'package:flutter/services.dart';

class UserService{
  String collection = "users";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createUser(Map<String, dynamic> values){
    _firestore.collection(collection).doc(values["id"]).set(values);
  }

  void updateDetails(Map<String, dynamic> values){
    _firestore.collection(collection).doc(values["id"]).update(values);
  }

  Future<UserModel> getUserById(String id) =>
      _firestore.collection(collection).doc(id).get().then((doc){
        return UserModel.fromSnapshot(doc);
      });



  Future <void> updateUserLocationDetails(String userId, String etat, String desc, String city, String suburb, String neighbourhood, String road,  String adressdesc, GeoPoint geopoint) async{
    var a;
    var userQuery = await      _firestore.collection(collection).where("userId", isEqualTo: userId).get();
    if(userQuery != null){
      for (int i = 0; i < userQuery.docs.length; i++) {
        //if(prodQuery.doc)
        a = userQuery.docs[i].id;
        //print(a);
      }
      print(a);
    }

    CollectionReference users = FirebaseFirestore.instance.collection(collection);
    DocumentReference user = users.doc(a);
    //var document = _firestore.collection(collection);
    try {
      user.update({"etat": etat} );
      user.update({"desc": desc} );
      user.update({"city": city} );
      user.update({"suburb": suburb} );
      user.update({"neighbourhood": neighbourhood} );
      user.update({"road": road} );
      user.update({"adressdesc": adressdesc} );
      user.update({"geopoint": geopoint} );
      print("successfully updated ");
    } on PlatformException catch (error) {
      print("error updating  $error");

    }


  }


  Future <void> updateDarkmode(String userId, bool isdarkmode) async{

    var a;
    var userQuery = await      _firestore.collection(collection).where("userId", isEqualTo: userId).get();
    if(userQuery != null){
      for (int i = 0; i < userQuery.docs.length; i++) {
        //if(prodQuery.doc)
        a = userQuery.docs[i].id;
        //print(a);
      }
      print(a);
    }

    CollectionReference users = FirebaseFirestore.instance.collection(collection);
    DocumentReference user = users.doc(a);
    //var document = _firestore.collection(collection);
    try {
      user.update({"isdarkmode": isdarkmode} );

      print("successfully updated ");
    } on PlatformException catch (error) {
      print("error updating  $error");

    }


  }
}