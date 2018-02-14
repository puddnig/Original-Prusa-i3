// PRUSA iteration4
// Y belt idler
// GNU GPL v3
// 2018 <puddnig@gmail.com>
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

include<variables.scad>
use<fdmtools.scad>
use<polyholes.scad>

ybi_frame_height=38.5;
ybi_width=25;
ybi_pulley_width=10;
ybi_pulley_dia=20;
ybi_pulley_to_frame=14;
ybi_pulley_to_frame_top=ymh_stepper_down-(idler_dia_belt-pulley_dia_belt)/2;
ybi_bolt_spacing=26;
ybi_bolt_to_frame=4;
ybi_height=ybi_pulley_to_frame+6;
ybi_flange_offset=2;
ybi_clamping_length_pulley=2.5;
ybi_clamping_length=2;

flange=ybi_pulley_to_frame-ybi_pulley_dia/2+ybi_flange_offset;
module add(){
    translate([-ybi_width/2,0,0])cube([ybi_width,2*ybi_pulley_to_frame_top,ybi_height]);
}

module cut(){
    translate([-ybi_pulley_width/2,-1,flange])cube([ybi_pulley_width,ybi_frame_height+2,ybi_height]);
    
    translate([0,ybi_pulley_to_frame_top,ybi_pulley_to_frame])rotate([0,90,0])cylinder(d=ybi_pulley_dia,h=ybi_pulley_width,center=true);
    //Nut pocket
    translate([0,ybi_bolt_to_frame,flange])rotate([180,0,0])hexhole_bottom(m3_through_dia,lock_nut_od,flange-ybi_clamping_length,0);
translate([0,ybi_bolt_to_frame+ybi_bolt_spacing,flange])rotate([180,0,0])hexhole_bottom(m3_through_dia,lock_nut_od,flange-ybi_clamping_length,0);
    //pulley bolt
    translate([ybi_width/2,ybi_pulley_to_frame_top,ybi_pulley_to_frame])rotate([0,-90,0])hexhole_bottom(m3_through_dia,lock_nut_od,(ybi_width-ybi_pulley_width)/2-ybi_clamping_length_pulley,0);
translate([-ybi_width/2,ybi_pulley_to_frame_top,ybi_pulley_to_frame])rotate([0,90,0])hole_bottom(m3_through_dia,2.1*m3_through_dia,(ybi_width-ybi_pulley_width)/2-ybi_clamping_length_pulley,0);
    //fillet
    translate([0,0,ybi_height])rotate([90,-90,90])fillet(3,ybi_width+2);
translate([0,2*ybi_pulley_to_frame_top,ybi_height])rotate([90,0,90])fillet(3,ybi_width+2);

}

difference(){add(); cut();}

//translate([0,ybi_pulley_to_frame_top,ybi_pulley_to_frame])rotate([0,90,0])cylinder(d=ybi_pulley_dia,h=ybi_pulley_width,center=true);
translate([0,3,ybi_height-3])rotate([0,90,0])cylinder(r=3,h=ybi_pulley_width+2,$fn=2*sides(3),center=true);
translate([0,2*ybi_pulley_to_frame_top-3,ybi_height-3])rotate([0,90,0])cylinder(r=3,h=ybi_pulley_width+2,$fn=2*sides(3),center=true);





