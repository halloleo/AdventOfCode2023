(require 'cl-lib)

(defun to-cons (tuple)
  (cons  (car (cdr tuple)) (car tuple)))

(to-cons '(12 red))


(defun to-alist (draw)
  "Convert a draw (or bag) to a cons list"
  (mapcar 'to-cons draw))

(to-alist '((3 blue) (4 red)))

(defun draws-to-alists (draws)
  "Convert a draw (or bag) to a cons list"
  (mapcar 'to-alist draws))

(draws-to-alists '(((3 blue) (4 red)) ((1 red) (2 green) (6 blue)) ((2 green))))

(setq colors '(red green blue))

(defun cubes-of-color (color one-draw)
  (let ((val (cdr (assq color one-draw))))
    (if val
        val
      0)))

(setq draws-alists (draws-to-alists '(((3 blue) (4 red)) ((1 red) (2 green) (6 blue)) ((2 green)))))

(cubes-of-color 'red (car draws-alists))


(defun cubes-of-color-max (color draws-alists)
  "Give a list of the number of cubes of a given color for each draw"

  (defun cubes-of-this-color (draw)
    (cubes-of-color color draw))

  (apply 'max (mapcar 'cubes-of-this-color draws-alists)))

(defun minimum-set (draws-alists)
  "The minimum set for the draws of a game"

  (defun cubes-max-for-these-draws (color)
    (cubes-of-color-max color draws-alists))

  (mapcar 'cubes-max-for-these-draws colors))

(minimum-set draws-alists)

(defun minimal-power (draws)
  (apply '* (minimum-set (draws-to-alists draws))))

(minimal-power '(((3 blue) (4 red)) ((1 red) (2 green) (6 blue)) ((2 green))))

(defun minimal-power-for-game (game)
  "Calculate the MP of this game"
  (let ((draws (cadr (eval game))))
    (minimal-power draws)))

(minimal-power-for-game (nth 0 sample))

(defun sum-of-powers (inp)
  "Get the sum of thel minimal powers fof all games"
  (apply '+
         (mapcar 'minimal-power-for-game inp)))

(sum-of-powers sample)

(setq sample (append [
'(1 (((3 blue) (4 red)) ((1 red) (2 green) (6 blue)) ((2 green))))
'(2 (((1 blue) (2 green)) ((3 green) (4 blue) (1 red)) ((1 green) (1 blue))))
'(3 (((8 green) (6 blue) (20 red)) ((5 blue) (4 red) (13 green)) ((5 green) (1 red))))
'(4 (((1 green) (3 red) (6 blue)) ((3 green) (6 red)) ((3 green) (15 blue) (14 red))))
'(5 (((6 red) (1 blue) (3 green)) ((2 blue) (1 red) (2 green))))
] nil))


(sum-of-powers input)


(setq input (append [
'(1 (((10 green) (5 blue)) ((1 red) (9 green) (10 blue)) ((5 blue) (6 green) (2 red)) ((7 green) (9 blue) (1 red)) ((2 red) (10 blue) (10 green)) ((7 blue) (1 red))))
'(2 (((7 green) (5 red) (3 blue)) ((4 blue) (7 green) (8 red)) ((9 blue) (4 green)) ((6 green) (3 red) (4 blue))))
'(3 (((2 green) (4 blue) (13 red)) ((15 blue) (9 red) (3 green)) ((3 red) (18 blue) (3 green)) ((6 red) (4 green) (2 blue)) ((6 blue) (13 red))))
'(4 (((9 red) (1 green) (13 blue)) ((3 red)) ((2 blue) (6 red) (1 green)) ((12 blue) (2 red))))
'(5 (((1 red) (8 green)) ((2 red) (8 green) (8 blue)) ((1 red) (11 green)) ((5 blue) (11 green)) ((11 blue) (2 green)) ((10 blue) (2 red) (1 green))))
'(6 (((1 red) (12 blue)) ((20 blue) (3 green) (2 red)) ((4 red) (15 blue))))
'(7 (((13 red) (9 green) (1 blue)) ((8 green) (2 red) (6 blue)) ((4 green) (5 blue)) ((7 red) (3 green) (7 blue)) ((19 red) (5 blue) (1 green))))
'(8 (((11 red) (14 green) (4 blue)) ((2 blue) (5 green) (16 red)) ((18 blue) (11 red) (2 green)) ((2 blue) (15 red)) ((13 green) (8 blue))))
'(9 (((7 green) (5 blue) (11 red)) ((10 red) (7 green) (4 blue)) ((1 red)) ((6 green) (2 blue) (9 red)) ((8 green) (10 red) (6 blue)) ((5 red) (5 green) (7 blue))))
'(10 (((4 blue) (2 green) (1 red)) ((5 green) (2 red) (1 blue)) ((3 green) (8 blue) (1 red)) ((2 blue) (6 green) (2 red)) ((1 red) (4 green) (2 blue))))
'(11 (((3 red) (4 blue)) ((8 blue) (7 green) (2 red)) ((7 blue) (1 red) (6 green)) ((13 blue) (4 green))))
'(12 (((2 red) (3 blue) (4 green)) ((2 blue) (9 red) (8 green)) ((10 red) (1 blue)) ((1 green) (7 red) (3 blue)) ((7 red) (2 blue) (9 green))))
'(13 (((12 red) (6 green) (2 blue)) ((15 green) (2 red) (4 blue)) ((7 green) (1 red) (3 blue))))
'(14 (((9 green) (4 red)) ((6 blue) (1 red) (7 green)) ((3 blue) (5 green))))
'(15 (((7 red) (3 green) (2 blue)) ((3 blue) (4 green)) ((4 blue) (4 green) (9 red))))
'(16 (((12 blue) (11 green) (4 red)) ((8 blue) (9 red) (10 green)) ((9 green) (11 blue) (13 red)) ((10 red) (5 blue) (6 green)) ((2 red)) ((2 blue) (5 green) (5 red))))
'(17 (((3 red) (2 green) (2 blue)) ((1 blue) (3 red) (1 green)) ((10 green))))
'(18 (((3 green) (1 blue) (4 red)) ((12 red) (5 green)) ((3 red) (3 green) (3 blue)) ((13 red) (2 blue))))
'(19 (((13 blue) (8 green) (6 red)) ((10 red) (12 blue)) ((8 green) (13 red) (9 blue)) ((13 green) (3 red) (5 blue)) ((5 green) (1 blue) (2 red))))
'(20 (((19 red) (13 blue) (4 green)) ((1 red) (4 green) (8 blue)) ((14 red) (6 blue) (7 green)) ((11 red) (13 blue) (8 green))))
'(21 (((3 green) (13 red) (7 blue)) ((1 blue) (1 green) (1 red)) ((3 blue) (15 red) (5 green)) ((3 blue) (15 red) (2 green)) ((6 green) (9 red) (14 blue))))
'(22 (((2 red) (6 green) (4 blue)) ((6 green) (2 red)) ((1 blue) (4 red) (3 green)) ((11 green) (7 blue) (1 red)) ((4 red) (8 green) (3 blue))))
'(23 (((14 blue)) ((3 green) (2 red) (3 blue)) ((5 blue) (1 red))))
'(24 (((12 red)) ((5 blue) (16 red)) ((2 blue) (1 green) (16 red)) ((1 green) (11 red)) ((2 blue) (8 red) (1 green))))
'(25 (((4 red) (11 blue) (1 green)) ((7 red) (9 blue)) ((6 blue) (10 green))))
'(26 (((3 green) (13 red)) ((7 blue) (13 red) (5 green)) ((5 blue) (8 green) (11 red)) ((7 blue) (18 green) (6 red))))
'(27 (((6 green) (6 red) (5 blue)) ((2 blue) (4 green) (11 red)) ((15 red) (6 green)) ((4 green) (12 red) (2 blue)) ((3 blue) (5 red))))
'(28 (((16 blue) (6 red) (1 green)) ((7 red) (4 green) (10 blue)) ((1 red) (4 green))))
'(29 (((5 blue) (4 red)) ((6 blue) (3 red) (4 green)) ((2 green) (4 red) (5 blue)) ((1 green) (7 blue) (4 red)) ((3 green) (2 blue) (4 red))))
'(30 (((2 green)) ((14 green) (1 blue) (2 red)) ((5 red) (14 green))))
'(31 (((9 blue) (6 red) (7 green)) ((20 red) (1 green) (15 blue)) ((6 blue) (7 green) (17 red)) ((2 blue) (3 green) (6 red)) ((1 red) (3 blue) (2 green)) ((5 green) (18 red) (6 blue))))
'(32 (((7 green) (9 blue) (8 red)) ((8 red) (13 green) (19 blue)) ((2 red) (9 blue) (3 green)) ((9 green) (6 blue) (6 red))))
'(33 (((6 blue) (12 red)) ((13 blue) (3 green) (15 red)) ((5 red) (10 blue) (4 green)) ((11 blue) (6 red))))
'(34 (((5 green) (16 blue) (6 red)) ((10 green) (1 blue) (4 red)) ((2 red) (7 blue) (6 green)) ((12 green) (4 blue) (4 red))))
'(35 (((11 green) (3 blue)) ((1 red) (6 blue) (10 green)) ((11 green) (3 blue)) ((1 red) (2 blue)) ((11 green) (3 blue) (1 red)) ((3 blue) (2 green))))
'(36 (((10 green) (6 red) (4 blue)) ((3 green) (3 blue) (5 red)) ((6 red) (5 blue) (10 green))))
'(37 (((8 red) (7 blue) (5 green)) ((8 blue) (5 green) (14 red)) ((8 red) (2 blue))))
'(38 (((4 green) (1 red) (4 blue)) ((8 green) (11 blue)) ((7 red) (5 blue))))
'(39 (((2 blue) (4 red) (4 green)) ((8 green) (8 red) (1 blue)) ((3 red))))
'(40 (((4 green) (3 red) (14 blue)) ((4 blue) (13 green) (3 red)) ((12 green) (2 red) (2 blue)) ((8 green) (1 red) (11 blue)) ((4 green) (1 red) (1 blue))))
'(41 (((4 red) (1 green) (2 blue)) ((4 red)) ((4 red))))
'(42 (((12 red) (8 blue) (1 green)) ((8 green) (6 red) (5 blue)) ((12 green) (3 red) (13 blue)) ((1 red) (2 green) (8 blue)) ((3 green) (5 red) (6 blue))))
'(43 (((12 green) (3 blue)) ((13 green) (7 red) (5 blue)) ((10 green) (4 red) (4 blue))))
'(44 (((6 green) (2 red) (4 blue)) ((10 green) (6 red)) ((5 blue) (15 red) (13 green)) ((1 blue) (6 red) (3 green)) ((9 red) (5 green) (3 blue)) ((6 green) (4 blue) (5 red))))
'(45 (((10 blue) (14 green)) ((2 green) (2 red) (12 blue)) ((7 green) (1 red)) ((8 blue) (6 green) (1 red))))
'(46 (((8 red) (10 green) (15 blue)) ((9 green) (3 red) (17 blue)) ((2 blue) (10 red) (5 green)) ((11 blue) (3 green) (9 red)) ((5 red) (11 blue) (1 green)) ((7 green) (5 red) (16 blue))))
'(47 (((10 blue) (1 green) (1 red)) ((3 red) (8 blue) (7 green)) ((8 red) (9 blue)) ((2 green) (8 red) (1 blue))))
'(48 (((5 blue) (2 green)) ((2 red) (7 green) (2 blue)) ((1 blue) (3 green) (1 red))))
'(49 (((2 green) (6 red) (5 blue)) ((6 green)) ((4 blue) (17 red) (5 green))))
'(50 (((5 blue) (10 green)) ((6 blue) (4 red) (9 green)) ((7 red) (4 blue)) ((7 red) (3 blue) (14 green)) ((5 blue) (10 green) (9 red)) ((13 green) (1 blue) (9 red))))
'(51 (((1 blue) (15 green)) ((6 green) (2 blue)) ((5 blue) (1 red) (12 green))))
'(52 (((3 red) (15 green)) ((7 blue) (1 red) (14 green)) ((8 green) (1 red) (12 blue)) ((1 red) (9 green) (7 blue))))
'(53 (((2 green) (4 red)) ((1 red) (1 blue)) ((3 blue) (1 green)) ((2 red) (2 blue) (2 green))))
'(54 (((7 blue) (13 red) (7 green)) ((1 red) (2 green)) ((11 red) (10 green) (5 blue)) ((10 red) (8 green) (5 blue)) ((8 green) (12 blue) (12 red))))
'(55 (((18 red) (3 green) (5 blue)) ((5 green) (3 blue) (7 red)) ((3 blue) (3 green) (4 red))))
'(56 (((14 red) (17 green) (2 blue)) ((5 green) (13 red) (1 blue)) ((11 red) (20 green))))
'(57 (((3 red) (6 green) (2 blue)) ((3 red) (2 green)) ((2 green) (5 red)) ((1 blue) (1 green) (2 red))))
'(58 (((7 blue) (5 green) (9 red)) ((10 red) (5 green) (9 blue)) ((2 blue) (3 red) (8 green)) ((8 blue) (9 red)) ((7 red) (3 blue) (7 green)) ((2 green) (7 red) (1 blue))))
'(59 (((4 green) (3 blue)) ((10 red) (4 green) (4 blue)) ((2 green) (14 red) (12 blue)) ((1 blue) (1 green) (13 red)) ((10 red) (3 green) (3 blue)) ((2 green))))
'(60 (((9 red) (13 blue)) ((2 green) (5 red) (9 blue)) ((3 green) (10 blue))))
'(61 (((2 red) (8 green) (4 blue)) ((3 green) (2 red)) ((10 red) (9 green) (12 blue)) ((11 green) (17 blue) (3 red)) ((7 green) (1 red) (14 blue))))
'(62 (((1 green) (5 red) (13 blue)) ((5 blue) (1 green) (8 red)) ((2 green) (8 blue) (3 red)) ((1 green) (8 red))))
'(63 (((8 green) (15 red) (2 blue)) ((4 blue) (3 red) (12 green)) ((4 green) (1 blue) (17 red)) ((9 green) (18 red) (4 blue))))
'(64 (((7 blue) (17 red) (17 green)) ((3 blue) (4 green) (3 red)) ((4 red) (19 green) (1 blue)) ((11 blue) (14 red)) ((4 blue) (19 green) (7 red)) ((1 red) (10 green) (11 blue))))
'(65 (((1 blue) (17 red) (5 green)) ((17 red) (3 blue) (2 green)) ((10 blue) (9 green))))
'(66 (((5 blue) (6 red)) ((8 red) (2 blue) (1 green)) ((2 green) (3 blue)) ((8 blue) (10 red)) ((1 green) (2 red) (5 blue)) ((1 red) (3 blue))))
'(67 (((12 green) (16 blue) (12 red)) ((15 red) (1 blue) (3 green)) ((10 red) (3 green) (10 blue)) ((2 blue) (6 green) (6 red)) ((9 red) (8 blue) (7 green))))
'(68 (((10 red) (7 blue)) ((12 blue) (9 red)) ((12 blue) (9 red) (2 green))))
'(69 (((14 blue) (3 red) (3 green)) ((7 green) (7 red) (2 blue)) ((8 blue) (4 green) (8 red)) ((6 blue) (14 red) (3 green))))
'(70 (((7 blue) (6 green) (2 red)) ((2 red) (4 blue) (4 green)) ((2 red) (5 blue) (3 green)) ((6 green) (2 blue)) ((5 blue) (2 red) (2 green))))
'(71 (((7 green) (15 blue) (3 red)) ((15 blue) (15 red) (2 green)) ((10 red) (9 blue)) ((6 green) (20 blue) (11 red)) ((12 blue) (3 green) (7 red)) ((1 red) (7 blue))))
'(72 (((2 green) (9 blue) (7 red)) ((5 green) (3 blue) (5 red)) ((10 blue) (8 red) (7 green))))
'(73 (((18 blue) (5 red) (1 green)) ((18 blue) (3 red) (9 green)) ((2 red) (4 blue) (9 green)) ((5 blue) (5 red)) ((2 blue) (10 green) (6 red))))
'(74 (((1 blue) (10 green) (5 red)) ((4 green) (12 blue) (6 red)) ((7 red) (13 green) (3 blue)) ((5 blue) (8 green) (4 red))))
'(75 (((4 red) (2 blue) (5 green)) ((2 blue) (7 red) (4 green)) ((2 blue) (4 green) (3 red)) ((12 green) (2 blue)) ((10 green) (1 blue) (2 red))))
'(76 (((8 green) (6 blue) (5 red)) ((1 red) (2 blue) (9 green)) ((7 red) (9 green)) ((5 green) (1 blue) (11 red))))
'(77 (((3 blue) (10 red) (9 green)) ((7 blue) (6 red) (4 green)) ((4 red) (1 green) (8 blue))))
'(78 (((2 blue) (1 red) (14 green)) ((11 green) (1 blue)) ((15 green) (1 red))))
'(79 (((3 green) (17 blue) (1 red)) ((3 red) (2 blue) (10 green)) ((13 blue) (11 green) (5 red)) ((16 blue) (2 green) (16 red)) ((11 green) (1 blue) (14 red))))
'(80 (((7 red) (10 blue) (5 green)) ((6 blue) (6 green) (8 red)) ((6 blue) (3 green) (5 red))))
'(81 (((1 blue) (14 red) (6 green)) ((1 red) (13 blue) (12 green)) ((2 green) (15 red) (15 blue))))
'(82 (((5 blue) (8 red) (6 green)) ((19 blue) (4 green)) ((9 green) (15 blue) (3 red))))
'(83 (((19 red) (15 green) (2 blue)) ((17 red) (4 green) (1 blue)) ((13 green) (18 red))))
'(84 (((9 green) (14 red)) ((11 green) (14 red) (1 blue)) ((1 blue) (2 red) (3 green)) ((13 green) (10 red)) ((1 green) (5 red))))
'(85 (((4 red) (2 green) (11 blue)) ((8 blue) (3 red)) ((4 red) (1 blue) (5 green)) ((2 red) (3 green)) ((1 green) (8 red) (12 blue))))
'(86 (((5 blue) (1 red)) ((8 blue)) ((2 red) (1 green) (12 blue)) ((12 blue) (2 red))))
'(87 (((3 red) (10 green) (3 blue)) ((13 blue) (6 red) (2 green)) ((1 green) (2 red) (10 blue))))
'(88 (((10 red) (3 green) (8 blue)) ((3 red) (18 blue) (2 green)) ((3 green) (15 blue)) ((15 green) (16 blue) (8 red))))
'(89 (((10 blue) (1 red)) ((4 green) (9 red) (13 blue)) ((10 red) (3 green) (12 blue)) ((2 green) (1 red) (16 blue)) ((10 blue) (1 red) (6 green))))
'(90 (((4 red) (2 blue) (15 green)) ((5 red) (1 blue) (12 green)) ((3 blue) (3 red) (7 green)) ((4 blue) (3 red) (7 green)) ((1 red) (2 green) (1 blue)) ((1 blue) (4 green) (3 red))))
'(91 (((16 red) (10 blue) (1 green)) ((13 green) (13 red) (19 blue)) ((11 blue) (12 green) (2 red))))
'(92 (((8 blue) (4 green) (5 red)) ((7 blue) (4 red)) ((2 green) (15 blue)) ((16 blue) (4 red)) ((1 red) (7 green) (16 blue)) ((11 blue) (1 red) (3 green))))
'(93 (((12 green) (2 blue) (2 red)) ((8 red) (16 green) (8 blue)) ((15 red) (4 blue) (7 green)) ((1 red) (4 blue) (15 green)) ((13 green) (5 red) (4 blue)) ((5 green) (8 blue) (12 red))))
'(94 (((13 green) (10 red)) ((11 red) (19 green) (1 blue)) ((1 blue) (10 red) (12 green)) ((18 green) (9 red) (1 blue)) ((8 green) (1 red))))
'(95 (((3 green) (4 blue)) ((2 red) (2 green) (2 blue)) ((7 red) (3 green))))
'(96 (((5 red) (7 green)) ((4 blue) (14 green) (10 red)) ((13 green)) ((13 green) (3 blue)) ((13 green) (1 red) (3 blue)) ((12 red) (1 green))))
'(97 (((2 green) (1 blue)) ((9 red)) ((4 blue) (8 red)) ((4 green) (1 red) (14 blue)) ((2 green) (9 blue)) ((1 red) (6 blue) (2 green))))
'(98 (((12 green) (9 blue) (13 red)) ((6 red) (7 blue)) ((2 blue) (2 green))))
'(99 (((9 red) (3 green) (10 blue)) ((10 red) (10 blue) (4 green)) ((2 green) (15 blue) (3 red)) ((12 blue) (4 red))))
'(100 (((15 blue) (6 red)) ((1 green) (2 red)) ((12 blue) (8 green) (1 red)) ((1 red) (7 blue))))
] nil))
