package hw2;

public class CertificateStudent extends NonDegreeSeekingStudent {

    Major certificate;

    public CertificateStudent(String id, String firstName, String lastName, int age, int credits, Major certificate) {
        super(id, firstName, lastName, age, credits);
        this.certificate = certificate;
    }

    public void printData() {
        StringBuilder data = new StringBuilder();
        data.append("ID number: " + id + "\n");
        data.append("Name: " + firstName + " " + lastName + "\n");
        data.append("Age: " + age + "\n");
        data.append(firstName + " is a certificate-seeking student enrolled in " + credits + " credits\n");
        data.append(firstName + "'s certificate is " + certificate + "\n");
        System.out.println(data);
    }

    public int computeFees() {
        /*
         * fees are a fixed assessment of $700 per term plus $300 for every
         * credit hour the student has enrolled in this term
         */
        return 700 + 300 * credits;
    }
}