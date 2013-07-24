// nelsoncs 2013Jun05 - NCSAppSoft.com
// modified to support:
// 1. U.S. measurements for y-motor for 3/8 in. rod threaded
// 2. motor mount screws are sized for #4-40 but should be suitable for 3mm (untested)
// 
// Original based on:
// PRUSA iteration3
// Y motor mount
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

//include <configuration.scad>

module y_motor_base(){
 // Motor holding part
 translate(v = [29,-21+50,0]){
  translate(v = [-21+4.5,0,5]) cube(size = [9,31,10], center=true);
  translate(v = [-15.5,-15.5,0]) cylinder(h = 10, r=5.5);
  translate(v = [-15.5,+15.5,0]) cylinder(h = 10, r=5.5);
  // Joins motor holder and rod plate
  translate(v = [-29,-21,0]) cube(size = [14,30,10]);
 }
 // Front holding part
 translate(v = [0,10,0]) cylinder(h = 10, r=7.9375);
 translate(v = [0,20,5])cube(size = [16,20,10], center=true);	
 translate(v = [0,30,0])cylinder(h = 10, r=7.9375);
}

module y_motor_holes(){
 translate(v = [29,-21+50,0]){
  // Screw holes
  translate(v = [-15.5,-15.5,-1]) cylinder(h = 10, r=1.7);
  translate(v = [-15.5,+15.5,-1]) cylinder(h = 10, r=1.7);
  // Screw head holes
  translate(v = [-15.5,-15.5,7.8]) cylinder(h = 7, r=3.5);
  translate(v = [-15.5,+15.5,7.8]) cylinder(h = 7, r=3.5);
 }
 translate(v = [0,10,-1]) cylinder(h = 12, r=4.7625);	
 translate(v = [0,30,-1])cylinder(h = 12, r=4.7625);
}

// Final part
module y_motor(){
 difference(){
  y_motor_base();
  y_motor_holes();
 }
}

y_motor();
