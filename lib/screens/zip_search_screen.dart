import 'package:activitat_1_4/models/zippo.dart';
import 'package:activitat_1_4/services/zippo_service.dart';
import 'package:flutter/material.dart';

class ZipSearchScreen extends StatefulWidget {
  const ZipSearchScreen({super.key});

  @override
  State<ZipSearchScreen> createState() => _ZipSearchScreenState();
}

class _ZipSearchScreenState extends State<ZipSearchScreen> {
  Zippo? zippo;
  final TextEditingController _zipController = TextEditingController();
  String? errorMessage;

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _zipController,
              decoration: InputDecoration(
                labelText: "Introdueix un codi postal",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchZip,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            if (zippo != null)
              Expanded(
                child: ListView(
                  children: zippo!.places
                      .map((place) => ListTile(
                            title: Text(place.placeName),
                          ))
                      .toList(),
                ),
              )
            else if (errorMessage == null)
              const Expanded(
                child: Center(
                  child: Text(
                      "Introdueix un codi postal per veure els resultats."),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _searchZip() async {
    final zipCode = _zipController.text.trim();
    if (zipCode.isEmpty) {
      setState(() {
        errorMessage = "Introdueix un codi postal vàlid.";
        zippo = null;
      });
      return;
    }

    setState(() {
      errorMessage = null;
      zippo = null;
    });

    try {
      final result = await ZippoService.instance.fetchDataFromApi(zipCode);
      setState(() {
        zippo = result;
      });
    } catch (e) {
      setState(() {
        errorMessage =
            "Impossible obtenir la informació. Comprova que el codi postal és correcte.";
        zippo = null;
      });
    }
  }
}
