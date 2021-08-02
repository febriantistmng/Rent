import 'package:flutter/material.dart';
import 'package:rent/data/models/products.dart';
import 'package:rent/view/components/car_widget.dart';
import './constants.dart';
import 'BookCar.dart';
import 'package:rent/utils/context_utils.dart';

class AvailableCars extends StatefulWidget {
  final List<Product> products;
  final String type;

  const AvailableCars({Key key, this.products, this.type}) : super(key: key);
  @override
  _AvailableCarsState createState() => _AvailableCarsState();
}

class _AvailableCarsState extends State<AvailableCars> {
  SortType _sortType = SortType.Best_Match;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      border: Border.all(
                        color: Colors.grey[300],
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.black,
                      size: 28,
                    )),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Available ${widget.type} (" +
                    widget.products.length.toString() +
                    ")",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: GridView.count(
                  physics: BouncingScrollPhysics(),
                  childAspectRatio: 1 / 2,
                  crossAxisCount: 2,
                  children: sort(widget.products)
                      .map<Widget>(
                        (e) => SingleChildScrollView(
                          child: InkWell(
                            onTap: () => context.pushTo(
                              BookCarPage(
                                car: e,
                              ),
                            ),
                            child: ProductContainer(product: e),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Row(
              children: [
                const IconSort(),
                Row(
                  children: SortType.values
                      .map<Widget>(
                        (e) => InkWell(
                          onTap: () => setState(() {
                            _sortType = e;
                          }),
                          child: Chip(
                            backgroundColor: _sortType == e
                                ? kPrimaryColor.withOpacity(0.5)
                                : Colors.white,
                            label: Text(e.toString().replaceAll("_", " ")),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  sort(List<Product> productlist) {
    var _productList = productlist;
    switch (_sortType) {
      case SortType.Best_Match:
        return widget.products;
        break;
      case SortType.Highest_Price:
        _productList.sort((b, a) => a.price.compareTo(b.price));
        break;
      case SortType.Lowest_Price:
        _productList.sort((a, b) => a.price.compareTo(b.price));
        break;
    }
    return _productList;
  }
}

class IconSort extends StatelessWidget {
  const IconSort({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Center(
        child: Icon(
          Icons.filter_list,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}

enum SortType { Best_Match, Highest_Price, Lowest_Price }
