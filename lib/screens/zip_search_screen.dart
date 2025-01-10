import 'package:activitat_1_4/models/zippo.dart';
import 'package:activitat_1_4/services/zippo_service.dart';
import 'package:flutter/material.dart';

class ZipSearchScreen extends StatefulWidget {
  const ZipSearchScreen({super.key});

  @override
  State<ZipSearchScreen> createState() => _ZipSearchScreenState();
}

class _ZipSearchScreenState extends State<ZipSearchScreen> {
  Zippo? zippopotam;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "ZipSearchApp",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: (zippopotam == null)
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: zippopotam!.places
                  .map(
                    (place) => Text(
                      place.placeName
                    ),
                  )
                  .toList(),
            ),
    );
  }

  Future<void> init() async {
    zippopotam = await ZippoService.instance.fetchDataFromApi();
    setState(() {});
  }
}