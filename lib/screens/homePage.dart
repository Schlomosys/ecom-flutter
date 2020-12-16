import 'package:cloud_firestore/cloud_firestore.dart';



import 'package:dextroecom/model/produkts.dart';
import 'package:dextroecom/model/user.dart';

import 'package:dextroecom/screens/login.dart';
import 'package:dextroecom/screens/productInfosdetails.dart';

import 'package:dextroecom/services/user.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dextroecom/provider/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:badges/badges.dart';
import 'package:dextroecom/screens/aboutUsInfos.dart';
import 'package:dextroecom/screens/cartDetails.dart';
import 'package:dextroecom/screens/contact.dart';
import 'package:dextroecom/screens/favorites.dart';
import 'package:dextroecom/screens/myAccount.dart';
import 'package:dextroecom/screens/myorders.dart';
import 'package:dextroecom/screens/nominatim_location.dart';





class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool darkmode = false;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User currentUser;

  UserModel user;

  UserModel get userModel => user;
  static bool darkbackcolor=false;

  List<Products> _list= [];
  List<Products> _searchList = [];

  @override
  void initState() {
    init();
    loadCurrentUser();

    super.initState();

  }

  void loadCurrentUser() {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {

      this.currentUser = auth.currentUser;
      String userUid=currentUser.uid;
      getUseC(userId:userUid);
    }

  }
  Future<void> getUseC({String userId})async{

    UserService userService = UserService();

    user= await userService.getUserById(userId);
    darkbackcolor=user.isdarkmode;
    _handleSearchEnd();
    setState(() {});

  }
  String setEmail() {
    if (currentUser != null) {
      return currentUser.email;
    } else {
      return "Pas d'adresse email";
    }
  }

  String setProfilePic() {
    if (currentUser != null) {
      return currentUser.email[0].toUpperCase();
    } else {
      return "A";
    }
  }//

  String setUsername() {
    if (currentUser != null) {
      if (currentUser.displayName == null) {
        return currentUser.email.replaceAll('@gmail.com', '');
      }
      return currentUser.displayName;
    } else {
      return "Vous n\'êtes pas connecté";
    }
  }


  //Rating STARS
  final int value=0;

  //***********************************************SEARCH LOGIC_*********************************************************//
  Widget appBarTitle = Text(
    "KAKUTA SHOP",
    style: TextStyle(color:darkbackcolor?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0), fontFamily: 'MontserratBold',),
  );
  Icon actionIcon = Icon(
    Icons.search,
    color: darkbackcolor?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),
  );
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();



  bool _IsSearching;
  String _searchText = "";
  _HomePageState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
          _buildSearchList();
          setState(() {});
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
          _buildSearchList();
          setState(() {});
        });
      }
    });

  }
  Future<void> init()  async{
   _list = Provider.of<ProductsProvider>(context, listen: false).productsRecentsList;

    _searchList = _list;

    setState(() {});
  }




  List<Products> _buildSearchList() {
    setState(() {
      if (_searchText.isEmpty) {
        print("isempty");
        return _searchList = _list;
      } else {


        _searchList = _list.where((element) =>element.name.toLowerCase().contains(_searchText.toLowerCase()) ||
            element.categorie.toLowerCase().contains(_searchText.toLowerCase()))
            .toList();
        print('${_searchList.length}');
        print(_searchList.toString());
        return _searchList; //_searchList.map((contact) =>  Uiitem(contact)).toList();
      }
    });

  }

  Widget buildAppBar(BuildContext context) {

    return AppBar(
        centerTitle: true,
        title: appBarTitle,
       iconTheme: IconThemeData(color:darkbackcolor?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),),

        backgroundColor: darkbackcolor?  Color.fromRGBO(33, 33, 33, 1.0):Color.fromRGBO(254,219,208, 1.0),
        actions: <Widget>[
          IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = Icon(
                    Icons.close,
                    color:  darkbackcolor?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),
                  );
                  this.appBarTitle = TextField(
                    controller: _searchQuery,
                    style: TextStyle(
                      color: darkbackcolor?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),
                    ),
                    decoration: InputDecoration(
                        hintText: "Rechercher un produit..",
                        hintStyle: TextStyle(color: darkbackcolor?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0), fontFamily: 'MontserratBold', fontStyle: FontStyle.italic)),
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart_sharp, color: darkbackcolor?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),),
            onPressed: () {


              setState(() {});
              Navigator.of(context).push(MaterialPageRoute(//CartScreen
                  builder: (context) => CartProducts(darkMode: darkbackcolor,)));
                 // builder: (context) => CartScreen(panier, user)));
            },
          ),
        ]);
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = Icon(
        Icons.search,
        color:darkbackcolor?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),
      );
      this.appBarTitle = Text(
        "KAKUTA SHOP",

        style: TextStyle(color: darkbackcolor?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0), fontFamily: 'MontserratBold',),
      );
      _IsSearching = false;
      _searchQuery.clear();
    });
  }
  //***********************************************SEARCH LOGIC_*********************************************************//



  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;

    CollectionReference categorie = FirebaseFirestore.instance.collection('categories');

    final products = Provider.of<ProductsProvider>(context);


    final List<String> pictList=products.imagesList;



    final List<Widget> PicturesSlide = pictList.map((item) => Container(
      child: Container(

        margin: EdgeInsets.all(5.0),
        child: ClipRRect(

            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(

              children: <Widget>[

                Image.network(item, fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                     '', //'No. ${pictList.indexOf(item)} ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    )).toList();

    String msgInline = "Benvenue sur Kakuta Shop, Votre partenaire e-commerce2, bon shopping !";

    List<String> msgInlinelist = msgInline.split(", ");
    int msgInlinelistlen = msgInlinelist.length;
    return Scaffold(
      backgroundColor: darkbackcolor? Color.fromRGBO(18, 18, 18, 1.0):Color.fromRGBO(254,234,230, 1.0),
      // Drawer Start
      drawer:Theme(
    data: Theme.of(context).copyWith(
    canvasColor: darkbackcolor? Color.fromRGBO(48, 48, 48, 0.75):Color.fromRGBO(254,234,230, 0.85), //This will change the drawer background to blue.
    //other styles
    ),
    child: Drawer(

      child: ListView(

        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: darkbackcolor? Color.fromRGBO(0, 191, 165, 0.75):Color.fromRGBO(207,102,121, 0.85),
            ),
            accountName: Text("${setUsername()}",  style: TextStyle(
              fontSize: 15.0,
              color: darkbackcolor? Colors.white:Color.fromRGBO(68,44,46, 1.0),
              fontWeight: FontWeight.bold,
            )),
            accountEmail: Text("${setEmail()}",  style: TextStyle(
              fontSize: 15.0,
              color: darkbackcolor? Colors.white:Color.fromRGBO(68,44,46, 1.0),
              fontWeight: FontWeight.bold,
            )
            ),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundColor: darkbackcolor? Color.fromRGBO(69, 90, 100, 0.75):Color.fromRGBO(215,204,200, 0.85),
                child: Text("${setProfilePic()}",
                    style: TextStyle(
                      fontSize: 35.0,
                      color: darkbackcolor? Colors.white:Color.fromRGBO(68,44,46, 1.0),
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ),
          ListTile(
            leading: darkbackcolor
                ?Icon(

              Icons.nights_stay,
              color: Colors.blueGrey,
            )

                :Icon(

              Icons.wb_sunny,
              color: Colors.amberAccent,
            ) ,
            title: Text("Thème foncé",    style: TextStyle(
              fontSize: 16.0,
              color: darkbackcolor? Color.fromRGBO(187, 134, 252, 1.0):Color.fromRGBO(58, 66, 86, 1.0),
              fontWeight: FontWeight.bold,
              fontFamily: 'MontserratBold',
            ) ),
            trailing: Switch(
              value: darkbackcolor,
              onChanged: (val) {
                setState(() {
                  darkbackcolor = val;
                  UserService userservice= new UserService();
                  userservice.updateDarkmode(currentUser.uid, val);
                  _handleSearchEnd();
                });
              },
            ),
          ),

          ListTile(
            leading: Icon(Icons.history,  color:darkbackcolor? Color.fromRGBO(197,17,98, 1.0): Colors.blueGrey),
            title: Text(
              "Mes commandes",
                style: TextStyle(
                  fontSize: 16.0,
                  color: darkbackcolor? Color.fromRGBO(187, 134, 252, 1.0):Color.fromRGBO(58, 66, 86, 1.0),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'MontserratBold',
                )
            ),
            onTap: () {
              setState(() {});
              Navigator.of(context).push(MaterialPageRoute(//CartScreen
                  builder: (context) => MyOrders(darkMode: darkbackcolor,)));
            },
          ),
          ListTile(
            leading: Icon(Icons.account_box,  color:darkbackcolor? Color.fromRGBO(197,17,98, 1.0): Colors.blueGrey),
            title: Text(
              "Mon compte",
                style: TextStyle(
                  fontSize: 16.0,
                  color: darkbackcolor? Color.fromRGBO(187, 134, 252, 1.0):Color.fromRGBO(58, 66, 86, 1.0),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'MontserratBold',
                )
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyAccount(darkMode: darkbackcolor)));
            },

          ),
          ListTile(
            leading: Icon(Icons.favorite, color:darkbackcolor? Color.fromRGBO(197,17,98, 1.0): Colors.blueGrey),
            title: Text(
              "Mes articles favoris",

                style: TextStyle(
                  fontSize: 16.0,
                  color: darkbackcolor? Color.fromRGBO(187, 134, 252, 1.0):Color.fromRGBO(58, 66, 86, 1.0),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'MontserratBold',
                )
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Favorites(darkMode: darkbackcolor,),
                ),
              );
            },

          ),

          ListTile(
            leading: Icon(Icons.info_outline, color:darkbackcolor? Color.fromRGBO(197,17,98, 1.0): Colors.blueGrey),
            title: Text(
              "À propos de nous",
                style: TextStyle(
                  fontSize: 16.0,
                  color: darkbackcolor? Color.fromRGBO(187, 134, 252, 1.0):Color.fromRGBO(58, 66, 86, 1.0),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'MontserratBold',
                )
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AboutUs(darkMode: darkbackcolor,)));
            },

          ),
          ListTile(
            leading: Icon(Icons.delivery_dining,  color:darkbackcolor? Color.fromRGBO(197,17,98, 1.0): Colors.blueGrey),
            title: Text(
              "Adresse de livraison",
                style: TextStyle(
                  fontSize: 16.0,
                  color: darkbackcolor? Color.fromRGBO(187, 134, 252, 1.0):Color.fromRGBO(58, 66, 86, 1.0),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'MontserratBold',
                )
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Nominatim()));
            },

          ),
          ListTile(
            leading: Icon(Icons.contact_phone,  color:darkbackcolor? Color.fromRGBO(197,17,98, 1.0): Colors.blueGrey),
            title: Text(
              "Nous contacter",
                style: TextStyle(
                  fontSize: 16.0,
                  color: darkbackcolor? Color.fromRGBO(187, 134, 252, 1.0):Color.fromRGBO(58, 66, 86, 1.0),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'MontserratBold',
                )
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ContactUs(darkMode: darkbackcolor,)));
            },

          ),

          ListTile(
            leading: Icon(Icons.exit_to_app,  color:darkbackcolor? Color.fromRGBO(197,17,98, 1.0): Colors.blueGrey),
            title: Text(
              "Déconnexion",
                style: TextStyle(
                  fontSize: 16.0,
                  color: darkbackcolor? Color.fromRGBO(187, 134, 252, 1.0):Color.fromRGBO(58, 66, 86, 1.0),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'MontserratBold',
                )
            ),
            onTap: () {
              FirebaseAuth.instance.signOut().then((value) {
                Navigator.of(context).pop();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyLoginPage()));
              });
            },

          ),
        ],
      ),
    ), ),
      // Drawer ends
      appBar: buildAppBar(context),
      body:
        Column(

        children: <Widget>[

          SizedBox( // Horizontal ListView

            height: 25,
            child: ListView.builder(
              itemCount: msgInlinelistlen,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {

                return new Card(
                  shadowColor: Colors.grey[350],
                  color: Colors.blueAccent[index * 100],
                  child: new Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: 25.0,
                    child: new Text(msgInlinelist[index],style: TextStyle(  fontWeight: FontWeight.bold, fontFamily: 'Montserrat',),),
                  ),
                );
              },
            ),
          ),
          Container(
            color:  Colors.grey.withOpacity(0.3),
            height: 30,
            child: StreamBuilder<QuerySnapshot>(
              stream: categorie.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: snapshot.data.docs.map((DocumentSnapshot document) {
                      return InkWell(
                        onTap: () {

                          _searchQuery.text="${document.data()['categorie']}";

                        },
                        child: Column(
                          children: <Widget>[
                            Container(

                              padding: EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
                              decoration: new BoxDecoration(boxShadow: [
                                new BoxShadow(
                                  color: Colors.blueGrey,
                                  blurRadius: 25.0,
                                  offset: Offset(0.0, 0.75),
                                ),
                              ]),

                              child:
                               Badge(
                                   toAnimate: false,
                                   shape: BadgeShape.square,
                                  badgeColor:  darkbackcolor?  Color.fromRGBO(197,17,98, 1.0):Color.fromRGBO(244, 143, 177, 1.0),
                                  borderRadius: BorderRadius.circular(8),
                                  badgeContent: Text('${document.data()['categorie']}', style: TextStyle(color: Colors.white,  fontFamily: 'MontserratBold')),
                                 ),
                            ),

                          ],
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          Container(

            alignment: Alignment.centerLeft,
            child: Text(
              "Top nouveaux produits",
              style: TextStyle(fontWeight: FontWeight.bold,
                  color:  darkbackcolor?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),
                  fontSize: 18.0,
                fontFamily: 'MontserratBold',
              ),
            ),
            padding: EdgeInsets.all(3.0),
          ),
          Container(

              child: CarouselSlider(
                options: CarouselOptions(
                  height:130,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                ),
                items: PicturesSlide,
              )
          ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Produits populaire",
              style: TextStyle(
                color:darkbackcolor?  Color.fromRGBO(3, 218, 213, 1.0):Color.fromRGBO(68,44,46, 1.0),
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'MontserratBold',

              ),

            ),
            FlatButton(
              child: Text(
                "Voir tout",
                style: TextStyle(
                  color:darkbackcolor?  Color.fromRGBO(187, 134, 252, 1.0):Color.fromRGBO(68,44,46, 1.0),
                  fontFamily: 'Montserrat',
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),

          Flexible(

            child: Padding(

              padding: const EdgeInsets.only(bottom: 0.0),

              child:GridView.builder(

               itemCount: _searchList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Hero(

                    tag:  _searchList[index].name,
                    child: Material(
                      child: InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProductInfosDetails(
                              productDetailsName:  _searchList[index].name,
                              productDetailsImage: _searchList[index].image,
                              productDetailsoldPrice: _searchList[index].odlPrice,
                              productDetailsPrice:_searchList[index].price ,
                              productDetailsDesc: _searchList[index].prodDesc,
                              productDetailUserId:currentUser.uid,
                              productDetailProdId: _searchList[index].prodId,
                              productCategory: _searchList[index].categorie,
                              colors: _searchList[index].color,
                              tailles: _searchList[index].taille,
                              darkMode: darkbackcolor,

                            ),
                          ),
                        ),
                        child: GridTile(
                          child:Image.network("${_searchList[index].image}",  fit: BoxFit.cover,),/* Image.asset(
                    products.productsList[index].image,
                    fit: BoxFit.cover,
                  ),*/
                          footer: Container(
                            height: 50.0,
                            color: Colors.black54,
                            child: Column(

                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "${_searchList[index].name}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        fontFamily: 'Montserrat',),
                                    ),
                                    Text(
                                      " ${_searchList[index].price} FCFA",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        fontFamily: 'Montserrat',),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(5, (inde) {
                                    return IconTheme(
                                      data: new IconThemeData(
                                          color: Colors.amberAccent),
                                      child: Icon(
                                        inde < _searchList[index].rank? Icons.star : Icons.star_border,
                                      ),
                                    );

                                  }),
                                )

                              ] ,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),

            ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        height: 66.0,
        child: BottomAppBar(
          color: darkbackcolor? Color.fromRGBO(58, 58, 58, 0.90):Color.fromRGBO(254,219,208, 1.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
          Column(
          children:<Widget>[
            IconButton(
              icon: Icon(Icons.home, color:darkbackcolor? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0)),
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
              style: TextStyle(color:darkbackcolor? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0), ),
            ),
          ]
          ),
                Column(
                    children:<Widget>[
                      IconButton(
                        icon: Icon(Icons.shopping_bag_sharp, color:darkbackcolor? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0)),
                        onPressed: () {

                          setState(() {});
                          Navigator.of(context).push(MaterialPageRoute(//CartScreen
                              builder: (context) => MyOrders(darkMode: darkbackcolor,)));
                        },
                      ),
                      Text(
                        'Mes commandes',
                        style: TextStyle(color:darkbackcolor? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0), ),
                      ),
                    ]
                ),
                Column(
                    children:<Widget>[
                      IconButton(
                        icon: Icon(Icons.shopping_cart, color:darkbackcolor? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0)),
                        onPressed: () {

                          setState(() {});
                          Navigator.of(context).push(MaterialPageRoute(//CartScreen
                              builder: (context) => CartProducts(darkMode: darkbackcolor,)));
                        },
                      ),
                      Text(
                        'Mon Panier',
                        style: TextStyle(color:darkbackcolor? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0), ),
                      ),
                    ]
                ),
                Column(
                    children:<Widget>[
                      IconButton(
                        icon: Icon(Icons.account_box,color:darkbackcolor? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0)),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) => MyAccount(darkMode: darkbackcolor,)));
                        },
                      ),
                      Text(
                        'Mon compte',
                        style: TextStyle(color:darkbackcolor? Color.fromRGBO(254,219,208, 1.0): Color.fromRGBO(68,44,46, 1.0), ),
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


