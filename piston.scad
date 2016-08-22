echo(version=version());

// piston ... all lengths in [cm], all masses in [g]
bore = 5.83; // diameter
ld = 0.1; // land diameter is the difference between the bore dia and piston dia
cd = bore - ld; // cyl diameter
ch = 8; // cyl height

/*color("red")*/

module barbell(toph, both, midh, outdia, india){
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

// put a hole in the barbell
difference() {
barbell(2, 2, ch-4, cd, cd-2);
translate([0,0,-4]){
  cylinder(h=ch, r=(cd-2)/2-0.2);
}
}
