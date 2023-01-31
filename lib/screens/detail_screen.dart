import 'package:flutter/material.dart';
import 'package:online_shop/models/get_top_products.dart';

class DetailScreen extends StatelessWidget {
  
DatumTopProducts? topProductListItem;

  DetailScreen(
     {
      required this.topProductListItem,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text("Detail"),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: IconButton(onPressed: (){

            }, icon: Icon(Icons.favorite_border))
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Container(
                    decoration:  BoxDecoration(
                      image: DecorationImage(image: NetworkImage("http://osonsavdo.devapp.uz/images/${topProductListItem!.image}"),
                      )
                      ),
                    width: double.infinity,
                    height: 200,
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.circular(5.0)
                      ),
                      width: 20,
                      height: 8,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(topProductListItem!.name.toString()),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Price: "+topProductListItem!.price.toString()+"Som"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: const Center(child: Text("Add to Cart",style: TextStyle(color: Colors.white),)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
