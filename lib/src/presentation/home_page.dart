import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:group_gps_chat_app/src/actions/index.dart';
import 'package:group_gps_chat_app/src/models/index.dart';
import 'package:group_gps_chat_app/src/presentation/containers/locations_container.dart';
import 'package:group_gps_chat_app/src/presentation/containers/user_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    StoreProvider.of<AppState>(context, listen: false)
      ..dispatch(const GetLocation.start())
      ..dispatch(const ListenForLocations.start());
  }

  @override
  Widget build(BuildContext context) {
    return LocationsContainer(
      builder: (BuildContext context, List<UserLocation> locations) {
        return UserContainer(
          builder: (BuildContext context, AppUser? user) {
            return Scaffold(
              appBar: AppBar(
                title: Text(user!.displayName),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.power_settings_new),
                    onPressed: () {
                      StoreProvider.of<AppState>(context).dispatch(const Logout());
                    },
                  ),
                ],
              ),
              body: ListView.builder(
                itemCount: locations.length,
                itemBuilder: (BuildContext context, int index) {
                  final UserLocation location = locations[index];

                  final bool isMe = location.uid == user.uid;

                  return ListTile(
                    title: Text('$location'),
                    trailing: isMe ? const Icon(Icons.star) : const Icon(Icons.star_outline),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
