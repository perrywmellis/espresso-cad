echo(version=version());
/*$fs=1;
$fa=1;*/

// piston

include <constants.scad>

module barbell(toph=tsh, both=bsh, midh=ch-bsh-tsh, outdia=cd,
  india=inner_bore+2*pwt){

  translate([0,0,midh/2]){
    cylinder(h=toph, r=outdia/2);
  }
  translate([0,0,-midh/2]){
    cylinder(h=midh, r=india/2);
  }
  translate([0,0,-midh/2-both]){
    cylinder(h=both, r=outdia/2);
}}


module piston_noseal(toph=tsh, both=bsh, midh=ch-bsh-tsh, outdia=cd,
  india=inner_bore+2*pwt, inbore=inner_bore, exdia=exit_hole_dia){
    difference(){
      barbell(toph, both, midh, outdia, india);
      /*translate([0,0,-midh/2]){cylinder(h=ch-bsh, r=inner_bore/2);}*/
      union(){
        translate([0,0,-midh/2]){cylinder(h=ch-bsh, r=inner_bore/2);}
        translate([0,0,-midh/2-both]){cylinder(h=bsh, r=exit_hole_dia/2);}
      }
      rotate([0,90,0]){translate([0,0,(india+inbore)/4]){
        millslot(milldia=1, depth=(india-inbore)/2+2, length=midh);
}}}}


module millslot(milldia=1, depth=0.5, length=4){
  linear_extrude(height=depth, center=true, convexity=10, twist=0, slices=2,
    scale=1.0){

    union(){
      translate([(length-milldia)/2,0,0]){circle(d=milldia);}
      translate([-(length-milldia)/2,0,0]){circle(d=milldia);}
      square(size=[length-milldia,milldia], center=true);
}}}


module rect_ring(innerdia=1.5, outerdia=2, h=1){
    difference(){
      cylinder(h=h, r=outerdia/2);
      cylinder(h=h, r=innerdia/2);
}}


module piston(toph=tsh, both=bsh, midh=ch-bsh-tsh, outdia=cd,
  india=inner_bore+2*pwt, inbore=inner_bore, exdia=exit_hole_dia,
  grd_top=grd1, gw_top=gw1, gpos_top=dh1,
  grd_bot=grd2, gw_bot=gw2, gpos_bot=dh2,
  grd_check=grd3, gw_check=gw3, india_check=id3){

  difference(){
    piston_noseal(toph, both, midh, outdia, india, inbore, exdia);
    translate([0,0,-midh/2-grd_check]) rect_ring(india_check,
      india_check + gw_check, grd_check+0.001);
    translate([0,0,midh/2+toph-gpos_top-gw_top/2]) rect_ring(outdia-2*grd_top,
      outdia+0.001, gw_top);
    translate([0,0,-midh/2-both+gpos_bot-gw_bot/2]) rect_ring(outdia-2*grd_bot,
      outdia+0.001, gw_bot);
}}


module check_piston(dia=inner_bore-ld2, h=ch_height, slot_w=ch_slot_width,
  slot_d=ch_slot_depth, pindia=ch_pin_dia, pinpos=ch_pin_pos){

  difference(){
    cylinder(h=h, r=dia/2);
    translate([0,0,h-slot_d/2]) cube(size=[slot_w, dia, slot_d], center=true);
    translate([0,0,h-pinpos]) rotate([0,90,0]) translate([0,0,-dia/2]){
      cylinder(h=dia+0.001, r=pindia/2);}
}}

//outputs below
echo("piston height is ", ch, " cm");
echo("piston volume is ", pow((bore-ld)/2,2)*3.1415*ch, " cm^3");

piston();
/*rect_ring();*/
/*check_piston();*/
