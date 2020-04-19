import 'package:flutter/cupertino.dart';
import 'package:fluttermovieapp/model/person_response.dart';
import 'package:fluttermovieapp/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class PersonListBloc {
  final MovieRepository _repository = MovieRepository();
  final BehaviorSubject<PersonResponse> _subject =
      BehaviorSubject<PersonResponse>();

  getPersons() async {
    PersonResponse response = await _repository.getPersons();
    _subject.sink.add(response);
  }

  void drainStream() {
    _subject.value = null;
  }

  @mustCallSuper
  dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<PersonResponse> get subject => _subject;
}

final personsBloc = PersonListBloc();
