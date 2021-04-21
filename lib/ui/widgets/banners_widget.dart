import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:qawafel/bloc/banners_bloc/basnners_bloc.dart';
import 'package:qawafel/bloc/banners_bloc/basnners_state.dart';
import 'package:qawafel/constants.dart';


class BannersWidget extends StatefulWidget {
  @override
  _BannersWidgetState createState() => _BannersWidgetState();
}

class _BannersWidgetState extends State<BannersWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannersBloc, BannersState>(
      builder: (context, state) {
        if (state is BannersInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is LoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FetchBannersSuccess) {
          return state.banners==null ? Center(child: Text("no data"),)
              :
          CarouselSlider.builder(options: CarouselOptions(initialPage: 1,autoPlay: true, aspectRatio: 2.0,
            enlargeCenterPage: true,),
            itemCount: state.banners.length,
            itemBuilder: (context, itemIndex,real) =>
                ClipRRect(borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
                  child: Image.network(mediaUrl+state.banners[itemIndex]),
                ),
          );

        } else if (state is ErrorState) {
          return ErrorWidget(state.messege.toString());
        }
      },
    );
  }
}
