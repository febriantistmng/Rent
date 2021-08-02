import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent/data/models/review.dart';
import 'package:rent/data/service/network_service.dart';
import 'package:rent/provider/main_provider.dart';
import 'package:rent/utils/formater.dart';
import 'package:rent/view/components/rate_bar.dart';
import 'package:rent/view/page/dialog_loading_progress.dart';
import 'package:rent/view/page/homepage.dart';
import 'package:rent/utils/context_utils.dart';

class BookListPage extends StatelessWidget {
  BookListPage({Key key}) : super(key: key);
  final GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, value, _) {
        var bookList = value.historyBook;
        return ListView.builder(
          itemCount: bookList.length,
          itemBuilder: (context, index) {
            var item = bookList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${item.product.brand} ${item.product.name}",
                              style: Theme.of(context).textTheme.headline5),
                          Chip(
                            label: Text(item.notes ?? ""),
                            backgroundColor: Colors.blue[100],
                          )
                        ],
                      ),
                      Divider(
                        height: 5,
                        thickness: 1.5,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: 75,
                              height: 100,
                              child:
                                  Image.network(item.product.imageUrls.first)),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                      "booked at : ${Formatter.stringDate(item.date)}"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child:
                                      Text("total price : \IDR${item.totalFee}"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                      "payment method : ${(item.paymentTypeStr)}"),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Divider(
                        height: 2,
                        thickness: 1.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                  "rental duration: ${Formatter.stringDate(item.rentStart)} - ${Formatter.stringDate(item.rentEnd)}"),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            onPressed: () async {
                              var review = await showGeneralDialog<Review>(
                                  context: context,
                                  pageBuilder: (ctx, a, b) {
                                    return SimpleDialog(
                                      title: Text("Review"),
                                      children: [
                                        ReviewForm(
                                          keys: _key,
                                          idBooking: item.idBooking,
                                        )
                                      ],
                                    );
                                  });
                              if (review != null) {
                                Dialogs.showLoadingDialog(
                                    context, HomePage.gKey);
                                try {
                                  var res =
                                      await NetworkService().addReview(review);
                                  Dialogs.hideLoadingDialog(HomePage.gKey);
                                  context.showSnacbar(res.message);
                                } catch (e) {
                                  Dialogs.hideLoadingDialog(HomePage.gKey);
                                  debugPrint(e.toString());
                                }
                              }
                            },
                            child: Text("Review"),
                          )),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ReviewForm extends StatefulWidget {
  const ReviewForm({
    Key key,
    @required GlobalKey<FormState> keys,
    this.idBooking,
  })  : _key = keys,
        super(key: key);
  final int idBooking;
  final GlobalKey<FormState> _key;

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  TextEditingController _reviewController;
  double _rate = 3;
  @override
  void initState() {
    _reviewController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._key,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _reviewController,
                    validator: (value) =>
                        value.length < 10 ? "length review minimum 10" : null,
                    decoration: InputDecoration(labelText: "review"),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text("Rate :")],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                itemSize: 20,
                initialRating: _rate,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rate = rating;
                  });
                },
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Row(
                    children: [
                      Text(
                        "Send",
                      ),
                      Icon(
                        Icons.send,
                        size: 18,
                      ),
                    ],
                  ),
                  onPressed: () {
                    if (widget._key.currentState.validate()) {
                      Navigator.of(context).pop(
                        Review(
                          rate: _rate.toInt(),
                          review: _reviewController.text,
                          idBooking: widget.idBooking,
                        ),
                      );
                    }
                  }),
              MaterialButton(
                  child: Text("cancel"),
                  onPressed: () => Navigator.pop(context))
            ],
          ),
        ],
      ),
    );
  }
}
