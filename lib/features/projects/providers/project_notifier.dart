import 'package:flutter_project_template/core/constants/app_flow_sate.dart';
import 'package:flutter_project_template/core/domain/repositories/state_repository.dart';
import 'package:flutter_project_template/core/shared/class_shared_import.dart';
import 'package:flutter_project_template/core/util/url_util.dart';
import 'package:flutter_project_template/features/projects/providers/project_state.dart';
import '../domain/repositories/projects_repository.dart';
import 'package:flutter_project_template/core/util/print_info.dart';

class ProjectNotifier extends StateNotifier<ProjectState>
    implements StateRepository {
  final ProjectRepository _projectRepository;

  ProjectNotifier(this._projectRepository) : super(const ProjectState());

  @override
  void resetState() {
    state = ProjectState();
  }

  @override
  void loadData({bool? refresh}) async {
    if (refresh == true) {
      ///must add reset state here
      ///if not added, when user refresh data it will return the last data url
      resetState();
      getAllProject();
    } else {
      ///check if user upload date before or not
      ///if not upload data, we call api to get data
      ///if upload data, we don't call api again

      if (state.allProjects.data == null) {
        getAllProject();
      }
    }
  }

  ///Example of get data with pagination
  //getAllProject===================================================================================================================================================
  void getAllProject({bool isLoadingMore = false}) async {
    final String currentUrl = state.allProjects.nextUrl ?? '';

    ///loading state
    state = state.copyWith(
      allProjects: state.allProjects.copyWith(
        result: isLoadingMore ? AppFlowState.loadingMore : AppFlowState.loading,
      ),
    );

    ///api call
    final PostDataHandle<ProjectModel> apiResponse = await _projectRepository
        .getAllProject(url: currentUrl);

    ///if success
    if (!apiResponse.hasError) {
      final List<ProjectModelData> newData = apiResponse.data?.data ?? [];
      final List<ProjectModelData> oldData = state.allProjects.data?.data ?? [];

      ///merge data if user scroll down
      final List<ProjectModelData> mergedData =
          isLoadingMore ? [...oldData, ...newData] : newData;

      ///save changed data
      state = state.copyWith(
        allProjects: state.allProjects.copyWith(
          result: AppFlowState.loaded,

          ///for save null value
          resetNextUrl: true,
          nextUrl: UrlUtils().mergeUrl(url: apiResponse.data?.nextUrl),
          data: apiResponse.data?.copyWith(data: mergedData),
        ),
      );
    }
    ///error response
    else {
      state = state.copyWith(
        allProjects: state.allProjects.copyWith(
          result: apiResponse.message,
          data: const ProjectModel(),
        ),
      );
    }
  }

  ///Example of get data without pagination
  //getAllProject===================================================================================================================================================
  void getSingleData() async {
    ///loading state
    state = state.copyWith(
      allProjects: state.allProjects.copyWith(result: AppFlowState.loading),
    );

    ///api call
    final PostDataHandle<ProjectModel> apiResponse =
        await _projectRepository.getSingleData();

    ///if success
    if (!apiResponse.hasError) {
      ///save changed data
      state = state.copyWith(
        allProjects: state.allProjects.copyWith(
          result: AppFlowState.loaded,
          data: apiResponse.data,
        ),
      );
    }
    ///error response
    else {
      state = state.copyWith(
        allProjects: state.allProjects.copyWith(
          result: apiResponse.message,
          data: const ProjectModel(),
        ),
      );
    }
  }
}
