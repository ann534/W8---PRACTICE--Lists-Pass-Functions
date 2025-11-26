import 'package:flutter/material.dart';
import 'data/profile_data.dart';
import 'data/profile_db.dart';

void main() => runApp(MaterialApp(home: ProfilesPage(profiles: profiles)));

/// EX2 - ProfileCard that binds to ProfileData model
/// Displays profile information in a Card widget
class ProfileCard extends StatelessWidget {
  final ProfileData data;

  const ProfileCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage:
              data.imageUrl.isNotEmpty ? NetworkImage(data.imageUrl) : null,
          child: data.imageUrl.isEmpty ? const Icon(Icons.person) : null,
        ),
        title: Text(
          data.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(data.subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}

/// ProfilesPage - Main page that displays all profiles
/// Uses ListView.builder for efficient scrolling
class ProfilesPage extends StatelessWidget {
  final List<ProfileData> profiles;

  const ProfilesPage({super.key, required this.profiles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EX2 - Profiles'),
        backgroundColor: Colors.blue[700],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          return ProfileCard(data: profiles[index]);
        },
      ),
    );
  }
}
