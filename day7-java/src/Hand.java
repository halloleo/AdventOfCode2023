
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Hand implements Comparable<Hand> {

    // Attention: Use ONLY the function getOrderedCards, not the constant
    // ORDERD_CARDS_DONT_REFERENCE because of inheritance in JokerHand!
    static List<Character> ORDERD_CARDS_DONT_REFERENCE = Arrays
            .asList(new Character[]{'A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6',
                    '5', '4', '3', '2'});

    public List<Character> getOrderedCards() {
        return ORDERD_CARDS_DONT_REFERENCE;
    }

    char[] cards;
    int bid;

    public Hand(char[] cards, int bid) {
        this.cards = cards;
        this.bid = bid;
    }

    public Hand(String line) {
        String[] parts = line.split(" ");
        if (parts.length != 2) {
            throw new IllegalArgumentException(
                    "Cannot parse '" + line + "' to a hand");
        }

        this.cards = parts[0].toCharArray();
        if (cards.length != 5) {
            throw new IllegalArgumentException(
                    "Cannot parse '" + parts[0] + "' to a set of cards");
        }
        for (char c : cards) {
            if (getOrderedCards().indexOf(c) < 0) {
                throw new IllegalArgumentException(
                        "Cannot parse '" + c + "' to a card");
            }
        }

        this.bid = Integer.parseInt(parts[1]);
    }

    public Hand() {
        //Instantiate with dummy values for testing
        this("XXXXX".toCharArray(), -1);
    }


    public char[] getCards() {
        return cards;
    }

    public int getBid() {
        return bid;
    }

    @Override
    public String toString() {
        return "Hand [Cards=" + String.valueOf(cards) + ", bid=" + bid + "]";
    }

    public static enum Type {
        FIVE_OF_A_KIND,
        FOUR_OF_A_KIND,
        FULL_HOUSE,
        THREE_OF_A_KIND,
        TWO_PAIR,
        ONE_PAIR,
        HIGH_CARD
    }

    private int countInOthers(char selected, List<Character> others) {
        int cnt = 0;
        for (char c : others) {
            if (c == selected)
                ++cnt;
        }
        return cnt;
    }

    /**
     * maxOfAKind -- Returns the highst number of repeated cards
     * 
     * @param excluded:
     *            Cards in the `excluded`String are excluded from counting (this
     *            is needed for pair and fullhouse types)
     * @return An array with two values: * Index 0 is the max N of repeation *
     *         Index 1 is the index of (one of the) cards which are repeated N
     *         times
     */
    public int[] maxOfAKindTuple(String excluded) {
        int max_n = 0;
        int max_sel = -1;
        for (int sel = 0; sel < cards.length - 1; sel++) {
            if (excluded.contains(String.valueOf(cards[sel])))
                continue;

            List<Character> others = new ArrayList<>();
            for (int i = 0; i < cards.length; i++) {
                if (i != sel)
                    others.add(cards[i]);
            }
            int curr_n = countInOthers(cards[sel], others) + 1; // +1 to count
                                                                // myself

            if (curr_n > max_n) {
                max_n = curr_n;
                max_sel = sel;
            }
            max_n = Math.max(curr_n, max_n);
        }

        int[] res = new int[2];
        res[0] = max_n;
        res[1] = max_sel;
        return res;

    }

    public int[] maxOfAKindTuple() {
        return maxOfAKindTuple("");
    }

    /**
     * maxOfAKindNum - version of maxOfAKind which return only the max number
     */
    public int maxOfAKindNum(String excluded) {
        int[] tpl = maxOfAKindTuple(excluded);
        return tpl[0];
    }

    public Type typeFromMaxOfAKind(int n, String subsequentlyExcluded) {
        switch (n) {
            case 5 :
                return Type.FIVE_OF_A_KIND;
            case 4 :
                return Type.FOUR_OF_A_KIND;
            case 3 :
                if (maxOfAKindNum(subsequentlyExcluded) >= 2)
                    return Type.FULL_HOUSE;
                else
                    return Type.THREE_OF_A_KIND;
            case 2 :
                if (maxOfAKindNum(subsequentlyExcluded) >= 2)
                    return Type.TWO_PAIR;
                else
                    return Type.ONE_PAIR;
        }
        return Type.HIGH_CARD;
    }
    
    public Type getType() {
        int[] maxTuple = maxOfAKindTuple();

        int n = maxTuple[0];
        char excludedChar = cards[maxTuple[1]];
        return typeFromMaxOfAKind(n, String.valueOf(excludedChar));
    }

    @Override
    public boolean equals(Object other) {
        Hand otherCard = (Hand) other;
        return Arrays.equals(cards, otherCard.cards);
    }

    public int charOrder(char c) {
        return getOrderedCards().indexOf(c);
    }

    // Declared as static for testing
    public int compareChars(String thisCards, String otherCards) {
        if ((thisCards.length() == 0) && (otherCards.length() == 0)) {
            return 0;
        } else {
            int thisFirstOrder = this.charOrder(thisCards.charAt(0));
            int otherFirstOrder = this.charOrder(otherCards.charAt(0));
            // Swap order around because ORDERED_CARDS *starts* wit the highest
            int sgn = Integer.compare(otherFirstOrder, thisFirstOrder);
            if (sgn == 0) {
                return compareChars(thisCards.substring(1),
                        otherCards.substring(1));
            } else {
                return sgn;
            }
        }

    }

    @Override
    public int compareTo(Hand otherHand) {
        Type type = this.getType();
        Type otherType = otherHand.getType();
        // Swap order around because Type *starts* wit the highest
        int sgn = Integer.compare(otherType.ordinal(), type.ordinal());
        if (sgn == 0) {
            return compareChars(String.valueOf(cards),
                    String.valueOf(otherHand.cards));
        } else {
            return sgn;
        }
    }

    public static void main(String[] args) throws Exception {
        System.out.print("Hand.compareTo(hand): \n");
        int res = new Hand("32T3K 765").compareChars("33332", "2AAAA");

        System.out.print(res);
    }

}
