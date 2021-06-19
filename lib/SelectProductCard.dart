import 'package:flutter/material.dart';
import 'package:flutter_app_test/repository/model/DatumProduct.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SelectProductCard extends StatelessWidget {
  const SelectProductCard({Key key, this.choice}) : super(key: key);
  final DatumProduct choice;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    width: double.infinity,
                    height: 120,
                    child: Image.network(
                      'https://halalbari.com/public/storage/product/media/featureimage/' + choice.featureImg,
                      fit: BoxFit.fill,
                    )),
                Container(
                  margin: EdgeInsets.only(top: 15, left: 5, right: 5),
                  child: Text(choice.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, left: 5),
                  alignment: Alignment.centerLeft,
                  child: RatingBar.builder(
                    initialRating: double.parse(choice.rating.toString()),
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemSize: 18,
                    allowHalfRating: true,
                    itemCount: 5,
                    ignoreGestures: true,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, left: 5, bottom: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '৳ ${choice.salePrice}',
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, color: Colors.red),
                  ),
                ),
              ]),
        ));
  }
}
