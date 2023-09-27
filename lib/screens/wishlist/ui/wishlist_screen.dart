import 'package:bloc_ecommerce_app/screens/wishlist/bloc/wish_list_bloc.dart';
import 'package:bloc_ecommerce_app/screens/wishlist/ui/wish_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final WishListBloc wishListBloc = WishListBloc();
  @override
  void initState() {
    wishListBloc.add(WishListInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Favourite Items',
          ),
        ),
        body: BlocConsumer<WishListBloc, WishListState>(
          bloc: wishListBloc,
          listenWhen: ((previous, current) => current is WishListActionState),
          listener: (context, state) {
            // TODO: implement listener
          },
          buildWhen: ((previous, current) => current is! WishListActionState),
          builder: (context, state) {
            switch (state.runtimeType) {
              case WishListSuccessState:
                final successState = state as WishListSuccessState;
                if (successState.wishlistItems.isEmpty) {
                  return Center(
                    child: Text(
                      "Favourites is Empty..",
                      style: TextStyle(
                          fontFamily: GoogleFonts.lato().fontFamily,
                          color: Theme.of(context).primaryColor,
                          fontSize: 20),
                    ),
                  );
                }
                return ListView.builder(
                    itemCount: successState.wishlistItems.length,
                    itemBuilder: (context, index) {
                      return WishListTile(
                          productDataModel: successState.wishlistItems[index],
                          wishListBloc: wishListBloc);
                    });
              default:
                return Scaffold();
            }
          },
        ));
  }
}
