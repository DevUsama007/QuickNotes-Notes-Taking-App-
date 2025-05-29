import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:notes_taking_app_dio/app/custom_widget/custom_btn_widget.dart';
import 'package:notes_taking_app_dio/app/custom_widget/custom_textField.dart';
import 'package:notes_taking_app_dio/app/custom_widget/notes_view_widget.dart';
import 'package:notes_taking_app_dio/app/res/app_assets.dart';
import 'package:notes_taking_app_dio/app/res/app_text_styles.dart';
import 'package:notes_taking_app_dio/app/res/routes/route_name.dart';
import 'package:notes_taking_app_dio/app/utils/notification.dart';
import 'package:notes_taking_app_dio/app/view/liaquidrefresh.dart';
import 'package:notes_taking_app_dio/app/view/notesScreen/notesDetailScreen.dart';
import 'package:notes_taking_app_dio/app/view_model/notesViewModel/fetch_notes_view_model.dart';
import '../../custom_widget/customAppBar.dart';
import '../../custom_widget/loading_indicator_widget.dart';
import '../../res/app_colors.dart';
import '../../res/status.dart';
import 'package:liquid_pull_refresh/liquid_pull_refresh.dart';

class NotesViewScreen extends StatefulWidget {
  const NotesViewScreen({super.key});

  @override
  State<NotesViewScreen> createState() => _NotesViewScreenState();
}

class _NotesViewScreenState extends State<NotesViewScreen> {
  FetchNotesViewModel _notesControler = Get.put(FetchNotesViewModel());

  void initState() {
    // TODO: implement initState
    super.initState();
    _notesControler.fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(
          backgroundColor: AppColors.iconColor,
          title: 'QuickNotes',
        ),
      ),
      body: LiquidPullRefresh(
        onRefresh:
            _notesControler.handleRefresh, // Just pass the function directly
        color: AppColors.iconColor, // Customize the refresh indicator color
        backgroundColor: Colors.white, // Background color
        height: 140,
        bottomShaddow: true,
        bottomShaddowCollor: Colors.red, // Height of the refresh indicator
        animSpeedFactor: 2, // Animation speed

        showChildOpacityTransition: true,
        child: ListView(
          children: [
            Column(
              children: [
                CustomTextFieldWidget(
                  controller: _notesControler.searchController.value,
                  hintText: "Search Notes Here",
                  labeltext: 'Search Here',
                  leadingIcon: Icon(
                    Icons.search,
                    color: AppColors.iconColor,
                  ),
                  onchange: () {
                    _notesControler.searchText.value =
                        _notesControler.searchController.value.text;
                  },
                ).paddingOnly(left: 10, right: 10, top: 15, bottom: 10),
                Obx(() {
                  switch (_notesControler.rxRequestStatus.value) {
                    case Status.LOADING:
                      return Container(
                          width: Get.width,
                          height: Get.height * 0.7,
                          child: Center(
                              child: Container(
                            child: LoadingIndicatorWidget(
                                strokeWidth: 1,
                                indicator: Indicator.orbit,
                                indicatorColor: Colors.purple),
                          )));
                    case Status.ERROR:
                      return Container(
                        width: Get.width,
                        height: Get.height * 0.7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.hourglass_empty_sharp,
                              size: 25,
                              color: AppColors.iconColor,
                            ),
                            Text(
                              _notesControler.showError.value,
                              style: AppTextStyles.customText(
                                  fontSize: 14,
                                  color:
                                      AppColors.detailColor.withOpacity(0.4)),
                            ),
                          ],
                        ),
                      );
                    case Status.COMPLETED:
                      // Filter notes based on search text
                      final filteredNotes = _notesControler
                              .searchText.value.isEmpty
                          ? _notesControler.notesData
                          : _notesControler.notesData
                              .where((note) => note.notesTitle
                                  .toString()
                                  .toLowerCase()
                                  .contains(_notesControler.searchText.value
                                      .toLowerCase()))
                              .toList();

                      // Show "No notes found" if search is active and no matches
                      if (_notesControler.searchText.value.isNotEmpty &&
                          filteredNotes.isEmpty) {
                        return Container(
                          width: Get.width,
                          height: Get.width,
                          child: Center(
                            child: Text('No notes Matched',
                                style: AppTextStyles.customText(
                                    fontSize: 14,
                                    color: AppColors.detailColor
                                        .withOpacity(0.4))),
                          ),
                        ).paddingOnly(top: 60);
                      }

                      return Wrap(
                        children: List.generate(
                          filteredNotes.length,
                          (index) {
                            final notes = filteredNotes[index];
                            return GestureDetector(
                              onTap: () async {
                                FocusScope.of(context).unfocus();
                                _notesControler.deleteSuccess.value = false;
                                await Get.to(() => NotesDetailScreen(
                                    id: notes.id.toString(),
                                    title: notes.notesTitle.toString(),
                                    detail: notes.notesDetail.toString(),
                                    imagePath: notes.coverImage.toString(),
                                    supportedfile:
                                        notes.supertiveFile.toString()));
                                print(_notesControler.deleteSuccess.value);
                                if (_notesControler.deleteSuccess.value) {
                                  _notesControler.fetchNotes();
                                } else {
                                  print("not deleted");
                                }
                              },
                              child: Card(
                                shadowColor: AppColors.textColor,
                                elevation: 0.9,
                                child: NotesViewWidget(
                                  bgColor: Color(Random().nextInt(0xFFEF0000)),
                                  title: notes.notesTitle.toString(),
                                  detail: notes.notesDetail.toString(),
                                  imagePath: notes.coverImage.toString(),
                                ),
                              ).paddingOnly(left: 5, bottom: 10),
                            );
                          },
                        ),
                      ).paddingOnly(bottom: 60);
                    default:
                      return const Text('Unknown error');
                  }
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
