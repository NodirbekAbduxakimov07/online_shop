import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:online_shop/models/get_top_products.dart';
import 'package:online_shop/screens/detail_screen.dart';
import 'package:online_shop/services/by_category_id_sceen.dart';
import 'package:online_shop/services/hive_service.dart';
import 'package:online_shop/view_model/fav_view_model.dart';
import 'package:online_shop/view_model/favorites_view_model.dart';
import 'package:online_shop/view_model/get_categories_view_model.dart';
import 'package:online_shop/view_model/get_offer_view_model.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../view_model/get_products_by_id_view_model.dart';
import '../view_model/top_products_view_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // HiveDB.getFavoriteBox();
    
    final provider2 = Provider.of<GetOfferViewModel>(context, listen: false);
    provider2.getOffersProvider();

    final providerGetCategoris =
        Provider.of<GetCategoriesViewModel>(context, listen: false);
    providerGetCategoris.getCategories();

    final providerTopProductsVM =
        Provider.of<TopProductViewModel>(context, listen: false);
    providerTopProductsVM.topProductVM();

    final providerProductsByIdVM =
        Provider.of<ProductByIdViewModel>(context, listen: false);
    providerProductsByIdVM.ProductByIdVM(categoryId);

    final providerVM = Provider.of<FavoritesViewModel>(context, listen: false);
    providerVM.addIdsToFavorite(favoriteId);

    final providerFav = Provider.of<FavViewModel>(context,listen: false);
    providerFav.addIdsToFav("");
  }

// List<DatumTopProducts?>? topProduct;
  DatumTopProducts? topProduct;
  int? favoriteId = 0;

  bool checkedCategory = false;
  int currentlyIndex = -1;
  int categoryId = 10;
  int test = -2;

  // callback(varTopic){
  //   setState(() {
  //     varTopic = category_id;
  //   });
  // }
  void changeID(changeId) {
    setState(() {
      changeId = categoryId;
    });
  }

  // List<Map<String, dynamic>> _items = [];

  // final _shoppingBox = Hive.box('shopping_box');

  // Future<List<DatumTopProducts?>?> _createItem(
  //     List<DatumTopProducts?>? newItem) async {
  //   await _shoppingBox.add(newItem);
  //   print("amount data is ${_shoppingBox.length}");
  //   return newItem;
  // }

  // final String name = "";
  // final String price = "";

  List<int?> favoriteIds = [];
  bool addToFavorite = false;
  int currentlyCheckedIndex = -1;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GetOfferViewModel>(context, listen: true);

    var providerCategories =
        Provider.of<GetCategoriesViewModel>(context, listen: true);

    var providerTopProducts = Provider.of<TopProductViewModel>(context);

    var providerproductById = Provider.of<ProductByIdViewModel>(context);

    var providerFavorite = Provider.of<FavoritesViewModel>(context);

    var providerFavv = Provider.of<FavViewModel>(context);

    return Container(
      child: (provider.loading &&
              providerCategories.loading &&
              providerTopProducts.loading)
          ? Center(child: SpinKitThreeBounce(
              itemBuilder: (context, index) {
                return DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: index.isEven ? Colors.red : Colors.green));
              },
            ))
          : SingleChildScrollView(
              child: Column(children: [
                Container(
                    margin: const EdgeInsets.only(top: 5, right: 5, left: 5),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.deepOrange)),
                    width: double.infinity,
                    height: 180,
                    child: CarouselSlider.builder(
                      itemCount: provider.datumProvider?.length,
                      itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) =>
                          Container(
                              child: CachedNetworkImage(
                        imageUrl:
                            "http://osonsavdo.devapp.uz/images/${provider.datumProvider![itemIndex].image}",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress)),
                        // placeholder: (context, url) =>
                        //     CircularProgressIndicator.adaptive(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )),
                      options: CarouselOptions(
                          autoPlay: true, viewportFraction: 0.9),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  child:
                      //  provider.loading ? Center(child: CircularProgressIndicator.adaptive()) :
                      ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              providerCategories.getCategoriesList?.length,
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  currentlyIndex = index;
                                  test = index;
                                  checkedCategory = true;
                                  categoryId = providerCategories
                                      .getCategoriesList![index]!.id!;
                                  print("checkItem  $categoryId");
                                  print("$currentlyIndex");
                                  // changeID(categoryId);
                                  ByCategoryScreen(providerCategories.getCategoriesList![index]!.id);
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5.0),
                                padding: const EdgeInsets.all(10.0),
                                height: 40,
                                decoration: BoxDecoration(
                                    color: (currentlyIndex == index)
                                        ? Colors.deepOrangeAccent
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.deepOrangeAccent)),
                                child: Center(
                                  child: Text(
                                    "${providerCategories.getCategoriesList?[index]?.title}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: (currentlyIndex == index)
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
                ),
                (
                        // checkedCategory == true
                        currentlyIndex == test
                        )
                    ? Container(
                        child: 
                        (providerproductById.loading)
                            ? Center(child: CircularProgressIndicator.adaptive())
                            : 
                            ByCategoryScreen(categoryId)
                            // ListView.builder(
                            //     shrinkWrap: true,
                            //     primary: false,
                            //     itemCount:
                            //         providerproductById.productByIdList?.length,
                            //     itemBuilder: ((context, index) {
                            //       // print("object");
                            //       // index = category_id;
                            //       return InkWell(
                            //         onTap: () {
                            //           Navigator.push(
                            //               context,
                            //               MaterialPageRoute(
                            //                 builder: (context) => DetailScreen(
                            //                   topProductListItem:
                            //                       providerproductById
                            //                           .productByIdList![index],
                            //                 ),
                            //               ));
                            //         },
                            //         child: Card(
                            //           child: Row(
                            //             children: [
                            //               Container(
                            //                 margin: const EdgeInsets.all(5.0),
                            //                 width: 100,
                            //                 height: 100,
                            //                 // color: Colors.green,
                            //                 child: CachedNetworkImage(
                            //                   imageUrl:
                            //                       "http://osonsavdo.devapp.uz/images/${providerproductById.productByIdList?[index]?.image}",
                            //                   progressIndicatorBuilder:
                            //                       (context, url, progress) {
                            //                     return Center(
                            //                         child:
                            //                             CircularProgressIndicator
                            //                                 .adaptive(
                            //                       value: progress.progress,
                            //                     ));
                            //                   },
                            //                 ),
                            //               ),
                            //               const SizedBox(
                            //                 width: 5,
                            //               ),
                            //               Expanded(
                            //                 child: Column(
                            //                   crossAxisAlignment:
                            //                       CrossAxisAlignment.start,
                            //                   children: [
                            //                     Text(
                            //                       // "tt"
                            //                       "${providerproductById.productByIdList?[index]?.name}",
                            //                       maxLines: 2,
                            //                       overflow:
                            //                           TextOverflow.ellipsis,
                            //                       style: const TextStyle(
                            //                           fontWeight:
                            //                               FontWeight.bold),
                            //                     ),
                            //                     const SizedBox(
                            //                       height: 5,
                            //                     ),
                            //                     Text(
                            //                       "${providerproductById.productByIdList?[index]?.price} So'm",
                            //                       style: const TextStyle(
                            //                           fontWeight:
                            //                               FontWeight.w500),
                            //                     )
                            //                   ],
                            //                 ),
                            //               )
                            //             ],
                            //           ),
                            //         ),
                            //       );
                            //     }))
                                )
                    : ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: providerTopProducts.topProductList?.length,
                        itemBuilder: ((context, index) {
                          // index = category_id;
                          return InkWell(
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
                                            child: CircularProgressIndicator
                                                .adaptive(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(right: 24),
                                              height: 24,
                                              width: 24,
                                              child: IconButton(
                                                  onPressed: () async {
                                                    setState(() {
                                                       providerFavorite.addIdsToFavorite(providerTopProducts.topProductList?[index]?.id);
                                                       HiveDB.getFavoriteBox();
                                                       providerFavv.addIdsToFav(providerTopProducts.topProductList?[index]?.id.toString());
                                                      
                                                    });
                                                  },
                                                  icon: 
                                                  (

                                                    HiveDB.getFavoriteBox().contains(providerTopProducts.topProductList?[index]?.id)
                                                    )
                                                      ? Icon(Icons.favorite,color: Colors.deepOrangeAccent,)
                                                      : Icon(Icons.favorite_border_outlined,color: Colors.deepOrangeAccent)),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }))
              ]),
            ),
    );
  }
}
