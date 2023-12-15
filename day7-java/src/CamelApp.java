import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class CamelApp {

    static public List<String> readFile(String fName) throws IOException {
        // ClassLoader cl = this.getClass().getClassLoader();
        ClassLoader cl = CamelApp.class.getClassLoader();

        Path path = Paths.get(cl.getResource(fName).getFile());
        List<String> lines = Files.readAllLines(path);
        return lines;
    }

    static public List<Hand> readHands(String fName) throws IOException {
        List<Hand> handsList = new ArrayList<Hand>();
        List<String> lines = readFile(fName);
        for (String line : lines) {
            handsList.add(new Hand(line));
        }
        return handsList;
    }

    static public List<JokerHand> readJokerHands(String fName)
            throws IOException {
        List<JokerHand> handsList = new ArrayList<JokerHand>();
        List<String> lines = readFile(fName);
        for (String line : lines) {
            handsList.add(new JokerHand(line));
        }
        return handsList;
    }

    static public int calculateWinnings(List<Hand> hands) {
        int res = 0;
        Collections.sort(hands);
        for (int i = 0; i < hands.size(); i++) {
            int rank = i + 1;
            int winPerHand = hands.get(i).bid * rank;
            System.out.println(winPerHand);
            res = res + winPerHand;
        }
        return res;
    }

    static public int calculateJokerWinnings(List<JokerHand> hands) {
        int res = 0;
        Collections.sort(hands);
        for (int i = 0; i < hands.size(); i++) {
            int rank = i + 1;
            int winPerHand = hands.get(i).bid * rank;
            System.out.println(winPerHand);
            res = res + winPerHand;
        }
        return res;
    }

    public static void main_1(String[] args) throws Exception {
        int winnings = calculateWinnings(readHands("input"));
        System.out.println(winnings);
    }

    public static void main_2(String[] args) throws Exception {
        int winnings = calculateJokerWinnings(readJokerHands("input"));
        System.out.println(winnings);
    }
    public static void main(String[] args) throws Exception {
        main_2(args);
    }

}
