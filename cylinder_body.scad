echo(version=version());

// cylinder portion of the group
// my units are [g],[cm],[s]
// want cylinder body to be at least 3 kg, with bore 5.83 cm. Density naval
// brass is 8.41 g/cm^3
// With bore 5.83 cm, a stroke of 3.75 cm has a volume of 100 mL

function wall_thick(mass=3000, bore=5.83, height=20, dens=8.41)
  = (-(bore/2) + sqrt(pow(bore / 2, 2) + 4 * (mass / (PI * height * dens)))) / 2;

  /*echo(wall_thick());*/

  t = wall_thick();

module cyl_raw (mass=3000, bore=5.83, height=7.5, dens=8.41){
  t=wall_thick(mass, bore, height, dens);
  echo(t);
  difference(){
    cylinder(h=height, r1=bore / 2 + wall_thick(mass, bore, height, dens), r2=bore / 2 + wall_thick(mass, bore, height, dens));
    cylinder(h=height, r1=bore / 2, r2=bore / 2);
  }
}

/*echo(t);*/
/*cyl_raw();*/

module cutout_shape(length=1, h=1, step=0.5, ang=45, thick=2){
  union(){
    translate([-length,0,0]){
    linear_extrude(height=thick, center=true){
      polygon(points=[[0, 0], [length, 0], [length, h], [-(h-step)/tan(ang), h], [0, step]]);
    }}
    translate([length,0,0])mirror([1,0,0]){{
    linear_extrude(height=thick, center=true){
      polygon(points=[[0, 0], [length, 0], [length, h], [-(h-step)/tan(ang), h], [0, step]]);
    }}}
  }
}


module cutout_arrange(rad=6, length=1, h=1, step=0.5, ang=45, thick=2 ){
  translate([0,rad,0]) rotate([90,0,0]) cutout_shape(length, h, step, ang, thick);
  rotate([0,0,120]) translate([0,rad,0]) rotate([90,0,0]) cutout_shape(length,h, step, ang, thick);
  rotate([0,0,-120]) translate([0,rad,0]) rotate([90,0,0]) cutout_shape(length,h, step, ang, thick);
}

module cyl_collar(mass=3000, bore=5.83, height=7.5, dens=8.41, collar_thick=0.5,
  collar_height=1, cut_len=1, cut_step=0.5, cut_ang=15, cut_thick=2){

  wt = wall_thick(mass, bore, height, dens);
  ft = wt+collar_thick;
  fh = collar_height;
  /*echo(wt);*/
  /*echo(ft);*/
  difference(){
    cylinder(h=fh, r=bore / 2 + ft);
    cylinder(h=fh, r=bore / 2);
    cutout_arrange(bore/2+ft, cut_len, fh+1, cut_step, cut_ang, cut_thick);
  }
}

module cyl_full(mass=3000, bore=5.83, height=7.5, dens=8.41, collar_thick=0.5,
  collar_height=1, cut_len=1, cut_step=0.5, cut_ang=15, cut_thick=2,
  screen_depth=0.2, screen_dia=0.2){
  difference(){
    union(){
      cyl_raw(mass, bore, height, dens);
      cyl_collar(mass, bore, height, dens, collar_thick, collar_height, cut_len,
        cut_step, cut_ang, cut_thick);
    }
    cylinder(h=screen_depth, r = bore/2+screen_dia/2);
  }
}


/*cutout_arrange();*/
cyl_full(mass=2000, bore=5.83, screen_depth=0.5, screen_dia=1);
