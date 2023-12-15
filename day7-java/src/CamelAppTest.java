import static org.junit.jupiter.api.Assertions.assertEquals;

import java.io.IOException;
import java.util.List;

import org.junit.jupiter.api.Test;

public class CamelAppTest {
    @Test
    void testReadFile() throws IOException {
        List<String> lines = CamelApp.readFile("sample");
        assertEquals(lines.size(), 5);
        assertEquals(lines.get(0), "32T3K 765");
        assertEquals(lines.get(1), "T55J5 684");
    }

    @Test
    void testReadHands() throws IOException {
        List<Hand> hands = CamelApp.readHands("sample");
        assertEquals(hands.size(), 5);

        assertEquals(String.valueOf(hands.get(0).cards), "32T3K");
        assertEquals(String.valueOf(hands.get(1).cards), "T55J5");
        assertEquals(String.valueOf(hands.get(4).cards), "QQQJA");

        assertEquals(hands.get(0).bid, 765);
        assertEquals(hands.get(1).bid, 684);
        assertEquals(hands.get(4).bid, 483);
    }

        @Test
    void testCalculateWinnings() throws IOException {
        assertEquals(
            CamelApp.calculateWinnings(CamelApp.readHands("sample")),
            6440);
    }
}
