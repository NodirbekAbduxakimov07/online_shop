import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/models/get_top_products.dart';
import 'package:online_shop/screens/detail_screen.dart';
import 'package:online_shop/screens/home_screen.dart';
import 'package:online_shop/services/hive_service.dart';
import 'package:online_shop/view_model/favorites_view_model.dart';
import 'package:online_shop/view_model/top_products_view_model.dart';
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

    HiveDB.getFavoriteBox();
    
    final providerVM = Provider.of<FavoritesViewModel>(context, listen: false);
    providerVM.addIdsToFavorite(id);

    final providerTopProductsVM =
        Provider.of<TopProductViewModel>(context, listen: false);
    providerTopProductsVM.topProductVM();
  }

  int? id = 0;

  DatumTopProducts? topProduct = DatumTopProducts();
  List<int?> topProductIds = [];
  DatumTopProducts? ids;

  // List<int?> favIds = HomeScreen.favoriteIds;

  @override
  Widget build(BuildContext context) {
    var providerFavorite = Provider.of<FavoritesViewModel>(context);

    var providerTopProducts = Provider.of<TopProductViewModel>(context);

    return 
    HiveDB.getFavoriteBox().isNotEmpty
    // providerFavorite.favoritesIds.isNotEmpty
        ? ListView.builder(
            itemCount: providerTopProducts.topProductList?.length,
            itemBuilder: ((context, index) {
              return (
                // providerFavorite.favoritesIds
                HiveDB.getFavoriteBox()
                      .contains(providerTopProducts.topProductList![index]?.id))
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                topProductListItem: providerTopProducts
                                    .topProductList![index],
                              ),
                            ));
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
                                    "http://osonsavdo.devapp.uz/images/${providerTopProducts.topProductList?[index]?.image}",
                                progressIndicatorBuilder:
                                    (context, url, progress) {
                                  return Center(
                                      child: CircularProgressIndicator.adaptive(
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
                                    "${providerTopProducts.topProductList?[index]?.name}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${providerTopProducts.topProductList?[index]?.price} So'm",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Container();
            }))
        : const Center(child: Text("Empty"),
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
