// GNU GPL v3
// 2018 <puddnig@gmail.com>

use<polyholes.scad>

idler_dia_belt=14.6;
pulley_dia_belt=10.6;
frog_to_frame=2.6;

m3_through_dia=3.2;
square_nut_w=6;
square_nut_d=2;
lock_nut_od=6.4;
rod_h=6; //Distance upper x_rod to top of part (bottom here)
rod_distance=70; //distance between x rods
rod_xz_distance=15;
hex_nut_od=6.4;
//rod_z_flange=28.5;//Distanze Z-rod to side of part in Y direction

//rod_xend_z_distance=1; //Distance between end of x rod to center of z rod in y direction
cube_width=17;
//overhang_rear=0;
cube_height=80;

//y rod holder
yrh_height=15.2;
yrh_width=26;
yrh_depth=10;
yrod_to_ext=10.5;
yrh_hole_height=3.5;
yrh_hole_spacing=11;
yrh_nut_in=1.8;
yrh_ext_slot=8;
//Y Motor HOlder

ymh_bolt_clamping_length_frame=3.5;
ymh_bolt_clamping_length_stepper=5;
ymh_bolt_height=18;
ymh_bolt_distance=22;
ymh_height=48;
ymh_width=19;
ymh_stepper_down=21;//from top of rear frame
ymh_stepper_in=21;
ymh_stepper_side=13;
ymh_flange=7;
hex_nut_od=6.4;

//Dimensions of y belt holder
ybelth_bolt_distance=38.5;
ybelth_bolt_adjust=0.5;
ybelth_bolt_clamplen=2;
ybelth_lower=frog_to_frame+ymh_stepper_down-pulley_dia_belt/2;
ybelth_upper=ybelth_lower+pulley_dia_belt-idler_dia_belt;
ybelth_flange=8;
ybelth_thickn=14;
ybelth_grabwidth=30;
//Belt dimensione
belt_slot_height=1.95;
belt_tooth_height=1.25;
belt_width=6;
//X end

rp_dia=7.8; //Rodpocket
dia_wp=10; //Wastepocket
wp_length_straight=4;
wp_length_taper=3;

belt_offset=2;
bs_h=28; //height beltslot
bs_w=10; //width beltslot
end_adjust=0.1;
bearing_reinforcement=1.2;
bearing_diameter=14.8;
bearing_height=25;
bs_to_top=11;

bearing_holder_wall = 3;

nut_outer=12.5; //radius
nut_inner=7; //radius
nut_height=8;
nut_offset=17;
bolt_distance_nut=19;
nut_trap_reinf_height= 32.5;
nut_reinf_pushback=0.98;
nut_reinf_wall=4.5;
nut_reinf_rotate=17.5;

//Variables used by x-end-idler:
pulley_dia=20;
idler_inward=15.5;
stress_relieve_height=20;
stress_relieve_offset=4.5;

//Variables used by x-end-motor:
xstepper_width=42.5;
xstepper_setback=33;
xstepper_bolt_distance=31;
tighten_range=5;
rear_flange_distance=62;
xstepper_guide_setback=2;
xstepper_cutout_dia=25;
xstepper_bolt_length=18;
xstepper_bolt_depth=4;
//Tensioner
tens_height=4;

//z axis bottom
zrod_frame_distance=29.3;
zab_stepper_flange=5;
zab_frame_flange=8;
zab_lower_bolt=12;
zab_bolt_spacing=20;
zab_reinf_inner=6;
zab_reinf_outer=4;
zab_bolt_clamping_length=4;
//
// z axis top
zat_bolt_distance=20;
zat_bolt_frame_side=10;
zat_bolt_frame_top=10.2;
zat_brace=4;
zat_tr_dia=11.6;
zat_bolt_to_rp=9.6;
zat_bolt_to_register=2;
zat_bolt_to_rod=7;
zat_bolt_clamping=4;
zat_frame_flange=8;
zat_pocket_outer=16;
//nema17 Bolt pattern
sd=xstepper_bolt_distance/2;
nema17_pattern=[[sd,sd,0],[sd,-sd,0],[-sd,-sd,0],[-sd,sd,0]];
//Aero Carriage
cr_width=52;
rod_to_face=15.5;
face_thickn=2;
bearing_holder_od=21;
nozzle_to_stepper=45.5;
nozzle_to_top_rod=78;
bearing_dia_carri=14.75;
e_stepper_width=42.5;
belt_to_stepper=24.5;
htr=nozzle_to_top_rod-nozzle_to_stepper;
rod_distance=66;

Z_axis_offset=14;
pinda_forward=10.5;
pinda_side=23;
nozzle_side=11.5;

ph_height=12;
ph_nozzle=23;
//
nut_outer_corr=correctedRadius(nut_outer,sides(nut_outer));
nut_inner_corr=correctedRadius(nut_inner,sides(nut_inner));

rod_z_flange=nut_offset+correctedRadius(nut_outer,sides(nut_outer));

idler_height=rod_h+htr+belt_to_stepper-idler_dia_belt/2;
xstepper_height=rod_h+htr+belt_to_stepper-pulley_dia_belt/2;
xstepper_guide_height=cube_height-xstepper_height-22.5;


bearing_size = bearing_diameter + 2 * bearing_holder_wall;
