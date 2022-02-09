import datetime # 날짜 처리 모듈

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

    def show_menu(self):
        print("*" * 30)
        print("* 1. 새 번호 뽑기.")
        print("* 2. 뽑힌 번호 보기.")
        print("* 3. 뽑힌 번호 저장.")
        print("* 0. 프로그램 종료.")
        print("*" * 30)
        selection = input("원하는 작업 번호 : ")
        return selection

    def start_game(self):
        while True:
            selection = self.show_menu()
            if selection == "1": # 새 번호 뽑기
                numbers = self.select_winning_numbers() # 번호 뽑기
                self.showNumbers(numbers) # 보여 주기
                yn = input("뽑힌 번호를 게임 목록에 추가할까요(y/n)? ")
                if yn == "y":
                    self.games.append(numbers)

            elif selection == "2": # 게임 목록 보기
                if len(self.games) == 0:
                    print("뽑힌 번호가 없습니다.")
                    continue
                for numbers in self.games:
                    self.showNumbers(numbers)

            elif selection == "3":
                d = datetime.datetime.now() # 현재 날짜 및 시간                
                fname = "games-{0}{1:02d}{2:02d}-{3:02d}{4:02d}{5:02d}.txt".format(d.year, d.month, d.day, 
                                                               d.hour, d.minute, d.second)
                with open(fname, "wt", encoding="utf-8") as f:
                    for numbers in self.games:
                        # format(*[1, 2, 3, 4, 5, 6]) -> format(1, 2, 3, 4, 5, 6)
                        f.write("[{0:2d}][{1:2d}][{2:2d}][{3:2d}][{4:2d}][{5:2d}]\n".format(*numbers))
                print("뽑힌 번호를 파일에 저장했습니다.")

            elif selection == "0":
                print("행운을 빕니다.")
                break
            else:
                print("지원하지 않는 명령입니다.")

if __name__ == "__main__":
    lotto = Lotto()
    lotto.start_game()
