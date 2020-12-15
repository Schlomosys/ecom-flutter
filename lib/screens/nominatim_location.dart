import 'package:flutter/material.dart';
import 'package:nominatim_location_picker/nominatim_location_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'NominatimPicker.dart';

class Nominatim extends StatefulWidget {
 Nominatim({this.userId});

 final String userId;

  @override
  _NominatimState createState() => _NominatimState();
}

class _NominatimState extends State<Nominatim> {
  Map _pickedLocation;
  var _pickedLocationText;

  Future getLocationWithNominatim() async {
    Map result = await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return NominatimPicker(
            userId: widget.userId,
            searchHint: 'Rechercher votre adresse',
            awaitingForLocation: "Veuillez patienter  ...",
          );
        });
    if (result != null) {
      setState(() {
        _pickedLocation = result;
       //   _pickedLocation[0].
       // var lat= _pickedLocation['lng'];
        print("this is my latitude");
       // print(lat.toString());

      });
      //setState(() => _pickedLocation = result);
    } else {
      return;
    }
  }

  RaisedButton nominatimButton(Color color, String name) {
    return RaisedButton(
      color: color,
      onPressed: () async {
        await getLocationWithNominatim();
      },
      textColor: Colors.white,
      child: Center(
        child: Text(name),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }

  RaisedButton mapBoxButton(Color color, String name) {
    return RaisedButton(
      color: color,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => getLocationWithMapBox()),
        );
      },
      textColor: Colors.white,
      child: Center(
        child: Text(name),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }

  Widget getLocationWithMapBox() {
    return MapBoxLocationPicker(
      popOnSelect: true,
      apiKey: "sk.eyJ1Ijoic2NoYWxsb3ciLCJhIjoiY2tobmw5dTl1MDJ3bDJ0cGVxYXU2aDQ1eiJ9.75D05wnXgb9IdUV9q-2IAw",
      limit: 10,
      language: 'fr',
      country: 'fr',
      searchHint: 'Rechercher',
      awaitingForLocation: "Recherche de votre position",
      onSelected: (place) async {
        setState(() {
          _pickedLocationText = place.geometry.coordinates; // Example of how to call the coordinates after using the Mapbox Location Picker
          print(_pickedLocationText);
        });
      },
      context: context,
    );
  }

  Widget appBar() {
    return  AppBar(
    elevation: 0,
    backgroundColor: Colors.black,
    centerTitle: true,
    title: Text("Votre adresse de livraison",  style: TextStyle(color: Colors.white, fontFamily: 'Montserrat',),),
    actions: <Widget>[

    ],
    );
  }

  Widget body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: _pickedLocation != null
              ? Center(child: Text("$_pickedLocation"))
              : nominatimButton(Colors.amber, 'Chargez la carte'),
        ),
        _instrucions(),
       /*Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child:_instrucions(),
        )*/
      ],
    );
  }
  Widget _instrucions() {
    /*
    --- Widget responsável constução das descrições de um determinado local.
  */
    return new Positioned(
      bottom: MediaQuery.of(context).size.width * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.20,
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 4,
                child: Row(
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: EdgeInsets.all(15),
                        child: Center(
                            child: Scrollbar(
                                child: new SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  reverse: false,
                                  child: AutoSizeText(
                                    " Une fois votre adresse obtenue, validez pour l'enregister",
                                    style: TextStyle(fontSize: 18),
                                    textAlign: TextAlign.start,
                                  ),
                                )))),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey, appBar: appBar(), body: body(context));
  }
}