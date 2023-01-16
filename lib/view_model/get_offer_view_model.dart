import 'package:flutter/cupertino.dart';
import 'package:online_shop/models/get_offers.dart';
import 'package:online_shop/services/get_offer_service.dart';
import 'package:online_shop/services/offer.dart';

class GetOfferViewModel extends ChangeNotifier{



  // final Future<List<Datum?>?> _list = GetOfferServices().getoffers();
  // Future<List<Datum?>?> get getOffersVM => _list;
  // notifyListeners();

//   void getoffers {
// final List<Datum> _list = GetOfferService().getoffers();
// return _list;
//   }

List<Datum>? datumProvider;
bool loading = false;

getOffersProvider() async {
loading = true;
datumProvider = await getoffers();
loading = false;
// print(datumProvider);

notifyListeners();
}
}
