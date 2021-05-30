import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:qawafel/models/item_in_cart.dart';
import 'package:qawafel/repository/productRepo.dart';
import 'package:qawafel/ui/widgets/cart_item.dart';

import '../../constants.dart';

class CartItems extends StatefulWidget {
  @override
  _CartItemsState createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future:  ProductRepo().getCartProducts(kUser.userId),initialData: [],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return Text('Your Cart is Empty');
            }else{
              return AnimationLimiter(
                child: ListView.builder(shrinkWrap: true,itemCount:snapshot.data.length ,itemBuilder: (context, index) {
                  ItemInCart item=snapshot.data[index];
                  return AnimationConfiguration.staggeredList(position: index, duration: Duration(milliseconds: 375),child: SlideAnimation(
                    verticalOffset: 50.0,child: FadeInAnimation(child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(ScreenUtil().setWidth(10.0)),
                      color: const Color(0xffffffff),
                    ),child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(17),vertical: ScreenUtil().setHeight(24)),
                    child: Column(children: [
                      Row(
                        children: [
                          Text("Product",style: TextStyle(color: grey,fontSize: ScreenUtil().setSp(20),fontWeight: FontWeight.w600)),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setHeight(17),),
                      Row(
                        children: [
                          Expanded(child: Text(item.product.name)),
                        ],
                      ),
                      SizedBox(height: ScreenUtil().setHeight(17),),
                      Divider(height: 2.0,color: grey,),
                      SizedBox(height: ScreenUtil().setHeight(17),),
                      Row(children: [Text("Price",style: TextStyle(color: grey,fontSize: ScreenUtil().setSp(20),fontWeight: FontWeight.w600)),],),
                      SizedBox(height: ScreenUtil().setHeight(17),),
                      Row(children: [Text(item.price.toString()),],),
                      SizedBox(height: ScreenUtil().setHeight(17),),
                      Divider(height: 2.0,color: grey,),
                      SizedBox(height: ScreenUtil().setHeight(17),),
                      Row(children: [Text("Tax",style: TextStyle(color: grey,fontSize: ScreenUtil().setSp(20),fontWeight: FontWeight.w600)),],),
                      SizedBox(height: ScreenUtil().setHeight(17),),
                      Row(children: [Text(item.tax.toString()),],),
                      SizedBox(height: ScreenUtil().setHeight(17),),
                      Divider(height: 2.0,color: grey,),
                      SizedBox(height: ScreenUtil().setHeight(17),),
                      Row(children: [Text("Quantity",style: TextStyle(color: grey,fontSize: ScreenUtil().setSp(20),fontWeight: FontWeight.w600)),],),
                      SizedBox(height: ScreenUtil().setHeight(17),),
                      Padding(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(11),
                          left: ScreenUtil().setWidth(100),

                        ),
                        child: Row(
                          children: [
                            InkWell(
                                onTap: () async {
                                  setState(() {
                                    item.quantity--;
                                  });
                                  await ProductRepo().changeQuantity(item.id, item.quantity);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(9999.0, 9999.0)),
                                    color: const Color(0xffffffff),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x19000000),
                                        offset: Offset(0, 0),
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                  child: Icon(Icons.remove),
                                )),
                            SizedBox(
                              width: ScreenUtil().setWidth(15),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: const Color(0xffffffff),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x19000000),
                                    offset: Offset(0, 0),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22.0, vertical: 4),
                                child: Text(item.quantity.toString()),
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(15),
                            ),
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  item.quantity++;
                                });
                                await ProductRepo().changeQuantity(item.id, item.quantity);

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(9999.0, 9999.0)),
                                  color: const Color(0xffffffff),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0x19000000),
                                      offset: Offset(0, 0),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                                child: Icon(Icons.add),
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(80),
                            ),
                          ],
                        ),),
                      SizedBox(height: ScreenUtil().setHeight(17),),
                      Divider(height: 2.0,color: grey,),
                      SizedBox(height: ScreenUtil().setHeight(17),),
                      Center(child:Text("Total",style:  TextStyle(fontWeight: FontWeight.w600, fontSize: ScreenUtil().setSp(20),
                          color: Theme.of(context).primaryColor),
                      ),),

                      SizedBox(height: ScreenUtil().setHeight(17),),
                      Center(child:Text((item.quantity*item.price).toString(),style:  TextStyle(fontWeight: FontWeight.w600, fontSize: ScreenUtil().setSp(14),
                          color: Theme.of(context).primaryColor),
                      ),),
                      SizedBox(height: ScreenUtil().setHeight(17),),
                      buttonWidget("Delete",Theme.of(context).accentColor,() async {
                        await   ProductRepo().removeFromCart(item.id, kUser.accessToken);
                        setState(() {

                        });
                      })
                    ],),
                  ),
                  )),
                  ));
                }),
              );
            }}else{
            return CircularProgressIndicator();
          }
        }
    );
  }

  Widget buttonWidget(String text, Color color, Function f) {
    return InkWell(
      onTap: f,
      child: Container(
        height: ScreenUtil().setHeight(31),
        width: ScreenUtil().setWidth(209),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(4)),
          color: color,
        ),
        child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(14),
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            )),
      ),
    );
  }
}

