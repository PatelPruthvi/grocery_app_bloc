import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_ecommerce_app/data/cart_items.dart';
import 'package:bloc_ecommerce_app/screens/home/models/home_products_data_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
    on<CartDecrementItemButtonPressedEvent>(
        cartDecrementItemButtonPressedEvent);
    on<CartIncrementItemButtonPressedEvent>(
        cartIncrementItemButtonPressedEvent);
    on<CartOnPayButtonClickedEvent>(cartOnPayButtonClickedEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems, getPrice()));
  }

  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.productRemoved);
    event.productRemoved.qty = 1;
    emit(CartRemovedFromCartActionState(event.productRemoved.name));

    emit(CartSuccessState(cartItems, getPrice()));
  }

  FutureOr<void> cartDecrementItemButtonPressedEvent(
      CartDecrementItemButtonPressedEvent event, Emitter<CartState> emit) {
    if (event.itemPressed.qty <= 1) {
      event.itemPressed.qty = 1;
      emit(CartMinimumQtyActionState());
    } else {
      event.itemPressed.qty--;
    }
    emit(CartSuccessState(cartItems, getPrice()));
  }

  FutureOr<void> cartIncrementItemButtonPressedEvent(
      CartIncrementItemButtonPressedEvent event, Emitter<CartState> emit) {
    if (event.itemPressed.qty >= 5) {
      event.itemPressed.qty = 5;
      emit(CartMaximumQtyActionState());
    } else {
      event.itemPressed.qty++;
    }
    emit(CartSuccessState(cartItems, getPrice()));
  }

  double getPrice() {
    double price = 0;
    for (int i = 0; i < cartItems.length; i++) {
      price = price + cartItems[i].price * cartItems[i].qty;
    }
    return price;
  }

  FutureOr<void> cartOnPayButtonClickedEvent(
      CartOnPayButtonClickedEvent event, Emitter<CartState> emit) {
    // void handleErrorFailure() {
    //   emit(CartErrorActionstate("PayMent Error"));
    // }

    // void handlePaymentSuccess() {
    //   emit(CartErrorActionstate("PayMent Success"));
    // }

    // void handleExternalWallet() {
    //   emit(CartErrorActionstate("Checking External Wallet"));
    // }

    // Razorpay? razorpay;
    // razorpay = Razorpay();
    // razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    // razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handleErrorFailure);
    // razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);

    // var options = {
    //   "key": "rzp_test_exKOXcMyx1xSVq",
    //   "amount": event.price,
    //   "name": "Grocery App",
    //   "description": "Payment for Groceries",
    //   "prefill": {"contact": "21222222", "email": "efslk@gmail.com"},
    //   "externals": {
    //     "wallets": ["paytm"]
    //   }
    // };
    // try {
    //   razorpay.open(options);
    // } catch (e) {
    //   emit(CartErrorActionstate("Checking Externa Wallet"));
    // }
    emit(CartPayingNotSupportedActionState());
  }
}
