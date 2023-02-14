import 'package:dio/dio.dart';
import 'package:online_shop/consts/api_url.dart';
import 'package:online_shop/models/get_categories.dart';

Future<dynamic> CategoriesService() async {
  List<DatumCategory?>? result;
  try {
    Response response = await Dio().get("${ApiUrl.BASE_URL}get_categories");
    if(response.statusCode == 200){
      GetCategoriesModel getCategoriesModel = GetCategoriesModel.fromJson(response.data);
      result = getCategoriesModel.data;
      // return getCategoriesModel.data;
    }
  } on DioError catch(e){
    switch(e.type){
      case DioErrorType.connectTimeout:
        // TODO: Handle this case.
        return "Connection time out";
        break;
      case DioErrorType.sendTimeout:
        // TODO: Handle this case.
        return "Send time out";
        break;
      case DioErrorType.receiveTimeout:
        // TODO: Handle this case.
        return "Receive time out";
        break;
      case DioErrorType.response:
        // TODO: Handle this case.
        return "Responce time out";
        break;
      case DioErrorType.cancel:
        // TODO: Handle this case.
        return "Cancel";
        break;
      case DioErrorType.other:
        // TODO: Handle this case.
        return "Internet error";
        break;
        default: 
        return "Unkrown Error";
    }
    print(e);
  }
  return result;
}
