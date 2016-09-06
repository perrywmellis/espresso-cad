// file for the base

include <rectangular_group.scad>
base_h = l/1.618; // cm golden ratio again
leg_h = l + post_hole_h + base_h;
base_thick=2;




module group_legs(leg_d=1, leg_h=10, leg_x=3, leg_y=3){
  translate([leg_x,-leg_y,0]) cylinder(h=leg_h, r=leg_d/2);
  translate([-leg_x,leg_y,0]) cylinder(h=leg_h, r=leg_d/2);
  translate([-leg_x,-leg_y,0]) cylinder(h=leg_h, r=leg_d/2);
}

module baseplate(base_l=10, base_w=10, base_thick=2,
  hole_x=3, hole_y=3, hole_d=1, x_shift=2, y_shift=2){

  difference(){
    translate([x_shift,y_shift,0])
      cube([base_l,base_w,base_thick], center=true);
    translate([hole_x,-hole_y,0]) cylinder(h=base_thick+0.001, r=hole_d/2,
      center=true);
    translate([-hole_x,hole_y,0]) cylinder(h=base_thick+0.001, r=hole_d/2,
      center=true);
    translate([-hole_x,-hole_y,0]) cylinder(h=base_thick+0.001, r=hole_d/2,
      center=true);
  }
}

module base(){
  group_legs(post_d, leg_h, l/2-0.25-post_d/2, w/2-0.25-post_d/2);
  translate([0,0,base_h-base_thick/2])
    baseplate(group_h, group_h, base_thick, l/2-0.25-post_d/2,
      w/2-0.25-post_d/2, post_d, group_h/2-l/2,
      group_h/2-w/2);
}


/*group_legs();*/
/*baseplate();*/
/*base();*/
