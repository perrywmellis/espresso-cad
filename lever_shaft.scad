echo("This is the file holding the lever and the shaft");
$fs=.1;
$fa=.1;

// Constants
total_lever_len = 30.5; // cm

block_w = 10; // cm
block_l = 2; // cm
block_h =  2; // cm
block_slot_l = 0.5 + 0.1; // cm
block_pin_d = 0.3+0.05; // cm
block_group_hole_pos = 0.5; // cm
block_shaft_hole_pos = block_group_hole_pos + 2.143; // cm
block_lever_hole_h = 3;

handle_d = 2.5; // cm
handle_l = 10; // cm

lever_d = 1; // cm
lever_l = total_lever_len - block_w - handle_l + block_group_hole_pos +
  block_lever_hole_h; // cm

module block(lwh = [4,10,4], slot_l=1, pin_pos1=1, pin_pos2=4, pin_d=2,
  hole_d=2, hole_h=3, ){

  difference(){
    cube(lwh, center=true);
    translate([0,-(lwh[1]-pin_pos2-pin_d)/2,0]){
      cube([slot_l,pin_pos2+2,lwh[2]+0.001], center=true);}
    translate([0,-(lwh[1]/2-pin_pos2),0]) rotate([0,90,0]){
      cylinder(h=lwh[2]+0.001, r=pin_d/2, center=true);}
    translate([0,-(lwh[1]/2-pin_pos1),0]) rotate([0,90,0]){
      cylinder(h=lwh[2]+0.001, r=pin_d/2, center=true);}
    translate([0,lwh[1]/2-hole_h/2,0]) rotate([90,0,0]){
      cylinder(h=hole_h, r=hole_d/2, center=true);}
}}

module lever_handle(shaft_d=2, shaft_l=5, handle_d=4, handle_l=3){
  union(){
    cylinder(h=shaft_l, r=shaft_d/2);
    translate([0,0,shaft_l]) cylinder(h=handle_l, r=handle_d/2);
  }
}

module lever(){
  union(){
  block([block_l,block_w,block_h], block_slot_l, block_group_hole_pos,
    block_shaft_hole_pos, block_pin_d, lever_d, block_lever_hole_h);
  translate([0,block_w/2 - block_lever_hole_h,0]) rotate([-90,0,0]){
    lever_handle(lever_d, lever_l, handle_d, handle_l);}
  }
}
/*-(pin_pos2+pin_d)/2*/
// output here
/*block();*/
/*rotate([90,0,0])*/
/*lever_handle();*/
lever();
