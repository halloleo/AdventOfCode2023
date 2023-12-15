import java.util.Arrays;
import java.util.List;

public class JokerHand extends Hand {

    // Attention: Use ONLY the function getOrderedCards, not the constant
    // ORDERD_CARDS_DONT_REFERENCE because of inheritance in JokerHand!
    static List<Character> ORDERD_CARDS_DONT_REFERENCE = Arrays
            .asList(new Character[]{'A', 'K', 'Q', 'T', '9', '8', '7', '6', '5',
                    '4', '3', '2', 'J'});

    @Override
    public List<Character> getOrderedCards() {
        return ORDERD_CARDS_DONT_REFERENCE;
    }

    public JokerHand(char[] cards, int bid) {
        super(cards, bid);
    }

    public JokerHand(String line) {
        super(line);
    }

    public JokerHand() {
        super();
    }

    @Override
    public Type getType() {
        int nJoker = (int) String.valueOf(cards).chars().filter(c -> c == 'J')
                .count();
        if (nJoker == 5) {
            return Type.FIVE_OF_A_KIND;
        } 

        int[] maxTuple = maxOfAKindTuple("J");
        int nOthers = maxTuple[0];
        int n = nOthers + nJoker;
        char excludedChar = cards[maxTuple[1]];
        return typeFromMaxOfAKind(n, "J" + excludedChar);
    }

    public static void main(String[] args) throws Exception {
        JokerHand jh = new JokerHand("JJJJJ 0");
        Type t = jh.getType();
        System.out.print(String.format("cards=%s, type=%s",String.valueOf(jh.cards), t));
    }
}
