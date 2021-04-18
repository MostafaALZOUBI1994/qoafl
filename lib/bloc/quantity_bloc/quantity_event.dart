import 'package:equatable/equatable.dart';

class QuantityEvent extends Equatable {

  const QuantityEvent();

  @override
  List<Object> get props => [];
}

class IncrementEvent extends QuantityEvent {}

class DecrementEvent extends QuantityEvent {}
