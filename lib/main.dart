import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crest_weather_demo/bloc/weather_bloc.dart';
import 'package:crest_weather_demo/pages/weather_page.dart';
import 'package:crest_weather_demo/utils/bloc_observer.dart';
import 'package:crest_weather_demo/utils/internet_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  Bloc.observer = AppBlocObserver();
  runApp(MyApp(connection: Connectivity()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.connection,
  });

  // This widget is the root of your application.
  final Connectivity connection;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connection),
        ),
        BlocProvider(
          create: (context) => WeatherBloc(),
        ),
      ],
      child: MyAppView(),
    );
  }
}

class MyAppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crest Weather Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WeatherPage(),
    );
  }
}
