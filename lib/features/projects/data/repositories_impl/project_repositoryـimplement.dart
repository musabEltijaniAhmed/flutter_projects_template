import 'package:matryal_seller/features/projects/data/model/project_model.dart';

import '../../../../core/constants/app_end_points.dart';
import '../../../../core/domain/entity/data_handel_model.dart';
import '../../../../core/services/network/inetwork_services.dart';
import '../../domain/repositories/projects_repository.dart';

class ProjectRepositoryImplementing implements ProjectRepository {
  final INetworkServices networkService;
  ProjectRepositoryImplementing({required this.networkService});

  ///Example of get data with pagination
  @override
  Future<PostDataHandle<ProjectModel>> getAllProject({
    required String url,
  }) async {
    return networkService.get<ProjectModel>(
      url: url.isEmpty ? ApiEndPoints.projectUrl : url,
      requiresToken: true,

      ///this is response from api
      fromJson: ProjectModel.fromJson,
    );
  }

  ///Example of get data without pagination
  @override
  Future<PostDataHandle<ProjectModel>> getSingleData() {
    return networkService.get<ProjectModel>(
      url: ApiEndPoints.projectUrl,
      requiresToken: true,

      ///this is response from api
      fromJson: ProjectModel.fromJson,
    );
  }
}
