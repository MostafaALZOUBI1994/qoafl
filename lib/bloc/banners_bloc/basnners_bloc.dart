import 'dart:async';
import 'package:qawafel/bloc/banners_bloc/basnners_event.dart';
import 'package:qawafel/bloc/banners_bloc/basnners_state.dart';

import '../../repository/productRepo.dart';
import 'package:bloc/bloc.dart';



class BannersBloc extends Bloc<BannersEvent, BannersState> {
  ProductRepo productRepo;
  BannersBloc(BannersState bannerInitial,this.productRepo) : super(BannersInitial());

  @override
  Stream<BannersState> mapEventToState(
    BannersEvent event,
  ) async* {
    if (event is FetchBanners) {
      yield LoadingState();
      try {
        var banner = await productRepo.getBanners();
        yield FetchBannersSuccess(banner);
      } catch (e) {
        yield ErrorState(messege: e.toString());
      }
    }
  }
}
