import 'package:flutter/material.dart';
import 'package:dextroecom/model/produkts.dart';
import 'package:dextroecom/services/products.dart';

class ProductsProvider with ChangeNotifier{
  List<Products> productsList = [];
  List<Products> productsRecentsList = [];
  List<String> imagesList = [];
  ProductsServices _productsServices = ProductsServices();

  ProductsProvider(){
    loadProducts();
    loadRecentProducts();
    loadVedetImage();
  }
  Future loadProducts()async{
    productsList = await _productsServices.getProducts();
    notifyListeners();
  }
  Future loadRecentProducts()async{
    productsRecentsList = await _productsServices.getRecentsProducts();
    notifyListeners();

  }
  Future loadVedetImage() async{
imagesList= await _productsServices.getProductsImages();
  }
}