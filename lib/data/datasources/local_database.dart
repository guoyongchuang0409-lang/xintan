import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../domain/models/quiz_report.dart';
import 'database_interface.dart';

class LocalDatabase implements DatabaseInterface {
  static const String _databaseName = 'personality_quiz.db';
  static const int _databaseVersion = 1;
  static const String _reportsTable = 'quiz_reports';

  static Database? _database;
  static LocalDatabase? _instance;

  LocalDatabase._();

  static LocalDatabase get instance {
    _instance ??= LocalDatabase._();
    return _instance!;
  }

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_reportsTable (
        id TEXT PRIMARY KEY,
        quiz_type_id TEXT NOT NULL,
        quiz_type_name TEXT NOT NULL,
        created_at TEXT NOT NULL,
        data TEXT NOT NULL
      )
    ''');
  }

  @override
  Future<void> insertReport(QuizReport report) async {
    final db = await database;
    await db.insert(
      _reportsTable,
      {
        'id': report.id,
        'quiz_type_id': report.quizTypeId,
        'quiz_type_name': report.quizTypeName,
        'created_at': report.createdAt.toIso8601String(),
        'data': jsonEncode(report.toJson()),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<QuizReport>> getAllReports() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _reportsTable,
      orderBy: 'created_at DESC',
    );

    return maps.map((map) {
      final data = jsonDecode(map['data'] as String) as Map<String, dynamic>;
      return QuizReport.fromJson(data);
    }).toList();
  }

  @override
  Future<QuizReport?> getReportById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _reportsTable,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      return null;
    }

    final data = jsonDecode(maps.first['data'] as String) as Map<String, dynamic>;
    return QuizReport.fromJson(data);
  }

  @override
  Future<void> deleteReport(String id) async {
    final db = await database;
    await db.delete(
      _reportsTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteAllReports() async {
    final db = await database;
    await db.delete(_reportsTable);
  }

  @override
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
