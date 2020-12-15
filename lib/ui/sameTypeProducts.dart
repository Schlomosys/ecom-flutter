import 'file:///C:/Users/Awolou%20Daniel/AndroidStudioProjects/dextroecom/lib/screens/productInfosdetails.dart';
import 'package:dextroecom/model/produkts.dart';
import 'package:dextroecom/services/products.dart';
import 'package:flutter/material.dart';

class SameTypeProducts extends StatefulWidget {
  String categorie;
  String userId;
  bool darkMode;
  SameTypeProducts(this.categorie, this.userId, this.darkMode);

  @override
  _SameTypeProductsState createState() => _SameTypeProductsState();
}

class _SameTypeProductsState extends State<SameTypeProducts> {
  List<Products> _products  = [];
  ProductsServices _productsServices = ProductsServices();
  @override
  void initState() {
    SimilProducts();
    super.initState();

  }

  Future SimilProducts()async{
    _products  = await _productsServices.getSimilarProducts(widget.categorie);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _products.length,
      itemBuilder: (BuildContext context, int i) {
        return Card(
          child: Hero(
            tag: _products[i].name,
            child: Material(
              child: InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductInfosDetails(
                      productDetailsName:  _products[i].name,
                      productDetailsImage: _products[i].image,
                      productDetailsoldPrice: _products[i].odlPrice,
                      productDetailsPrice:_products[i].price ,
                      productDetailsDesc: _products[i].prodDesc,
                      productDetailUserId:widget.userId,
                      productDetailProdId: _products[i].prodId,
                      productCategory: _products[i].categorie,
                      colors: _products[i].color,
                      tailles: _products[i].taille,
                      darkMode: widget.darkMode,

                    ),
                  ),
                ),
                child: GridTile(
                  child: Image.network(
                    _products[i].image,
                    fit: BoxFit.cover,
                  ),
                  footer: Container(
                    height: 50.0,
                    color: Colors.black54,
                    child: Column(

                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "${_products[i].name}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Montserrat',),
                            ),
                            Text(
                              " ${_products[i].price} FCFA",
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
                                inde < _products[i].rank? Icons.star : Icons.star_border,
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
    );
  }
}
