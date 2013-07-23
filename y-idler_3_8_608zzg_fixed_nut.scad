// nelsoncs 2013Jun05 
// modified to support:
// 1. U.S. measurements for y-idler for 3/8 in. rod, 5/16 in. bolt holding 608ZZG bearing
// 2. "fake bearing" was causing problems with two-manifold edges, has been widened to 
// create an overlap with the part
// 
// PRUSA iteration3
// Y idler
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

wall_thickness=3;
opening_width=11;
external_width=opening_width+wall_thickness*2;
opening_diameter = 32;
bearing_width = 6.35; 		// 1/4 in.
bearing_ID = 7.9375; 			// 5/16 in.
rod_diameter = 9.525 + 0.2; 	// 3/8 in. + slack space

tensioner_length = 10;

// increase the elongation if the bearing opening intersects
// with the M10 rod opening.
elongation = 1;


module nut(d,h,horizontal=true){
    cornerdiameter =  (d / 2) / cos (180 / 6);
    cylinder(h = h, r = cornerdiameter, $fn = 6);
    if(horizontal){
        for(i = [1:6]){
			rotate([0,0,60*i]) 
			translate([-cornerdiameter-0.2,0,0]) 
			rotate([0,0,-45]) 
			cube([2,2,h]);
        }
    }
}

module y_idler_base(){

	// bearing end
	translate(v = [0,0,0]) 
	cylinder(h = external_width, r=8);	

	// tensioner end
 	translate(v = [0, 20+2+elongation+2,0]) 
	hull() {
		cylinder(h = external_width, r=8);
		translate([0, tensioner_length,0]) 
		cylinder(h = external_width, r=8);
 	}

	// center
 	translate(v = [0, 10+1+elongation/2+tensioner_length/2+1, external_width/2]) 
	cube(
		size = [16, 22+elongation+tensioner_length+2,external_width], 
		center=true);
 		translate(v = [-4, 10+1+elongation/2+tensioner_length/2+1, external_width/2]) 
		cube(size = [8, 16+22+elongation+tensioner_length+2, external_width], center=true);
}

module y_idler_holes(){

	// bearing center hole
 	translate(v = [0,0,-1]) cylinder(h = 25, r=bearing_ID/2);

 	difference() {
   		translate(v = [0, 0, wall_thickness]) 
		cylinder(h = opening_width, r=opening_diameter/2);

   		// The fake bearing
   		%translate([0, 0, (external_width/2)-(bearing_width/2)-0.5]) 
		cylinder(h = bearing_width+1, r=(22/2)+2*0.66);

   		// The two bumps around the center of the bearing
   		translate([0,0,wall_thickness]) 
		cylinder(r1=15/2, r2=12/2, h=opening_width/2-bearing_width/2);

   		translate([0,0,external_width-wall_thickness]) 
		rotate([0,180,0]) 
		cylinder(r1=15/2, r2=12/2, h=opening_width/2-bearing_width/2);
 	}

	// rod slot (hull)
 	translate(v = [0, 20+2+elongation, -1]) 
	hull() {
		cylinder(h = 25, r=rod_diameter/2);
		
		translate([0, tensioner_length, 0]) 
		cylinder(h = 25, r=rod_diameter/2);
 	}
	
	// tensioner bolt and nut
 	translate([0, 16+22+elongation+tensioner_length+2-12, external_width/2]) 
	rotate([90, 0, 0]) {
		nut(5.8, 5);
		translate([0, 0, -5]) cylinder(r=2, h=10);
 	}
}

// Final part
module y_idler(){
 	translate(v = [0, 0, 8])
	rotate([0, -90, 0]) difference(){
  		y_idler_base();
  		y_idler_holes();
 	}
}

y_idler();
