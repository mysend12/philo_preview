import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:philo/common/exception/exception_handler.dart';
import 'package:philo/ui/home/home_view.dart';

import 'common/dependency_injection.dart';

void main() async {
  ExceptionHandler exceptionHandler = ExceptionHandler();
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    exceptionHandler.onErrorDetails(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    exceptionHandler.onError(error, stack);
    return true;
  };

  WidgetsFlutterBinding.ensureInitialized();
  await dependencyInjection();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeView(),
    );
  }
}

