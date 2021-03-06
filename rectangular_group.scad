echo(version=version());

// cylinder portion of the group
include <constants.scad>

// calcs here to output volume
cyl_vol = 3.1415*pow((bore/2),2) * bore_h;
hopper_vol = hl*hw*(hh);
total_vol = l*w*(group_h);

//modules below


module bored_rect(sz=[10,10,10], r=2, pos=[0,2]){

  mml = [min(pos[0]-r, -sz[0]/2), max(pos[0]+r,sz[0]/2),
    min(pos[1]-r, -sz[1]/2), max(pos[1]+r,sz[1]/2)];
  /*echo(mml);*/
  if(mml!=[-sz[0]/2, sz[0]/2, -sz[1]/2, sz[1]/2] ) {
    echo("Error in BORED_RECT: bore exceeds rectangle");
  }
  else{
    difference(){
      cube(sz, center=true);
      translate([pos[0],pos[1],0]){cylinder(h=sz[2]+0.001, r=r, center=true);
  }}}}


module hopper_negative(sz=[10,10,10], notch_l=2, notch_h=4){
  echo(sz);
  union(){
    cube(sz, center=true);
    translate([0, sz[1]/2+1/2, sz[2]/2-notch_h/2])
      cube([notch_l, 1, notch_h], center=true);
  }
}

module teeth(tooth_h=1, tooth_w=2, tooth_l=0.5, tooth_hole_d=0.5, teeth_sep=2,
  tooth_hole_shift=[0,0]){

  difference(){
    union(){
      translate([teeth_sep/2+tooth_l/2,0,0])
        cube([tooth_l, tooth_w+0.0001, tooth_h+0.0001], center=true);
      translate([-teeth_sep/2-tooth_l/2,0,0])
        cube([tooth_l, tooth_w+0.0001, tooth_h+0.0001], center=true);}

    translate([0,tooth_hole_shift[0], tooth_hole_shift[1]])
      rotate([0,90,0])
        cylinder(h=2*tooth_l+teeth_sep+0.0001, r=tooth_hole_d/2, center=true);
  }
}


module cartridge_heater_negative(block_h=2, block_w=2, heater_d=1,
   heater_h=10, heater_sep=2){
     union(){
       cube([2*heater_d+heater_sep,block_w,block_h], center=true);
       translate([heater_sep/2+heater_d/2,block_w/2-heater_d/2,block_h/2]){
         cylinder(h=heater_h, r=heater_d/2);}
        translate([-heater_sep/2-heater_d/2,block_w/2-heater_d/2,block_h/2]){
          cylinder(h=heater_h, r=heater_d/2);}
}}

module post_negative(post_d=1, post_h=5, post_x=3, post_y=3){
  translate([post_x,-post_y,0]) cylinder(h=post_h, r=post_d/2);
  translate([-post_x,post_y,0]) cylinder(h=post_h, r=post_d/2);
  translate([-post_x,-post_y,0]) cylinder(h=post_h, r=post_d/2);
}

module portafilter_holder(holder_h=2, holder_l=1, holder_w=0.5, holder_thick=1,
                          holder_d=5){
  translate([0, -holder_d/2-holder_w/2, 0])
  union(){
    cube([holder_l, holder_w, holder_h], center=true);
    translate([0, holder_thick/2 + holder_w/2, -holder_h/2+holder_w/2])
      cube([holder_l, holder_thick, holder_w], center=true);
  }

  mirror([0,1,0])
    translate([0, -holder_d/2-holder_w/2, 0])
      union(){
        cube([holder_l, holder_w, holder_h], center=true);
        translate([0, holder_thick/2 + holder_w/2, -holder_h/2+holder_w/2])
          cube([holder_l, holder_thick, holder_w], center=true);
      }
}

module group(){
  difference(){
    union(){
      bored_rect(sz=[l,w,group_h], r=bore/2, pos=[0,0]);
      translate([0,-w/2+lever_tooth_w/2,group_h/2+lever_tooth_h/2])
        teeth(lever_tooth_h, lever_tooth_w, lever_tooth_l, lever_pin_d,
              lever_teeth_sep, lever_pin_shift);
      rotate([0,0,90])
        translate([0,0,-group_h/2-porta_h/2])
          portafilter_holder(porta_h, porta_l, porta_w, porta_thick, porta_dia);
    }

    translate([0,w/2-hw/2-hopper_min_wall_thick,group_h/2-hh/2])
      hopper_negative([hl,hw,hh], lever_front_notch_1, lever_front_notch_h);

    translate([0,-w/2+(max_wall_thick-0.5)/2,
      -group_h/2+cartridge_heater_notch_h/2]){cartridge_heater_negative(
          cartridge_heater_notch_h,(max_wall_thick-0.5),cartridge_heater_d,
          cartridge_heater_h,2);}

    translate([0,0,-group_h/2]) post_negative(post_d, post_hole_h,
      l/2-0.25-post_d/2, w/2-0.25-post_d/2);

    translate([0,0,-group_h/2]) cylinder(h=screen_h, r=(bore+screen_d_delta)/2);
}}

module group_tocast(){
  difference(){
    union(){
      bored_rect(sz=[l,w,group_h], r=bore/2, pos=[0,0]);
      translate([0,-w/2+lever_tooth_w/2,group_h/2+lever_tooth_h/2])
        cube([2*lever_tooth_l+lever_teeth_sep,lever_tooth_w,lever_tooth_h], center=true);
      rotate([0,0,90])
        translate([0,0,-group_h/2-porta_h/2])
          portafilter_holder(porta_h, porta_l, porta_w+porta_thick, 0, porta_dia-2*porta_thick);
    }
    translate([0,w/2-hw/2-hopper_min_wall_thick,group_h/2-hh/2])
      hopper_negative([hl,hw,hh], lever_front_notch_1, lever_front_notch_h);
  }
}


// outputs here
echo("len/width is ", l, " cm");
echo("group height is ", group_h, " cm");
echo("total volume is ", total_vol, " cm^3");
echo("cylinder volume is ", cyl_vol, " cm^3");
echo("hopper volume is ", hopper_vol, " cm^3");
echo("water volume is ", hopper_vol+cyl_vol, " cm^3");
echo("brass volume is ", total_vol-hopper_vol-cyl_vol, " cm^3");


/*bored_rect(sz=[l,w,group_h], r=bore/2, pos=[0,w/2-bore/2-min_wall_thick]);*/
/*hopper_negative([hl,hw,hh], lever_tooth_h,*/
  /*hopper_back_wall_thick-hopper_min_wall_thick, lever_tooth_l);*/
/*hopper_negative();*/
/*teeth();*/
/*group();*/
/*group_tocast();*/
/*cartridge_heater_negative();*/
/*post_negative();*/
/*portafilter_holder();*/
