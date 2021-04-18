import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:qawafel/bloc/quantity_bloc/quantity_event.dart';
import 'package:qawafel/bloc/quantity_bloc/quantity_state.dart';

class QuantityBloc extends Bloc<QuantityEvent, QuantityState> {
  QuantityBloc() : super(QuantityState(quantity: 1));

  @override
  Stream<QuantityState> mapEventToState(QuantityEvent event) async* {

    if (event is IncrementEvent) {

      yield QuantityState(quantity: state.quantity + 1);
    } else if (event is DecrementEvent) {

      yield QuantityState(quantity: state.quantity - 1);
    }
  }
}