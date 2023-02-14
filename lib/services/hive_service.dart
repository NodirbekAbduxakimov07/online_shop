import 'dart:ffi';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:online_shop/models/get_categories.dart';
import 'package:online_shop/models/get_offers.dart';
import 'package:online_shop/models/get_top_products.dart';

class HiveDB {
  static var box = Hive.box("shopping_box");

  // List favoritesIds = [];
  // Box<List<int?>>? favoriteIds;
  

  static void favoritesAddBox(List ids) async {
    // favoriteIds?.add(box.put("id", id))
    await box.put("ids", ids);
    // box.add(ids);
    // return box.put("id", id);
  }

  static List getFavoriteBox() {
    // List idd = box.get("ids");
    return 
    box.get("ids");
    // print("$idd");
    // idd;
  }

static void favoriteDeleteBox(List ids) {
  box.delete(ids);
}

static void saveTopProducts(List<DatumTopProducts?>? getTopProductsModel) async{
  List<DatumTopProducts?>? getTopProductsModel;
  box.put("getTopProductsModel", getTopProductsModel);
  print("getTop "+"$getTopProductsModel");
}

static List<DatumTopProducts?>? loadTopProducts() {
  List<DatumTopProducts?>? getTopProductsModel = box.get("getTopProductsModel");
  return getTopProductsModel;
}


static void saveGetOffer(List<DatumCategory?>? getOfferModel) async{
  List<DatumCategory?>? getOfferModel;
  box.put("getOfferModel", getOfferModel);
  print("getOffers "+"$getOfferModel");
}

static List<DatumCategory?>? loadGetOfferModel() {
  List<DatumCategory?>? getOfferModel = box.get("getOfferModel");
  return getOfferModel;
}

}