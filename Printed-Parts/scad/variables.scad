// GNU GPL v3
// 2018 <puddnig@gmail.com>

use<polyholes.scad>


m3_through_dia=3.2;
square_nut_w=6;
square_nut_d=2;
rod_h=6; //Distance upper x_rod to top of part (bottom here)
rod_distance=45; //distance between x rods
rod_xz_distance=15;
hex_nut_od=6.4;
//rod_z_flange=28.5;//Distanze Z-rod to side of part in Y direction

//rod_xend_z_distance=1; //Distance between end of x rod to center of z rod in y direction
cube_width=17;
//overhang_rear=0;
cube_height=58;
//Dimensions of y belt holder
ybelth_bolt_distance=38.5;
ybelth_bolt_adjust=0.5;
ybelth_bolt_clamplen=2;
ybelth_upper=14.3;
ybelth_lower=18.3;
ybelth_flange=8;
ybelth_thickn=14;
ybelth_grabwidth=30;
//Belt dimensione
belt_slot_height=1.95;
belt_tooth_height=1.25;
belt_width=6;

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
bs_to_top=14;

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
idler_height=28.5;
idler_inward=15.5;
stress_relieve_height=27.5;
stress_relieve_offset=4.5;

//Variables used by x-end-motor:
xstepper_height=30.25;
xstepper_width=42.5;
xstepper_setback=33;
xstepper_bolt_distance=31;
tighten_range=5;
rear_flange_distance=62;
xstepper_guide_setback=2;
xstepper_guide_height=8;
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


nut_outer_corr=correctedRadius(nut_outer,sides(nut_outer));
nut_inner_corr=correctedRadius(nut_inner,sides(nut_inner));

rod_z_flange=nut_offset+correctedRadius(nut_outer,sides(nut_outer));



bearing_size = bearing_diameter + 2 * bearing_holder_wall;
