package hw2;

public class SeniorCitizenStudent extends NonDegreeSeekingStudent {
    public SeniorCitizenStudent(String id, String firstName, String lastName, int age, int credits) {
        super(id, firstName, lastName, age, credits);
    }

    public void printData() {
        StringBuilder data = new StringBuilder();
        data.append("ID number: " + id + "\n");
        data.append("Name: " + firstName + " " + lastName + "\n");
        data.append("Age: " + age + "\n");
        data.append(firstName + " is a senior-citizen student enrolled in " + credits + " credits\n");
        System.out.println(data);
    }

    public int computeFees() {
        /*
         * Fees are a fixed assessment of $100 per term for six or fewer enrolled
         * credit hours. Add an additional $50 for every credit hour greater than six.
         */
        return credits <= 6 ? 100 : 100 + (50 * (credits - 6));
    }
}