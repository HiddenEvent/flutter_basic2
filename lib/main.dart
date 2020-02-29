import 'package:flutter/material.dart'; //material 라이브러리 추가
import 'package:english_words/english_words.dart'; //english_words 라이브러리 추가
import 'package:flutter_basic2/src/random_list.dart';


void main () => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {// 플루터는 모든 컴포넌트를 위젯으로 보면된다.
    //추가합니다 / test
    return MaterialApp(
      home: RandomList()
    );

  }

}