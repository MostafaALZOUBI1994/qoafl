import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:qawafel/models/item_in_cart.dart';
import 'package:qawafel/repository/productRepo.dart';
import 'package:qawafel/ui/widgets/cart_item.dart';

import '../../constants.dart';

class CartItems extends StatelessWidget {
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
                    verticalOffset: 50.0,child: FadeInAnimation(child: CartItem(item: item,)),
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

