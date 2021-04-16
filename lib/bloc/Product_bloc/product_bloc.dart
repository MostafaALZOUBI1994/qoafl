import 'dart:async';
import '../../repository/productRepo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qawafel/models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepo productRepo;
  ProductBloc(ProductState productInitial,this.productRepo) : super(ProductInitial());

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is FetchProducts) {
      yield LoadingState();
      try {
        var product = await productRepo.fetchFlashDealsProducts();
        yield FetchProductsSuccess(product);
      } catch (e) {
        yield ErrorState(messege: e.toString());
      }
    }
  }
}
