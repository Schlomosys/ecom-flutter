import 'package:dextroecom/screens/cartDetails.dart';
import 'package:dextroecom/screens/homePage.dart';
import 'package:dextroecom/screens/myorders.dart';

import 'package:flutter/material.dart';
//import 'package:dextroecom/services/payment-service.dart';
import 'package:progress_dialog/progress_dialog.dart';

//import 'PaypalAppel.dart';
//import 'existing-cards.dart';
import 'flutterwavePayment.dart';
import 'hoverPayment.dart';
import '../screens/myAccount.dart';

class PaymentStripe extends StatefulWidget {
  String email;
  double amount;
  String country;
  String firstName;
  String lastName;
  String userId;
  final darkMode;

  //PaymentStripe({Key key}) : super(key: key);
  PaymentStripe(this.email, this.amount, this.country, this.firstName, this.lastName, this.userId, this.darkMode);
  @override
  PaymentStripeState createState() => PaymentStripeState();
}

class PaymentStripeState extends State<PaymentStripe> {

  onItemPress(BuildContext context, int index) async {
    switch(index) {
      case 0:
        //payViaNewCard(context);
        break;
      case 1:
       /* Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ExistingCardsPage()));*/
        //Navigator.pushNamed(context, '/existing-cards');
        break;
      case 2:
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => FlutterRave(widget.email, widget.amount, widget.country, widget.firstName, widget.lastName, widget.userId, widget.darkMode)));
      //Navigator.pushNamed(context, '/existing-cards');
      break;
     case 3:
        /*Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => makePayment()));*/
        //Navigator.pushNamed(context, '/existing-cards');
        break;
      /*case 4:
      Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HoverPayment()));
        //Navigator.pushNamed(context, '/existing-cards');
        break;*/
    }
  }

  /*payViaNewCard(BuildContext context) async {
    ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(
        message: 'Patientez s\'il vous plaît...'
    );
    await dialog.show();
    var response = await StripeService.payWithNewCard(
        amount: '15000',
        currency: 'USD'
    );
    await dialog.hide();
    Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          duration: new Duration(milliseconds: response.success == true ? 1200 : 3000),
        )
    );
  }*/

  @override
  void initState() {
    super.initState();
   // StripeService.init();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: widget.darkMode==true?  Color.fromRGBO(18, 18, 18, 1.0):Color.fromRGBO(254,234,230, 1.0),
      appBar: AppBar(
        elevation: 10,
        iconTheme: IconThemeData(color:widget.darkMode?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),),
        centerTitle: true,
        backgroundColor: widget.darkMode?  Color.fromRGBO(33, 33, 33, 1.0):Color.fromRGBO(254,219,208, 1.0),
        title: Text('Paiement',  style: TextStyle(color: widget.darkMode?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0), fontFamily: 'MontserratBold',),),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.separated(
            itemBuilder: (context, index) {
              Icon icon;
              Text text;

              switch(index) {
                case 0:
                  icon = Icon(Icons.add_circle, color: widget.darkMode? Color.fromRGBO(205, 220, 57, 1.0):Color.fromRGBO(0,051,51,1.0),);
                  text = Text('Payer via une nouvelle carte bancaire',  style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold,  color:  widget.darkMode? Color.fromRGBO(255, 61, 0, 1.0):Color.fromRGBO(93,64,55,1.0)),);
                  break;
                case 1:
                  icon = Icon(Icons.credit_card, color: widget.darkMode? Color.fromRGBO(205, 220, 57, 1.0):Color.fromRGBO(0,051,51,1.0),);
                  text = Text('Payer via une carte existante',   style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold,  color:  widget.darkMode? Color.fromRGBO(255, 61, 0, 1.0):Color.fromRGBO(93,64,55,1.0)),);
                  break;
                case 2:
                  icon = Icon(Icons.account_balance_wallet, color: widget.darkMode? Color.fromRGBO(205, 220, 57, 1.0):Color.fromRGBO(0,051,51,1.0),);
                  text = Text('Payer via Flutterwave',   style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold,  color:  widget.darkMode? Color.fromRGBO(255, 61, 0, 1.0):Color.fromRGBO(93,64,55,1.0)),);
                  break;
               case 3:
                  icon = Icon(Icons.payment_outlined, color: widget.darkMode? Color.fromRGBO(205, 220, 57, 1.0):Color.fromRGBO(0,051,51,1.0),);
                  text = Text('Payer via Paypal',   style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold,  color:  widget.darkMode? Color.fromRGBO(255, 61, 0, 1.0):Color.fromRGBO(93,64,55,1.0)),);
                  break;

              }

              return InkWell(
                onTap: () {
                  onItemPress(context, index);
                },
                child: ListTile(
                  title: text,
                  leading: icon,
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(
              color: theme.primaryColor,
            ),
            itemCount: 4
        ),
      ),
        bottomNavigationBar: Container(
          height: 66.0,
          child: BottomAppBar(
            color:widget.darkMode? Color.fromRGBO(58, 58, 58, 0.90):Color.fromRGBO(254,219,208, 1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                    children:<Widget>[
                      IconButton(
                        icon: Icon(Icons.home, color:widget.darkMode? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0)),
                        onPressed: () {

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                                (Route<dynamic> route) => false,
                          );
                        },
                      ),
                      Text(
                        'Accueil',
                        style: TextStyle(color:widget.darkMode? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0)),
                      ),
                    ]
                ),
                Column(
                    children:<Widget>[
                      IconButton(
                        icon: Icon(Icons.shopping_bag_sharp, color:widget.darkMode? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0)),
                        onPressed: () {

                          setState(() {});
                          Navigator.of(context).push(MaterialPageRoute(//CartScreen
                              builder: (context) => MyOrders(darkMode: widget.darkMode)));
                        },
                      ),
                      Text(
                        'Mes commandes',
                        style: TextStyle(color:widget.darkMode? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0)),
                      ),
                    ]
                ),
                Column(
                    children:<Widget>[
                      IconButton(
                        icon: Icon(Icons.shopping_cart, color:widget.darkMode? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0)),
                        onPressed: () {

                          setState(() {});
                          Navigator.of(context).push(MaterialPageRoute(//CartScreen
                              builder: (context) => CartProducts(darkMode: widget.darkMode,)));
                        },
                      ),
                      Text(
                        'Mon Panier',
                        style: TextStyle(color:widget.darkMode? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0)),
                      ),
                    ]
                ),
                Column(
                    children:<Widget>[
                      IconButton(
                        icon: Icon(Icons.account_box,color:widget.darkMode? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0)),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => MyAccount(darkMode: widget.darkMode)));
                        },
                      ),
                      Text(
                        'Mon compte',
                        style: TextStyle(color:widget.darkMode? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0)),
                      ),
                    ]
                ),




              ],
            ),
          ),
        )
    );
  }
}