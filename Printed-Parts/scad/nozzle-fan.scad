use <polyholes.scad>
use <fdmtools.scad>
include <variables.scad>

module base(){
    difference(){
cube([40,40,2],center=true);
        intersection(){
        cylinder(d=39,h=4,center=true);
        cube([32,34,6],center=true);}
            for(a=[0:90:270])rotate([0,0,a])translate([16,16,0])cylinder(d=2.9,h=5,center=true,$fn=20);
                for(a=[0:90:270])rotate([0,0,a])translate([20,20,0])rotate([0,90,0])chamfer(2,10);
    }

}
module mount(){
    translate([-2,-2,-4])difference(){
    cube([20,14,14,]);
        translate([2,2,4])difference(){cube([20,14,14]);rotate([0,90,0])chamfer(2,30);}
        translate([7.5,7.5,0])cylinder(d=3.4,h=10,center=true,$fn=20);
        rotate([0,0,-45])translate([-10,15,-1])cube([30,10,20]);
    }
}
translate([0,8,1])base();
translate([0,0,2])rotate([90,0,0])mount();

