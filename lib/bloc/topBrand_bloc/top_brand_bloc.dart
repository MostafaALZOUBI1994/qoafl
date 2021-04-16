import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qawafel/models/brand.dart';
import 'package:qawafel/repository/brandRepo.dart';

part 'top_brand_event.dart';
part 'top_brand_state.dart';

class TopBrandBloc extends Bloc<TopBrandEvent, TopBrandState> {
  BrandRepo brandRepo;
  TopBrandBloc(TopBrandState TopBrandInitialState,this.brandRepo) : super(TopBrandInitial());

  @override
  Stream<TopBrandState> mapEventToState(
    TopBrandEvent event,
  ) async* {
    if (event is FetchTopBrands) {
      yield LoadingState();
      try {
        var brand = await brandRepo.fetchTopBrands();
        yield FetchSuccess(brands: brand);
      } catch (e) {
        yield ErrorState(messege: e.toString());
      }
    }
  }

  @override
  // TODO: implement initialState
  TopBrandState get initialState => throw UnimplementedError();
}
