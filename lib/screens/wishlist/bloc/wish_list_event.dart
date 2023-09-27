part of 'wish_list_bloc.dart';

@immutable
abstract class WishListEvent {}

class WishListInitialEvent extends WishListEvent {}

class WishListRemoveFromListEvent extends WishListEvent {
  final ProductDataModel removedProduct;

  WishListRemoveFromListEvent(this.removedProduct);
}
