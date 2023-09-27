import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:bloc_ecommerce_app/data/cart_items.dart';
import 'package:bloc_ecommerce_app/data/grocery_data.dart';
import 'package:bloc_ecommerce_app/data/wishlist_items.dart';
import 'package:bloc_ecommerce_app/screens/home/models/home_products_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

bool isLiked = false;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeWishListButtonNavigateEvent>(homeWishListButtonNavigateEvent);
    on<HomeProductCartButtonClickEvent>(homeProductCartButtonClickEvent);
    on<HomeProductWishListButtonClickEvent>(
        homeProductWishListButtonClickEvent);
    on<HomeWishListBackPressedEvent>(homeWishListBackPressedEvent);
    // on<HomeProductItemTileBuildEvent>(homeProductItemTileBuildEvent);
  }
  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));

    emit(HomeLoadedSuccessState(GroceryData.groceryItems
        .map((e) => ProductDataModel(e['id'], e['name'], e['description'],
            e['price'], e['imageUrl'], e['qty']))
        .toList()));
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    // print("Cart Navigate Clicked...");
    emit(HomeNavigateToCartActionState());
  }

  FutureOr<void> homeWishListButtonNavigateEvent(
      HomeWishListButtonNavigateEvent event, Emitter<HomeState> emit) {
    // print("WishList Navigate Clicked...");
    emit(HomeNavigateToWishListActionState());
  }

  FutureOr<void> homeProductCartButtonClickEvent(
      HomeProductCartButtonClickEvent event, Emitter<HomeState> emit) {
    if (!cartItems.contains(event.clickedProduct)) {
      cartItems.add(event.clickedProduct);
    }

    emit(HomeProductItemCartedActionState());
  }

  FutureOr<void> homeProductWishListButtonClickEvent(
      HomeProductWishListButtonClickEvent event, Emitter<HomeState> emit) {
    if (wishlistItems.contains(event.clickedProduct)) {
      wishlistItems.remove(event.clickedProduct);
    } else {
      wishlistItems.add(event.clickedProduct);
    }
    emit(HomeBackPressedState());
  }

  FutureOr<void> homeWishListBackPressedEvent(
      HomeWishListBackPressedEvent event, Emitter<HomeState> emit) {
    emit(HomeBackPressedState());
  }

  // FutureOr<void> homeProductItemTileBuildEvent(
  //     HomeProductItemTileBuildEvent event, Emitter<HomeState> emit) {
  //   if (event.likedProduct) {
  //     emit(HomeProductItemFavState());
  //   } else {
  //     emit(HomeProductItemNotFavState());
  //   }
  // }
}
