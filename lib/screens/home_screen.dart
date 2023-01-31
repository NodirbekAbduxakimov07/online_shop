import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:online_shop/models/get_top_products.dart';
import 'package:online_shop/screens/detail_screen.dart';
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
    providerProductsByIdVM.ProductByIdVM(category_id);

    final providerVM = Provider.of<FavoritesViewModel>(context, listen: false);
    // providerVM.addFavoriteList(topProduct);
  }

// List<DatumTopProducts?>? topProduct;
  DatumTopProducts? topProduct;

  bool checkedCategory = false;
  int currentlyIndex = -1;
  int category_id = 8;
  int test = -2;

  // callback(varTopic){
  //   setState(() {
  //     varTopic = category_id;
  //   });
  // }
  void changeID(changeId) {
    setState(() {
      changeId = category_id;
    });
  }

  List<Map<String, dynamic>> _items = [];

  final _shoppingBox = Hive.box('shopping_box');

  Future<List<DatumTopProducts?>?> _createItem(
      List<DatumTopProducts?>? newItem) async {
    await _shoppingBox.add(newItem);
    print("amount data is ${_shoppingBox.length}");
    return newItem;
  }

  final String name = "";
  final String price = "";

  List favoriteIds = [];
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
                                  category_id = providerCategories
                                      .getCategoriesList![index]!.id!;
                                  print("checkItem  $category_id");
                                  print("$currentlyIndex");
                                  changeID(category_id);
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
                        currentlyIndex == test)
                    ? Container(
                        child: (providerproductById.loading)
                            ? CircularProgressIndicator.adaptive()
                            : ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount:
                                    providerproductById.productByIdList?.length,
                                itemBuilder: ((context, index) {
                                  // print("object");
                                  // index = category_id;
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                              topProductListItem:
                                                  providerproductById
                                                      .productByIdList![index],
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
                                                  "http://osonsavdo.devapp.uz/images/${providerproductById.productByIdList?[index]?.image}",
                                              progressIndicatorBuilder:
                                                  (context, url, progress) {
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator
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
                                                  // "tt"
                                                  "${providerproductById.productByIdList?[index]?.name}",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${providerproductById.productByIdList?[index]?.price} So'm",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                })))
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
                                          // "tt"
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
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                final checkedId =favoriteIds.contains(providerTopProducts.topProductList?[index]?.id);
                                                if (checkedId) {
                                                  favoriteIds.remove(
                                                      providerTopProducts
                                                          .topProductList?[
                                                              index]
                                                          ?.id);
                                                  addToFavorite = false;
                                                  currentlyCheckedIndex = index;
                                                } else {
                                                  favoriteIds.add(
                                                      providerTopProducts
                                                          .topProductList?[
                                                              index]
                                                          ?.id);
                                                  addToFavorite = true;
                                                }
                                                print(
                                                    "setSta ${favoriteIds.length}");
                                              });
                                            },
                                            icon: (favoriteIds.contains(
                                                    providerTopProducts
                                                        .topProductList?[index]
                                                        ?.id))
                                                ? Icon(Icons.favorite)
                                                : Icon(Icons
                                                    .favorite_border_outlined))
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
