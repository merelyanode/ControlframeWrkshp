/**
 * ControlP5 Controlframe
 * with controlP5 2.0 all java.awt dependencies have been removed
 * as a consequence the option to display controllers in a separate
 * window had to be removed as well. 
 * this example shows you how to create a java.awt.frame and use controlP5
 *
 * by Andreas Schlegel, 2012
 * www.sojamo.de/libraries/controlp5
 *
 */

//using this sketch to troubleshoot controlframe issues for TwoWindowsTwo
//This is what success looks like!!!!!
import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;//P5
import java.util.Date;
private ControlP5 cp5;//P5
ControlFrame cf;
int def;
PImage img_1; //P5
PImage img_2; //P5
PImage img_3;//P5

//String textValue = "";//P5
//String timestamp;//P5
//int i;
 

void setup() {
  size(400, 400,P3D);
  cp5 = new ControlP5(this);
  
  // by calling function addControlFrame() a
  // new frame is created and an instance of class
  // ControlFrame is instanziated.
  cf = addControlFrame("extra", 800,400);

  // add Controllers to the 'extra' Frame inside 
  // the ControlFrame class setup() method below.
  
  
}

/*
void setup() {
  //define the second frame and set up/draw? the form field
 size(1500, 800); 
 cp5 = new ControlP5(this);//P5
    cf = addControlFrame("extra", 800,400);
  cp5.addTextfield("input")//P5
     .setPosition(800,600)//P5
    .setSize(600,40)//P5
     .setFocus(true)//P5
    .setColor(color(255));//P5 
   

}
*/




void draw() {
  pushStyle();
  background(def);
  noStroke();
  fill(150,0,0);
  ellipse(20,20,20,20);
  popStyle();
  pushMatrix();
  translate(100,100,0);
  sphere(35);
  popMatrix();
}

ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100, 100);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}


// the ControlFrame class extends PApplet, so we 
// are creating a new processing applet inside a
// new frame with a controlP5 object loaded
public class ControlFrame extends PApplet {

  int w, h;

  int abc = 100;
  
  public void setup() {
    size(w, h,P3D);
    frameRate(25);
   // cp5 = new ControlP5(this);
    //cp5.addSlider("abc").setRange(0, 255).setPosition(10,10);
   // cp5.addSlider("def").plugTo(parent,"def").setRange(0, 255).setPosition(10,30);
  }

  public void draw() {
      background(abc);
      stroke(0,255,0);
  //rect(-200,-200, 400, 400);
  translate(200,200,0);
  //noStroke();
  noFill();
  rotateY(map(mouseX, 0, width, -PI, PI));
  rotateX(map(mouseY,0,height, -PI, PI));
  box(100,100,100);
  stroke(255,0,0);
  line(0,0, -200, 0, 0, 200);ellipse(20,20,20,20);
  }
  
  private ControlFrame() {
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }


  public ControlP5 control() {
    return cp5;
  }
  
  
  ControlP5 cp5;

  Object parent;

  
}

