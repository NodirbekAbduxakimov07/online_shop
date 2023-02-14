import 'package:flutter/cupertino.dart';
import 'package:online_shop/services/shared_preferences_service.dart';

class FavViewModel extends ChangeNotifier{
  List<String> favIds = [];
  
  // List<DatumTopProducts?>? datumProvider;
  // DatumTopProducts? datumTopProducts;

  void addIdsToFav(String? id) async {
    final checkedId = favIds.contains(id);
    
   
    if(checkedId){
      favIds.remove(id);
      SharedPref.deletefavoriteids(id);
      // HiveDB.favoriteDeleteBox(favIds);
      print("${ SharedPref.deletefavoriteids(id)}");
    
    } else {
      favIds.add(id!);
      SharedPref.savefavoriteids(id);
      // HiveDB.favoritesAddBox(favoritesIds);
      print("${ SharedPref.savefavoriteids(id)}");
      
      
    }
}
}