import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class UserCreation {
  String collection = "users";
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
  void createUser(String name, String firstname, String tel, String isophone,bool isdarkmode, String email, String userUid, String stripeId, String activeCard){
    firestore.collection(collection).doc(userUid).set({
      "userId": userUid,
      "name": name,
      "firstname": firstname,
      "tel":tel,
      "isophone": isophone,
      "isdarkmode":isdarkmode,
      "email":email,
      "stripeId": stripeId,
      "activeCard":activeCard
    });

  }

}
