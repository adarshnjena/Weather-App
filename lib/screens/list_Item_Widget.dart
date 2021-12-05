import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListItemWidget extends StatefulWidget {
  final temp;
  final wind;
  final weatherIcon;
  final cityName;
  const ListItemWidget({
    this.cityName,
    this.temp,
    this.wind,
    this.weatherIcon,
  });

  @override
  State<ListItemWidget> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black12,
      // shadowColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      elevation: 2,
      margin: EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.cityName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cabin',
                  ),
                ),
                Text(
                  '${widget.temp}°c',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Nunito',
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "wind",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Cabin',
                  ),
                ),
                Text(
                  '${widget.wind}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Nunito',
                  ),
                ),
              ],
            ),
            Image(
              image: AssetImage(widget.weatherIcon),
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
