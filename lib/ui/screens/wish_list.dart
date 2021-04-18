import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:qawafel/constants.dart';
import 'package:qawafel/models/product.dart';
import 'package:qawafel/repository/productRepo.dart';
import 'package:qawafel/ui/screens/product_detail.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top:ScreenUtil().setHeight(20)),
      child: FutureBuilder(
        future: ProductRepo().getWishList(kUser.userId.toString()),
        builder: (context, productSnap) {
          if (productSnap.connectionState == ConnectionState.done) {
            if (productSnap.data == null) {
              return Text('no data');
            } else {
              return Container(
                child: AnimationLimiter(
                  child: GridView.count(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10,
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
                                child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(18),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  Product product = await ProductRepo()
                                      .getProductDetailsByUrl(
                                          productSnap.data[index].links.details,kUser.userId);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetail(
                                              product: product,
                                            )),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.0),
                                    color: const Color(0xffffffff),
                                    border: Border.all(
                                        width: 0.1,
                                        color: const Color(0xff000000)),
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
                                          imageUrl: mediaUrl +
                                              productSnap
                                                  .data[index].thumbnailImage,
                                          placeholder: (context, url) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator()),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(5),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          productSnap.data[index].name,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(14)),
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
                                            rating: productSnap.data[index].rating
                                                .toDouble(),
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
                                            productSnap.data[index].basePrice
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: ScreenUtil().setSp(14),
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            }
          } else {
            return Center(child: CircularProgressIndicator()); // loading
          }
        },
      ),
    );
  }
}
