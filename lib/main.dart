import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'model_res.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rest API Integration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;

  List<ModelRes> models = [];

  @override
  void initState() {
    getHttp();
    super.initState();
  }

  getHttp() async {
    try {
      setState(() {
        isLoading = true;
      });
      var response =
          await Dio().get('https://jsonplaceholder.typicode.com/todos');
      print(response);
      models =
          (response.data as List).map((e) => ModelRes.fromJson(e)).toList();
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemBuilder: (context, index) => HomeCard(
                  id: models[index].id!,
                  isCompleted: models[index].completed!,
                  title: models[index].title!,
                ),
                itemCount: models.length,
              ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final int id;

  HomeCard({required this.id, required this.title, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                isCompleted ? 'Completed' : "Pending",
                style: TextStyle(
                    color: isCompleted ? Colors.red : Colors.blueAccent,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
