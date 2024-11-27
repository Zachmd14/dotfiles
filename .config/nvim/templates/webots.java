import com.cyberbotics.webots.controller.Robot;

public class {{_file_name_}} {

 public static void main(String[] args) {

   int TIME_STEP = 64;

   Robot robot = new Robot();

   while (robot.step(TIME_STEP) != -1) {
	 // Your code here
	 //
	 {{_cursor_}}

	 }
 }
}
