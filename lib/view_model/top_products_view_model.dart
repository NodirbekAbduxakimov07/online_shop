import 'package:flutter/cupertino.dart';
import 'package:online_shop/models/get_top_products.dart';
import 'package:online_shop/services/top_products_service.dart';

class TopProductViewModel extends ChangeNotifier{

  List<DatumTopProducts?>? topProductList;
  bool loading = false;

  topProductVM() async {
    loading = true;
    topProductList = await GetTopProductsService();
    loading = false;
    notifyListeners();
  }

}