import 'package:auto_injector/auto_injector.dart';
import 'package:challenge/data/repositories/file_repository.dart';
import 'package:challenge/data/services/word_search_service.dart';
import 'package:challenge/ui/home/cubit/home_page_cubit.dart';

final injector = AutoInjector();

void setupInjector() {
  injector.addSingleton<FileRepository>(FileRepository.new);
  injector.add<WordSearchService>(WordSearchService.new);

  injector.add<HomePageCubit>(HomePageCubit.new);

  injector.commit();
}
