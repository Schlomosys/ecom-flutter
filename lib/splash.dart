
import 'package:dextroecom/screens/homePage.dart';
import 'package:flutter/material.dart';

import 'package:splashscreen/splashscreen.dart';


class Splash extends StatefulWidget {
  @override
  VideoState createState() => VideoState();
}


class VideoState extends State<Splash> with SingleTickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 10,
        navigateAfterSeconds: new HomePage(),
        title: new Text('Bienvenue sur Kakuta Shop',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),),
        image: new Image.asset('images/logoOne.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: ()=>print("Flutter Boonee"),
        loaderColor: Colors.red
    );
  }

  }

  /*var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation =
    new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }
*/
  /*
  @override
  Widget build(BuildContext context) {
    deviceSize = DeviceSize(
        size: MediaQuery.of(context).size,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        aspectRatio: MediaQuery.of(context).size.aspectRatio);
    return ChangeNotifierProvider<SignInViewModel>(
      builder: (_) => SignInViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
        fit: StackFit.expand,
    children: <Widget>[
    new Column(
    mainAxisAlignment: MainAxisAlignment.end,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[

    Padding(padding: EdgeInsets.only(bottom: 30.0),child:new Image.asset('assets/powered_by.png',height: 25.0,fit: BoxFit.scaleDown,))

    ],),
    new Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    new Image.asset(
    'assets/devs.jpg',
    width: animation.value * 250,
    height: animation.value * 250,
    ),
    ],
    ),
    ],
    ),
    )
    );
  }*/
//}

