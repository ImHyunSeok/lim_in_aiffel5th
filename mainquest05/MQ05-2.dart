//임현석
import 'package:flutter/material.dart';
import 'dart:async';
// ignore_for_file: prefer_const_constructors
void main() {
  runApp(PomodoroApp());
}

class PomodoroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Timer',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PomodoroScreen(),
    );
  }
}

class PomodoroScreen extends StatefulWidget {
  @override
  _PomodoroScreenState createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  int workTime = 25 * 60; // 작업 시간 (25분)
  int shortBreak = 5 * 60; // 짧은 휴식 시간 (5분)
  int longBreak = 15 * 60; // 긴 휴식 시간 (15분)

  int workCount = 1; // 작업 회차
  int remainingTime = 0; // 남은 시간
  bool isWorking = true; // 현재 작업 중인지 여부

  Timer? timer; // 타이머 저장하기위한 변수

  void startTimer() {
    if (isWorking) {
      remainingTime = workTime;
    } else {
      if (workCount % 4 == 0) {
        remainingTime = longBreak;
      } else {
        remainingTime = shortBreak;
      }
    }

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          timer.cancel();
          if (isWorking) {
            isWorking = false;
            startTimer(); // 휴식 시간 시작
          } else {
            if (workCount % 4 == 0) {
              isWorking = true;
              remainingTime = workTime;
            } else {
              isWorking = true;
              remainingTime = workTime;
              workCount++;
            }
            startTimer(); // 작업 시간 시작
          }
        }
      });
    });
  }

  void pauseTimer() {
    if (timer != null) {
      timer!.cancel();
    }
  }

  void resumeTimer() {
  if (isWorking || (workCount % 4 == 0)) {
    if (timer == null || !timer!.isActive) {
      if (remainingTime > 0) {
        startTimerWithRemainingTime(); // 저장된 시간을 바탕으로 타이머 시작
      } else {
        startTimer(); // 저장된 시간이 없다면 일반적으로 타이머 시작
      }
    }
  }
}

void startTimerWithRemainingTime() {
  timer = Timer.periodic(Duration(seconds: 1), (timer) {
    setState(() {
      if (remainingTime > 0) {
        remainingTime--;
      } else {
        timer.cancel();
        handleTimerCompletion(); // 타이머가 완료되었을 때 처리 로직 호출
      }
    });
  });
}

void handleTimerCompletion() {
  if (isWorking) {
    isWorking = false;
    startTimer(); // 휴식 시간 시작
  } else {
    if (workCount % 4 == 0) {
      isWorking = true;
      remainingTime = workTime;
    } else {
      isWorking = true;
      remainingTime = workTime;
      workCount++;
    }
    startTimer(); // 작업 시간 시작
  }
}



  void toggleTimer() {
    if (timer != null && timer!.isActive) {
      pauseTimer();
    } else {
      resumeTimer();
    }
  }

  void startNextAction() {
    if (isWorking) {
      if (workCount % 4 == 0) {
        remainingTime = longBreak;
      } else {
        remainingTime = shortBreak;
      }
    } else {
      workCount++;
      remainingTime = workTime;
    }
    isWorking = !isWorking;

    // 기존 타이머 취소
    pauseTimer();

    // 새로운 타이머 시작
    remainingTime = isWorking ? workTime : (workCount % 4 == 0) ? longBreak : shortBreak;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    String actionType = isWorking ? '작업' : '휴식';
    return Scaffold(
      appBar: AppBar(title: Text('Pomodoro Timer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '회차: ${workCount % 4}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              '$actionType 시간',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              '${remainingTime ~/ 60}:${(remainingTime % 60).toString().padLeft(2, '0')} 남음',
              style: TextStyle(fontSize: 36),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: toggleTimer, // 일시정지/재개 기능 토글
                  tooltip: '일시정지 / 재개',
                  child: Icon(
                    timer != null && timer!.isActive ? Icons.pause : Icons.play_arrow,
                  ),
                ),
                SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: startNextAction,
                  tooltip: 'Next Action',
                  child: Icon(Icons.skip_next),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
