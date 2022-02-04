# 계산기 만들기
# 1. 숫자 입력
# 2. 연산자 입력
# 3. 숫자 입력
# 4. 입력된 연산자에 따라 계산 선택
# 5. 결과 출력

number1 = input("첫 번째 숫자 : ")
# print( type(number1) ) # type : 자료형을 확인하는 명령
number1 = int(number1) # number1을 정수형으로 변환

op = input("연산자 ( +, -, *, /, % ) : ")

number2 = input("두 번째 숫자 : ")
number2 = int(number2) # number2를 정수형으로 변환

# print(number1, op, number2) # 테스트 코드
valid = True
if op == '+':
    result = number1 + number2
elif op == '-':
    result = number1 - number2
elif op == '*':
    result = number1 * number2
elif op == '/':
    result = number1 / number2
elif op == '%':
    result = number1 % number2
else:
    valid = False
    pass

if valid:
    print( "{0} {1} {2} = {3}".format(number1, op, number2, result) )
else:
    print("{0}은 지원하지 않는 연산자입니다.".format(op))