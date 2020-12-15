class ColorModel {

  static const COLOR = "color";


  String _color;


  //  getters

  String get color => _color;




  ColorModel.fromMap(Map data){

    _color = data[COLOR];
  }

  Map toMap() => {
    COLOR: _color
  };
}