// this file holds the constants and parameters for the espresso machine
// this file should be imported into every other file that renders parts
// my units are [g], [cm], [s]
// want operating volume to be ~ 500 mL
// Density of naval brass is 8.41 g/cm^3
// With a bore of 5.83 cm, a stroke of 3.75 cm has a volume of 100 mL and a
//     stroke of 3 cm has a volume of 80 mL

//
// parameters for the group
//

  // general block size
  bore = 5.83; // cm
  bore_h = 9; // cm this needs to long enough to have a 3 cm stroke with a 4 cm piston
  min_wall_thick = 2; // cm
  max_wall_thick = 2; // cm
  /*group_h = 15; // cm*/
  group_h = (bore + min_wall_thick + max_wall_thick)*1.618; // cm try golden ratio

  // constants to mount the lever and notch the group to give clearance
  lever_tooth_h = 2;
  lever_tooth_l = 0.75; // x distance of tooth for the lever
  lever_tooth_w = 2; // y distance of the tooth for the lever
  lever_teeth_sep = 2+0.05; // distance betweent he 2 teeth
  lever_pin_d = 0.3 + 0.05; // diameter of hole in the slot for the lever
  lever_pin_shift = [0,0.25];
  lever_front_notch_1 = 1.5;
  lever_front_notch_h = -lever_tooth_h/2-lever_pin_shift[1] +
    tan(15)*(bore+min_wall_thick+max_wall_thick-(max_wall_thick-lever_tooth_w/2));

  // constants for the hopper/reseroir
  hopper_min_wall_thick = 0.5;
  hopper_back_wall_thick = max_wall_thick;

  // constants for the cartridge heater slots
  cartridge_heater_d = 1; // cm
  cartridge_heater_h = 10; // cm
  cartridge_heater_notch_h = 1;// cm

  // constants for the posts and post holes
  post_d = 1.5; // cm
  post_hole_h = 5; // cm

  // constants for the shower screen cutout
  screen_d_delta = 0.5;
  screen_h = 0.5;

  // constants for the portafilter holder
  porta_h=1;
  porta_l=1;
  porta_w=0.5;
  porta_thick=0.5;
  porta_dia=bore+2;

  // calcs here for geometries
  l = bore + min_wall_thick + max_wall_thick; //group len and width
  w = l;

  hl = l- 2*hopper_min_wall_thick;
  hw = l - hopper_min_wall_thick - hopper_back_wall_thick;
  hh = group_h - bore_h;

//
// parameters for the piston
//

  // things for the piston body
  ld = 0.1; // land diameter is the difference between the bore dia and piston dia
  cd = bore - ld; // cyl diameter
  ch = 4; // cyl height
  tsh = 1; //height of the portion holding the top seal
  bsh = 1.5; // height of the portion holding the bottom seal

  // things needed for the check valve
  inner_bore = 4; // diameter of the inner bore
  pwt = 0.3; // thickness of the piston walls
  exit_hole_dia = 0.75; // diameter of the hole in the piston face

  // things needed for the top seals (basically a piston guide)
  grd1 = 0.3; // groove depth - depth of the droove itself
  gld1 = grd1 + ld; // gland diameter - froove depth plus land diameter
  gw1 = 0.5; // groove width
  dh1 = 0.5; // position of gr0ove center measured from TOP


  // things needed for the bottom seal (reciprocating seal)
  grd2 = 0.5; // groove depth - depth of the droove itself
  gld2 = grd2 + ld; // gland diameter - froove depth plus land diameter
  gw2 = 0.75; // groove width
  dh2 = 0.75; // position of groove center measured from BOT

  // things needed for the check valve seal (static axial seal)
  grd3 = 0.5; // groove depth
  gw3 = 0.5; // groove width
  id3 = 1; // inner diameter of the groove
  /*color("red")*/

  // things needed for the check piston
  ld2 = 0.1; // land diameter between the inner bore and the check piston
  ch_height = 2; // height of the check piston
  ch_slot_width = 1; // width of the slot for the shaft
  ch_slot_depth = 1; // depth of the slot for the shaft
  ch_pin_dia = 0.3; // diameter of pin to hold shaft
  ch_pin_pos = 0.5; // distance from top of check piston to center of pin


//
// paramters for the lever
//

  total_lever_len = 30.5; // cm

  // constants for the block
  block_w = 8; // cm
  block_l = 2; // cm
  block_h =  2; // cm
  block_slot_l = 0.5 + 0.1; // cm
  block_slot_w = 3; // cm
  block_pin_d = 0.3+0.05; // cm
  block_group_hole_pos = 0.5; // cm
  block_shaft_hole_pos = block_group_hole_pos + 2.143; // cm
  block_lever_hole_h = 2;

  // constants for the handle
  handle_d = 2.5; // cm
  handle_l = 10; // cm

  // constants for the lever shaft
  lever_d = 1; // cm
  lever_l = total_lever_len - block_w - handle_l + block_group_hole_pos +
    block_lever_hole_h; // cm

//
// paramters for the portafilter
//

  basket_hole_d = bore + 5.89; // cm basket overhang diameter
  basket_hole_thick_upper; = 0.05;
  basket_hole_thick_lower; = 0.2; // cm
  basket_hole_upper_h = 0.1;
  basket_hole_lower_h = 1;
  porta_body_d = porta_dia-0.01; // cm 100 micron less than holder
  porta_body_h = 1;

//
// paramters for the base
//

  base_h = l/1.618; // cm golden ratio again
  leg_h = l + post_hole_h + base_h;
  base_thick=2;
