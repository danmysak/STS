import java.io.File;
import java.io.FileWriter;
import java.util.Scanner;

class sum
{
    public static void main (String[] arguments)
    {
        int b = 0;
        int a = 3 / b;
        try {
            Scanner scanner = new Scanner(new File("sum.in"));
            FileWriter writer = new FileWriter("sum.out");
            int result = scanner.nextInt() + scanner.nextInt();
            writer.write(String.valueOf(result) + "\r\n");
            writer.close();
        } catch (Exception ex) {}
    }
}