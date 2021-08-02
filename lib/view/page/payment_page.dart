import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent/data/models/book.dart';
import 'package:rent/provider/payment_provider.dart';
import 'package:rent/utils/formater.dart';
import 'package:rent/utils/context_utils.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Start book Date",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Consumer<PaymentProvider>(builder: (ctx, prov, _) {
                  var dateTime = prov.startDate;
                  return DatePickerWidget(
                    (value) => prov.setStart(value),
                    dateTime: dateTime,
                  );
                }),
              ],
            ),
          ),
          Row(
            children: [
              Consumer<PaymentProvider>(
                builder: (context, value, _) => Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Book Range (${value.currentProduct.rentalTypeStr})',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          Consumer<PaymentProvider>(
            builder: (ctx, prov, _) => SliderTheme(
              data: Theme.of(context).sliderTheme.copyWith(
                    trackShape: RoundedRectSliderTrackShape(),
                    trackHeight: 4.0,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                    overlayColor: Colors.red.withAlpha(32),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                    tickMarkShape: RoundSliderTickMarkShape(),
                    valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                    valueIndicatorTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
              child: Slider(
                min: 0,
                max: 12,
                onChanged: (value) =>
                    value >= 1 ? prov.setDuration(value.toInt()) : null,
                value: prov.duration.toDouble(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Payment Type:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Consumer<PaymentProvider>(
                    builder: (ctx, prov, _) => DropdownButton<PaymentType>(
                      value: prov.type,
                      onChanged: (value) {
                        prov.setType(value);
                      },
                      items: PaymentType.values
                          .map(
                            (e) => DropdownMenuItem(
                              value: (e),
                              child: Text(
                                getTypeStr(e),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Consumer<PaymentProvider>(
                    builder: (context, value, _) {
                      return Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: Formatter.stringDate(value.startDate),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: " to ",
                          ),
                          TextSpan(
                            text: Formatter.stringDate(value.endDate),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ], text: "book this car from "),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget(
    Function(DateTime value) this.onChange, {
    Key key,
    @required this.dateTime,
  }) : super(key: key);

  final DateTime dateTime;
  final onChange;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime pickedDateTime = await showDialog<DateTime>(
          context: context,
          builder: (context) => SimpleDialog(
            title: Text('Select Date'),
            children: [
              Container(
                child: CalendarDatePicker(
                  initialDate: dateTime,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                  onDateChanged: (DateTime value) {
                    Navigator.of(context).pop(value);
                  },
                ),
              ),
            ],
          ),
        );
        if (pickedDateTime != null) {
          onChange(pickedDateTime);
        }
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 22,
            ),
            SizedBox(width: 5),
            Text(dateTime.day == DateTime.now().day
                ? 'Today'
                : dateTime.day == DateTime.now().day + 1
                    ? 'Tomorrow'
                    : '${dateTime.day}/${dateTime.month}/${dateTime.year}'),
            Icon(Icons.arrow_drop_down, size: 20),
          ],
        ),
      ),
    );
  }
}
