name = 'John Doe'

def add(*numbers):
    total = 0
    for number in numbers:
        total += number

    return total

# 테스트 코드 ( import일 때에는 실행되지 않도록 설정 필요 )
if __name__ == "__main__": # python g_mod1.py로 실행한 경우
    print( "add function test ")
    print( add(10, 20, 30, 40, 50) )