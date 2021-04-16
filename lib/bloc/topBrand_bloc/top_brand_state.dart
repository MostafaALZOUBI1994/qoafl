part of 'top_brand_bloc.dart';

 class TopBrandState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class TopBrandInitial extends TopBrandState {
}
class LoadingState extends TopBrandState {}

class FetchSuccess extends TopBrandState {
  List<Brand> brands;
  FetchSuccess({this.brands});
}

class ErrorState extends TopBrandState {
  String messege;
  ErrorState({this.messege});
}

