part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> products;
  HomeLoadedSuccessState(this.products);
}

class HomeErrorState extends HomeState {}

class HomeNavigateToWishListActionState extends HomeActionState {}

class HomeNavigateToCartActionState extends HomeActionState {}

class HomeProductItemWishlistedActionState extends HomeActionState {}

class HomeProductItemCartedActionState extends HomeActionState {}

class HomeBackPressedState extends HomeActionState {}

// class HomeProductItemFavState extends HomeState {}

// class HomeProductItemNotFavState extends HomeState {}
