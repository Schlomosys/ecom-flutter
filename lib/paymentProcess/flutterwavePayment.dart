import 'dart:io';

import 'package:dextroecom/screens/homePage.dart';
import 'package:dextroecom/services/products.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rave_flutter/rave_flutter.dart';
import 'package:uuid/uuid.dart';

//import 'button_widget.dart';
//import 'witch_widget.dart';
//import 'vendor_widget.dart';



class FlutterRave extends StatefulWidget {
  String email;
  double amount;
  String country;
  String firstName;
  String lastName;
  String userId;
  final darkMode;
  FlutterRave(this.email, this.amount, this.country, this.firstName, this.lastName, this.userId, this.darkMode);

  @override
  FlutterRaveState createState() => FlutterRaveState();
}

class FlutterRaveState extends State<FlutterRave> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var autoValidate = false;
  bool acceptCardPayment = true;
  bool acceptAccountPayment = true;
  bool acceptMpesaPayment = false;
  bool shouldDisplayFee = true;
  bool acceptAchPayments = false;
  bool acceptGhMMPayments = false;
  bool acceptUgMMPayments = false;
  bool acceptMMFrancophonePayments = false;
  bool live = false;
  bool preAuthCharge = false;
  bool addSubAccounts = false;
  List<SubAccount> subAccounts = [];
  String email;
  double amount;
  String publicKey = "YOUR_KEY";
  String encryptionKey = "YOUR_KEY";
  String txRef;
  String orderRef;
  String narration;
  String currency;
  String country;
  String firstName;
  String lastName;
  int cardNumber;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.darkMode==true?  Color.fromRGBO(18, 18, 18, 1.0):Color.fromRGBO(254,234,230, 1.0),
      appBar: AppBar(
        elevation: 10,
        iconTheme: IconThemeData(color:widget.darkMode?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),),
        backgroundColor: widget.darkMode?  Color.fromRGBO(33, 33, 33, 1.0):Color.fromRGBO(254,219,208, 1.0),
        title: Text('Flutterwave Paiement',  style: TextStyle(color: widget.darkMode?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0), fontFamily: 'Pacifico',),),
      ),
      key: scaffoldKey,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              children: <Widget>[
                /*Text("Accept card payments"),
                Switch(
                  value: acceptCardPayment,
                //  title: 'Accept card payments',
                  onChanged: (value) =>
                      setState(() => acceptCardPayment = value),
                ),*/
                /*Text("Accept account payments"),
                Switch(
                  value: acceptAccountPayment,
                  //title: 'Accept account payments',
                  onChanged: (value) =>
                      setState(() => acceptAccountPayment = value),
                ),
                Text("Accept Mpesa payments"),
                Switch(
                  value: acceptMpesaPayment,
                 // title: 'Accept Mpesa payments',
                  onChanged: (value) =>
                      setState(() => acceptMpesaPayment = value),
                ),*/
                /*Text("should display fee"),
                Switch(
                  value: shouldDisplayFee,
                  //title: 'Should Display Fee',
                  onChanged: (value) =>
                      setState(() => shouldDisplayFee = value),
                ),*/
                /*Text("Accept ACH payments"),
                Switch(
                  value: acceptAchPayments,
                 // title: 'Accept ACH payments',
                  onChanged: (value) =>
                      setState(() => acceptAchPayments = value),
                ),
                Text("Accept  Mobile money payments"),
                Switch(
                  value: acceptGhMMPayments,
                 // title: 'Accept GH Mobile money payments',
                  onChanged: (value) =>
                      setState(() => acceptGhMMPayments = value),
                ),

                Text("Accept UG Mobile money payments"),
                Switch(
                  value: acceptUgMMPayments,
                //  title: 'Accept UG Mobile money payments',
                  onChanged: (value) =>
                      setState(() => acceptUgMMPayments = value),
                ),
                Text("Accept Mobile money Francophone Africa payments"),
                Switch(
                  value: acceptMMFrancophonePayments,
                  //title: 'Accept Mobile money Francophone Africa payments',
                  onChanged: (value) =>
                      setState(() => acceptMMFrancophonePayments = value),
                ),
                Text("live"),
                Switch(
                  value: live,
                  //title: 'Live',
                  onChanged: (value) => setState(() => live = value),
                ),
                Text("Pre auth charge"),
                Switch(
                  value: preAuthCharge,
                 // title: 'Pre Auth Charge',
                  onChanged: (value) => setState(() => preAuthCharge = value),
                ),
                Text("Add sub Accounts"),
                Switch(
                    value: addSubAccounts,
                  //  title: 'Add subaccounts',
                    onChanged: onAddAccountsChange),*/
                buildVendorRefs(),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 200.0),
                  child: Form(
                    key: formKey,
                    autovalidate: autoValidate,
                    child: Column(
                      children: <Widget>[
                       /* TextFormField(
                          decoration: InputDecoration(hintText: 'Email'),
                          onSaved: (value) => email = value,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration:
                          InputDecoration(hintText: 'Amount to charge'),
                          onSaved: (value) => amount = double.tryParse(value),
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(hintText: 'txRef'),
                          onSaved: (value) => txRef = value,
                          initialValue:
                          "rave_flutter-${DateTime.now().toString()}",
                          validator: (value) =>
                          value.trim().isEmpty ? 'Field is required' : null,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(hintText: 'orderRef'),
                          onSaved: (value) => orderRef = value,
                          initialValue:
                          "rave_flutter-${DateTime.now().toString()}",
                          validator: (value) =>
                          value.trim().isEmpty ? 'Field is required' : null,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(hintText: 'Narration'),
                          onSaved: (value) => narration = value,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Currency code e.g NGN'),
                          onSaved: (value) => currency = value,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration:
                          InputDecoration(hintText: 'Country code e.g NG'),
                          onSaved: (value) => country = value,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(hintText: 'First name'),
                          onSaved: (value) => firstName = value,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(hintText: 'Last name'),
                          onSaved: (value) => lastName = value,
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(hintText: 'Card Number'),
                          onSaved: (value) => cardNumber = int.tryParse(value),
                        ),*/
                      ],
                    ),
                  ),
                ),
                MaterialButton(

                  //padding:  const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 10.0),
                  minWidth: MediaQuery.of(context).size.width*0.4,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(0.0),
                  ),
                  child: ListTile(
                    title: Center(
                      child: Text(
                        "Procéder au paiement",
                        style: TextStyle(color:widget.darkMode? Color.fromRGBO(254,219,208, 1.0): Colors.white),

                      ),
                    ),
                  ),
                  onPressed: () {
                    validateInputs();
                  },
                  color:widget.darkMode? Color.fromRGBO(234, 128, 252, 0.90):Color.fromRGBO(130,119,23, 1.0),
                ),
                /*MaterialButton(
                  onPressed: () {
                    validateInputs();
                  },
                  color: Colors.amber,
                  minWidth: 200.0,
                  height: 45.0,
                  child: Text(
                    "Procéder au paiement",
                    style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,  color:  widget.darkMode? Color.fromRGBO(255, 61, 0, 1.0):Color.fromRGBO(93,64,55,1.0)),)
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildVendorRefs() {
    if (!addSubAccounts) {
      return SizedBox();
    }

    addSubAccount() async {
     /* var subAccount = await showDialog<SubAccount>(
          context: context, builder: (context) => AddVendorWidget());*/
     /* if (subAccount != null) {
        if (subAccounts == null) subAccounts = [];
        setState(() => subAccounts.add(subAccount));
      }*/
    }

    var buttons = <Widget>[
      MaterialButton(
        onPressed: () {
          addSubAccount();
        },
        color: Color(0xFFB33771),
        minWidth: 200.0,
        height: 45.0,
        child: Text(
          "Add vendor",
          style:
          TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
        ),
      ),

      SizedBox(
        width: 10,
        height: 10,
      ),
      MaterialButton(
        onPressed: () => onAddAccountsChange(false),
        color: Color(0xFFB33771),
        minWidth: 200.0,
        height: 45.0,
        child: Text(
          "clear",
          style:
          TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
        ),
      ),

    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Your current vendor refs are: ${subAccounts.map((a) => '${a.id}(${a.transactionSplitRatio})').join(', ')}',
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Platform.isIOS
                ? Column(
              children: buttons,
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: buttons,
            ),
          )
        ],
      ),
    );
  }

  onAddAccountsChange(bool value) {
    setState(() {
      addSubAccounts = value;
      if (!value) {
        subAccounts.clear();
      }
    });
  }

  void validateInputs() {
    /*var formState = formKey.currentState;
    if (!formState.validate()) {
      setState(() => autoValidate = true);
      return;
    }
    formState.save();*/
    startPayment();
  }

  void startPayment() async {
    var initializer = RavePayInitializer(
        amount: widget.amount,
        publicKey: publicKey,
        encryptionKey: encryptionKey,
        subAccounts: subAccounts.isEmpty ? null : null)
      ..country =
      country = country != null && country.isNotEmpty ? country : "BJ"
      ..currency = currency != null && currency.isNotEmpty ? currency : "XOF"
      ..email =widget.email
      ..fName = widget.firstName
      ..lName = widget.lastName
      ..narration = narration ?? ' Payement de produits'
      ..txRef =  "rave_flutter-${DateTime.now().toString()}"
      ..orderRef = "rave_flutter-${DateTime.now().toString()}"
      ..acceptMpesaPayments = acceptMpesaPayment
      ..acceptAccountPayments = acceptAccountPayment
      ..acceptCardPayments = true
      ..acceptAchPayments = acceptAchPayments
      ..acceptGHMobileMoneyPayments = acceptGhMMPayments
      ..acceptUgMobileMoneyPayments = acceptUgMMPayments
      ..acceptMobileMoneyFrancophoneAfricaPayments = acceptMMFrancophonePayments
      ..displayEmail = true
      ..displayAmount = true
      ..staging = !live
      ..isPreAuth = preAuthCharge
      ..displayFee = true;

    var response = await RavePayManager().prompt(context: context, initializer: initializer);
    if(response.status==RaveStatus.success){
      print("YES SUCESSS!");
    }

   // if(response.message=="successful")
    if(response.status==RaveStatus.success)
      {
        print("oye oye SUCESS");
        ProductsServices pservices=ProductsServices();
        pservices.deleteCart(widget.userId);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false,
        );
        /*PurchaseServices purchaseServices = PurchaseServices();
        var uuid = Uuid();
        int amoun=amount.toInt();
        var purchaseId = uuid.v1();
        purchaseServices.createPurchase(id: purchaseId, amount: amoun, cardId: "85457878", userId: "sdff", productName: "sjdj");*/

     }
    print(response);
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(response?.message)));
  }
}