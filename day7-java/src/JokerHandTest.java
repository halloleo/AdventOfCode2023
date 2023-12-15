import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

public class JokerHandTest {
    @Test
    void testCharOrder() {
        JokerHand jh = new JokerHand();
        assertEquals(jh.charOrder('A'), 0);
        assertEquals(jh.charOrder('2'), 11);
        assertEquals(jh.charOrder('J'), 12);
    }
    @Test
    void testGetType() {
        assertEquals(new JokerHand("QJJQ2 765").getType(),
                Hand.Type.FOUR_OF_A_KIND);
        assertEquals(new JokerHand("32T3K 765").getType(), Hand.Type.ONE_PAIR);
        assertEquals(new JokerHand("T55J5 765").getType(),
                Hand.Type.FOUR_OF_A_KIND);
        assertEquals(new JokerHand("AAKKK 765").getType(),
                Hand.Type.FULL_HOUSE);
        assertEquals(new JokerHand("KK677 765").getType(), Hand.Type.TWO_PAIR);
        assertEquals(new JokerHand("82T3K 765").getType(), Hand.Type.HIGH_CARD);

        assertEquals(new JokerHand("AJKKK 765").getType(),
                Hand.Type.FOUR_OF_A_KIND);
        assertEquals(new JokerHand("JJKKK 765").getType(),
                Hand.Type.FIVE_OF_A_KIND);
        assertEquals(new JokerHand("JJKKK 765").getType(),
                Hand.Type.FIVE_OF_A_KIND);
        assertEquals(new JokerHand("KKJ77 765").getType(),
                Hand.Type.FULL_HOUSE);

        assertEquals(new JokerHand("JJJJJ 765").getType(),
                Hand.Type.FIVE_OF_A_KIND);
    }

    @Test
    void testCompareChars() {
        JokerHand jh = new JokerHand();
        assertEquals(jh.compareChars("33332", "JAAAA"), 1);
        assertEquals(jh.compareChars("QQQQ2", "JKKK2"), 1);
        assertEquals(jh.compareChars("34567", "34A67"), -1);
        assertEquals(jh.compareChars("34A67", "34A67"), 0);
    }

    @Test
    void testCompareTo() {
        assertEquals(
                new JokerHand("32T3K 76").compareTo(new JokerHand("KK677 28")),
                -1);
        assertEquals(
                new JokerHand("KK677 28").compareTo(new JokerHand("T55J5 765")),
                -1);
        assertEquals(new JokerHand("T55J5 765")
                .compareTo(new JokerHand("QQQJA 767")), -1);
        assertEquals(new JokerHand("QQQJA 765")
                .compareTo(new JokerHand("KTJJT 765")), -1);

        assertEquals(new JokerHand("JJJJJ 765")
                .compareTo(new JokerHand("22222 765")), -1);

    }

}
