import 'package:flutter/material.dart';


class ContactUs extends StatefulWidget {
  final darkMode;
  ContactUs({this.darkMode});
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.darkMode==true?  Color.fromRGBO(18, 18, 18, 1.0):Color.fromRGBO(254,234,230, 1.0),
      appBar: AppBar(
        elevation: 10,
        iconTheme: IconThemeData(color:widget.darkMode?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),),
        backgroundColor: widget.darkMode?  Color.fromRGBO(33, 33, 33, 1.0):Color.fromRGBO(254,219,208, 1.0),
        centerTitle: true,
        title: Text("Contacter nous",
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,  color:  widget.darkMode? Color.fromRGBO(255, 61, 0, 1.0):Color.fromRGBO(93,64,55,1.0), fontFamily: 'MontserratBold',),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 8.0),
              alignment: Alignment.topLeft,
              child: Text(
                "Vous avez une préoccupation? Voici les coordonnées du developpeur",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,  color:  widget.darkMode? Color.fromRGBO(255, 61, 0, 1.0):Color.fromRGBO(93,64,55,1.0)),
              ),
            ),
           // Text("Feel free to Ask!"),
            SizedBox(height: 50.0),
            Row(
              children: <Widget>[

              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  //Text("OR Email me at :"),
                  Text(" Email: schal94.aw@gmail.com",
                  style: TextStyle(color:widget.darkMode?   Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0), fontFamily: 'Goldman', fontSize: 18),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
