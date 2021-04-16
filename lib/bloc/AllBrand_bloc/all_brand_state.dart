part of 'all_brand_bloc.dart';

class AllBrandState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class AllBrandInitial extends AllBrandState {
}
class LoadingState extends AllBrandState {}

class FetchSuccess extends AllBrandState {
  List<Brand> brands;
  FetchSuccess({this.brands});
}

class ErrorState extends AllBrandState {
  String messege;
  ErrorState({this.messege});
}

