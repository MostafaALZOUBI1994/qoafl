import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:qawafel/models/category.dart';
import 'package:qawafel/repository/categoryRepo.dart';

part 'all_category_event.dart';
part 'all_category_state.dart';

class AllCategoryBloc extends Bloc<AllCategoryEvent, AllCategoryState> {
  CategoryRepo repo;
  AllCategoryBloc(AllCategoryState AllCategoryInitial,this.repo) : super(AllcategoryInitial());

  @override
  Stream<AllCategoryState> mapEventToState(
    AllCategoryEvent event,
  ) async* {
    if (event is FetchAllCategories) {
      yield LoadingState();
      try {
        var category = await repo.fetchAllCategories();
        yield FetchAllCategoriesSuccess(categories: category);
      } catch (e) {
        yield ErrorState(messege: e.toString());
      }
    }


  }
}
