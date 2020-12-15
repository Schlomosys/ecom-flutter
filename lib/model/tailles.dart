class TaillesModel {

  static const TAILLE = "taille";


  String _taille;


  //  getters

  String get taille => _taille;




  TaillesModel.fromMap(Map data){

    _taille = data[TAILLE];
  }

  Map toMap() => {
    TAILLE: _taille
  };
}