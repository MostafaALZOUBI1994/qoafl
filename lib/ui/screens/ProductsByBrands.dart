import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qawafel/models/brand.dart';
import '../../constants.dart';
import '../../models/category.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "../../repository/categoryRepo.dart";
import '../../repository/productRepo.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../models/product.dart';
import '../../ui/screens/product_detail.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';



class ProductByBrand extends StatefulWidget {
  final Brand brandProducts;

  const ProductByBrand({Key key, this.brandProducts}) : super(key: key);
  @override
  _ProductByBrandState createState() => _ProductByBrandState();
}

class _ProductByBrandState extends State<ProductByBrand> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Brands",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setHeight(20),
              horizontal: ScreenUtil().setWidth(10)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.brandProducts.name,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(20),
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(onTap:
                    (){
                    Navigator.of(context).pop();
                    },child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 1.0, color: const Color(0xfff16a29)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset("assets/grid.svg"),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: ScreenUtil().setHeight(10),),
              Container(
                width: ScreenUtil().setWidth(375),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: const Color(0xfff9f9f9),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(9),
                      vertical: ScreenUtil().setHeight(18)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Products",
                            style: TextStyle(
                                color: Color.fromRGBO(112, 112, 112, 1.0),
                                fontSize: ScreenUtil().setSp(20),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10),),
                      Container(
                        child: FutureBuilder(
                          future: ProductRepo().fetchProductsByCategory(widget.brandProducts.links.products),
                          builder: (context, productSnap) {
                            if (productSnap.connectionState == ConnectionState.done) {
                              if (productSnap.data == null) {
                                return Text('no data');
                              } else {
                                return  Container(
                                  child:  AnimationLimiter(
                                    child: GridView.count(shrinkWrap: true,scrollDirection: Axis.vertical,physics:NeverScrollableScrollPhysics(),
                                      crossAxisCount: 2,crossAxisSpacing:5,mainAxisSpacing: 10,
                                      children: List.generate(
                                        productSnap.data.length,
                                            (int index) {
                                          print(productSnap.data[index]);
                                          return AnimationConfiguration.staggeredGrid(
                                            position: index,
                                            duration: const Duration(milliseconds: 500),
                                            columnCount: 2,
                                            child: ScaleAnimation(
                                              child: FadeInAnimation(
                                                  child:Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: ScreenUtil().setWidth(18),),
                                                    child: InkWell(
                                                      onTap: () async {
                                                        Product  product=await ProductRepo().getProductDetails(productSnap.data[index].id,kUser.userId);
                                                        Navigator.push (
                                                          context,
                                                          MaterialPageRoute(builder: (context) => ProductDetail(product: product,)),
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(6.0),
                                                          color: const Color(0xffffffff),
                                                          border: Border.all(
                                                              width: 0.1, color: const Color(0xff000000)),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: const Color(0x1a000000),
                                                              offset: Offset(0, 0),
                                                              blurRadius: 5,
                                                            ),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: ScreenUtil().setHeight(5),
                                                            ),
                                                            Container(
                                                              height: ScreenUtil().setHeight(87),
                                                              child: CachedNetworkImage(
                                                                imageUrl:
                                                                mediaUrl +productSnap.data[index].thumbnailImage,
                                                                placeholder: (context, url) => Padding(
                                                                  padding: const EdgeInsets.all(8.0),
                                                                  child: Center(child: CircularProgressIndicator()),
                                                                ),
                                                                errorWidget: (context, url, error) =>
                                                                    Icon(Icons.error),
                                                              ),
                                                            ),

                                                            SizedBox(
                                                              height: ScreenUtil().setHeight(5),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                              child: Text(
                                                                productSnap.data[index].name,
                                                                overflow: TextOverflow.ellipsis,
                                                                style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: ScreenUtil().setHeight(5),
                                                            ),
                                                            SizedBox(
                                                              height: ScreenUtil().setHeight(5),
                                                            ),
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: ScreenUtil().setWidth(8),
                                                                ),
                                                                RatingBarIndicator(
                                                                  rating: productSnap.data[index].rating.toDouble(),
                                                                  itemBuilder: (context, index) => Icon(
                                                                    Icons.star,
                                                                    color: Colors.amber,
                                                                  ),
                                                                  itemCount: 5,
                                                                  itemSize: ScreenUtil().setWidth(10),
                                                                  direction: Axis.horizontal,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: ScreenUtil().setHeight(5),
                                                            ),
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: ScreenUtil().setWidth(8),
                                                                ),
                                                                Text(
                                                                  productSnap.data[index].basePrice,
                                                                  style: TextStyle(
                                                                      fontSize: ScreenUtil().setSp(14),
                                                                      color: Theme.of(context).primaryColor),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }  else {
                              return Center(child: CircularProgressIndicator()); // loading
                            }
                          },

                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
