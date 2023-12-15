import static org.junit.jupiter.api.Assertions.assertEquals;

import java.io.IOException;
import java.util.List;

import org.junit.jupiter.api.Test;

public class AppTest {
    @Test
    void testReadFile() throws IOException {
        App app = new App();
        List<String> lines = app.readFile("sample");
        assertEquals(lines.size(), 5);
        assertEquals(lines.get(0), "32T3K 765");
        assertEquals(lines.get(1), "T55J5 684");
    }
}
