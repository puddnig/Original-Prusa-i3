// PRUSA iteration4
// cable holder
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <polyholes.scad>
use <fdmtools.scad>
include <variables.scad>

module zip(){
difference(){
    cylinder(d=16,h=3.5);
    cylinder(d=11,h=10,center=true);
    }}
    
module add(){
translate([0,0,4])cube([58,10,8],center=true);
    translate([-19,-5,8])cube([14,10,35]);
}
module cut(){
    translate([25,0,4]){
        cylinder(d=6,h=10,$fn=25);
        cylinder(d=m3_through_dia,h=10,$fn=25,center=true);
    }
    translate([-25,0,4]){
        cylinder(d=6,h=10,$fn=25);
        cylinder(d=m3_through_dia,h=10,$fn=25,center=true);
    }
    //round
    translate([-1,0,8.01])cylinder(d=12,h=40);
    translate([-19,0,43])rotate([0,0,90])chamfer(7,11);

    //zip
    translate([-6,0,13])zip();
        translate([-6,0,24])zip();
    translate([-6,0,35])zip();
    translate([0,0,9])rotate([0,90,0])zip();
translate([16,0,9])rotate([0,90,0])zip();
translate([20,0,13])rotate([0,15,0])cube([40,15,10],center=true);

}
difference(){add();cut();}

translate([-7,0,8])rotate([0,0,90])chamfer(5,10);
translate([-19,0,8])rotate([0,0,90])chamfer(2.5,10);



