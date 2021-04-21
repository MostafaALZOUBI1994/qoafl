

 import 'package:equatable/equatable.dart';
import 'package:qawafel/models/product.dart';

class BannersState extends Equatable {
  @override

  List<Object> get props => [];

}

class BannersInitial extends BannersState {

}
class LoadingState extends BannersState {}

class FetchBannersSuccess extends BannersState {
  List<String> banners;
  FetchBannersSuccess(this.banners);
}
class ErrorState extends BannersState {
  String messege;
  ErrorState({this.messege});
}

