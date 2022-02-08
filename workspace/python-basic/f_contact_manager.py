# [ 연락처 관리 프로그램 ]
# 1. 기능 : 등록, 수정, 삭제, 조회(검색)
# 2. 연락처 내용 : 고유번호(자동증가), 이름, 이메일, 전화번호
# 3. 연락처 형식 :  딕셔너리 or 클래스

from re import search


class Contact:
    "연락처 정보를 저장하는 클래스"

    def __init__(self, no=0, name="", email="", phone=""):
        self.no = no
        self.name = name
        self.email = email
        self.phone = phone

    def info(self):
        return "[{0:4d}][{1}][{2}][{3}]".format(self.no, self.name, self.email, self.phone)

class ContactManager:
    """
    [ 연락처 관리 클래스 ]
    1. 기능 : 등록, 수정, 삭제, 조회
    2. 변수 : 연락처 목록 ( Contact의 List ), 다음 연락처 고유 번호
    """

    def __init__(self):
        self.contacts = []
        self.next_no = 1

    def show_menu(self):
        print("*" * 30)
        print("* 1. 연락처 등록.")
        print("* 2. 연락처 수정.")
        print("* 3. 연락처 삭제.")
        print("* 4. 연락처 목록.")
        print("* 5. 연락처 검색.")
        print("* 0. 종료.")
        print("*" * 30)
        selection = input("작업 번호를 입력하세요 : ")
        return selection

    def search_contact(self):
        name = input('검색할 연락처 이름 : ')
        searched_result = [] # 검색 결과를 저장할 리스트
        for contact in self.contacts:
            # if name == contact.name:  # 완전 일치 검색
            if name in contact.name:    # 부분 일치 검색
                searched_result.append(contact)

        return searched_result

    def do_manage(self):
        "연락처 관리 로직 구현 함수"

        while True: # 무한 반복 -> 반드시 while 내부에서 break를 사용해야 합니다.
            print()
            selection = self.show_menu()
            print()

            if selection == "0":
                print("프로그램을 종료합니다.....")
                break
            elif selection == '1': # 등록 선택
                # 연락처 정보 입력
                name = input("이름 : ")
                email = input("이메일 : ")
                phone = input("전화번호 : ")
                # 입력 정보를 사용해서 연락처 인스턴스 만들기
                contact = Contact(no=self.next_no, name=name, email=email, phone=phone)
                self.next_no += 1 # self.next_no = self.next_no + 1
                # 연락처 인스턴스를 목록에 추가
                self.contacts.append(contact)
                # 메시지 출력
                print("새 연락처를 등록했습니다.")
            elif selection == '4':  # 목록보기 선택
                if len(self.contacts) == 0: # 등록된 연락처가 없는 경우
                    print("등록된 연락처가 없습니다.")
                    continue # 반복문의 처음으로 즉시 이동

                print("[ 연락처 목록 ]")
                for contact in self.contacts:
                    print(contact.info())
            elif selection == '5':
                searched_result = self.search_contact()

                if len(searched_result) == 0:
                    print("검색 결과가 없습니다.")
                else:
                    print("[ 검색 결과 ]")
                    for contact in searched_result:
                        print(contact.info())
            elif selection == '3': # 삭제 선택
                searched_result = self.search_contact()

                if len(searched_result) == 0:
                    print("검색 결과가 없습니다.")
                else:
                    print("[ 검색 결과 ]")
                    for contact in searched_result:
                        print(contact.info())

                    no_to_delete = input("삭제할 연락처 번호 : ")
                    for contact in searched_result:
                        if str(contact.no) == no_to_delete:
                            self.contacts.remove(contact)
                            print("삭제 했습니다.")
                            break
                    else:
                        print("삭제 대상을 찾을 수 없습니다.")
            elif selection == '2': # 수정 선택
                searched_result = self.search_contact()

                if len(searched_result) == 0:
                    print("검색 결과가 없습니다.")
                else:
                    print("[ 검색 결과 ]")
                    for contact in searched_result:
                        print(contact.info())

                    no_to_edit = input("수정할 연락처 번호 : ")
                    for contact in searched_result:
                        if str(contact.no) == no_to_edit:
                            contact.name = input("이름 : ")
                            contact.email = input("이메일 : ")
                            contact.phone = input("전화번호 : ")
                            print("수정 했습니다.")
                            break
                    else:
                        print("수정 대상을 찾을 수 없습니다.")        
            else:
                print("지원하지 않는 작업입니다.")


contact_manager = ContactManager()
contact_manager.do_manage()