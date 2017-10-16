public class FizzBuzz {
    public static void main(String[] args) {
        // 1 to 100 inclusive for loop
        for (int i = 1; i <= 100; i++) {
            if (i % 5 == 0 && i % 7 == 0) { //check if divisible by 5 AND 7
                System.out.println("FizzBuzz");
            } else if (i % 5 == 0) { //check if divisible by 5
                System.out.println("Fizz");
            } else if (i % 7 == 0) { //check if divisible by 7
                System.out.println("Buzz");
            } else { //is not divisible by 5 or 7
                System.out.println(i);
            }
        }
    }
}
