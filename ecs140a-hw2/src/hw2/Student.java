package hw2;

public abstract class Student {

    String id;
    String firstName;
    String lastName;
    int age;
    int credits;
    int fees;

    public Student(String id, String firstName, String lastName, int age, int credits) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.age = age;
        this.credits = credits;
    }

    public abstract void printData();

    public abstract int computeFees();
}