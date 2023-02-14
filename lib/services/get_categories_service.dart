import 'package:dio/dio.dart';
import 'package:online_shop/consts/api_url.dart';
import 'package:online_shop/models/get_categories.dart';

Future<List<DatumCategory?>?> getCategoriesService() async {
  List<DatumCategory?>? result;
  try {
    Response response = await Dio().get("${ApiUrl.BASE_URL}get_categories");
    if(response.statusCode == 200){
      GetCategoriesModel getCategoriesModel = GetCategoriesModel.fromJson(response.data);
      result = getCategoriesModel.data;
      // return getCategoriesModel.data;
    }
  }catch(e){
    print(e);
  }
  return result;
}
