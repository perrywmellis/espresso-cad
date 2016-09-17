// portafilter

include <constants.scad>



module portafilter(hole_d=2, hole_thick_upper=0.1, hole_thick_lower=0.2,
                   hole_h_upper=1, hole_h_lower=2, body_d = 5, body_h=3){
  difference(){
    union(){
      cylinder(h=body_h, r=body_d/2, center=true);
      translate([0,0,-(body_h+hole_h_lower)/2])
        cylinder(h=hole_h_lower, r=hole_d/2+hole_thick_lower, center=true);
      translate([0,0,(body_h+hole_h_upper)/2])
        cylinder(h=hole_h_upper, r=hole_d/2+hole_thick_upper);
    }
    translate([0,0,-(hole_h_lower-hole_h_upper)])
      cylinder(h=hole_h_upper+hole_h_lower+body_h+0.001, r=hole_d/2);
  }
}
