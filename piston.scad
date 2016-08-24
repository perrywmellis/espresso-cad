echo(version=version());
$fs=0.1;
$fa=0.1;

// piston ... all lengths in [cm], all masses in [g]
bore = 5.83; // diameter
ld = 0.1; // land diameter is the difference between the bore dia and piston dia
cd = bore - ld; // cyl diameter
ch = 4; // cyl height
tsh = 1; //height of the portion holding the top seal
bsh = 1; // height of the portion holding the bottom seal

// things below needed for the check valve
inner_bore = 3; // diameter of the inner bore
pwt = 0.5; // thickness of the piston walls
exit_hole_dia = 0.5; // diameter of the hole in the piston face

// things needed for the top and bottom seals (reciprocating seals)
grd1 = 0.2; // groove depth - depth of the droove itself
gld1 = grd1 + ld; // gland diameter - froove depth plus land diameter
gw1 = 0.3; // groove width

// things needed for the check valve seal (static axial seal)
grd2 = 0.2; // groove depth
gw2 = 0.3; // groove width
/*color("red")*/

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
  }
}

module piston_noseal(toph=tsh, both=bsh, midh=ch-bsh-tsh, outdia=cd,
  india=inner_bore+2*pwt, inbore=inner_bore, exdia=exit_hole_dia){
    difference(){
      barbell(toph, both, midh, outdia, india);
      /*translate([0,0,-midh/2]){cylinder(h=ch-bsh, r=inner_bore/2);}*/
      union(){
        translate([0,0,-midh/2]){cylinder(h=ch-bsh, r=inner_bore/2);}
        translate([0,0,-midh/2-both]){cylinder(h=bsh, r=exit_hole_dia/2);}
      }

    }
  }

module piston(toph=tsh, both=bsh, midh=ch-bsh-tsh, outdia=cd,
  india=inner_bore+2*pwt, inbore=inner_bore, exdia=exit_hole_dia){}

module millslot(milldia=1, depth=0.5, length=4){
  linear_extrude(height=depth, center=true, convexity=10, twist=0, slices=2,
    scale=1.0){

    union(){
      translate([(length-milldia)/2,0,0]){circle(d=milldia);}
      translate([-(length-milldia)/2,0,0]){circle(d=milldia);}
      square(size=[length-milldia,milldia], center=true);
    }
  }
}
// put a hole in the barbell
/*difference() {
barbell(2, 2, ch-4, cd, cd-2);
translate([0,0,-4]){
  cylinder(h=ch, r=(cd-2)/2-0.2);
}
}*/
piston_noseal();
/*millslot();*/
