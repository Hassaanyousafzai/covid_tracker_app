import 'package:flutter/material.dart';

import '../components/homepage_row.dart';

class CountryDetails extends StatefulWidget {
  final String image;

  final String name;

  final int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      population,
      todayRecovered,
      test;
  const CountryDetails({
    super.key,
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.population,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<CountryDetails> createState() => _CountryDetailsState();
}

class _CountryDetailsState extends State<CountryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 212, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 212, 255, 255),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .05),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Column(children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .06,
                      ),
                      ReusableRow(
                        title: 'Country Name',
                        value: widget.name.toString(),
                      ),
                      ReusableRow(
                        title: 'Population',
                        value: widget.population.toString(),
                      ),
                      ReusableRow(
                        title: 'Total Cases',
                        value: widget.totalCases.toString(),
                      ),
                      ReusableRow(
                        title: 'Active Cases',
                        value: widget.active.toString(),
                      ),
                      ReusableRow(
                        title: 'Recovered',
                        value: widget.totalRecovered.toString(),
                      ),
                      ReusableRow(
                        title: 'Today Recovered',
                        value: widget.totalRecovered.toString(),
                      ),
                      ReusableRow(
                        title: 'Death',
                        value: widget.totalDeaths.toString(),
                      ),
                      ReusableRow(
                        title: 'Tests',
                        value: widget.test.toString(),
                      ),
                    ]),
                  ),
                ),
              ),
              Positioned(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
