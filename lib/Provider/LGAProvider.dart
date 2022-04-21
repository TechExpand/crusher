

import 'package:flutter/foundation.dart';

class LgaInfo{
  String name;
  int id;
  LgaInfo(this.name, this.id);
}

List<LgaInfo> data = [
  LgaInfo('Akoko-Edo', 1),
  LgaInfo('Egor', 2),
  LgaInfo('Esan Central', 3),
  LgaInfo('Esan North-East', 4),
  LgaInfo('Esan West', 5),
  LgaInfo('Etsako Central', 6),
  LgaInfo('Etsako West', 7),
  LgaInfo('Etsako East', 8),
  LgaInfo('Esan South-East', 9),
  LgaInfo('Igueben', 10),
  LgaInfo('Ikpoba-Okha', 11),
  LgaInfo('Oredo',12),
  LgaInfo('Orhionmwon', 13),
  LgaInfo('Ovia North-East', 14),
  LgaInfo('Ovia South-West', 15),
  LgaInfo('Owan East', 16),
  LgaInfo('Owan West', 17),
  LgaInfo('Uhunmwonde', 18),
];

class LgaProvider with ChangeNotifier {
  List<LgaInfo> allLgaList = data;

   LgaInfo ?seletedinfo;

  changeSelectedLGA(value){
    seletedinfo = value;
    notifyListeners();
  }


}


