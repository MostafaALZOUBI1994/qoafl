part of 'topcategory_bloc.dart';

class TopcategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class TopcategoryInitial extends TopcategoryState {}

class LoadingState extends TopcategoryState {}

class FetchTopCategoriesSuccess extends TopcategoryState {
  List<Category> categories;
  FetchTopCategoriesSuccess({this.categories});
}
class FetchAllCategoriesSuccess extends TopcategoryState {
  List<Category> categories;
  FetchAllCategoriesSuccess({this.categories});
}
class ErrorState extends TopcategoryState {
  String messege;
  ErrorState({this.messege});
}
