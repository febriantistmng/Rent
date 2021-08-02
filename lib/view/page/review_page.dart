import 'package:flutter/material.dart';
import 'package:rent/data/models/review.dart';
import 'package:rent/data/service/network_service.dart';
import 'package:rent/utils/context_utils.dart';
import 'package:rent/view/components/rate_bar.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({Key key, @required this.idProducts}) : super(key: key);
  final int idProducts;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 5,
                width: context.mediaQueryData.size.width * 0.6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 1.6,
        ),
        FutureBuilder<List<Review>>(
          future: NetworkService().getReview(idProducts),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var reviews = snapshot.data;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: ListTile(
                        horizontalTitleGap: 10,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("anonym"),
                            RatingBar.builder(
                              itemSize: 20,
                              initialRating: reviews[index].rate.toDouble(),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              ignoreGestures: true,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {},
                            ),
                          ],
                        ),
                        subtitle: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(reviews[index].review ?? ""),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 5,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    ));
  }
}
