import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:qawafel/bloc/AllCategory_bloc/all_category_bloc.dart';

import 'package:qawafel/bloc/quantity_bloc/quantity_bloc.dart';
import 'package:qawafel/bloc/topBrand_bloc/top_brand_bloc.dart';
import 'package:qawafel/bloc/topCategory_bloc/bloc/topcategory_bloc.dart';
import 'package:qawafel/models/user.dart';
import 'package:qawafel/repository/brandRepo.dart';
import 'package:qawafel/repository/categoryRepo.dart';
import 'package:qawafel/repository/userRepo.dart';
import 'package:qawafel/ui/screens/main_screen.dart';
import 'package:qawafel/bloc/Product_bloc/product_bloc.dart';
import 'package:qawafel/ui/splash_screen.dart';
import 'bloc/AllBrand_bloc/all_brand_bloc.dart';
import 'constants.dart';
import "package:qawafel/repository/productRepo.dart";

Future<void> main() async {
  kUser = User();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<TopcategoryBloc>(
        create: (BuildContext context) =>
            TopcategoryBloc(TopcategoryInitial(), CategoryRepo()),
      ),
      BlocProvider<TopBrandBloc>(
        create: (BuildContext context) =>
            TopBrandBloc(TopBrandInitial(), BrandRepo()),
      ),
      BlocProvider<AllBrandBloc>(
        create: (BuildContext context) =>
            AllBrandBloc(AllBrandInitial(), BrandRepo()),
      ),
      BlocProvider<AllCategoryBloc>(
        create: (BuildContext context) =>
            AllCategoryBloc(AllcategoryInitial(), CategoryRepo()),
      ),
      BlocProvider<ProductBloc>(
        create: (BuildContext context) =>
            ProductBloc(ProductInitial(), ProductRepo()),
      ),
      BlocProvider<QuantityBloc>(
          create: (BuildContext context) => QuantityBloc()),

    ],
    child: MaterialApp(
      home: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 813),
      allowFontScaling: false,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primaryColor: Color.fromRGBO(241, 106, 41, 1.0),
            accentColor: Color.fromRGBO(254, 201, 13, 1.0)),
        home: SplashScreen(),
      ),
    );
  }
}
