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
  double topPosition=ScreenUtil().setHeight(450);
  double leftPosition=ScreenUtil().setWidth(150);
  double mainScreenOpacity=0.0;


  animationfunc(){
    setState(() {
      topPosition=ScreenUtil().setHeight(30);
      leftPosition=ScreenUtil().setWidth(10);
    });
    Future.delayed(Duration(milliseconds: 3500)).then((value) => {
      setState(()
      {
        mainScreenOpacity=1.0;
      })
    });
  }
  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this);
    Future.delayed(Duration(milliseconds: 100)).then((value) => {
      animationfunc()
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.white,),
        AnimatedOpacity(opacity: mainScreenOpacity,duration:Duration(milliseconds: 3500),
          child: DefaultTabController(
            length: 4,
            child: Scaffold(
              backgroundColor: backColor,
              appBar: AppBar(
                  toolbarHeight: ScreenUtil().setHeight(113),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                                      setState(() {

                                      });
                                    },
                                    child:CircleAvatar(
                                      radius: 20.0,
                                      backgroundImage: kUser==null || kUser.userInfo.avatar==null ? AssetImage("assets/user.png")
                                          :NetworkImage(mediaUrl+kUser.userInfo.avatar ,),
                                      backgroundColor: backColor,
                                    ),
                                  ),
                              openBuilder: (BuildContext c, VoidCallback action) =>
                              kUser==null?   Signup_SigninScreen()
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
                   kUser==null?   OpenContainer(
                        closedElevation: 0,
                        openColor: backColor,
                        transitionType: ContainerTransitionType.fadeThrough,
                        transitionDuration: Duration(milliseconds: 500),
                        closedBuilder: (BuildContext c, VoidCallback action) =>
                            InkWell(
                              onTap: () async {
                                action();
                              },
                              child:Container(child: Icon(MaterialIcons.account_circle),)
                            ),
                        openBuilder: (BuildContext c, VoidCallback action) =>
                         Signup_SigninScreen(),
                        tappable: false,
                      )
                   : new Tab(
                     icon: new Icon(MaterialIcons.shopping_cart),
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
                kUser==null?Center(child: Text("Sign In Please...."),):  MyCart(),
                  WishList(),
                ],
                controller: _tabController,
              ),
              // This trailing comma makes auto-formatting nicer for build methods.
            ),
          ),
        ),
        AnimatedPositioned(top: topPosition,left: leftPosition,duration:Duration(milliseconds: 3500),
            child: Container(height: ScreenUtil().setHeight(70),width: ScreenUtil().setHeight(70),child: Image.asset("assets/logoluncher.png"),)
        ),
      ],
    );
  }
}
