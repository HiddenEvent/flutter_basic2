import 'dart:async';

import 'package:english_words/english_words.dart';

// block Pattern
class Bloc{
  Set<WordPair> saved = Set<WordPair>();
  //broadcast Stream에서 여러군대로 다 보내줌
  final _savedController = StreamController<Set<WordPair>>.broadcast();

  get savedStream => _savedController.stream; // 값을 받아서 넣기만 하는 기능

  // addCrrentSaved 호출하면 saved값을 보내줘라
  get addCrrentSaved => _savedController.sink.add(saved);

  addToOrRemoveFromSavedList(WordPair item){
    if(saved.contains(item)){
      saved.remove(item);
    }else{
      saved.add(item);
    }
    // sink => 변경된 데이터를 메모리에 변경됬다고 알림.
    _savedController.sink.add(saved);
  }

  disposed(){ // 어느시기에 close를 반드시 해줘야한다.. 메모리누수?
    _savedController.close();
  }
}

// 블록패턴 연결부.
var bloc = Bloc();