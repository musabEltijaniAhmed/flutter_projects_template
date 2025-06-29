import 'package:flutter_project_template/core/shared/class_shared_import.dart';

///use this class fro abstracting the building repo

abstract interface class ProjectRepository {
  ///we add all authentication function here
  Future<PostDataHandle<ProjectModel>> getAllProject({required String url});
  Future<PostDataHandle<ProjectModel>> getSingleData();
}
