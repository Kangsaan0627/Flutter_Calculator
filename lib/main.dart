/*  계산기 기능
    1. 계산 처리 화면
    2. 4 * 5 형태의 버튼 (가로 X 세로) 젤 밑에 줄 예외
    3. 박스 모양 생성 -> 비율 나눠서 버튼 분배
    4. 0 버튼은 가로로 버튼 2개 길이
    5. 클릭시 field 창에 숫자 대입 -> 연산
*/  
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('예비 계산기'),
          backgroundColor: Colors.yellow,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 붉은 박스
              Container(
                width: 150,
                height: 150,
                color: Colors.red,
                child: Center(
                  child: Text(
                    'text',
                    style: TextStyle(fontSize: 20), // 텍스트 스타일
                  ),
                ),
              ),
              SizedBox(width: 10), // 두 컨테이너 사이에 간격 추가
              // 파란 박스
              Container(
                width: 200,
                height: 150,
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
                  crossAxisAlignment: CrossAxisAlignment.start, // 좌측 정렬
                  children: [
                    Text('카메라 팝니다', style: TextStyle(fontSize: 16)),
                    Text('금호동 7가', style: TextStyle(fontSize: 16)),
                    Text('7000원', style: TextStyle(fontSize: 16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.favorite, color: Colors.white),
                        SizedBox(width: 5), // 아이콘과 텍스트 사이 간격 추가
                        Text('글자', style: TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
