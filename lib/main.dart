import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kandy_hotel/models/product.dart';
import 'package:kandy_hotel/models/sale.dart';
import 'package:kandy_hotel/models/sale_product.dart';
import 'package:kandy_hotel/providers/product_provider.dart';
import 'package:kandy_hotel/providers/sale_provider.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'providers/auth_provider.dart';
import 'services/system_services.dart';
import 'utils/attributes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await localNotifier.setup(appName: 'New Orchid Cafe');
  const windowOptions = WindowOptions(
    minimumSize: Size(
      1264.0,
      681.0,
    ),
    center: true,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  await checkForUpdates(background: true);

  _initDatabase();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => SaleProvider()),
      ],
      child: const Main(),
    ),
  );
}

void _initDatabase() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(SaleAdapter());
  Hive.registerAdapter(SaleProductAdapter());
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
