import 'package:flutter/material.dart';
import 'package:rent/data/models/products.dart';

import '../page/constants.dart';

class ProductContainer extends StatelessWidget {
  const ProductContainer({
    Key key,
    @required this.product,
  }) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(right: 16, left: 16),
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  product.rentalTypeStr,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 120,
            child: Center(
              child: Hero(
                tag: product.idProducts,
                child: Image.network(
                  product.imageUrls.first,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            product.name,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            product.brand,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1,
            ),
          ),
          Text(
            product.priceTypeStr,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
