import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:bloc_ecommerce_app/data/wishlist_items.dart';
import 'package:bloc_ecommerce_app/screens/home/models/home_products_data_model.dart';

part 'wish_list_event.dart';
part 'wish_list_state.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  WishListBloc() : super(WishListInitial()) {
    on<WishListInitialEvent>(wishListInitialEvent);
    on<WishListRemoveFromListEvent>(wishListRemoveFromListEvent);
  }

  FutureOr<void> wishListInitialEvent(
      WishListInitialEvent event, Emitter<WishListState> emit) {
    emit(WishListSuccessState(wishlistItems));
  }

  FutureOr<void> wishListRemoveFromListEvent(
      WishListRemoveFromListEvent event, Emitter<WishListState> emit) {
    wishlistItems.remove(event.removedProduct);

    emit(WishListSuccessState(wishlistItems));
  }
}
