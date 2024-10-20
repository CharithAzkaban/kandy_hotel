import 'package:auto_updater/auto_updater.dart';
import 'package:kandy_hotel/utils/constants.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> checkForUpdates({bool? background}) async {
  await autoUpdater.setFeedURL(feedUrl);
  await autoUpdater.checkForUpdates(inBackground: background);
  await autoUpdater.setScheduledCheckInterval(3600);
}

Future<String> getVersion() async {
  final packageInfo = await PackageInfo.fromPlatform();
  return '${packageInfo.version} + ${packageInfo.buildNumber}';
}
