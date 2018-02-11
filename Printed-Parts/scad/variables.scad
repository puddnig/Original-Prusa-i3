use<polyholes.scad>


m3_through_dia=3.2;
rod_h=6; //Distance upper x_rod to top of part (bottom here)
rod_distance=45; //distance between x rods
rod_xz_distance=15;
//rod_z_flange=28.5;//Distanze Z-rod to side of part in Y direction

//rod_xend_z_distance=1; //Distance between end of x rod to center of z rod in y direction
cube_width=17;
//overhang_rear=0;
cube_height=58;

rp_dia=7.8; //Rodpocket
dia_wp=10; //Wastepocket
wp_length_straight=4;
wp_length_taper=3;

belt_offset=2;
bs_h=28; //height beltslot
bs_w=10; //width beltslot
end_adjust=0.1;
bearing_reinforcement=1.2;
bearing_diameter=14.95;
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
//nema17 Bolt pattern
sd=xstepper_bolt_distance/2;
nema17_pattern=[[sd,sd,0],[sd,-sd,0],[-sd,-sd,0],[-sd,sd,0]];


nut_outer_corr=correctedRadius(nut_outer,sides(nut_outer));
nut_inner_corr=correctedRadius(nut_inner,sides(nut_inner));

rod_z_flange=nut_offset+correctedRadius(nut_outer,sides(nut_outer));



bearing_size = bearing_diameter + 2 * bearing_holder_wall;
