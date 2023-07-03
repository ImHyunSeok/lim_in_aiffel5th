AIFFEL Campus Online 4th Code Peer Review Templete
코더 : 김소연
리뷰어 : 이윤상
PRT(PeerReviewTemplate)
각 항목을 스스로 확인하고 토의하여 작성한 코드에 적용합니다.

 코드가 정상적으로 동작하고 주어진 문제를 해결했나요?

 주석을 보고 작성자의 코드가 이해되었나요?

각각의 필요한 부분에 주석을 달아서 이해하기 쉬웠ㅅ브니다.

 코드가 에러를 유발할 가능성이 없나요?

숫자나 문장을 입력해도 잘 작동합니다.

 코드 작성자가 코드를 제대로 이해하고 작성했나요?

코드를 처음부터 끝까지 잘 말로 설명했고, 역순으로 만드는 과정, if문까지 이해가 될 수 있게 설명했습니다.

 코드가 간결한가요?

중간에 print문을 2번 작성한 것 빼고는 간결하게 잘 작성했습니다. 불필요한 변수 사용이나 논리적으로 맞지않는 부분은 없었습니다.

# 회문 판독기
def word_reverse(a):
  W = a[::-1]                               # 입력된 단어를 역순으로 W에 저장
  if a == W:                                # 사용자가 입력한 단어와 뒤집은 단어가 동일한지 확인하고 뒤집은 단어 return
    return True, W
  else:
    return False, W

print("===")
word=str(input("입력값 : \n"))              # 사용자가 단어 입력

rev_Check, R_word = word_reverse(word)      #word_reverse 함수 호출

if rev_Check:                               #뒤집어진 단어와 회문 여부 출력
  print("뒤집어진 단어는: ", R_word)         
  print("입력한 단어는 회문입니다.")
else:
  print("뒤집어진 단어는: ", R_word)
  print("입력한 단어는 회문이 아닙니다.")


# 참고 링크 및 코드 개선
```python

#회문 판독기

def word_reverse(a):
  W = a[::-1]                               # 입력된 단어를 역순으로 W에 저장
  if a == W:                                # 사용자가 입력한 단어와 뒤집은 단어가 동일한지 확인하고 뒤집은 단어 return
    return True, W
  else:
    return False, W

print("===")
word=str(input("입력값 : \n"))              # 사용자가 단어 입력

rev_Check, R_word = word_reverse(word)      #word_reverse 함수 호출

if rev_Check:                               #뒤집어진 단어와 회문 여부 출력
  print("뒤집어진 단어는: ", R_word)         #print문을 if문 앞에 작성하면 1번만 작성하여 코드가 더 간단해 질 수 있다.           
  print("입력한 단어는 회문입니다.")
else:
  print("뒤집어진 단어는: ", R_word)
  print("입력한 단어는 회문이 아닙니다.")


# 코드 리뷰 시 참고한 링크가 있다면 링크와 간략한 설명을 첨부합니다.
# 코드 리뷰를 통해 개선한 코드가 있다면 코드와 간략한 설명을 첨부합니다.
