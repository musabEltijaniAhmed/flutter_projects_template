import 'package:equatable/equatable.dart';

class ProjectModel extends Equatable {
  const ProjectModel({
    this.total,
    this.limit,
    this.skip,
    this.currentPage,
    this.totalPages,
    this.hasNext,
    this.hasPrev,
    this.nextUrl,
    this.prevUrl,
    this.data,
  });

  final int? total;
  final int? limit;
  final int? skip;
  final int? currentPage;
  final int? totalPages;
  final bool? hasNext;
  final bool? hasPrev;
  final String? nextUrl;
  final String? prevUrl;
  final List<ProjectModelData>? data;

  ProjectModel copyWith({
    int? total,
    int? limit,
    int? skip,
    int? currentPage,
    int? totalPages,
    bool? hasNext,
    bool? hasPrev,
    String? nextUrl,
    String? prevUrl,
    List<ProjectModelData>? data,
  }) {
    return ProjectModel(
      total: total ?? this.total,
      limit: limit ?? this.limit,
      skip: skip ?? this.skip,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasNext: hasNext ?? this.hasNext,
      hasPrev: hasPrev ?? this.hasPrev,
      nextUrl: nextUrl ?? this.nextUrl,
      prevUrl: prevUrl ?? this.prevUrl,
      data: data ?? this.data,
    );
  }

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      total: json["total"],
      limit: json["limit"],
      skip: json["skip"],
      currentPage: json["current_page"],
      totalPages: json["total_pages"],
      hasNext: json["has_next"],
      hasPrev: json["has_prev"],
      nextUrl: json["next_url"],
      prevUrl: json["prev_url"],
      data:
          json["data"] == null
              ? []
              : List<ProjectModelData>.from(
                json["data"]!.map((x) => ProjectModelData.fromJson(x)),
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    "total": total,
    "limit": limit,
    "skip": skip,
    "current_page": currentPage,
    "total_pages": totalPages,
    "has_next": hasNext,
    "has_prev": hasPrev,
    "next_url": nextUrl,
    "prev_url": prevUrl,
    "data": data?.map((x) => x.toJson()).toList(),
  };

  @override
  List<Object?> get props => [
    total,
    limit,
    skip,
    currentPage,
    totalPages,
    hasNext,
    hasPrev,
    nextUrl,
    prevUrl,
    data,
  ];
}

class ProjectModelData extends Equatable {
  const ProjectModelData({
    required this.name,
    required this.uid,
    required this.imageUrl,
    required this.userUid,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? name;
  final String? uid;
  final String? imageUrl;
  final String? userUid;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProjectModelData copyWith({
    String? name,
    String? uid,
    String? imageUrl,
    String? userUid,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProjectModelData(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      imageUrl: imageUrl ?? this.imageUrl,
      userUid: userUid ?? this.userUid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory ProjectModelData.fromJson(Map<String, dynamic> json) {
    return ProjectModelData(
      name: json["name"],
      uid: json["uid"],
      imageUrl: json["image_url"],
      userUid: json["user_uid"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "uid": uid,
    "image_url": imageUrl,
    "user_uid": userUid,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  @override
  List<Object?> get props => [
    name,
    uid,
    imageUrl,
    userUid,
    createdAt,
    updatedAt,
  ];
}
