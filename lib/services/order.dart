import 'package:dextroecom/model/cartItems.dart';

import 'package:dextroecom/model/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dextroecom/services/user.dart';


class OrderServices{
  String collection = "orders";
  UserService _userServices = UserService();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;


  void createOrder({String userId ,String id,String description,String status ,List<CartItems> cart, int totalPrice}) {
    List<Map> convertedCart = [];

    for(CartItems item in cart){
      convertedCart.add(item.toMap());
    }

    _firestore.collection(collection).doc(id).set({
      "userId": userId,
      "id": id,
      "cart": convertedCart,
      "total": totalPrice,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "description": description,
      "status": status
    });
  }

  Future<List<OrderModel>> getUserOrders({String userId}) async =>
      _firestore
          .collection(collection)
          .where("userId", isEqualTo: userId)
          .get()
          .then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot order in result.docs) {
          orders.add(OrderModel.fromSnapshot(order));
        }
        return orders;
      });




  Future<OrderModel> getOneOrder(String orderUiid) async{
    List<OrderModel> producto=[];
    // var a;
    var prodQuery = await      _firestore.collection(collection).where("id", isEqualTo: orderUiid).get();
    for(DocumentSnapshot item in prodQuery.docs){
      producto.add(OrderModel.fromSnapshot(item));
      print(" PRODUCT OnE length ${producto.length}");
    }

    OrderModel prod=producto[0];
    return prod;


  }


}