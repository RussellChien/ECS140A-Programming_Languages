package hw2;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

import java.util.List;
import java.util.ArrayList;

public class Report {

	// generateReport() should be a public static method that takes no parameters
	// and returns a String
	public static String generateReport() {
		StringBuilder reportBuilder = new StringBuilder();
		int student_fee = 0;
		String student_name = "";

		// calculate total fees for each category 
		int degree_nofin_fees = 0;
		int degree_fin_fees = 0;
		int certificate_fees = 0;
		int senior_fees = 0;
		int total_fees = 0;

		Student[] students; // save all the student record objects here
		int numStudents = 0;
		List<Student> studentList = new ArrayList<Student>();
		reportBuilder.append("Summary of each student's fees assessed: \n\n");
		String filePath = "hw2.txt";
		try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
			String line;
			while ((line = br.readLine()) != null) {
				// instantiate student 
				Student student;
				// split input file by ';'
				String[] lineArr = line.split(";");
				String id = lineArr[0];
				String firstName = lineArr[1];
				String lastName = lineArr[2];
				int age = Integer.parseInt(lineArr[3]);
				int credits = Integer.parseInt(lineArr[4]);
				// degree seeking
				if (lineArr[5].equals("Y")) {
					Major major = null;
					switch (lineArr[6]) {
						case "M":
							major = Major.HM;
						case "A":
							major = Major.LA;
						case "E":
							major = Major.BE;
						case "S":
							major = Major.GS;
					}
					AcademicStanding academicStanding = null;
					switch (lineArr[7]) {
						case "G":
							academicStanding = AcademicStanding.GOOD;
						case "W":
							academicStanding = AcademicStanding.WARNING;
						case "P":
							academicStanding = AcademicStanding.PROBATION;
					}
					int finAid = 0;
					if (lineArr[8].equals("Y")) {
						finAid = Integer.parseInt(lineArr[9]);
					}
					student = new DegreeSeekingStudent(id, firstName, lastName, age, credits, major, academicStanding,
							finAid);
					if (finAid > 0)
						degree_fin_fees += student.computeFees();
					else
						degree_nofin_fees += student.computeFees();
				} else {
					// non degree seeking
					if (lineArr[6].equals("C")) {
						Major cert = null;
						switch (lineArr[7]) {
							case "M":
								cert = Major.HM;
							case "A":
								cert = Major.LA;
							case "E":
								cert = Major.BE;
							case "S":
								cert = Major.GS;
						}
						student = new CertificateStudent(id, firstName, lastName, age, credits, cert);
						certificate_fees += student.computeFees();
					} else {
						student = new SeniorCitizenStudent(id, firstName, lastName, age, credits);
						senior_fees += student.computeFees();
					}
				}
				// use this to check printData()
				// student.printData();
				// add student to arraylist
				studentList.add(student);
				student_name = firstName + " " + lastName;
				student_fee = student.computeFees();
				numStudents++;
				// add fees to report
				reportBuilder.append(student_name + " has $" + String.format("%,d", student_fee) + " fees assessed \n");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		// convert arraylist to students array
		students = studentList.toArray(new Student[numStudents]);
		total_fees = degree_fin_fees + degree_nofin_fees + certificate_fees + senior_fees;
		// Print out the total fees for different students
		reportBuilder.append("\n\n");
		reportBuilder.append("Summary of all student fees assessed: \n\n");
		reportBuilder.append(
				"Degree-seeking students without financial assistance: $" + String.format("%,d", degree_nofin_fees)
						+ "\n");
		reportBuilder
				.append("Degree-seeking students with financial assistance: $" + String.format("%,d", degree_fin_fees)
						+ "\n");
		reportBuilder.append("Certificate students: $" + String.format("%,d", certificate_fees) + "\n");
		reportBuilder.append("Senior citizens: $" + String.format("%,d", senior_fees) + "\n\n");
		reportBuilder.append("Total fees assessed: $" + String.format("%,d", total_fees));

		students[0].printData();
		students[1].printData();

		return reportBuilder.toString();
	}

	public static void main(String[] args) {
		// You may test your Report here by comparing the output with the provided
		// hw2_output.txt
		System.out.println(generateReport());
	}
}
