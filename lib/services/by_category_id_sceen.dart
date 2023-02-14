import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/screens/detail_screen.dart';
import 'package:online_shop/view_model/get_products_by_id_view_model.dart';
import 'package:provider/provider.dart';

class ByCategoryScreen extends StatelessWidget {
  int? categoryId;
  ByCategoryScreen(
      // {Key? key}) : super(key: key
      this.categoryId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerProductsByIdVM =
        Provider.of<ProductByIdViewModel>(context, listen: false);
    providerProductsByIdVM.ProductByIdVM(categoryId!);

    var providerproductById = Provider.of<ProductByIdViewModel>(context);
    return 
    providerproductById.productByIdList!.isEmpty ? Center(child: Column(
      children: [
        SizedBox(height: 50,),
        Text("Empty"),
      ],
    ),) :
   ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: providerproductById.productByIdList?.length,
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
                          providerproductById.productByIdList![index],
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
                      progressIndicatorBuilder: (context, url, progress) {
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
                          // "tt"
                          "${providerproductById.productByIdList?[index]?.name}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${providerproductById.productByIdList?[index]?.price} So'm",
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }
}
