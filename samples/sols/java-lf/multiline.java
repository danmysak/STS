import java.io.File;
import java.io.FileWriter;
import java.util.Scanner;

class multiline
{
    public static void main (String[] arguments)
    {
        try {
            Scanner scanner = new Scanner(new File("multiline.in"));
            FileWriter writer = new FileWriter("multiline.out");
            int n = scanner.nextInt();
			for (int i = 0; i < n; i++)
			{
				for (int j = 0; j <= i; j++)
				{
					if (j > 0)
					{
						writer.write(" ");
					}
					writer.write(String.valueOf(j + 1));
				}
				writer.write("\n");
			}
            writer.close();
        } catch (Exception ex) {}
    }
}