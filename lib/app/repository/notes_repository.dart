import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:notes_taking_app_dio/app/data/network/base_api_services.dart';
import 'package:notes_taking_app_dio/app/data/network/network_api_services.dart';
import 'package:notes_taking_app_dio/app/model/notes_model.dart';
import 'package:notes_taking_app_dio/app/res/app_url.dart';

import '../data/response/app_exception.dart';

class NotesRepository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<List<NotesModel>> FetchNotes(NotesModel notesData) async {
    try {
      final formdata = FormData.fromMap({...notesData.toJson()});
      final response =
          await _apiServices.postApi(formdata, AppUrl.fetchNotesApi);
      final responseData = jsonDecode(response.data);
      if (responseData['status'] == 'success') {
        // Map each item in the list to NotesModel
        final List<NotesModel> notes = (responseData['data'] as List)
            .map((noteJson) => NotesModel.fromJson(noteJson))
            .toList();
        return notes;
      } else {
        throw DefaultException(
            responseData['message'] ?? 'Failed to fetch notes');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future uploadNotes(
      NotesModel notesData, File? image, PlatformFile? supportedfile) async {
    final formdata = FormData.fromMap({
      ...notesData.toJson(),
      'coverImage': await MultipartFile.fromFile(
        image!.path,
        filename: 'coverimage_${DateTime.now().millisecondsSinceEpoch}.jpg',
      ),
      if (supportedfile != null)
        'supertiveFile': await MultipartFile.fromFile(supportedfile.path!,
            filename:
                "supertiveFile_${DateTime.now().millisecondsSinceEpoch}.${supportedfile.extension ?? ''}")
    });
    print('--- FormData Fields ---');
    formdata.fields.forEach((field) {
      print('${field.key}: ${field.value}');
    });
    print('\n--- FormData Files ---');
    formdata.files.forEach((file) {
      print('${file.key}: ${file.value.filename}');
      print('  Path: ${file.value.filename}');
      print('  ContentType: ${file.value.contentType}');
      print('  Length: ${file.value.length} bytes');
    });
    final response =
        await _apiServices.postApi(formdata, AppUrl.addNewNotesApi);
    final responseData = response.data;
    if (responseData['status'] == 'success') {
      return responseData['message'];
    } else {
      throw DefaultException("${responseData['message']}");
    }
  }

  Future deleteNotes(NotesModel notesData) async {
    try {
      final formData = FormData.fromMap({
        ...notesData.toJson(),
      });
      final response =
          await _apiServices.postApi(formData, AppUrl.deleteNotesApi);
      final responseData = jsonDecode(response.data);

      if (responseData['status'] == 'success') {
        return {'success': true, 'message': responseData['message']};
      } else {
        return {'success': false, 'message': responseData['message']};
      }
    } catch (e) {
      rethrow;
    }
  }
}
