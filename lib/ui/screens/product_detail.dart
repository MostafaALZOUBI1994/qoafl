import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:like_button/like_button.dart';
import 'package:qawafel/constants.dart';
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import 'package:qawafel/ui/widgets/related.dart';
import 'package:qawafel/ui/widgets/snakbar.dart';
import 'package:qawafel/ui/widgets/video_widget.dart';
import 'package:video_player/video_player.dart';
import '../../models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animations/animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "../../repository/productRepo.dart";

class ProductDetail extends StatefulWidget {
  final Product product;

  const ProductDetail({Key key, this.product}) : super(key: key);
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int selectedPhoto = 0;
  int selectedDetail = 0;
  bool _onFirstPage = true;
  int quantity = 1;
  bool isLiked=false;
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {

    // Create an store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4",
    );

    _initializeVideoPlayerFuture = _controller.initialize();

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details",
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
      body: Padding(
        padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(20),
            bottom: ScreenUtil().setHeight(20)),
        child: Container(
          decoration: BoxDecoration(
              color: backColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(13)),
            child: ListView(
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Container(
                  height: ScreenUtil().setHeight(165),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          height: ScreenUtil().setHeight(185),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9.0),
                            gradient: RadialGradient(
                              center: Alignment(0.0, 0.0),
                              radius: 0.717,
                              colors: [
                                const Color(0xffffffff),
                                const Color(0xfffecc0c)
                              ],
                              stops: [0.0, 1.0],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CachedNetworkImage(
                              imageUrl: mediaUrl +
                                  widget.product.photos[selectedPhoto],
                              placeholder: (context, url) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        )),
                        SizedBox(
                          width: ScreenUtil().setWidth(7),
                        ),
                        Expanded(
                          child: Column(children: [
                            Text(
                              widget.product.name,
                              maxLines: 2,
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(17),
                            ),
                            Row(
                              children: [
                                widget.product.brand.logo == null
                                    ? Container()
                                    : Container(
                                        height: ScreenUtil().setWidth(30),
                                        width: ScreenUtil().setWidth(30),
                                        child: CachedNetworkImage(
                                          imageUrl: mediaUrl +
                                              widget.product.brand.logo,
                                          placeholder: (context, url) =>
                                              Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(15),
                                ),
                                RatingBarIndicator(
                                  rating: widget.product.ratingCount.toDouble(),
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
                              height: ScreenUtil().setHeight(17),
                            ),
                            Container(
                              height: ScreenUtil().setHeight(65),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: widget.product.photos.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedPhoto = index;
                                      });
                                    },
                                    child: Container(
                                      width: ScreenUtil().setWidth(62),
                                      height: ScreenUtil().setWidth(62),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            ScreenUtil().setWidth(9.2)),
                                        border: Border.all(
                                            width: 1.0,
                                            color: index == selectedPhoto
                                                ? Theme.of(context).primaryColor
                                                : Color(0xff707070)),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: mediaUrl +
                                            widget.product.photos[index],
                                        placeholder: (context, url) => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Container(
                  height: ScreenUtil().setHeight(35),
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                        width: ScreenUtil().setHeight(11),
                      ),
                      InkWell(
                        onTap: () {
                          selectedDetail == 0
                              ? () {}
                              : setState(() {
                                  selectedDetail = 0;
                                  //  selectedPhoto = ;
                                });
                        },
                        child: Container(
                          width: ScreenUtil().setWidth(87),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23.0),
                            color: selectedDetail == 0
                                ? Color(0xfff16a29)
                                : Colors.white,
                            border: Border.all(
                                width: 1.0, color: const Color(0xffe2e5ec)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Center(
                              child: Text(
                                "Price",
                                style: TextStyle(
                                    color: selectedDetail == 0
                                        ? Colors.white
                                        : Color.fromRGBO(137, 139, 146, 1.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(11),
                      ),
                      InkWell(
                        onTap: () {
                          selectedDetail == 1
                              ? () {}
                              : setState(() {
                                  selectedDetail = 1;
                                  //  selectedPhoto = ;
                                });
                        },
                        child: Container(
                          width: ScreenUtil().setWidth(87),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23.0),
                            color: selectedDetail == 1
                                ? Color(0xfff16a29)
                                : Colors.white,
                            border: Border.all(
                                width: 1.0, color: const Color(0xffe2e5ec)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Center(
                              child: Text(
                                "Description",
                                style: TextStyle(
                                    color: selectedDetail == 1
                                        ? Colors.white
                                        : Color.fromRGBO(137, 139, 146, 1.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setHeight(11),
                      ),
                      InkWell(
                        onTap: () {
                          selectedDetail == 2
                              ? () {}
                              : setState(() {
                                  selectedDetail = 2;
                                  //  selectedPhoto = ;
                                });
                        },
                        child: Container(
                          width: ScreenUtil().setWidth(87),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23.0),
                            color: selectedDetail == 2
                                ? Color(0xfff16a29)
                                : Colors.white,
                            border: Border.all(
                                width: 1.0, color: const Color(0xffe2e5ec)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Center(
                              child: Text(
                                "Video",
                                style: TextStyle(
                                    color: selectedDetail == 2
                                        ? Colors.white
                                        : Color.fromRGBO(137, 139, 146, 1.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(11),
                      ),
                      InkWell(
                        onTap: () {
                          selectedDetail == 3
                              ? () {}
                              : setState(() {
                                  selectedDetail = 3;
                                  //  selectedPhoto = ;
                                });
                        },
                        child: Container(
                          width: ScreenUtil().setWidth(87),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23.0),
                            color: selectedDetail == 3
                                ? Color(0xfff16a29)
                                : Colors.white,
                            border: Border.all(
                                width: 1.0, color: const Color(0xffe2e5ec)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Center(
                              child: Text(
                                "Reviews",
                                style: TextStyle(
                                    color: selectedDetail == 3
                                        ? Colors.white
                                        : Color.fromRGBO(137, 139, 146, 1.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                PageTransitionSwitcher(
                    duration: const Duration(milliseconds: 300),
                    reverse: !_onFirstPage,
                    transitionBuilder: (Widget child,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return SharedAxisTransition(
                        child: child,
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: SharedAxisTransitionType.horizontal,
                      );
                    },
                    child: pageViewContent()
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  pageViewContent() {
    switch (selectedDetail) {
      case 0:
        return Container(
            key: UniqueKey(),
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(12),
                ),
                Container(
                  width: ScreenUtil().setWidth(350.8),
                  height: ScreenUtil().setHeight(630.7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: const Color(0xffffffff),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 12),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: ScreenUtil().setWidth(87),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(23.0),
                                  color: selectedDetail == 3
                                      ? Color(0xfff16a29)
                                      : Colors.white,
                                  border: Border.all(
                                      width: 1.0,
                                      color: Theme.of(context).primaryColor),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Center(
                                    child: Text(
                                      "By price",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 11,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: ScreenUtil().setWidth(87),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(23.0),
                                  color: selectedDetail == 3
                                      ? Color(0xfff16a29)
                                      : Colors.white,
                                  border: Border.all(
                                      width: 1.0,
                                      color: const Color(0xffe2e5ec)),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Center(
                                    child: Text(
                                      "Whole sale",
                                      style: TextStyle(
                                          color: selectedDetail == 3
                                              ? Colors.white
                                              : Color.fromRGBO(
                                                  137, 139, 146, 1.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: ScreenUtil().setWidth(14),
                          ),
                          new RichText(
                            text: new TextSpan(
                              // text: 'This item costs ',
                              children: <TextSpan>[
                                new TextSpan(
                                  text: '\$' +
                                      widget.product.priceHigher.toString(),
                                  style: new TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                new TextSpan(
                                  text: '             \$' +
                                      widget.product.priceLower.toString(),
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(7),
                      ),
                      Divider(
                        height: 1,
                        color: grey,
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(12),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: ScreenUtil().setWidth(14),
                          ),
                          Text(
                            "Sold by",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(12),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: ScreenUtil().setWidth(14),
                          ),
                          Text("Inhouse product"),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(12),
                      ),
                      Divider(
                        height: 1,
                        color: grey,
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(12),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: ScreenUtil().setWidth(14),
                          ),
                          Text(
                            "Quantity",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(150),
                          ),
                          Text(
                            "Total Price",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(11),
                          left: ScreenUtil().setWidth(14),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  quantity == 1
                                      ? () {}
                                      : setState(() {
                                          quantity--;
                                        });
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
                                child: Text(quantity.toString()),
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(15),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  quantity++;
                                });
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
                            Text(
                              (quantity * widget.product.priceLower).toString(),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(11),
                            left: ScreenUtil().setWidth(14),
                          ),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: ScreenUtil().setWidth(87),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(23.0),
                                    color: Color(0xfff16a29),
                                    border: Border.all(
                                        width: 1.0,
                                        color: const Color(0xffe2e5ec)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("assets/buynow.svg"),
                                          SizedBox(
                                            width: 1,
                                          ),
                                          Text("Buy Now",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(25),
                              ),
                              InkWell(
                                onTap: () async {
                                  //TODO add to cart
                                  await ProductRepo().addToCart(kUser.userId,widget.product.id);
                                  showSnackBar(context, "The Product added to cart");
                                },
                                child: Container(
                                  width: ScreenUtil().setWidth(87),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(23.0),
                                    color: Colors.white,
                                    border: Border.all(
                                        width: 1.0,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 2.0),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.shopping_cart_outlined,
                                            size: 15,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          Text("Add to cart",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(25),
                              ),
                              LikeButton(

                                  onTap:(nothing) async {


                                if(isLiked){
                                  await ProductRepo().removeFromWishList( widget.product.id);
                                  showSnackBar(context, "The Product removed from Favourites");
                                }
                                else{
                                  await ProductRepo().saveToWishList(kUser.userId, widget.product.id);
                                  showSnackBar(context, "The Product added to Favourites");
                                }
                                setState(() {
                                  isLiked=!isLiked;
                                });

                              },
                                circleColor: CircleColor(
                                    start: Theme.of(context).primaryColor,
                                    end: Theme.of(context).accentColor), isLiked: isLiked

                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(25),
                              ),
                              Icon(Icons.cached, color: grey),
                            ],
                          )),
                      SizedBox(
                        height: ScreenUtil().setHeight(30),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: ScreenUtil().setHeight(11),
                              ),
                              Container(
                                  height: ScreenUtil().setHeight(15),
                                  width: 10,
                                  child: VerticalDivider(
                                      thickness: 3,
                                      color: Theme.of(context).primaryColor)),
                              Text(
                                "Related products",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ScreenUtil().setSp(14)),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: ScreenUtil().setWidth(123),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23.0),
                                color: Theme.of(context).accentColor,
                                border: Border.all(
                                    width: 1.0, color: const Color(0xffe2e5ec)),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(widget.product.category.name,
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                      ReltedProducts(
                        product: widget.product,
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(10),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(120),
                ),
              ],
            ));
        break;
      case 1:
        return Container(
          key: UniqueKey(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: const Color(0xffffffff),
          ),
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: Html(
                data: widget.product.description,
              )),
        );
        break;
      case 2:
        return Container(width: 300,height: 300,
            key: UniqueKey(),
            child: VideoWidget());
        break;
      case 3:
        return Container(
            key: UniqueKey(),
            child: Center(child: Text("No reviews"),));
        break;
    }
  }
}
