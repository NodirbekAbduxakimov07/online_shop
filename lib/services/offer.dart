import 'package:dio/dio.dart';

import '../consts/api_url.dart';
import '../models/get_offers.dart';

Future<List<Datum>?> getoffers() async {
  List<Datum>? result;
    try{
      Response response = await Dio().get("${ApiUrl.BASE_URL}get_offers");
      if(response.statusCode ==200){
         GetOfferModel getOfferModel = GetOfferModel.fromJson(response.data);
        result = getOfferModel.data;
      return result;
      }
    } catch(e){
      print(e);
    }
    return result;
  }