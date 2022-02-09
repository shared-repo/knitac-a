class Lotto:

    def __init__(self):
        self.games = []

    def showNumbers(self, numbers):
        print("SELECTED NUMBERS : ", end="") # end : 출력 후 마지막에 자동으로 포함되는 문자
        for n in numbers:
            print("[{0}]".format(n), end="")
        mean = sum(numbers)/len(numbers)
        print("[{0}]".format(mean))

    def checkMean(self, numbers):
        total = sum(numbers)
        mean = total/len(numbers)

        return mean >= 20 and mean <= 26

    def selectBasicNumbers(self):
        import random

        numbers = []
        idx = 0
        while idx < 6: # 중복이 몇 번 발생할지 미리 예측할 수 없기 때문에 for -> while로 변경
            n = random.randrange(1, 46) # 1 ~ 45(포함) 사이의 Random 정수
            for i in range(idx): # 기존에 뽑힌 데이터와 새로 뽑힌 데이터를 비교하는 반복문
                if n == numbers[i]: # 중복이 발생한 경우
                    break
            else: # 중복이 발생하지 않은 경우 (위 반복문에서 break가 실행되지 않은 경우)
                numbers.append(n) # 리스트에 추가
                idx += 1

        numbers.sort() # 오름차순 정렬

        return numbers

    def select_winning_numbers(self):
        while True: # 평균 검사의 영향을 받는 반복문
            numbers = self.selectBasicNumbers()

            valid = self.checkMean(numbers)
            if valid: # valid가 True이면
                break
            
        return numbers
