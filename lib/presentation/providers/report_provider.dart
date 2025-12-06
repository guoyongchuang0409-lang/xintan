import 'package:flutter/foundation.dart';
import '../../domain/models/quiz_report.dart';
import '../../domain/repositories/quiz_repository.dart';
import '../../data/repositories/quiz_repository_impl.dart';
class ReportProvider extends ChangeNotifier {
  final QuizRepository _repository;
  
  List<QuizReport> _reports = [];
  QuizReport? _currentReport;
  bool _isLoading = false;
  String? _errorMessage;

  ReportProvider({QuizRepository? repository})
      : _repository = repository ?? QuizRepositoryImpl();
  List<QuizReport> get reports => List.unmodifiable(_reports);
  QuizReport? get currentReport => _currentReport;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Future<void> loadReports() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _reports = await _repository.getQuizReports();
    } catch (e) {
      _errorMessage = '加载报告失败，请重试试';
      debugPrint('Error loading reports: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<void> loadReportById(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentReport = await _repository.getReportById(id);
      if (_currentReport == null) {
        _errorMessage = '报告不存在';
      }
    } catch (e) {
      _errorMessage = '加载报告失败，请重试试';
      debugPrint('Error loading report by id: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  void setCurrentReport(QuizReport? report) {
    _currentReport = report;
    notifyListeners();
  }
  Future<bool> deleteReport(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.deleteReport(id);
      _reports.removeWhere((report) => report.id == id);
      
      // 如果删除的是当前报告，清除当前报
      if (_currentReport?.id == id) {
        _currentReport = null;
      }
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = '删除报告失败，请重试试';
      debugPrint('Error deleting report: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  Future<bool> deleteAllReports() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.deleteAllReports();
      _reports = [];
      _currentReport = null;
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = '清除所有数据失败，请重试';
      debugPrint('Error deleting all reports: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
  void clearCurrentReport() {
    _currentReport = null;
    notifyListeners();
  }
  Future<bool> saveReport(QuizReport report) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _repository.saveQuizReport(report);
      // Add to local list and sort by time descending
      _reports.insert(0, report);
      _currentReport = report;
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = '保存报告失败，请重试试';
      debugPrint('Error saving report: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
