import 'package:flutter/cupertino.dart';
import 'package:online_shop/models/get_top_products.dart';
import 'package:online_shop/services/top_products_service.dart';
import 'package:online_shop/view_model/top_products_view_model.dart';

class FavoritesViewModel extends ChangeNotifier {

  List<DatumTopProducts?>? favoritesList;

  bool loading = false;

  addToFavorite() async {
    loading = true;
    favoritesList= await GetTopProductsService();
    loading = false;
    notifyListeners();

  }

// List<DatumTopProducts?>? favoritesList = [];
// List<dynamic> favoritesList = [];
// List<DatumTopProducts?>? topProduct;
// TopProductViewModel? topProduct;


// List<DatumTopProducts?>? get topProduct => favoritesList;

// DatumTopProducts? get topProduct => favoritesList;



// bool loading = false;

// void addFavoriteList(DatumTopProducts? topProduct) {
// final isExist = favoritesList.contains(topProduct);
// if(isExist){
//   favoritesList.remove(topProduct);
// } else {
//   favoritesList.add(topProduct);
// }
// notifyListeners();

// }

// bool isExist(DatumTopProducts? topProduct){
// final isExist = favoritesList.contains(topProduct);
// return isExist;
// }

}