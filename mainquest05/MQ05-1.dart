//임현석
//https://swjs.tistory.com/52를 참고하여 작성하였습니다.

import 'dart:async'; //Timer불러오기 위해 임포트

//pomorodo 25분일하고 5분휴식 4번반복하고 긴휴식 
//몇번반복했는지 저장해주는 기능, 반복기능

void main() {
  PomodoroTimer timer = PomodoroTimer();
  timer.startTimer();
}

class PomodoroTimer {
  int workTime = 25; // 작업시간 25분
  int shortBreak = 5; // 짧은 쉬는시간 5분
  int longBreak = 15; // 4번 반복 후 긴 쉬는시간
  int workCount = 0; // 작업반복횟수

  //타이머 시작 함수
  void startTimer() {
    workCount++;
    print('Pomodoro 타이머 시작! 작업반복횟수 ${workCount}회');
    
    
    int remainingTime = workTime * 60;// 분을 초로 변환
    
    Timer.periodic(Duration(seconds: 1), (timer) {
      int minutes = remainingTime ~/ 60;
      int seconds = remainingTime % 60;
      
      print('남은 시간: $minutes 분 $seconds 초');
      remainingTime--;
      
     
      if (remainingTime < 0){
        timer.cancel();
        print('작업 시간 종료');
        
        // 4번 반복마다 긴 휴식, 아닐 경우 짧은 휴식
        if (workCount % 4 == 0){
          startBreak(longBreak, '긴 휴식');
        } else {
          startBreak(shortBreak, '짧은 휴식');
        }
      }
    } );
    
  }
  
  //휴식시작 함수
  void startBreak(int duration, String breakType) {
    int remainingTime = duration;
    
    print('$breakType 시작! ${duration} 분 동안 휴식');
    
    Timer.periodic(Duration(seconds:1), (timer) {
      int minutes = remainingTime ~/ 60;
      int seconds = remainingTime % 60;
      
      print('남은 시간: $minutes 분 $seconds 초');
      remainingTime--;
      
      if (remainingTime < 0) {
        timer.cancel();
        print('$breakType 종료!');
        
        if (workCount % 4 == 0) {
          print('긴 휴식 후 집중을 다시 시작하세요.');
          workCount = 0; //반복횟수 초기화
          startTimer();
        } else {
          startTimer();
        }
      }
    });
  }
}

