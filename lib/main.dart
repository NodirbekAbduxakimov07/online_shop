import 'package:flutter/material.dart';
import 'package:online_shop/screens/main_screen.dart';
import 'package:online_shop/view_model/fav_view_model.dart';
import 'package:online_shop/view_model/favorites_view_model.dart';
import 'package:online_shop/view_model/get_categories_view_model.dart';
import 'package:online_shop/view_model/get_offer_view_model.dart';
import 'package:online_shop/view_model/get_products_by_id_view_model.dart';
import 'package:online_shop/view_model/top_products_view_model.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

// const String FAVORITE_BOX = "favorite_box";
void main() async {

WidgetsFlutterBinding.ensureInitialized();

await Hive.initFlutter();
await Hive.openBox('shopping_box');

  // runApp(ChangeNotifierProvider(
  // create: (_)=>GetOfferViewModel(),
  
  // child: const MyApp(),
  // )
  // );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => GetOfferViewModel()),
      ChangeNotifierProvider(create: (_) => GetCategoriesViewModel()),
      ChangeNotifierProvider(create: (_) => TopProductViewModel()),
      ChangeNotifierProvider(create: (_) => ProductByIdViewModel()),
      ChangeNotifierProvider(create: (_) => FavoritesViewModel()),
      ChangeNotifierProvider(create: (_) => FavViewModel())
    ],
    child: const MyApp()),
    );

    
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen()
    );
  }
}
