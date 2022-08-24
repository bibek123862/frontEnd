import 'package:clothing_roll/http/httpProduct.dart';
import 'package:clothing_roll/model/productModel.dart';
import 'package:clothing_roll/sqfliteDatabase/db_provider.dart';
import 'package:clothing_roll/ui/screens/productDetail_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:logger/logger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

  final sliderImages = [
    "images/slider/s1.jpg",
    "images/slider/s2.jpg",
    "images/slider/s3.jpg",
  ];


  late Future<List<Product>> futureProducts;
  late Future<List<Product>> dbProvider;
  String photourl = 'http://10.0.2.2:8000/';
  var log = Logger();
  // var dbProvider = DBProvider.db.getAllProduct();

  @override
  void initState() {
    super.initState();
    futureProducts = HttpProduct().getProducts();
    log.i(futureProducts);
    dbProvider = DBProvider.db.getAllProduct();
    log.i(dbProvider);
  }


  Widget MyContainer(Product obj){
    return  
    Container(
              child: InkWell(
                child: Card(
                // color: Colors.cyan[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  elevation: 5.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image(image: NetworkImage(photourl+obj.productThumbnail!),
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                        )
                        ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "${obj.productName}",
                          maxLines: 1,
                          style: TextStyle(fontSize: 15, fontFamily: 'openSans', color: Colors.black87),
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "${obj.productActualPrice} /-",
                          style: TextStyle(fontSize: 15, fontFamily: 'openSans', color: Colors.deepOrange[700]),
                          ),
                      )
                    ],
                  ),
                              
                  ),
                onTap: () => {
                  Navigator.of(context)
                    .push(MaterialPageRoute(
                    builder: (context)=>productDetailPage(id:obj.id)
                  ))
                },
              )
            );

  }

  @override
  Widget build(BuildContext context) {
    return
    
    Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(

              child: FutureBuilder<List<Product>>(
                future: futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return MyContainer(snapshot.data![index]);
                      },

                      );
                  }
                  else{
                    return Text("there is no data !!");
                  }
                },
                )
            ),

            
    );

   
  
  }
}



      // Column(
      //   children: [
      //     // Container(
      //     //   margin: EdgeInsets.only(top: 10, bottom: 5),
      //     //   width: MediaQuery.of(context).size.width * 1.0,
      //     //   height: MediaQuery.of(context).size.height * 0.15,
      //     //   child: CarouselSlider.builder(
      //     //     itemCount: sliderImages.length,
      //     //     itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
      //     //       SizedBox(
      //     //           width: MediaQuery.of(context).size.width*1.0,
      //     //           child: ClipRRect(
      //     //             borderRadius: BorderRadius.circular(10),
      //     //             child: Image.asset(sliderImages[itemIndex], width: 100,),
      //     //             )
                  
      //     //       ),
                

      //     //     options: CarouselOptions(
      //     //       // height: 400,
      //     //       aspectRatio: 16/9,
      //     //       autoPlay: true,
      //     //       enableInfiniteScroll: true,
      //     //       viewportFraction: 0.9,
      //     //       // enlargeCenterPage: true,
      //     //       autoPlayAnimationDuration: Duration(milliseconds: 800)
      //     //       ),
      //     //     ),
      //     // ),



          

          
      //   ],
      // ),
    
    
