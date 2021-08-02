import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent/data/models/products.dart';
import 'package:rent/provider/payment_provider.dart';
import 'package:rent/view/page/review_page.dart';
import './constants.dart';
import 'package:rent/utils/context_utils.dart';

class BookCarPage extends StatefulWidget {
  final Product car;
  static final GlobalKey<ScaffoldState> skey = GlobalKey<ScaffoldState>();
  BookCarPage({@required this.car});

  @override
  _BookCarState createState() => _BookCarState();
}

class _BookCarState extends State<BookCarPage> {
  int _currentImage = 0;

  List<Widget> buildPageIndicator() {
    List<Widget> list = [];
    for (var i = 0; i < widget.car.image.length; i++) {
      list.add(buildIndicator(i == _currentImage));
    }
    return list;
  }

  Widget buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 6),
      height: 8,
      width: isActive ? 20 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.grey[400],
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: BookCarPage.skey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
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
              ),
            ),
          ),
        ),
        actions: [
          // Container(
          //     width: 45,
          //     height: 45,
          //     decoration: BoxDecoration(
          //       color: kPrimaryColor,
          //       borderRadius: BorderRadius.all(
          //         Radius.circular(15),
          //       ),
          //     ),
          //     child: Icon(
          //       Icons.bookmark_border,
          //       color: Colors.white,
          //       size: 22,
          //     )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(
                  color: Colors.grey[300],
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.share,
                color: Colors.black,
                size: 22,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          widget.car.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          widget.car.brand,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 150,
                        child: PageView(
                          physics: BouncingScrollPhysics(),
                          onPageChanged: (int page) {
                            setState(() {
                              _currentImage = page;
                            });
                          },
                          children: widget.car.imageUrls.map((path) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: Hero(
                                tag: widget.car.idProducts,
                                child: Image.network(
                                  path,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      widget.car.image.length > 1
                          ? Container(
                              margin: EdgeInsets.symmetric(vertical: 16),
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: buildPageIndicator().length < 1
                                    ? Container(
                                        height: 8,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 6),
                                      )
                                    : buildPageIndicator(),
                              ),
                            )
                          : Container(),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: Text(
                                    "Details",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              color: Colors.white,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("${widget.car.details}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: Text(
                          "SPECIFICATIONS",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                      Container(
                        height: 80,
                        padding: EdgeInsets.only(
                          top: 8,
                          left: 16,
                        ),
                        margin: EdgeInsets.only(bottom: 16),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.car.spec.toJson().keys.length,
                          itemBuilder: (context, index) {
                            var data =
                                widget.car.spec.toJson().keys.elementAt(index);
                            return SpecificationCard(
                              title: data,
                              data: widget.car.spec
                                  .toJson()
                                  .values
                                  .elementAt(index)
                                  .toString(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            MaterialButton(
              onPressed: () {
                BookCarPage.skey.currentState.showBottomSheet(
                  (context) => Container(
                      height: context.mediaQueryData.size.height * 0.75,
                      child: ReviewPage(idProducts: widget.car.idProducts)),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25.0)),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("See Review"),
                  Icon(Icons.rate_review_outlined)
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 75,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "\IDR ${widget.car.price}",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      widget.car.rentalTypeStrRead,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: () {
                context.paymentProvider.pay(widget.car);
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Consumer<PaymentProvider>(
                      builder: (context, value, _) => Text(
                        value.isPaymentActive
                            ? "Book Now(\IDR${value.totalPayment})"
                            : "Book this vehicle",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpecificationCard extends StatelessWidget {
  const SpecificationCard({
    Key key,
    this.title,
    this.data,
  }) : super(key: key);
  final String title;
  final String data;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      margin: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            data,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
