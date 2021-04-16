import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:qawafel/constants.dart';
import 'package:qawafel/ui/screens/payment_screen.dart';
import 'package:qawafel/ui/screens/shipping_address.dart';

import 'cart_items.dart';
import 'delivery_info.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> with SingleTickerProviderStateMixin {
  TabController _controller;
  int _tab = 0;
  @override
  void initState() {
    _controller = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(24),
          ),
          Row(children: [
            SizedBox(
              width: ScreenUtil().setWidth(11),
            ),
            Text(
              "My Cart",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(20),
                  fontWeight: FontWeight.bold),
            ),
          ]),
          DefaultTabController(
            length: 4,
            child: TabBar(
              unselectedLabelColor: Colors.grey,
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).primaryColor,
              isScrollable: true,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
              tabs: [
                Tab(
                  child: InkWell(
                    onTap: () {
                      _controller.animateTo(0);
                      setState(() {
                        _tab = 0;
                      });
                    },
                    child: Text('My Cart'),
                  ),
                ),
                Tab(
                  child: InkWell(
                    onTap: () {
                      _controller.animateTo(1);
                      setState(() {
                        _tab = 1;
                      });
                    },
                    child: Text("Address"),
                  ),
                ),
                Tab(
                  child: InkWell(
                      onTap: () {
                        _controller.animateTo(2);
                        setState(() {
                          _tab = 2;
                        });
                      },
                      child: Text("Delivery Info")),
                ),
                Tab(
                  child: InkWell(
                      onTap: () {
                        _controller.animateTo(3);
                        setState(() {
                          _tab = 3;
                        });
                      },
                      child: Text("Payment")),
                )
              ],
              controller: _controller,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(586),
            child: TabBarView(
              controller: _controller,
              children: [
                Column(
                  children: [
                    Flexible(
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(19),
                              horizontal: ScreenUtil().setWidth(13)),
                          child: CartItems()),
                    ),
                    buttonWidget(
                        "Continue to shipping", Theme.of(context).primaryColor,
                        () {
                      _controller.animateTo(1);
                      setState(() {
                        _tab = 1;
                      });
                    }),
                    SizedBox(
                      height: ScreenUtil().setHeight(38),
                    )
                  ],
                ),
                Address(
                  controller: _controller,
                ),
                DeliveryInfo(controller: _controller),
                PaymentScreen(controller: _controller)
              ],
            ),
          ),
        ],
      ),
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
