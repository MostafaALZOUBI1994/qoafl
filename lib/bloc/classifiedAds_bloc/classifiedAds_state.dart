

 import 'package:equatable/equatable.dart';
import 'package:qawafel/models/product.dart';

class ClassifiedAdsState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class ClassifiedProductInitial extends ClassifiedAdsState {

}
class LoadingState extends ClassifiedAdsState {}

class FetchProductsSuccess extends ClassifiedAdsState {
  List<Product> products;
  FetchProductsSuccess(this.products);
}
class ErrorState extends ClassifiedAdsState {
  String messege;
  ErrorState({this.messege});
}

