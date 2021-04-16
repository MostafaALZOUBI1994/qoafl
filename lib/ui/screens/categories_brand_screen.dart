import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:qawafel/bloc/AllBrand_bloc/all_brand_bloc.dart';


import 'package:qawafel/bloc/AllCategory_bloc/all_category_bloc.dart';
import 'package:qawafel/ui/widgets/allBrand.dart';

import 'package:qawafel/ui/widgets/allCategory.dart';
import 'package:qawafel/ui/widgets/brand.dart';


class CategoryBrand extends StatefulWidget {
  @override
  _CategoryBrandState createState() => _CategoryBrandState();
}

class _CategoryBrandState extends State<CategoryBrand> {
  bool selected=true;
  AllCategoryBloc allcategoryBloc;
  AllBrandBloc allBrandBloc;
  

  @override
  void initState() {
    allcategoryBloc = BlocProvider.of<AllCategoryBloc>(context);
    allBrandBloc = BlocProvider.of<AllBrandBloc>(context);
    allcategoryBloc.add(FetchAllCategories());
    allBrandBloc.add(FetchAllBrands());
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    allcategoryBloc.close();
    allBrandBloc.close();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: ScreenUtil().setHeight(24),),
      Row(
        children: [
          SizedBox(width: ScreenUtil().setWidth(11),),
          Text("Categories",style: TextStyle(fontSize: ScreenUtil().setSp(20),fontWeight: FontWeight.bold),),
        ],
      ),
      SizedBox(height: ScreenUtil().setHeight(19),),
      Row(
        children: [
          SizedBox(
            width: ScreenUtil().setHeight(11),
          ),
          InkWell(onTap: (){setState(() {
            selected =true;
          });},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23.0),
                color:selected? const Color(0xfff16a29): Colors.white,
                border:
                Border.all(width: 1.0, color: const Color(0xffe2e5ec)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Categories",
                  style: TextStyle(color:selected ? Colors.white : Color.fromRGBO(137, 139, 146, 1.0)),
                ),
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(11),
          ),
          InkWell(onTap: (){setState(() {
            selected =false;
          });},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23.0),
                color:selected ? Colors.white:const Color(0xfff16a29),
                border:
                Border.all(width: 1.0, color: const Color(0xffe2e5ec)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 8.0),
                child: Text(
                  "Brands",
                  style: TextStyle(color:selected ? Color.fromRGBO(137, 139, 146, 1.0) :Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: ScreenUtil().setHeight(14),),
      Padding(
        padding:  EdgeInsets.symmetric(horizontal:ScreenUtil().setWidth(11)),
        child: Center(
            child:selected ?AllCategoryWidget():AllBrandWidget()

          // :Container()
        ),
      ),
    ],);
  }
}
