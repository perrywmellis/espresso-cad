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
