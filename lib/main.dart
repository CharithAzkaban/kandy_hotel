import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'utils/attributes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers:  [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const Main(),
    ),
  );
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerConfig: goRouter,
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        theme: ThemeData(
          brightness: MediaQuery.of(context).platformBrightness,
          primarySwatch: generateMaterialColor(color: primary),
        ),
      );
}
