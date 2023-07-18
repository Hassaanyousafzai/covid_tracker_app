import 'package:covid_tracker/components/get_api.dart';
import 'package:covid_tracker/components/homepage_row.dart';
import 'package:covid_tracker/models/covid_all_data.dart';
import 'package:covid_tracker/screens/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<Color> colorList = const [
    Color(0xff1974D2),
    Color(0xff50C878),
    Color(0xffFF2400),
  ];

  @override
  Widget build(BuildContext context) {
    GetAPI getAllData = GetAPI();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 212, 255, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              FutureBuilder<covidAllDataModel>(
                future: getAllData.getCovidAllData(),
                builder: (context, AsyncSnapshot<covidAllDataModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                          color: Colors.black,
                          controller: controller,
                          size: 70),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          animationDuration: const Duration(seconds: 3),
                          colorList: colorList,
                          chartType: ChartType.ring,
                          chartRadius: MediaQuery.of(context).size.width / 1.0,
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Death":
                                double.parse(snapshot.data!.deaths.toString()),
                          },
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Column(
                            children: [
                              ReusableRow(
                                  title: "Total",
                                  value: snapshot.data!.cases.toString()),
                              const Divider(
                                color: Colors.black,
                              ),
                              ReusableRow(
                                  title: "Recovered",
                                  value: snapshot.data!.recovered.toString()),
                              const Divider(
                                color: Colors.black,
                              ),
                              ReusableRow(
                                  title: "Death",
                                  value: snapshot.data!.deaths.toString()),
                              const Divider(
                                color: Colors.black,
                              ),
                              ReusableRow(
                                  title: "Active Cases",
                                  value: snapshot.data!.active.toString()),
                              const Divider(
                                color: Colors.black,
                              ),
                              ReusableRow(
                                  title: "Today's Cases",
                                  value: snapshot.data!.todayCases.toString()),
                              const Divider(
                                height: 6,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .04,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CountriesScreen()));
                          },
                          child: Container(
                            height: 60,
                            // width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green),
                            child: const Center(
                              child: Text(
                                "Countries",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
