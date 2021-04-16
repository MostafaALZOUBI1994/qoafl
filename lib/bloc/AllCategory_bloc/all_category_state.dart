part of 'all_category_bloc.dart';

 class AllCategoryState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class AllcategoryInitial extends AllCategoryState {
}
class LoadingState extends AllCategoryState {}

class FetchAllCategoriesSuccess extends AllCategoryState {
  List<Category> categories;
  FetchAllCategoriesSuccess({this.categories});
}
class ErrorState extends AllCategoryState {
  String messege;
  ErrorState({this.messege});
}
