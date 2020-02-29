import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_basic2/src/saved.dart';
import 'block/Block.dart';

class RandomList extends StatefulWidget {
  @override
  // 한줄짜리 return을 갖는 함수는 => 대체 가능
  State<StatefulWidget> createState() => _RandomListState();
}

//Scaffold,block Pattern,Navigator.of(context).push,StreamBuilder,
// snapshot,StreamController<Set<WordPair>>.broadcast();
class _RandomListState extends State<RandomList> {
  //리스트 중복값 가능
  final List<WordPair> _suggestions = <WordPair>[];

  @override
  Widget build(BuildContext context) {
    //화면을 그려줌
    final randomWord = WordPair.random();
    return Scaffold(
        appBar: AppBar(
          title: Text("naming app"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () {
                //화면 전환 부분!
                bloc.savedStream; // block 패턴 적용

                //Navigator 오브젝트를 이용해서 다른 페이지로 이동
                Navigator.of(context).push(
                    // 클릭하면 SavedList 페이지 호출
                    MaterialPageRoute(builder: (context) => SavedList()));
              },
            ),
            IconButton(
              icon: Icon(Icons.account_balance),
              onPressed: () {
                //화면 전환 부분!
                bloc.savedStream; // block 패턴 적용

                //Navigator 오브젝트를 이용해서 다른 페이지로 이동
                Navigator.of(context).push(
                    // 클릭하면 SavedList 페이지 호출
                    MaterialPageRoute(builder: (context) => SavedList()));
              },
            ),
            IconButton(
              icon: Icon(Icons.access_alarm),
              onPressed: () {
                //화면 전환 부분!
                bloc.savedStream; // block 패턴 적용

                //Navigator 오브젝트를 이용해서 다른 페이지로 이동
                Navigator.of(context).push(
                    // 클릭하면 SavedList 페이지 호출
                    MaterialPageRoute(builder: (context) => SavedList()));
              },
            ),
            IconButton(
              icon: Icon(Icons.accessible),
              onPressed: () {
                //화면 전환 부분!
                bloc.savedStream; // block 패턴 적용

                //Navigator 오브젝트를 이용해서 다른 페이지로 이동
                Navigator.of(context).push(
                    // 클릭하면 SavedList 페이지 호출
                    MaterialPageRoute(builder: (context) => SavedList()));
              },
            )
          ],
        ),
        // ignore: missing_return
        //데이터 가져오와서 앱 화면에 뿌려주기위해 호출
        body: _buildList());
  }

  Widget _buildList() {
    //스트림 빌더를 이용하여 데이터를 bloc 패턴으로 구성
    return StreamBuilder<Set<WordPair>>(
        stream: bloc.savedStream, //블록패턴 연결부.
        builder: (context, snapshot) {
          // snapshot이 도착할때마다 페이지를 새로그림
          return ListView.builder(itemBuilder: (context, index) {
            //짝수 = 진짜 인덱스 를 말한다.
            //홀수 = 선을 그릴때 사용함
            if (index.isOdd) {
              // 짝수면 선을 그려넣음
              return Divider();
            }

            var realIndex = index ~/ 2; // ~/ 몫을 구하는 연산자
            print("리얼인덱스 값 $realIndex");
            print("sugestion 값 ${_suggestions.length}");
            if (realIndex >= _suggestions.length) {
              _suggestions.addAll(generateWordPairs().take(10));
            }

            return _buildRow(snapshot.data, _suggestions[realIndex]);
          });
        });
    //ListView.Builder는 리스트 객체를 생성해서 가져와주는 함수
  }

  Widget _buildRow(Set<WordPair> saved, WordPair pair) {
    // 단어가 있냐 없냐를 boolean으로 리턴 ( 하트 칠하기 )
    final bool alreadySaved = saved == null ? false : saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        textScaleFactor: 1.5,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: Colors.pink,
      ),
      onTap: () {
        // 하트 클릭시 해당 데이터 저장하는 기능 bloc 패턴으로 관리
        bloc.addToOrRemoveFromSavedList(pair);
      },
    );
  }
//trailing 꼬리에 달린다.
}
