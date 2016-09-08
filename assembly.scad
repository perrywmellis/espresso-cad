//assembly

include <rectangular_group.scad>
include <piston.scad>
include <lever_shaft.scad>
include <base.scad>

union(){
base();
translate([0,0,group_h/2+leg_h-post_hole_h]) {group();}

}

/*translate([0,0,40]) {piston();}*/

translate([0,(-block_group_hole_pos+block_w/2-w/2+
              max_wall_thick-lever_tooth_w/2+lever_pin_shift[0]),
  group_h+leg_h-post_hole_h+lever_tooth_h/2+lever_pin_shift[1]]) {lever();}
