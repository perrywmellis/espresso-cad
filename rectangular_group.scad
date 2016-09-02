echo(version=version());

// cylinder portion of the group
// my units are [g], [cm], [s]
// want operating volume to be max 500 mL
// Density of naval brass is 8.41 g/cm^3
// With a bore of 5.83 cm, a stroke of 3.75 cm has a volume of 100 mL and a
//     stroke of 3 cm has a volume of 80 mL

// Constants here
bore = 5.83; // cm
bore_h = 10; // cm
min_wall_thick = 0.5; // cm
max_wall_thick = 2; // cm
group_h = 15; // cm

hopper_min_wall_thick = 0.5;
hopper_back_wall_thick = 1.5;
lever_tooth_h = 1;
lever_tooth_l = 0.5; // y distance of tooth for the lever


cartridge_heater_d = 1; // cm
cartridge_heater_h = 10; // cm
cartridge_heater_notch_h = 1;// cm
post_d = 1.5; // cm
post_hole_h = 2; // cm

screen_d_delta = 0.5;
screen_h = 0.5;

// calcs here
l = bore + min_wall_thick + max_wall_thick; //group len and width
w = l;

hl = l- 2*hopper_min_wall_thick;
hw = l - hopper_min_wall_thick - hopper_back_wall_thick;
hh = group_h - bore_h;


module bored_rect(sz=[10,10,10], r=2, pos=[0,2]){

  mml = [min(pos[0]-r, -sz[0]/2), max(pos[0]+r,sz[0]/2), min(pos[1]-r, -sz[1]/2), max(pos[1]+r,sz[1]/2)];
  /*echo(mml);*/
  if(mml!=[-sz[0]/2, sz[0]/2, -sz[1]/2, sz[1]/2] ) {
    echo("Error in BORED_RECT: bore exceeds rectangle");
  }
  else{
    difference(){
      cube(sz, center=true);
      translate([pos[0],pos[1],0]){cylinder(h=sz[2]+0.001, r=r, center=true);
  }}}}


module hopper_negative(sz=[10,10,10], tooth_h=1, tooth_w=2, tooth_l=0.5 ){
  echo(sz);
  union(){
    cube(sz, center=true);
    translate([0, -sz[1]/2-tooth_w/2, sz[2]/2-tooth_h/2]){
      difference(){
        cube([sz[0], tooth_w+0.0001, tooth_h], center=true);
        cube([tooth_l, tooth_w+0.0001, tooth_h], center=true);
}}}}

module group(){
  difference(){
    bored_rect(sz=[l,w,group_h], r=bore/2, pos=[0,w/2-bore/2-min_wall_thick]);
    translate([0,w/2-hw/2-hopper_min_wall_thick,group_h/2-hh/2]){ hopper_negative([hl,hw,hh], lever_tooth_h,
      hopper_back_wall_thick-hopper_min_wall_thick, lever_tooth_l);}
}}

/*bored_rect(sz=[l,w,group_h], r=bore/2, pos=[0,w/2-bore/2-min_wall_thick]);*/
/*hopper_negative([hl,hw,hh], lever_tooth_h,*/
  /*hopper_back_wall_thick-hopper_min_wall_thick, lever_tooth_l);*/
  /*hopper_negative();*/

  /*echo([hl,hw,hh]);*/
  /*echo(sz);*/
group();
