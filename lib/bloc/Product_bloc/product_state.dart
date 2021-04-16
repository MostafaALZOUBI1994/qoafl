part of 'product_bloc.dart';

 class ProductState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class ProductInitial extends ProductState {

}
class LoadingState extends ProductState {}

class FetchProductsSuccess extends ProductState {
  List<Product> products;
  FetchProductsSuccess(this.products);
}
class ErrorState extends ProductState {
  String messege;
  ErrorState({this.messege});
}

