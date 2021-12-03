import 'package:flutter/material.dart';

class CityListPage extends StatefulWidget {
  final String home;
  CityListPage({this.home});
  @override
  _CityListPageState createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  String home;

  List memory = [
    'Delhi',
    'Mumbai',
    'London',
    'Dubai',
    'Nagpur',
    'Delhi',
    'Mumbai',
    'London',
    'Dubai',
    'Nagpur'
  ];
  void addCity(String newCity) {
    if (memory.length < 5) {
      memory.add(newCity);
    }
  }

  void removeCity(int index) {
    if (memory.indexOf(index) != null) {
      memory.removeAt(index);
    }
  }

  @override
  void initState() {
    super.initState();
    home = widget.home;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(home),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.darken),
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
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.white54,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                          margin: EdgeInsets.all(5),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      memory[index],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Cabin',
                                      ),
                                    ),
                                    Text(
                                      '100°c',
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
                                      "wind :- 120",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Cabin',
                                      ),
                                    ),
                                    Text(
                                      'temp :- 100°c',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Nunito',
                                      ),
                                    ),
                                  ],
                                ),
                                Image(
                                  image: AssetImage('images/Day Sun.png'),
                                  height: 50,
                                ),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        memory.removeAt(index);
                                      });
                                    },
                                    child: Icon(Icons.delete))
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: memory.length,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
