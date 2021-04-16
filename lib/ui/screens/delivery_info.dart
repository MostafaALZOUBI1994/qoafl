import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:qawafel/models/item_in_cart.dart';
import 'package:qawafel/repository/productRepo.dart';

import '../../constants.dart';

class DeliveryInfo extends StatefulWidget {
  final TabController controller;

  const DeliveryInfo({Key key, this.controller}) : super(key: key);
  @override
  _DeliveryInfoState createState() => _DeliveryInfoState();
}

class _DeliveryInfoState extends State<DeliveryInfo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Column(
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(13),
                      vertical: ScreenUtil().setHeight(21)),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(10.0)),
                      color: const Color(0xffffffff),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(17),
                          vertical: ScreenUtil().setHeight(24)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Product",
                                  style: TextStyle(
                                      color: grey,
                                      fontSize: ScreenUtil().setSp(20),
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          FutureBuilder(
                              future:
                                  ProductRepo().getCartProducts(kUser.userId),
                              initialData: [],
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.data == null) {
                                    return Text('Your Cart is Empty');
                                  } else {
                                    print(snapshot.data);
                                    return AnimationLimiter(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, index) {
                                            return AnimationConfiguration
                                                .staggeredList(
                                                    position: index,
                                                    duration: Duration(
                                                        milliseconds: 375),
                                                    child: SlideAnimation(
                                                      verticalOffset: 50.0,
                                                      child: FadeInAnimation(
                                                          child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: ScreenUtil()
                                                                .setHeight(17),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                               snapshot.data[index].product.name,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: ScreenUtil()
                                                                .setHeight(17),
                                                          ),
                                                          Divider(
                                                            height: 2.0,
                                                            color: grey,
                                                          ),
                                                        ],
                                                      )),
                                                    ));
                                          }),
                                    );
                                  }
                                } else {
                                  return CircularProgressIndicator();
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: ScreenUtil().setWidth(13),
                    ),
                    Text("Choose Delivery Type",
                        style: TextStyle(
                            color: Color.fromRGBO(112, 112, 112, 1.0),
                            fontSize: ScreenUtil().setSp(20),
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(25),
                ),
                buttonWidget(
                    "Home Delivery",
                    Colors.white,
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor,
                    () {}),
                SizedBox(
                  height: ScreenUtil().setHeight(25),
                ),
                buttonWidget("Local Pickup", Colors.white, grey, grey, () {}),
                SizedBox(
                  height: ScreenUtil().setHeight(25),
                ),
                buttonWidget(
                    "Continue to Payment",
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor,
                    Colors.white, () {
                  setState(() {
                    widget.controller.animateTo(3);
                  });
                })
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget buttonWidget(
      String text, Color color, Color border, Color textColor, Function f) {
    return InkWell(
      onTap: f,
      child: Container(
        height: ScreenUtil().setHeight(31),
        width: ScreenUtil().setWidth(209),
        decoration: BoxDecoration(
          border: Border.all(color: border),
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(4)),
          color: color,
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(14),
              color: textColor,
              fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}
