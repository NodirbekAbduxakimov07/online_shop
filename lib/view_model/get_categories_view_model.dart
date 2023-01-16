import 'package:flutter/cupertino.dart';
import 'package:online_shop/models/get_categories.dart';
import 'package:online_shop/services/get_categories_service.dart';

class GetCategoriesViewModel extends ChangeNotifier{

  List<DatumCategory?>? getCategoriesList;
  bool loading = false;

  getCategories() async {
    loading = true;
    getCategoriesList = await getCategoriesService();
    loading = false;
    notifyListeners();
  }

}