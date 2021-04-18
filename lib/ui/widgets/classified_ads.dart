import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qawafel/bloc/Product_bloc/product_bloc.dart';
import '../screens/product_detail.dart';
import '../../constants.dart';
import '../../models/product.dart';
import '../../repository/productRepo.dart';

class ClassifeidList extends StatefulWidget {
  @override
  _ClassifeidListState createState() => _ClassifeidListState();
}

class _ClassifeidListState extends State<ClassifeidList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ProductRepo().fetchClassifiedAds(),
      builder: (context, productSnap) {
        if (productSnap.connectionState == ConnectionState.done) {
          if (productSnap.data == null) {
            return Text('no data');
          } else {
            return  Container(
              child: ListView.builder(scrollDirection: Axis.horizontal,shrinkWrap: true,
                itemCount: productSnap.data.length,
                itemBuilder: (context, index) {
                  Product product = productSnap.data[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(10),vertical: ScreenUtil().setHeight(10)),
                    child: InkWell(
                      onTap: () async {
                        Product productDetails= await ProductRepo().getProductDetailsByUrl(product.links.details,kUser.userId);
                        Navigator.push (
                          context,
                          MaterialPageRoute(builder: (context) => ProductDetail(product: productDetails,)),
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

    );
  }
}
/*
ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(10)),
                  child: InkWell(
                    onTap: () async {
                      Product  product=await ProductRepo().getProductDetails(state.products[index].id);
                      Navigator.push (
                        context,
                        MaterialPageRoute(builder: (context) => ProductDetail(product: product,)),
                      );
                    },
                    child: Container(
                      width: ScreenUtil().setWidth(154),
                      height: ScreenUtil().setHeight(222.0),
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
                                  mediaUrl + state.products[index].thumbnailImage,
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
                          SizedBox(
                            height: ScreenUtil().setHeight(5),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              state.products[index].name,
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
                                rating: state.products[index].rating.toDouble(),
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
                                "\$"+state.products[index].basePrice.toString(),
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
                );
              });
 */