import 'dart:async';
import 'package:qawafel/bloc/classifiedAds_bloc/classifiedAds_state.dart';
import '../../repository/productRepo.dart';
import 'package:bloc/bloc.dart';


import 'classifiedAds_event.dart';


class ClassifiedAdsBloc extends Bloc<ClassifiedAdsEvent, ClassifiedAdsState> {
  ProductRepo productRepo;
  ClassifiedAdsBloc(ClassifiedAdsState productInitial,this.productRepo) : super(ClassifiedProductInitial());

  @override
  Stream<ClassifiedAdsState> mapEventToState(
    ClassifiedAdsEvent event,
  ) async* {
    if (event is FetchClassifiedProducts) {
      yield LoadingState();
      try {
        var product = await productRepo.fetchClassifiedAds();
        yield FetchProductsSuccess(product);
      } catch (e) {
        yield ErrorState(messege: e.toString());
      }
    }
  }
}
