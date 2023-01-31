// import 'dart:ffi';

// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class ProductsById extends StatelessWidget {
//   final Int category_id;
//   const ProductsById({Key? key, required this.category_id}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return              ListView.builder(
//                     shrinkWrap: true,
//                     primary: false,
//                     itemCount: providerproductById.productByIdList?.length,
//                     itemBuilder: ((context, index) {
//                       // print("object");
//                       // index = category_id;
//                       return InkWell(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => DetailScreen(
//                                   topProductListItem: providerproductById
//                                       .productByIdList![index],
//                                 ),
//                               ));
//                         },
//                         child: Card(
//                           child: Row(
//                             children: [
//                               Container(
//                                 margin: const EdgeInsets.all(5.0),
//                                 width: 100,
//                                 height: 100,
//                                 // color: Colors.green,
//                                 child: CachedNetworkImage(
//                                   imageUrl:
//                                       "http://osonsavdo.devapp.uz/images/${providerproductById.productByIdList?[index]?.image}",
//                                   progressIndicatorBuilder:
//                                       (context, url, progress) {
//                                     return Center(
//                                         child:
//                                             CircularProgressIndicator.adaptive(
//                                       value: progress.progress,
//                                     ));
//                                   },
//                                 ),
//                               ),
//                               const SizedBox(
//                                 width: 5,
//                               ),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       // "tt"
//                                       "${providerproductById.productByIdList?[index]?.name}",
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     Text(
//                                       "${providerproductById.productByIdList?[index]?.price} So'm",
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.w500),
//                                     )
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       );
//                     })
//                     )
//   }
// }