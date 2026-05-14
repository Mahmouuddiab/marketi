import 'package:marketi/features/search/data/model/search_response.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final SearchResponse response;

  SearchSuccess(this.response);
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}