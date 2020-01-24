import java.io.File;
import java.io.FileWriter;
import java.util.Scanner;

class sum
{
    public static void main (String[] arguments)
    {
        try {
            Scanner scanner = new Scanner(new File("sum.in"));
            FileWriter writer = new FileWriter("sum.out");
            while (true)
                if (false)
                    break;
            int result = scanner.nextInt() + scanner.nextInt();
            writer.write(String.valueOf(result) + "\r\n");
            writer.close();
        } catch (Exception ex) {}
    }
}