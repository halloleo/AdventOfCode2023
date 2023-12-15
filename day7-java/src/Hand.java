import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Hand {

    List<Character> ORDERD_CARDS = Arrays.asList(new Character[]{'A', 'K', 'Q',
            'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2'});

    char[] cards;
    int bid;

    public Hand(char[] hand, int bid) {
        this.cards = hand;
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
            if (ORDERD_CARDS.indexOf(c) < 0) {
                throw new IllegalArgumentException(
                        "Cannot parse '" + c + "' to a card");
            }
        }

        this.bid = Integer.parseInt(parts[1]);
    }

    public char[] getCards() {
        return cards;
    }

    public int getBid() {
        return bid;
    }

    @Override
    public boolean equals(Object other) {
        Hand otherCard = (Hand) other;
        System.out.println(this.bid);
        System.out.println(otherCard.bid);
        return Arrays.equals(cards, otherCard.cards) && bid == otherCard.bid;
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
     * @param excluded: Cards in the `excluded`String are excluded from counting
     *                 (this is needed for pair and fullhouse types)
     * @return An array with two values: 
     *         * Index 0 is the max N of repeation
     *         * Index 1 is the index of (one of the) cards which are repeated N times
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
    

    public Type getType() {
        int[] maxtpl = maxOfAKindTuple();

        int n = maxtpl[0];
        System.err.println(n);
        switch (n) {
            case 5:
                return Type.FIVE_OF_A_KIND;
            case 4:
                return Type.FOUR_OF_A_KIND;
            case 3:
                if (maxOfAKindNum(String.valueOf(cards[maxtpl[1]])) >=2) 
                    return Type.FULL_HOUSE;
                else
                    return Type.THREE_OF_A_KIND;
            case 2:
                if (maxOfAKindNum(String.valueOf(cards[maxtpl[1]])) >=2) 
                    return Type.TWO_PAIR;
                else
                    return Type.ONE_PAIR;
        }
        return Type.HIGH_CARD;
    }
    public static void main(String[] args) throws Exception {
        Hand hand = new Hand("7A326 765");
        System.out.print("maxOfAKind: ");
        System.out.println(hand.maxOfAKindTuple()[0]);
        System.out.print("Type: ");
        System.out.println(hand.getType());

    }

}
