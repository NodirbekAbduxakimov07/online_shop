import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:online_shop/view_model/get_categories_view_model.dart';
import 'package:online_shop/view_model/get_offer_view_model.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../view_model/top_products_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<GetOfferViewModel>(context, listen: true);

    var providerCategories =
        Provider.of<GetCategoriesViewModel>(context, listen: true);

    var providerTopProducts = Provider.of<TopProductViewModel>(context);

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
                    margin: EdgeInsets.only(top: 5, right: 5, left: 5),
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
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )),
                      options:
                          CarouselOptions(autoPlay: true, viewportFraction: 0.9),
                    )),
                SizedBox(
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
                          itemCount: providerCategories.getCategoriesList?.length,
                          itemBuilder: ((context, index) {
                            return Container(
                              margin: EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(10.0),
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: 1, color: Colors.deepOrangeAccent)),
                              child: Center(
                                  child: Text(
                                      "${providerCategories.getCategoriesList?[index]?.title}")),
                            );
                          })),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: providerTopProducts.topProductList?.length,
                    itemBuilder: ((context, index) {
                      return Card(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5.0),
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
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }))
              ]),
          ),
    );
  }
}
