#
# Sum of calibration values hidden as digits OR digit words.
# https://adventofcode.com/2023/day/1
#

digits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
dwords = ['one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine']
dwords_rev = [ ''.join(reversed(w)) for w in dwords ]

def first_digit(line, from_end):
    lookline = ''.join(reversed(line)) if from_end else line
    dws = dwords_rev if from_end else dwords
    for i in range(len(lookline)):
        if lookline[i] in digits:
            return int(lookline[i])

        sub = lookline[i:]
        for j, dw in enumerate(dws):
            if sub.startswith(dw):
                return int(digits[j+1])
    return None

def num_in_line(line):
    return first_digit(line, False) * 10 + first_digit(line, True)

sum = 0
for line in open('input', 'r'):
    v = num_in_line(line.rstrip())
    print(v)
    sum = sum + v

print(sum)
