import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qawafel/models/category.dart';
import 'package:qawafel/repository/categoryRepo.dart';

part 'topcategory_event.dart';
part 'topcategory_state.dart';

class TopcategoryBloc extends Bloc<TopcategoryEvent, TopcategoryState> {
  CategoryRepo categoryRepo;
  TopcategoryBloc(TopcategoryState TopCategoryInitial, this.categoryRepo)
      : super(TopcategoryInitial());

  @override
  Stream<TopcategoryState> mapEventToState(
    TopcategoryEvent event,
  ) async* {
    if (event is FetchTopCategories) {
      yield LoadingState();
      try {
        var category = await categoryRepo.fetchTopCategories();
        yield FetchTopCategoriesSuccess(categories: category);
      } catch (e) {
        yield ErrorState(messege: e.toString());
      }
    }
  }
}
