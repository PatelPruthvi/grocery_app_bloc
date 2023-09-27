part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductWishListButtonClickEvent extends HomeEvent {
  final ProductDataModel clickedProduct;

  HomeProductWishListButtonClickEvent(this.clickedProduct);
}

class HomeProductCartButtonClickEvent extends HomeEvent {
  final ProductDataModel clickedProduct;

  HomeProductCartButtonClickEvent(this.clickedProduct);
}

class HomeWishListButtonNavigateEvent extends HomeEvent {}

class HomeCartButtonNavigateEvent extends HomeEvent {}

class HomeWishListBackPressedEvent extends HomeEvent {}

// class HomeProductItemTileBuildEvent extends HomeEvent {
//   final bool likedProduct;

//   HomeProductItemTileBuildEvent(this.likedProduct);
// }
