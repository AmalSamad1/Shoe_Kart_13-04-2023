import 'dart:convert';
import 'dart:ffi';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/model/product.dart';

import 'model/shoes_product.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  void initState() {
    super.initState();
    setState(() {
      readData();
    });
    readData();
  }
  List<Products> pro=[];
  bool isLoading = true;
  List<String> description = [];
  List<String> name = [];
  List<String> image = [];

  Future<Void<Products>>readData() async {
    // Please replace the Database URL
    // which we will get in “Add Realtime Database”
    // step with DatabaseURL
    var url = "https://shoes-kart-default-rtdb.firebaseio.com/"+"pruductlist.json";
    // Do not remove “data.json”,keep it as it is
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((blogId, blogData) {

        pro.add(blogData["name"]);
        pro.add(blogData["image"]);
        pro.add(blogData["description"]);
      });
      setState(() {
        isLoading = false;
      });
    } catch (error) {

    }
  }

  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
          builder: (context, snapshot,) {

            if (snapshot.connectionState == ConnectionState.none) {

              return  GridView.builder(
                    itemCount: pro.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0
                    ),
                    itemBuilder: (BuildContext context, int index,){

                      return InkWell(
                          onTap: () {

                          },
                          child: new Card(

                            child: new Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    child: Container(
                                      width: 200,
                                      height: 150,
                                      color: Colors.white,
                                      child: Center(
                                          child: Image(
                                            fit: BoxFit.cover,
                                            image: NetworkImage("${pro.first.image![index]}"),
                                          )
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),

                                Text("${pro.first.name![index]}"),
                              ],
                            ),
                            elevation: 2.0,
                            margin: EdgeInsets.all(5.0),
                          )
                      );
                    },
                  );
            }else{
              return CircularProgressIndicator();
            }
          },
        ),
    );
        // isLoading
        //     ? CircularProgressIndicator()
        //     :  GridView.builder(
        //   itemCount: name.length,
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 2,
        //       crossAxisSpacing: 4.0,
        //       mainAxisSpacing: 4.0
        //   ),
        //   itemBuilder: (BuildContext context, int index){
        //     return InkWell(
        //         onTap: () {
        //
        //         },
        //         child: new Card(
        //           child: new Column(
        //             mainAxisSize: MainAxisSize.min,
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: <Widget>[
        //               new Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: ClipRRect(
        //                   child: Container(
        //                     width: 200,
        //                     height: 150,
        //                     color: Colors.white,
        //                     child: Center(
        //                         child: Image(
        //                           fit: BoxFit.cover,
        //                           image: NetworkImage(image[index]),
        //                         )
        //                     ),
        //                   ),
        //                   borderRadius: BorderRadius.circular(12.0),
        //                 ),
        //               ),
        //
        //               Text(name[index]),
        //             ],
        //           ),
        //           elevation: 2.0,
        //           margin: EdgeInsets.all(5.0),
        //         ));
        //   },
        // )
    // );

    // ListView.builder(
        //   itemCount: name.length,
        //     itemBuilder: (context, index) {
        //       return Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: SizedBox(
        //             width: 100,
        //             height: 150,
        //             child: Card(
        //               shape: Border(
        //                   left: BorderSide(color: Colors.blueGrey, width: 5)),
        //               child:
        //                   ListTile(
        //                     leading: SizedBox(
        //                       width: 100,
        //                       height: 50,
        //                       child: Image(
        //                         fit: BoxFit.fill,
        //                         image: NetworkImage('${image[index]}'),
        //                       ),
        //                     ),
        //                     title: Text("${name[index]}"),
        //                     subtitle: Text("${description[index]}"),
        //
        //                   ),
        //
        //             ),
        //           ));
        //     },
        // )

  }
}