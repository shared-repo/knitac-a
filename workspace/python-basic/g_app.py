# [ 모듈 사용 1 ]

# import g_mod1

# print( g_mod1.name ) # 모듈의 변수 사용

# result = g_mod1.add(11, 24, 37, 46, 25)
# print( result )

# [ 모듈 사용 2 ]
# import sys

# print( sys.path )

# [ 모듈 사용 3 ]

# from g_mod1 import name, add

# print( name )
# print( add(10, 20, 30, 40, 50) )

# [ 모듈 사용 4 ]

# from g_mod1 import *

# print( name )
# print( add(10, 20, 30, 40, 50) )

# [ 모듈 사용 5 ]

import g_mod1 as my_mod

print( my_mod.name ) # 모듈의 변수 사용

result = my_mod.add(11, 24, 37, 46, 25)
print( result )