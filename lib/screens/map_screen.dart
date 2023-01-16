
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/get_categories_view_model.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
     final providerGetCategoris =
        Provider.of<GetCategoriesViewModel>(context, listen: false);
    providerGetCategoris.getCategories();
  }

  @override
  Widget build(BuildContext context) {

var providerCategories =
        Provider.of<GetCategoriesViewModel>(context, listen: true);


    return Center(child:
    providerCategories.loading ? CircularProgressIndicator.adaptive() :
    Container(
          height: 50,
          child: ListView.builder(
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
                      border: Border.all(width: 1,color: Colors.deepOrangeAccent)
                      ),
                  child: Center(
                      child: Text(
                          "${providerCategories.getCategoriesList?[index]?.title}")),
                );
              })),
        ),
    );
  }
}