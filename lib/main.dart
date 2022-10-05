import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'model_res.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rest API Integration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  getHttp() async {
    var response =
        await Dio().get('https://jsonplaceholder.typicode.com/todos');
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: getHttp(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        ModelRes model =
                            ModelRes.fromJson(snapshot.data[index]);
                        return ListTile(
                          contentPadding: const EdgeInsets.all(5),
                          title: Text(model.title!),
                          trailing: model.completed!
                              ? const Icon(Icons.done, color: Colors.green)
                              : const Icon(
                                  Icons.check_box_outline_blank_outlined),
                        );
                      },
                    );
            }),
      ),
    );
  }
}
