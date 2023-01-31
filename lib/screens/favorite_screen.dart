
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/models/get_top_products.dart';
import 'package:online_shop/view_model/favorites_view_model.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final providerVM = Provider.of<FavoritesViewModel>(context, listen: false);
    providerVM.addToFavorite();
    
  }

  DatumTopProducts? topProduct;

  @override
  Widget build(BuildContext context) {
    
    var providerFavorite = Provider.of<FavoritesViewModel>(context);

    return providerFavorite.loading ? CircularProgressIndicator.adaptive() : ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: providerFavorite.favoritesList?.length,
                    itemBuilder: ((context, index) {
                      // index = category_id;
                      return InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => DetailScreen(
                          //         topProductListItem: providerTopProducts
                          //             .topProductList![index],
                          //       ),
                          //     ));
                        },
                        child: Card(
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(5.0),
                                width: 100,
                                height: 100,
                                // color: Colors.green,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "http://osonsavdo.devapp.uz/images/${providerFavorite.favoritesList?[index]?.image}",
                                  progressIndicatorBuilder:
                                      (context, url, progress) {
                                    return Center(
                                        child:
                                            CircularProgressIndicator.adaptive(
                                      value: progress.progress,
                                    ));
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // "tt"
                                      "${providerFavorite.favoritesList?[index]?.name}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${providerFavorite.favoritesList?[index]?.price} So'm",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    })
                    );
    
    
    
    // FutureBuilder<List<Datum?>?>(
    //   future: GetOfferServices().getoffers(),
    //   builder: ((context, snapshot) {
    //    if(snapshot.hasData){
    //     return ListView.builder(
    //       itemCount: snapshot.data!.length,
    //       itemBuilder: ((context, index) {
    //       return Text(snapshot.data![index]!.id.toString());
    //     }
    //     )
    //     );
    //   } else {
    //     if(snapshot.hasError){
    //       return Text("err");
    //     } else {
    //       return CircularProgressIndicator.adaptive();
    //     }
    //   }
    // }));
  }
}