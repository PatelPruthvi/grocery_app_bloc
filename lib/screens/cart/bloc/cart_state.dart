part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

abstract class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartErrorActionstate extends CartActionState {
  final String errorMsg;

  CartErrorActionstate(this.errorMsg);
}

class CartSuccessState extends CartState {
  final List<ProductDataModel> cartItems;
  final double price;

  CartSuccessState(this.cartItems, this.price);
}

class CartRemovedFromCartActionState extends CartActionState {
  final String productName;

  CartRemovedFromCartActionState(this.productName);
}

class CartMinimumQtyActionState extends CartActionState {}

class CartMaximumQtyActionState extends CartActionState {}

class CartPayingNotSupportedActionState extends CartActionState {}
