import 'package:flutter/material.dart';
import 'package:matryal_seller/core/constants/app_flow_sate.dart';
import 'package:matryal_seller/core/widgets/data_view_builder.dart';
import '../../../../core/shared/class_shared_import.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  ProviderContainer? provider;

  ScrollController scrollController = ScrollController();
  late PaginationHandler paginationHandler;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      provider = ProviderScope.containerOf(context);
      provider?.read(projectNotifier.notifier).loadData();
      onScrollBottom();
    });
  }

  ///load data from api

  ///using this in pagination for get new data
  void onScrollBottom() {
    paginationHandler = PaginationHandler(
      scrollController: scrollController,
      hasNextPage:
          () => provider?.read(projectNotifier).allProjects.nextUrl != null,
      onLoadMore:
          () async => provider
              ?.read(projectNotifier.notifier)
              .getAllProject(isLoadingMore: true),
    );
  }

  @override
  void dispose() {
    ///delete filter data when user exit from screen
    scrollController.dispose();
    paginationHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(text: AppMessage.profile),
      body: Consumer(
        builder: (_, ref, child) {
          final DataHandle<ProjectModel> projectData =
              ref.watch(projectNotifier).allProjects;
          return DataViewBuilder<ProjectModel>(
            dataHandle: projectData,
            loadingBuilder: () => CustomLoad().projectShimmer(context),
            isDataEmpty: () => projectData.data?.data?.isEmpty == true,
            onReload:
                () async =>
                    ref.read(projectNotifier.notifier).loadData(refresh: true),
            successBuilder:
                (ProjectModel model) => ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: scrollController,
                  padding: EdgeInsets.only(
                    bottom: 10.h,
                    left: 10.w,
                    right: 10.w,
                  ),
                  itemCount: model.data!.length + 1,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (_, index) {
                    return model.data!.length > index
                        ? Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: GestureDetector(
                            onTap: () {},
                            child: ProjectWidget(
                              isScale:
                                  ref.watch(projectNotifier).allProjectsIndex ==
                                  index,
                              width: context.width * 0.8,
                              data: model.data![index],
                            ),
                          ),
                        )
                        : projectData.result == AppFlowState.loadingMore
                        ? CustomLoad().boxLoad()
                        : SizedBox.shrink();
                  },
                ),
          );
        },
      ),
    );
  }
}
