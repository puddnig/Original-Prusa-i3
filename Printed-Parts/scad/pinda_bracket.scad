use <polyholes.scad>
use <fdmtools.scad>
include <variables.scad>

ph_id=8.2;
cr_width=52;
rod_to_face=15.5;
face_thickn=2;
bearing_holder_od=21;
nozzle_to_stepper=46;
nozzle_to_top_rod=78;
bearing_dia_carri=14.75;
e_stepper_width=42.5;
belt_to_stepper=25;
htr=nozzle_to_top_rod-nozzle_to_stepper;
rod_distance=66;

Z_axis_offset=14;
pinda_forward=10.5;
pinda_side=23;
nozzle_side=11.5;

ph_height=10;
ph_nozzle=23;
module add(){
    cylinder(d=ph_id+6,h=ph_height);
    translate([0,-ph_id/2-3,0])cube([ph_id/2+9,ph_id+6,ph_height]);
}
module cut(){
cylinder(d=ph_id,h=30,center=true,$fn=20);
    translate([0,-0.6,-1])cube([20,1.2,15]);
    //pinda screw
    translate([ph_id/2+4.5,0,ph_height/2])rotate([-90,0,0])cylinder(d=m3_through_dia,h=12,$fn=20);
mirror([0,1,0])translate([ph_id/2+4.5,0,ph_height/2])rotate([-90,0,0])cylinder(d=m3_through_dia,h=12,$fn=20);
mirror([0,1,0])translate([ph_id/2+4.5,3,ph_height/2])rotate([-90,0,0])cylinder(d=6,h=12,$fn=20);


}

difference(){add();cut();}

