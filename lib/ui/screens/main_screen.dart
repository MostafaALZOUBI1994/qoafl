import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:qawafel/constants.dart';
import 'package:qawafel/presentation/my_flutter_app_icons.dart';
import 'package:qawafel/ui/screens/categories_brand_screen.dart';
import 'package:qawafel/ui/screens/home_screen.dart';
import 'package:qawafel/ui/screens/my_cart.dart';
import 'package:qawafel/ui/screens/profile_screen.dart';
import 'package:qawafel/ui/screens/search_screen.dart';
import 'package:qawafel/ui/screens/signup_signin.dart';
import 'package:qawafel/ui/screens/wish_list.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: backColor,
        appBar: AppBar(
            toolbarHeight: ScreenUtil().setHeight(113),
            backgroundColor: Colors.white,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/LogoMV.png",
                ),
                Container(
                  child: Row(
                    children: [
                      OpenContainer(
                        closedElevation: 0,
                        openColor: backColor,
                        transitionType: ContainerTransitionType.fadeThrough,
                        transitionDuration: Duration(milliseconds: 500),
                        closedBuilder: (BuildContext c, VoidCallback action) =>
                            InkWell(
                          onTap: () async {
                            //ProductRepo().ad();
                            action();
                          },
                          child:kUser==null?Container() :CircleAvatar(
                            radius: 30.0,
                            backgroundImage: kUser.accessToken==""?AssetImage("assets/user.png"):NetworkImage(mediaUrl+kUser.userInfo.avatar),
                            backgroundColor: backColor,
                          ),
                        ),
                        openBuilder: (BuildContext c, VoidCallback action) =>
                        kUser.accessToken==""?   Signup_SigninScreen()
                            :ProfileScreen(),
                        tappable: false,
                      ),
                      SizedBox(width: ScreenUtil().setWidth(3),),
                      OpenContainer(closedElevation: 0,
                        openColor: backColor,
                        transitionType: ContainerTransitionType.fade,
                        transitionDuration: Duration(milliseconds: 500),
                        closedBuilder: (BuildContext c, VoidCallback openSearchScreen) =>
                            IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: grey,
                                ),
                                onPressed:() {
                                  openSearchScreen();
                                }),
                        openBuilder: (BuildContext c, VoidCallback action) =>
                            SearchScreen(),
                      )
                    ],
                  ),
                )
              ],
            ),
            bottom: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: grey,
              labelColor: Theme.of(context).primaryColor,
              tabs: [
                new Tab(icon: new Icon(Icons.home)),
                new Tab(
                  icon: new Icon(MyFlutterApp.category),
                ),
                new Tab(
                  icon: new Icon(Icons.shopping_cart_outlined),
                ),

                new Tab(
                  icon: new Icon(MaterialIcons.favorite_border),
                ),
              ],
              controller: _tabController,
            )),
        body: TabBarView(
          children: [
            HomeScreen(controller: _tabController,),
            CategoryBrand(),
            MyCart(),
            WishList(),
          ],
          controller: _tabController,
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
