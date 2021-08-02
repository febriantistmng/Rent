import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent/data/models/products.dart';
import 'package:rent/provider/main_provider.dart';
import 'package:rent/view/components/car_widget.dart';
import 'package:rent/view/page/BookCar.dart';
import 'package:rent/view/page/available_cars.dart';
import 'package:rent/view/page/constants.dart';
import 'package:rent/utils/context_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);
  static GlobalKey gKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Container(
        //   padding: EdgeInsets.only(bottom: 10),
        //   child: Padding(
        //     padding: EdgeInsets.all(16),
        //     child: TextField(
        //       decoration: InputDecoration(
        //         hintText: 'Search',
        //         hintStyle: TextStyle(fontSize: 16),
        //         border: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(15),
        //           borderSide: BorderSide(
        //             width: 0,
        //             style: BorderStyle.none,
        //           ),
        //         ),
        //         filled: true,
        //         fillColor: Colors.grey[100],
        //         contentPadding: EdgeInsets.only(
        //           left: 30,
        //         ),
        //         suffixIcon: Padding(
        //           padding: EdgeInsets.only(right: 24.0, left: 16.0),
        //           child: Icon(
        //             Icons.search,
        //             color: Colors.black,
        //             size: 24,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        Expanded(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pushTo(AvailableCars(
                        products: context.mainProvider.products
                                .where((element) =>
                                    element.type == ProductType.car)
                                .toList() ??
                            [],
                        type: "Cars",
                      ));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Available Cars",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[400],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "view all",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                                color: kPrimaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 280,
                    child: Consumer<MainProvider>(
                      builder: (ctx, prov, _) {
                        return ListView.builder(
                          itemCount: prov.products
                              .where(
                                  (element) => element.type == ProductType.car)
                              .take(5)
                              .length,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () => context.pushTo(BookCarPage(
                                  car: prov.products
                                      .where((element) =>
                                          element.type == ProductType.car)
                                      .take(5)
                                      .toList()[index])),
                              child: ProductContainer(
                                  product: prov.products
                                      .where((element) =>
                                          element.type == ProductType.car)
                                      .take(5)
                                      .toList()[index]),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pushTo(AvailableCars(
                        products: context.mainProvider.products
                                .where((element) =>
                                    element.type == ProductType.bike)
                                .toList() ??
                            [],
                        type: "Bikes",
                      ));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Available Bikes",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[400],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "view all",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 12,
                                color: kPrimaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 280,
                    child: Consumer<MainProvider>(
                      builder: (ctx, prov, _) {
                        return ListView.builder(
                          itemCount: prov.products
                              .where(
                                  (element) => element.type == ProductType.bike)
                              .take(5)
                              .length,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () => context.pushTo(BookCarPage(
                                  car: prov.products
                                      .where((element) =>
                                          element.type == ProductType.bike)
                                      .take(5)
                                      .toList()[index])),
                              child: ProductContainer(
                                  product: prov.products
                                      .where((element) =>
                                          element.type == ProductType.bike)
                                      .take(5)
                                      .toList()[index]),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
