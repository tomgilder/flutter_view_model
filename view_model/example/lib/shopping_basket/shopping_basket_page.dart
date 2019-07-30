

import 'package:example/shopping_basket/shopping_basket_view_model.dart';
import 'package:flutter/material.dart';
import 'package:view_model/view_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }

}

class ShoppingBasketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ViewModelProvider(
      createViewModel: () => ShoppingBasketViewModel(),
      builder: (BuildContext context, ShoppingBasketViewModel viewModel) {
        
        return ListView.builder(
          itemCount: viewModel.items.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Text(viewModel.items[index].title),
            );
          },
        );
      });
  }
}