import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Locationwidget extends StatelessWidget {
  const Locationwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
                child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('locations').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No location data found.'));
                }

                final locations = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    final data =
                        locations[index].data() as Map<String, dynamic>;

                    final email = data['email'] ?? 'Unknown Email';
                    final latitude = data['latitude']?.toString() ?? 'N/A';
                    final longitude = data['longitude']?.toString() ?? 'N/A';

                    return ListTile(
                      leading: const Icon(Icons.location_on),
                      title: Text(email),
                      subtitle: Text("Lat: $latitude, Long: $longitude"),
                    );
                  },
                );
              },
            ));
  }
}