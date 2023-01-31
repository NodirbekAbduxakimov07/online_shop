import 'package:dio/dio.dart';
import 'package:online_shop/consts/api_url.dart';
import 'package:online_shop/models/get_top_products.dart';

Future<List<DatumTopProducts?>?> GetProductsByIdService(int categoryId) async {
  try {
    Response response = await Dio().get("${ApiUrl.BASE_URL}get_products/$categoryId");
    if (response.statusCode == 200) {
      GetTopProductsModel getTopProductsModel =
          GetTopProductsModel.fromJson(response.data);
      return getTopProductsModel.data;
    }
  } catch (e) {
    print(e);
  }
}
