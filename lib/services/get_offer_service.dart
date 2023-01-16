import 'package:dio/dio.dart';
import 'package:online_shop/consts/api_url.dart';
import 'package:online_shop/models/get_offers.dart';

class GetOfferService {
  Future<Datum?> getoffers() async {
    try{
      Response response = await Dio().get(ApiUrl.BASE_URL+"get_offers");
      if(response.statusCode ==200){
        //  GetOfferModel getOfferModel = GetOfferModel.fromJson(response.data);
        Datum datum = Datum.fromJson(response.data);
      return datum;
      }
    }catch(e){
      print(e);
    }
  }
}
class GetOfferServices {
  Future<List<Datum?>?> getoffers() async {
    try{
      Response response = await Dio().get(ApiUrl.BASE_URL+"get_offers");
      if(response.statusCode ==200){
         GetOfferModel getOfferModel = GetOfferModel.fromJson(response.data);
        // Datum datum = Datum.fromJson(response.data);
      return getOfferModel.data;
      }
    }catch(e){
      print(e);
    }
  }
}