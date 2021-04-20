import 'package:carousel_slider/carousel_slider.dart';
import 'package:qawafel/bloc/classifiedAds_bloc/classifiedAds_bloc.dart';
import 'package:qawafel/bloc/classifiedAds_bloc/classifiedAds_event.dart';
import 'package:qawafel/constants.dart';
import 'package:qawafel/repository/productRepo.dart';
import 'package:qawafel/ui/widgets/classified_ads.dart';

import '../widgets/product.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qawafel/bloc/Product_bloc/product_bloc.dart';
import 'package:qawafel/bloc/topBrand_bloc/top_brand_bloc.dart';
import 'package:qawafel/bloc/topCategory_bloc/bloc/topcategory_bloc.dart';

import 'package:qawafel/ui/widgets/brand.dart';
import 'package:qawafel/ui/widgets/category.dart';

class HomeScreen extends StatefulWidget {
  final TabController controller;

  const HomeScreen({Key key, this.controller}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TopcategoryBloc topcategoryBloc;
  TopBrandBloc topBrandBloc;
  ProductBloc productBloc;
  ClassifiedAdsBloc classifiedAdsBloc;

  bool selected = true;
  @override
  void initState() {
    topcategoryBloc = BlocProvider.of<TopcategoryBloc>(context);
    topBrandBloc = BlocProvider.of<TopBrandBloc>(context);
    productBloc = BlocProvider.of<ProductBloc>(context);
    classifiedAdsBloc=BlocProvider.of<ClassifiedAdsBloc>(context);
    productBloc.add(FetchProducts());
    topcategoryBloc.add(FetchTopCategories());
    topBrandBloc.add(FetchTopBrands());
    classifiedAdsBloc.add(FetchClassifiedProducts());

    super.initState();
  }

  @override
  void dispose() {
    topcategoryBloc.close();
    topBrandBloc.close();
    productBloc.close();
    classifiedAdsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),


          Container(
            child: FutureBuilder(
              future: ProductRepo().getBanners(),
              builder: (context, bannerSnap) {
                if (bannerSnap.connectionState == ConnectionState.done) {
                  if (bannerSnap.data == null) {
                    return Text('no data');
                  } else {
                    return  CarouselSlider.builder(options: CarouselOptions(initialPage: 1,autoPlay: true, aspectRatio: 2.0,
                      enlargeCenterPage: true,),
                      itemCount: bannerSnap.data.length,
                      itemBuilder: (context, itemIndex,real) =>
                          ClipRRect(borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
                            child: Image.network(mediaUrl+bannerSnap.data[itemIndex]),
                          ),
                    );
                  }
                }  else {
                  return Center(child: CircularProgressIndicator()); // loading
                }
              },

            ),
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
                          thickness: 3, color: Theme.of(context).primaryColor)),
                  Text(
                    "Flash Sales",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(14)),
                  ),
                ],
              ),

            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(13),
          ),
          Container(height: ScreenUtil().setHeight(210), child: ProductsList()),
          SizedBox(
            height: ScreenUtil().setHeight(8),
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
                          thickness: 3, color: Theme.of(context).primaryColor)),
                  Text(
                    "Classified ads",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(14)),
                  ),
                ],
              ),
              InkWell(
                  child: Row(
                children: [
                  Text(
                    "More",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(4)),
                  Container(
                    height: ScreenUtil().setWidth(23),
                    width: ScreenUtil().setWidth(23),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: const Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x19000000),
                          offset: Offset(0, 0),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: ScreenUtil().setWidth(15),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(11),
                  )
                ],
              ))
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
          Container(height: ScreenUtil().setHeight(210), child: ClassifeidList()),
          SizedBox(
            height: ScreenUtil().setHeight(8),
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
                          thickness: 3, color: Theme.of(context).primaryColor)),
                  Text(
                    "Top 10",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: ScreenUtil().setSp(14)),
                  ),
                ],
              ),
              InkWell(onTap: (){setState(() {
                widget.controller.animateTo(1);
              });},
                  child: Row(
                children: [
                  Text(
                    "All Categories",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(width: ScreenUtil().setWidth(4)),
                  Container(
                    height: ScreenUtil().setWidth(23),
                    width: ScreenUtil().setWidth(23),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: const Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x19000000),
                          offset: Offset(0, 0),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: ScreenUtil().setWidth(15),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(11),
                  )
                ],
              )),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
          Row(
            children: [
              SizedBox(
                width: ScreenUtil().setHeight(11),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selected = true;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23.0),
                    color: selected ? const Color(0xfff16a29) : Colors.white,
                    border:
                        Border.all(width: 1.0, color: const Color(0xffe2e5ec)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Categories",
                      style: TextStyle(
                          color: selected
                              ? Colors.white
                              : Color.fromRGBO(137, 139, 146, 1.0)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(11),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selected = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(23.0),
                    color: selected ? Colors.white : const Color(0xfff16a29),
                    border:
                        Border.all(width: 1.0, color: const Color(0xffe2e5ec)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 8.0),
                    child: Text(
                      "Brands",
                      style: TextStyle(
                          color: selected
                              ? Color.fromRGBO(137, 139, 146, 1.0)
                              : Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(14),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(11)),
            child: Center(child: selected ? CategoryWidget() : TopBrandWidget()

                // :Container()
                ),
          ),
          SizedBox(height: ScreenUtil().setHeight(14),),
        ],
      ),
    );
  }
}
