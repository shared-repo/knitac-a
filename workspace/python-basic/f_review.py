class StudentScore:

    def __init__(self):
        self.kor = 80
        self.eng = 65
        self.math = 54

class StudentScore2:

    def __init__(self, kor=0, eng=0, math=0):
        self.kor = kor
        self.eng = math
        self.math = eng

if __name__ == "__main__":
    student = StudentScore()
    print(student.kor, student.eng, student.math)

    student2 = StudentScore2(95, 97, 87)
    print(student2.kor, student2.eng, student2.math)