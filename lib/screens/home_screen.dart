import 'package:flutter/material.dart';
import 'package:flutter_gest_event_slama_best_choice_app/models/event.dart';
import 'package:flutter_gest_event_slama_best_choice_app/screens/color_filters.dart';
import 'package:flutter_gest_event_slama_best_choice_app/screens/login_screen.dart';
import 'package:flutter_gest_event_slama_best_choice_app/services/auth.dart';
import 'package:flutter_gest_event_slama_best_choice_app/services/remote_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//create local storage instance
  final storage = new FlutterSecureStorage();
  String _token = '';

  //iniate list of events
  List<Event>? events;

  var isLoaded = false;

  getData() async {
    //hatina data fi variable events
    events = await remoteServices().getEvents();

    //test aal data est que l model maabi wala la
    if (events != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readToken();
    //fetch data from api
    getData();
  }

  void readToken() async {
    //read token mil local storage
    String? token = await this.storage.read(key: 'token');

    ///tayaat ll provider yjib data kano token shih kano shih yconicti direct
    Provider.of<Auth>(context, listen: false).getToken();

    print(token);

    if (token != null) {
      this._token = token;
    }
  }

  Widget buildQuoteCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'If life were predictable it would cease to be life, and be without flavor.',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 12),
              const Text(
                'Eleanor Roosevelt',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );

  Widget buildRoundedCard() => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Rounded card',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'This card is rounded',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      );

  Widget buildColoredCard() => Card(
        shadowColor: Colors.red,
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.redAccent, Colors.red],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Colored card',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'This card is rounded and has a gradient',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildImageCard() => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: const NetworkImage(
                'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80',
              ),
              colorFilter: ColorFilters.greyscale,
              child: InkWell(
                onTap: () {},
              ),
              height: 240,
              fit: BoxFit.cover,
            ),
            const Text(
              'Card With Splash',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventify'),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
            itemCount: events?.length,
            itemBuilder: (context, index) {
              Event _events = events![index];
              return Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Ink.image(
                                image: NetworkImage(
                                  'http://10.0.2.2/PFE-GestEvent/public/storage/' +
                                      _events.photo,
                                ),
                                child: InkWell(
                                  onTap: () {},
                                ),
                                height: 240,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                bottom: 16,
                                right: 16,
                                left: 16,
                                child: Text(
                                  _events.label,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.all(16).copyWith(bottom: 0),
                            child: Text(
                              _events.description,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.all(16).copyWith(bottom: 0),
                            child: Text(
                              _events.lieux,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.all(30).copyWith(bottom: 30),
                            child: Text(
                              _events.price + " DT",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          // ButtonBar(
                          //   alignment: MainAxisAlignment.start,
                          //   children: [
                          //     FlatButton(
                          //       child: const Text('See more'),
                          //       onPressed: () {},
                          //     ),
                          //     FlatButton(
                          //       child: const Text('See more'),
                          //       onPressed: () {},
                          //     )
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      drawer: Drawer(child: Consumer<Auth>(builder: (context, auth, child) {
        //kano auth tjih bouton logout barek sinn login fil else
        if (!auth.authentiated) {
          return ListView(
            children: [
              ListTile(
                title: const Text('login'),
                leading: const Icon(Icons.login),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
                },
              ),
            ],
          );
        } else {
          return ListView(
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    CircleAvatar(
                      // backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(auth.user.avatar),
                      radius: 30,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      auth.user.name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      auth.user.email,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: const Text('Logout'),
                leading: const Icon(Icons.logout),
                onTap: () {
                  Provider.of<Auth>(context, listen: false).logout();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
              ),
            ],
          );
        }
        throw '';
      })),
    );
  }
}
