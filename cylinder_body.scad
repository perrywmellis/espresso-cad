echo(version=version());

// cylinder portion of the group

color("red")
  difference(){
    cylinder(h=20, r1=10, r2=10);
    cylinder(h=20, r1=8, r2=8);
  }
