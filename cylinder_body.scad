echo(version=version());

// cylinder portion of the group
// my units are [g],[cm],[s]
// want cylinder body to be at least 3 kg, with bore 5.83 cm. Density naval
// brass is 8.41 g/cm^3

function wall_thick(mass=3000, bore=5.83, height=20, dens=8.41)
  = (-(bore/2) + sqrt(pow(bore / 2, 2) + 4 * (mass / (PI * height * dens)))) / 2;

  /*echo(wall_thick());*/

  t = wall_thick();

module cyl_raw (mass=3000, bore=5.83, height=20, dens=8.41){
  difference(){
    cylinder(h=height, r1=bore / 2 + wall_thick(mass, bore, height, dens), r2=bore / 2 + wall_thick(mass, bore, height, dens));
    cylinder(h=height, r1=bore / 2, r2=bore / 2);
  }
}

echo(t);
cyl_raw();
