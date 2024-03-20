package hw2;

public class DegreeSeekingStudent extends Student {

    Major major;
    AcademicStanding academicStanding;
    int finAid;

    public DegreeSeekingStudent(String id, String firstName, String lastName, int age, int credits, Major major,
            AcademicStanding academicStanding, int finAid) {
        super(id, firstName, lastName, age, credits);
        this.major = major;
        this.academicStanding = academicStanding;
        this.finAid = finAid;
    }

    public void printData() {
        StringBuilder data = new StringBuilder();
        data.append("ID number: " + id + "\n");
        data.append("Name: " + firstName + " " + lastName + "\n");
        data.append("Age: " + age + "\n");
        data.append(firstName + " is a degree-seeking student enrolled in " + credits + " credits\n");
        data.append(firstName + " receives $" + finAid + " in financial assistance per term\n");
        data.append(firstName + "'s major is " + major + "\n");
        data.append(firstName + "'s academic standing is " + academicStanding + "\n");
        System.out.println(data);
    }

    public int computeFees() {
        /*
         * Fees are a recreation and athletics
         * fee of $100, a student union fee of $50, and $275 per credit hour, up to a
         * maximum of
         * twelve credit hours. Thus, the maximum fee assessment would be $100 + $50 +
         * $275*12
         * = $3450. If the student enrolls in more than twelve credit hours, the
         * additional credit
         * hours will appear in the student's records but the student is assessed only
         * for twelve
         * hours; the additional hours are essentially free of charge.
         */
        int fees = 100 + 50 + (credits <= 12 ? 275 * credits : 275 * 12);
        return finAid >= fees ? 0 : fees - finAid;
    }
}