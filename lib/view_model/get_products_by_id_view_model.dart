import 'package:flutter/cupertino.dart';
import 'package:online_shop/models/get_top_products.dart';
import 'package:online_shop/services/top_products_service.dart';

import '../services/get_products_by_id.dart';

class ProductByIdViewModel extends ChangeNotifier{

  List<DatumTopProducts?>? productByIdList;
  bool loading = false;
  // late int category_id;
  

  ProductByIdVM(int categoryId) async {
    
    loading = true;
    productByIdList = await GetProductsByIdService(categoryId);
    loading = false;
    notifyListeners();
  }
  

}