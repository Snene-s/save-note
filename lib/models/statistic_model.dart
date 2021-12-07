
import 'package:flutter/foundation.dart';
import 'package:savenote/Services/statistic_service.dart';


class StatisticModel extends ChangeNotifier {

  bool _isLoading = false;
  bool get loading => _isLoading;
  final StatisticService statService = StatisticService();



}
