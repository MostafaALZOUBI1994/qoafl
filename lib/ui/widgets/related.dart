import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:qawafel/models/product.dart';
import 'package:qawafel/repository/productRepo.dart';
import 'package:qawafel/ui/screens/product_detail.dart';

import '../../constants.dart';
class ReltedProducts extends StatefulWidget {
  final Product product;

  const ReltedProducts({Key key, this.product}) : super(key: key);
  @override
  _ReltedProductsState createState() => _ReltedProductsState();
}

class _ReltedProductsState extends State<ReltedProducts> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom:ScreenUtil().setHeight(200)),
      child: Container(
        child: FutureBuilder(
          future: ProductRepo().fetchRelatedProducts(widget.product.id.toString()),
          builder: (context, productSnap) {
            if (productSnap.connectionState == ConnectionState.done) {
              if (productSnap.data == null) {
                return Text('no data');
              } else {
                return  Container(height: ScreenUtil().setHeight(170),
                  child: ListView.builder(scrollDirection: Axis.horizontal,shrinkWrap: true,
                    itemCount: productSnap.data.length,
                    itemBuilder: (context, index) {
                      Product product = productSnap.data[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(10),vertical: ScreenUtil().setHeight(10)),
                        child: InkWell(
                          onTap: () async {
                            Product relatedProduct= await ProductRepo().getProductDetails(product.id,kUser.userId);
                            Navigator.push (
                              context,
                              MaterialPageRoute(builder: (context) => ProductDetail(product: relatedProduct,)),
                            );
                          },
                          child: Container(
                            width: ScreenUtil().setWidth(154),
                          //  height: ScreenUtil().setHeight(22.0),
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
                                  height: ScreenUtil().setHeight(50),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                    mediaUrl + product.thumbnailImage,
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
                                    product.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                                  ),
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
                                      rating: product.rating.toDouble(),
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
                                      product.basePrice.toString(),
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(14),
                                          color: Theme.of(context).primaryColor),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );

                    },
                  ),
                );
              }
            }  else {
              return Center(child: CircularProgressIndicator()); // loading
            }


          },

        ),
      ),
    );
  }
}
