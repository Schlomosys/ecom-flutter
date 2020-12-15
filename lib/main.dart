
import 'package:dextroecom/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'package:dextroecom/provider/products_provider.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 // HoverUssd().initialize();
 // runApp(MyApp());
  runApp(MultiProvider(
      providers: [
    //ChangeNotifierProvider.value(value: UserProvider.initialize()),
  ChangeNotifierProvider.value(value: ProductsProvider()),



  ],
  child: MaterialApp(

  debugShowCheckedModeBanner: false,
  title: 'KAKUTA SHOP',
    theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
   // darkTheme: Constants.darkTheme,
  //theme: ThemeData.light(),
  home: MyLoginPage(),
    /*builder: (BuildContext context, Widget child) {
      /// make sure that loading can be displayed in front of all other widgets
      return FlutterEasyLoading(child: child);
    },*/

  )));
  //configLoading();
}

/*void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..customAnimation = CustomAnimation();
}*/
/*class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meet Up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyLoginPage(),);

  }
}*/
/*Material(
                                      elevation: 5,
                                      color: Colors.lightBlue,
                                      borderRadius: BorderRadius.circular(32.0),
                                      child: MaterialButton(
                                        onPressed: () async {


                                        },
                                        minWidth: 200.0,
                                        height: 45.0,
                                        child: Text(
                                          "Sign in",
                                          style:
                                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                                        ),
                                      ),
                                    ),*/
