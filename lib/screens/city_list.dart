import 'package:clima/screens/listLoding.dart';
import 'package:clima/screens/list_item_Widget.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/List.dart';

class CityListPage extends StatefulWidget {
  final String home;
  final List<ValueData> valueData;
  final listMemory;
  CityListPage({this.home, this.valueData, this.listMemory});
  @override
  _CityListPageState createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  TextEditingController controller;

  String home;

  GlobalKey<AnimatedListState> animatedListKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    home = widget.home;
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List listMemory = widget.listMemory;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(home),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'City List',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    AnimatedList(
                      key: animatedListKey,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      initialItemCount: memory.length,
                      itemBuilder: (context, index, animation) {
                        return SizeTransition(
                          sizeFactor: animation,
                          child: GestureDetector(
                            onDoubleTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Colors.black,
                                  title: Text(
                                    'Do you want to delete ${widget.listMemory[index]}?',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Nunito',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        if (widget.listMemory.indexOf(index) !=
                                            null) {
                                          widget.listMemory.removeAt(index);
                                          animatedListKey.currentState
                                              .removeItem(index,
                                                  (context, animation) => null);
                                        }
                                        Navigator.of(context)
                                            .pop(controller.text);
                                      },
                                      child: Text('Yes'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(controller.text);
                                      },
                                      child: Text('No'),
                                    )
                                  ],
                                ),
                              );
                            },
                            child: ListItemWidget(
                              cityName: listMemory[index],
                              temp: widget.valueData[index].temp,
                              wind: widget.valueData[index].wind,
                              weatherIcon: widget.valueData[index].weatherIcon,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final name = await openDialog();
            bool check = await CityCheck(name).getbool();
            if (check) {
              listMemory.add(name);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return ListLoadingScreen(
                  home: widget.home,
                  listMemory: listMemory,
                );
              }));

              if (animatedListKey.currentState != null) {
                animatedListKey.currentState.insertItem(0);
              }
            }
          },
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add,
            color: Colors.black,
            size: 40,
          ),
        ),
      ),
    );
  }

  Future<String> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          actionsPadding: EdgeInsets.only(right: 30, top: 10),
          titlePadding: EdgeInsets.all(30),
          contentPadding: EdgeInsets.only(right: 30, left: 30),
          backgroundColor: Colors.black,
          title: Text(
            'Add the city Name',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            autofocus: true,
            autocorrect: true,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Nunito',
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Colors.white10,
              labelText: 'City Name',
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Nunito',
              ),
              hintText: 'Enter the City',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(controller.text);
              },
              child: Text(
                'Submit',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Nunito',
                ),
              ),
            )
          ],
        ),
      );

  // void removeCity(int index) {
  //   if (widget.listMemory.indexOf(index) != null) {
  //     widget.listMemory.removeAt(index);
  //     animatedListKey.currentState
  //         .removeItem(index, (context, animation) => null);
  //   }
  // }
}
