import 'package:flutter/material.dart';

/*import 'package:hover_ussd/hover_ussd.dart';

class HoverPayment extends StatefulWidget {
  @override
  HoverPaymentState createState() => HoverPaymentState();
}*/
/*
class HoverPaymentState extends State<HoverPayment> {
  final HoverUssd _hoverUssd = HoverUssd();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Row(
            children: [
              FlatButton(
                onPressed: () {
                  _hoverUssd.sendUssd(
                      actionId: "c6e45e62", extras: {"price": "4000"});
                },
                child: Text("Start Trasaction"),
              ),
              StreamBuilder(
                stream: _hoverUssd.onTransactiontateChanged,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == TransactionState.succesfull) {
                    return Text("succesfull");
                  } else if (snapshot.data == TransactionState.waiting) {
                    return Text("pending");
                  } else if (snapshot.data == TransactionState.failed) {
                    return Text("failed");
                  }
                  return Text("no transaction");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/