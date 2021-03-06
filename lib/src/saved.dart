import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'block/Block.dart';

//tip - 파일을 새로 만들고 stless 라고 치면 자동으로 코드가 만들어짐
class SavedList extends StatefulWidget {
  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Saved"),
        ),
        body: _buildList());
  }

  Widget _buildList() {
    return StreamBuilder<Set<WordPair>>(
        stream: bloc.savedStream,
        builder: (context, snapshot) {
          var saved = Set<WordPair>();
          if (snapshot.hasData)
            saved.addAll(snapshot.data);
          else
            bloc.addCrrentSaved; //test

          //▼ ListView 스크롤 할때마다 리스트가 추가되는 부분
          // itemCount를 정해 주어야함. 안해주면 무제한으로 스크롤 할때 마다 동작함
          // saved.length * 2 를 한 이유는 줄을 표현 하는 Weiget도 1개의 카운트에 들어가기 때문에...
          return ListView.builder(
              itemCount: saved.length * 2,
              itemBuilder: (context, index) {
                if (index.isOdd) return Divider();//줄
                var realIndex = index ~/ 2;
                // ▼ set객체는 인덱스로 불러오는게 불가능하여  List로 캐스팅후 인덱스 값으로 호출
                return _buildRow(saved.toList()[realIndex]);
              });
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      onTap: () {
        bloc.addToOrRemoveFromSavedList(pair);
      },
    );
  }
}
