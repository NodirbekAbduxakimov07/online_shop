
import 'package:flutter/material.dart';
import 'package:online_shop/models/get_offers.dart';
import 'package:online_shop/services/get_offer_service.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Datum?>?>(
      future: GetOfferServices().getoffers(),
      builder: ((context, snapshot) {
       if(snapshot.hasData){
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: ((context, index) {
          return Text(snapshot.data![index]!.id.toString());
        }
        )
        );
      } else {
        if(snapshot.hasError){
          return Text("err");
        } else {
          return CircularProgressIndicator.adaptive();
        }
      }
    }));
  }
}