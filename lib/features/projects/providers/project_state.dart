import 'package:equatable/equatable.dart';
import 'package:matryal_seller/core/shared/class_shared_import.dart';

class ProjectState extends Equatable {
  final bool isLoading;

  final DataHandle<ProjectModel> allProjects;
  final DataHandle<ProjectModel> myProjects;
  final int allProjectsIndex;
  final int myProjectsIndex;
  final bool isHorizontalView;

  const ProjectState({
    this.isLoading = false,

    this.allProjects = const DataHandle(),
    this.myProjects = const DataHandle(),
    this.allProjectsIndex = 0,
    this.myProjectsIndex = 0,
    this.isHorizontalView = false,
  });
  ProjectState copyWith({
    bool? isLoading,
    DataHandle<ProjectModel>? allProjects,
    DataHandle<ProjectModel>? myProjects,
    int? allProjectsIndex,
    int? myProjectsIndex,
    bool? isHorizontalView,
  }) {
    return ProjectState(
      isLoading: isLoading ?? this.isLoading,
      allProjects: allProjects ?? this.allProjects,
      myProjects: myProjects ?? this.myProjects,
      allProjectsIndex: allProjectsIndex ?? this.allProjectsIndex,
      myProjectsIndex: myProjectsIndex ?? this.myProjectsIndex,
      isHorizontalView: isHorizontalView ?? this.isHorizontalView,
    );
  }

  @override
  List<Object?> get props => [isLoading, allProjects, myProjects];
}
