def valueFrequency1(src):
    ch_list = set(src)
    ch_list = sorted(ch_list)
    word_count = {}
    for ch in ch_list:
        word_count[ch] = src.count(ch)

    for k, v in word_count.items():
        print("{0} : {1}개".format(k, v))

def valueFrequency2(src):
    ch_list = set(src)
    ch_list = sorted(ch_list)
    word_count = {}
    for ch in ch_list:
        word_count[ch] = src.count(ch)
    
    return word_count

def valueFrequency3(src, key_sort=False):
    ch_list = set(src)
    if key_sort:
        ch_list = sorted(ch_list)
    word_count = {}
    for ch in ch_list:
        word_count[ch] = src.count(ch)
    
    return word_count

#####################################

class ListQueue:

    def __init__(self):
        self.dataList = [] # 인스턴스 변수 만들기

    def put(self, data):
        self.dataList.append(data)

    def get(self):
        if len(self.dataList) == 0:
            return None
        data = self.dataList.pop(0)
        return data

    def info(self):
        print("queue >> {0}".format(self.dataList))

if __name__ == "__main__":
    # test 1
    # valueFrequency1('abcmartmbcaacc')
    
    # test 2
    # word_count = valueFrequency2('abcmartmbcaacc')
    # for k, v in word_count.items():
    #     print("{0} : {1}개".format(k, v))

    # test 3
    # word_count = valueFrequency3('abcmartmbcaacc', True)
    # for k, v in word_count.items():
    #     print("{0} : {1}개".format(k, v))

    ####################

    data = ListQueue()

    data.put(10)
    data.info()

    data.put(5)
    data.info()

    data.put(7)
    data.info()

    print('삭제 : ', data.get())
    data.info()

    print('삭제 : ', data.get())
    data.info()