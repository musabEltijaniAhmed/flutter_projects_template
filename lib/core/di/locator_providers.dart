import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:matryal_seller/core/services/network/inetwork_services.dart';
import 'package:matryal_seller/features/projects/data/repositories_impl/project_repository%D9%80implement.dart';
import 'package:matryal_seller/features/projects/domain/repositories/projects_repository.dart';

import '../services/network/dio_network_service.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

// Network service provider that returns either mock or real service based on debug mode
final networkServicesDi = Provider<INetworkServices>(
  (ref) => DioNetworkService(ref.read(dioProvider)),
);
 
// Projects repository using the injected network service
final projectRepoDi = Provider<ProjectRepository>(
  (ref) => ProjectRepositoryImplementing(
    networkService: ref.read(networkServicesDi),
  ),
);

 
