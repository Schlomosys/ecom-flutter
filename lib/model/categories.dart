class CategoriesModel {

  static const CATEGORIE = "categorie";


  String _categorie;


  //  getters

  String get categorie => _categorie;




  CategoriesModel.fromMap(Map data){

    _categorie = data[CATEGORIE ];
  }

  Map toMap() => {
    CATEGORIE : _categorie
  };
}