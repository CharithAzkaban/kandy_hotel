import 'package:auto_updater/auto_updater.dart';
import 'package:kandy_hotel/utils/constants.dart';

Future<void> checkForUpdates({bool? background}) async {
  await autoUpdater.setFeedURL(feedUrl);
  await autoUpdater.checkForUpdates(inBackground: background);
  await autoUpdater.setScheduledCheckInterval(3600);
}