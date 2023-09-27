part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartRemoveFromCartEvent extends CartEvent {
  final ProductDataModel productRemoved;

  CartRemoveFromCartEvent(this.productRemoved);
}

class CartIncrementItemButtonPressedEvent extends CartEvent {
  final ProductDataModel itemPressed;

  CartIncrementItemButtonPressedEvent(this.itemPressed);
}

class CartDecrementItemButtonPressedEvent extends CartEvent {
  final ProductDataModel itemPressed;

  CartDecrementItemButtonPressedEvent(this.itemPressed);
}

class CartOnPayButtonClickedEvent extends CartEvent {
  final double price;

  CartOnPayButtonClickedEvent(this.price);
}
