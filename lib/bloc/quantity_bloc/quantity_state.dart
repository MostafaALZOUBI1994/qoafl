import 'package:equatable/equatable.dart';

class QuantityState extends Equatable {
  final int quantity;
  const QuantityState({ this.quantity});

  @override
  List<Object> get props => [quantity];
}
