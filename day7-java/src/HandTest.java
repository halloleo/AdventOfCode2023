import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.jupiter.api.Assertions.fail;

import org.junit.jupiter.api.Test;


public class HandTest {
    @Test
    void testLineConstuctor() {
        assertEquals(
            new Hand("32T3K 765"), 
            new Hand("32T3K".toCharArray(), 765));
        assertNotEquals(
            new Hand("32T3K 765"), 
            new Hand("32T3K".toCharArray(), 99));
        assertNotEquals(
            new Hand("32T3K 765"), 
            new Hand("32T3".toCharArray(), 765));
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
        assertEquals(new Hand("32T3K 765").maxOfAKindTuple()[0],2);
        assertEquals(new Hand("32T8K 765").maxOfAKindTuple()[0],1);
        assertEquals(new Hand("TTTKK 765").maxOfAKindTuple()[0],3);
        assertEquals(new Hand("32222 765").maxOfAKindTuple()[0],4);
        assertEquals(new Hand("88888 765").maxOfAKindTuple()[0],5);

        assertEquals(new Hand("32T3K 765").maxOfAKindTuple("3")[0], 1);
        assertEquals(new Hand("333TT 765").maxOfAKindNum("3"), 2);
    }
    
    @Test
    void testGetType() {
        assertEquals(new Hand("KKKKK 765").getType(), Hand.Type.FIVE_OF_A_KIND);
        assertEquals(new Hand("4444T 765").getType(), Hand.Type.FOUR_OF_A_KIND);
        assertEquals(new Hand("4A444 765").getType(), Hand.Type.FOUR_OF_A_KIND);
        assertEquals(new Hand("AAKKK 765").getType(), Hand.Type.FULL_HOUSE);
        assertEquals(new Hand("23KKK 765").getType(), Hand.Type.THREE_OF_A_KIND);
        assertEquals(new Hand("32K3K 765").getType(), Hand.Type.TWO_PAIR);
        assertEquals(new Hand("32T3K 765").getType(), Hand.Type.ONE_PAIR);
        assertEquals(new Hand("82T3K 765").getType(), Hand.Type.HIGH_CARD);
    }
}
