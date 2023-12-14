#
# Sum of calibration values hidden just as digits
# https://adventofcode.com/2023/day/1
#

def first_digit(line, from_end):
    lookline = reversed(line) if from_end else line
    for c in lookline:
        if c >= '0' and c <= '9':
            return int(c)
    return None

def num_in_line(line):
    return first_digit(line, False) * 10 + first_digit(line, True)

sum = 0
for line in open('input', 'r'):
    v = num_in_line(line)
    print(v)
    sum = sum + v

print(sum)
