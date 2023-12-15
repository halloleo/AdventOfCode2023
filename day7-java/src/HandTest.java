import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.jupiter.api.Assertions.fail;

import org.junit.jupiter.api.Test;

public class HandTest {
    @Test
    void testLineConstuctor() {
        assertEquals(new Hand("32T3K 765"),
                new Hand("32T3K".toCharArray(), 765));
        assertEquals(new Hand("32T3K 765"),
                new Hand("32T3K".toCharArray(), 99));
    }

    @Test
    void testFailingLineConstuctor() {
        try {
            new Hand("32T3x 765"); // wrong card char
            fail("Hand with wrong card char did NOT throw exception");
        } catch (IllegalArgumentException e) {
            assertNotNull(e);
        }
    }

    @Test
    void testMaxOfAKind() {
        assertEquals(new Hand("32T3K 765").maxOfAKindTuple()[0], 2);
        assertEquals(new Hand("32T8K 765").maxOfAKindTuple()[0], 1);
        assertEquals(new Hand("TTTKK 765").maxOfAKindTuple()[0], 3);
        assertEquals(new Hand("32222 765").maxOfAKindTuple()[0], 4);
        assertEquals(new Hand("88888 765").maxOfAKindTuple()[0], 5);

        assertEquals(new Hand("32T3K 765").maxOfAKindTuple("3")[0], 1);
        assertEquals(new Hand("333TT 765").maxOfAKindNum("3"), 2);
    }

    @Test
    void testGetType() {
        assertEquals(new Hand("KKKKK 765").getType(), Hand.Type.FIVE_OF_A_KIND);
        assertEquals(new Hand("4444T 765").getType(), Hand.Type.FOUR_OF_A_KIND);
        assertEquals(new Hand("4A444 765").getType(), Hand.Type.FOUR_OF_A_KIND);
        assertEquals(new Hand("AAKKK 765").getType(), Hand.Type.FULL_HOUSE);
        assertEquals(new Hand("23KKK 765").getType(),
                Hand.Type.THREE_OF_A_KIND);
        assertEquals(new Hand("32K3K 765").getType(), Hand.Type.TWO_PAIR);
        assertEquals(new Hand("32T3K 765").getType(), Hand.Type.ONE_PAIR);
        assertEquals(new Hand("82T3K 765").getType(), Hand.Type.HIGH_CARD);
    }

    @Test
    void testCompareChars() {
        Hand hand = new Hand();
        assertEquals(hand.compareChars("33332", "2AAAA"), 1);
        assertEquals(hand.compareChars("33332", "33334"), -1);
        assertEquals(hand.compareChars("34567", "34A67"), -1);
        assertEquals(hand.compareChars("34A67", "34A67"), 0);
    }

    @Test
    void testCompareToBasic() {
        assertEquals(
            new Hand("32K3K 765").compareTo(new Hand("34K3K 765")),
            -1);
        assertEquals(
            new Hand("32K3K 765").compareTo(new Hand("32K3K 765")),
            0);        
        assertEquals( // Other *bid* should not make a difference
            new Hand("32K3K 765").compareTo(new Hand("32K3K 767")),
            0);
        assertEquals(
            new Hand("3AK3K 765").compareTo(new Hand("32K3K 765")),
            1);
    }

    @Test
    void testCompareToTypeOrder() {
        // Check the type order
        assertEquals( // FIVE_OF_A_KIND > FOUR_OF_A_KIND
            new Hand("33333 765").compareTo(new Hand("AA3AA 765")),
            1);

        assertEquals( // FOUR_OF_A_KIND > FULL_HOUSE
            new Hand("A2AAA 765").compareTo(new Hand("JJJAA 765")),
            1);

        assertEquals( // FULL_HOUSE > THREE_OF_A_KIND
            new Hand("JJJTT 765").compareTo(new Hand("A23AA 765")),
            1);

        assertEquals( // THREE_OF_A_KIND > TWO_PAIR
            new Hand("A23AA 765").compareTo(new Hand("AA388 765")),
            1);

        assertEquals( // TWO_PAIR > ONE_PAIR
            new Hand("AA388 765").compareTo(new Hand("JT3AA 765")),
            1);

        assertEquals( // ONE_PAIR > HIGH_CARD
            new Hand("JT3AA 765").compareTo(new Hand("AK653 765")),
            1);
    }

    @Test
    void testCompareToMore() {       
        // More in one order
        assertEquals(
            new Hand("TTTTT 765").compareTo(new Hand("JJJJJ 13")),
            -1);
        assertEquals(
            new Hand("A9999 765").compareTo(new Hand("TTTTA 0")),
            1);
    }

    @Test
    void testCompareToProblemExamples() {
        // The examples from the problem description:
        assertEquals(
            new Hand("33332 765").compareTo(new Hand("2AAAA 765")),
            1);
        assertEquals(
            new Hand("77888 765").compareTo(new Hand("77788 765")),
            1);
    }

}
