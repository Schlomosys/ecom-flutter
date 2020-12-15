import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class AboutUs extends StatefulWidget {
  final darkMode;
  AboutUs({this.darkMode});
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.darkMode==true?  Color.fromRGBO(18, 18, 18, 1.0):Color.fromRGBO(254,234,230, 1.0),
      appBar: AppBar(
        elevation: 10,
        iconTheme: IconThemeData(color:widget.darkMode?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),),
        backgroundColor: widget.darkMode?  Color.fromRGBO(33, 33, 33, 1.0):Color.fromRGBO(254,219,208, 1.0),
        centerTitle: true,
        title: Text("À propos de nous", style: TextStyle(color:widget.darkMode?   Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0), fontFamily: 'MontserratBold', fontSize: 18)),),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "KAKUTA SHOP",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,  color:  widget.darkMode? Color.fromRGBO(255, 61, 0, 1.0):Color.fromRGBO(93,64,55,1.0), fontFamily: 'MontserratBold',),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
            ),
            Divider(
              height: 20.0,
              color: Colors.grey,
            ),
            Container(
              padding: const EdgeInsets.only(left: 8.0),
              alignment: Alignment.topLeft,
              child: Text(
                "KAKUKA SHOP: Vot p*tain de p'tite b'tique!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: widget.darkMode?Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0), fontFamily: "BigShouldersStencilText"),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Nous sommes la combinaison du triptyque passion,  travail et  expertise. Kakuta shop est une boutique en ligne détenue par les chaines de magasins CANCUN BABY. Avec vous nous créerons le futur." ,   style: TextStyle(
                  color: widget.darkMode? Color.fromRGBO(205, 220, 57, 1.0):Color.fromRGBO(0,051,51,1.0),
                  fontWeight: FontWeight.w500,

                  //decoration: TextDecoration.lineThrough
              ),
              textAlign: TextAlign.justify,),
            ),
            Text("Version 1.0.0",  style: TextStyle(
              color: widget.darkMode? Color.fromRGBO(205, 220, 57, 1.0):Color.fromRGBO(0,051,51,1.0),
              fontWeight: FontWeight.w500,

              // decoration: TextDecoration.lineThrough
            ),
                textAlign: TextAlign.center),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
            ),
            Row(
              children: <Widget>[
                Icon(Icons.copyright, color:  widget.darkMode? Color.fromRGBO(255, 61, 0, 1.0):Color.fromRGBO(93,64,55,1.0) ,),
                Expanded(
                    child: Text(" 2021, KAKUTA est une marque enregistrée de SCHLOMOSIS SYSTEMS ",    style: TextStyle(
                        color: widget.darkMode? Color.fromRGBO(205, 220, 57, 1.0):Color.fromRGBO(0,051,51,1.0),
                        fontWeight: FontWeight.w500,

                       // decoration: TextDecoration.lineThrough
                    ),
                    textAlign: TextAlign.center),)
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 8.0),
              alignment: Alignment.topLeft,
              child: Text(
                "Principe",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: widget.darkMode?Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0), fontFamily: "BigShouldersStencilText"),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Le commerce électronique offre une foule d’avantages aux consommateurs et aux commerçants. Il permet, entre autres, de magasiner en ligne pour nous faire une première idée des produits. Fini le temps où nous devions magasiner pendant des heures pour trouver ce que nous cherchions. ",    style: TextStyle(
                  color: widget.darkMode? Color.fromRGBO(205, 220, 57, 1.0):Color.fromRGBO(0,051,51,1.0),
                  fontWeight: FontWeight.w500,
                 // decoration: TextDecoration.lineThrough
                ),
                textAlign: TextAlign.justify,),
            )
          ],
        ),
      ),
    );
  }
}
