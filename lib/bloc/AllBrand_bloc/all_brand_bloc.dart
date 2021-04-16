import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qawafel/models/brand.dart';
import 'package:qawafel/repository/brandRepo.dart';

part 'all_brand_event.dart';
part 'all_brand_state.dart';

class AllBrandBloc extends Bloc<AllBrandEvent, AllBrandState> {
  BrandRepo brandRepo;
  AllBrandBloc(AllBrandState AllBrandInitialState,this.brandRepo) : super(AllBrandInitial());

  @override
  Stream<AllBrandState> mapEventToState(
      AllBrandEvent event,
      ) async* {
    if (event is FetchAllBrands) {
      yield LoadingState();
      try {
        var brand = await brandRepo.fetchAllBrands();
        yield FetchSuccess(brands: brand);
      } catch (e) {
        yield ErrorState(messege: e.toString());
      }
    }
  }
}
