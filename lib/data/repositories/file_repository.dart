import 'dart:convert';
import 'dart:typed_data';
import 'package:challenge/data/services/word_search_service.dart';
import 'package:file_picker/file_picker.dart';

class FileRepository {
  FileRepository(this._service);
  final WordSearchService _service;
  Future<List<String>?> getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );
    if (result != null) {
      Uint8List fileBytes = result.files.first.bytes!;
      String conteudoDoArquivo = utf8.decode(fileBytes);
      List<String> linhas = conteudoDoArquivo.split('\n');
      return linhas;
    }
    return null;
  }

  int countWord(String word, List<String> matriz) {
    return _service.countWord(word, matriz);
  }
}
