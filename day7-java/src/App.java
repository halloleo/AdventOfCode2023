import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

public class App {

    public List<String> readFile(String fName) throws IOException {
        ClassLoader cl = this.getClass().getClassLoader();
        Path path = Paths.get(cl.getResource(fName).getFile());
        List<String> lines = Files.readAllLines(path);
        return lines;        
    }

    public static void main_app(String[] args) throws Exception {
        App app = new App();
        System.out.println(
                app.readFile("sample"));
    }

    public static void main(String[] args) throws Exception {
        System.out.println(
            new Hand("32T3K 765").equals(
                new Hand("32T3K".toCharArray(), 785)));
    }

}
