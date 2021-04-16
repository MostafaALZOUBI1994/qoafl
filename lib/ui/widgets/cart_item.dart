import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:qawafel/models/item_in_cart.dart';
import 'package:qawafel/repository/productRepo.dart';

import '../../constants.dart';


class CartItem extends StatefulWidget {
  final ItemInCart item;

  const CartItem({Key key, this.item}) : super(key: key);
  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            Text(widget.item.product.name,overflow: TextOverflow.ellipsis,),
          ],
        ),
        SizedBox(height: ScreenUtil().setHeight(17),),
        Divider(height: 2.0,color: grey,),
        SizedBox(height: ScreenUtil().setHeight(17),),
        Row(children: [Text("Price",style: TextStyle(color: grey,fontSize: ScreenUtil().setSp(20),fontWeight: FontWeight.w600)),],),
        SizedBox(height: ScreenUtil().setHeight(17),),
        Row(children: [Text(widget.item.price.toString()),],),
        SizedBox(height: ScreenUtil().setHeight(17),),
        Divider(height: 2.0,color: grey,),
        SizedBox(height: ScreenUtil().setHeight(17),),
        Row(children: [Text("Tax",style: TextStyle(color: grey,fontSize: ScreenUtil().setSp(20),fontWeight: FontWeight.w600)),],),
        SizedBox(height: ScreenUtil().setHeight(17),),
        Row(children: [Text(widget.item.tax.toString()),],),
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
                      widget.item.quantity--;
                    });
                    await ProductRepo().changeQuantity(widget.item.id, widget.item.quantity);
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
                  child: Text(widget.item.quantity.toString()),
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(15),
              ),
              InkWell(
                onTap: () async {
                  setState(() {
                    widget.item.quantity++;
                  });
                  await ProductRepo().changeQuantity(widget.item.id, widget.item.quantity);
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
        Center(child:Text((widget.item.quantity*widget.item.price).toString(),style:  TextStyle(fontWeight: FontWeight.w600, fontSize: ScreenUtil().setSp(14),
            color: Theme.of(context).primaryColor),
        ),),
        SizedBox(height: ScreenUtil().setHeight(17),),
        buttonWidget("Delete",Theme.of(context).accentColor,() async {

       await   ProductRepo().removeFromCart(widget.item.id, kUser.accessToken);
       setState(() {

       });
        })
      ],),
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
