import 'package:mmarn/features/reports/data/models/report_request_model.dart';
import 'package:mmarn/features/reports/data/repositories/reports_repository.dart';

class SendReportUseCase {
  final ReportRepository repository;

  SendReportUseCase(this.repository);

  Future<void> call(ReportRequestModel report) {
    return repository.sendReport(report);
  }
}
