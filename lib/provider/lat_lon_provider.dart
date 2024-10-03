import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class GetLatLong extends ChangeNotifier{
  double mLat = 0.0;
  double mLon = 0.0;
  void addInProvider({required double lat,required double lon}){
    mLat = lat;
    mLon = lon;
    notifyListeners();
  }

  List<double> getLatLon(){
    List<double> mList =[];
    mList.add(mLat);
    mList.add(mLon);
    return mList;
  }
}