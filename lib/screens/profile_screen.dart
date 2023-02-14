
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/screens/detail_screen.dart';
import 'package:online_shop/services/hive_service.dart';
import 'package:online_shop/services/shared_preferences_service.dart';
import 'package:online_shop/view_model/fav_view_model.dart';
import 'package:online_shop/view_model/favorites_view_model.dart';
import 'package:online_shop/view_model/top_products_view_model.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    
    
    // final providerVM = Provider.of<FavoritesViewModel>(context, listen: false);
    // providerVM.addIdsToFavorite(id);

    final providerTopProductsVM =
        Provider.of<TopProductViewModel>(context, listen: false);
    providerTopProductsVM.topProductVM();

    final providerFav = 
    Provider.of<FavViewModel>(context,listen: false);
    providerFav.addIdsToFav(id);

    super.initState();
  }

  
  String? id = "";

  @override
  Widget build(BuildContext context) {


    var providerTopProducts = Provider.of<TopProductViewModel>(context);
    var providerFavv = Provider.of<FavViewModel>(context);
    
    return 
    // FavViewModel().favIds.isNotEmpty
    // SharedPref.loadfavoriteids.isNotEmpty
    // HiveDB.getFavoriteBox().isNotEmpty
    // providerFavorite.favoritesIds.isNotEmpty
        // ? 
        ListView.builder(
            itemCount: providerTopProducts.topProductList?.length,
            itemBuilder: ((context, index) {
              return (
                // providerFavorite.favoritesIds
                // FavViewModel().favIds
                providerFavv.favIds
                      .contains(providerTopProducts.topProductList![index]?.id.toString()))
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
            }));
        // : const Center(child: Text("Empty"),
        //   );
  }
}