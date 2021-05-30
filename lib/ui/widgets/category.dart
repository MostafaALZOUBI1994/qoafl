import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:qawafel/bloc/topCategory_bloc/bloc/topcategory_bloc.dart';
import 'package:qawafel/ui/screens/products_by_category.dart';

import '../../constants.dart';

class CategoryWidget extends StatefulWidget {
  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  final double runSpacing = 5;
  final double spacing = 5;
  final columns = 5;
  @override
  Widget build(BuildContext context) {
    final w = (MediaQuery.of(context).size.width - runSpacing * (columns - 1)) / columns;
    return BlocBuilder<TopcategoryBloc, TopcategoryState>(
      builder: (context, state) {
        if (state is TopcategoryInitial) {
          return CircularProgressIndicator();
        } else if (state is LoadingState) {
          return CircularProgressIndicator();
        } else if (state is FetchTopCategoriesSuccess) {
          return
            state.categories==null ? Center(child: Text("no data"),)
            :SingleChildScrollView(
              child: Wrap(
                runSpacing: runSpacing,
                spacing: spacing,
                alignment: WrapAlignment.center,
                children: List.generate(state.categories.length, (index) {
                  return OpenContainer(
                    openColor: backColor,
                    transitionType: ContainerTransitionType.fadeThrough,
                    transitionDuration: Duration(milliseconds: 500),openBuilder: (BuildContext c, VoidCallback action) =>
                      ProductByCategory(mainCategory: state.categories[index],),
                    tappable: false,
                    closedBuilder: (BuildContext c, VoidCallback action)

                    => InkWell(onTap: (){

                      action();
                    },

                      child: Container(width: ScreenUtil().setWidth(77),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(width: w,height: w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9.0),
                                color: const Color(0xffffffff),
                                border: Border.all(
                                    width: 0.1, color: const Color(0xff707070)),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x29000000),
                                    offset: Offset(0, 3),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),

                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CachedNetworkImage(
                                  imageUrl: mediaUrl+state.categories[index].banner,
                                  placeholder: (context, url) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                            ),
                            SizedBox(height: ScreenUtil().setHeight(10),),
                            Container(height: ScreenUtil().setHeight(50),child: Column(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(state.categories[index].name,overflow: TextOverflow.ellipsis,),
                              ],
                            )),

                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
        } else if (state is ErrorState) {
          return ErrorWidget(state.messege.toString());
        }
      },
    );
  }
}


