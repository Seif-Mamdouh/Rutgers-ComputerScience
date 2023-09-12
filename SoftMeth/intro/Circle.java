package intro;
public class Circle{

  // attributes
  // private data no access outside of the class
  private double radius;

  // default constructor
  public Circle() {
    // default value
    radius = 1.0;
  }

  // Paramtized Constructor
  public Circle(double radius) {
    this.radius = radius;
  }

  // getter method that return the current value of the radius
  public double getRadius() {
    return radius;
  }

  // setter method that sets the radius of a circle object to a given value.
  public void setRadius(double radius) {
    this.radius = radius;
  }

  // Compute and return the area of the circle object.
  public double getArea() {
    return radius * radius * Math.PI;
  }

  public double getPerimeter() {
    return 2 * radius * Math.PI;
  }

  // The test bed main, which can be used as a driver to test the code in the
  // class
  public static void main(String[] args) {
    Circle circle1 = new Circle();
    System.out.println("The area of circle1 with radius " + circle1.radius + " is " + circle1.getArea());
    Circle circle2 = new Circle(4.0);
    System.out.println("The perimeter of Circle2 with radius of " + circle2.radius + " is " + circle2.getPerimeter());
  }

}