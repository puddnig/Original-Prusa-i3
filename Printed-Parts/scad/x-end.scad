// PRUSA iteration4
// X end prototype
// GNU GPL v3
// 2018 <puddnig@gmail.com>
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <polyholes.scad>
use <fdmtools.scad>

rod_h=6; //Distance upper x_rod to top of part (bottom here)
rod_distance=45; //distance between x rods
rod_xz_distance=15;
//rod_z_flange=28.5;//Distanze Z-rod to side of part in Y direction

rod_xend_z_distance=1; //Distance between end of x rod to center of z rod in y direction
cube_width=17;
overhang_rear=0;
cube_height=58;

rp_dia=7.8; //Rodpocket
dia_wp=10; //Wastepocket
wp_length_straight=4;
wp_length_taper=3;

belt_offset=3;
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
nut_trap_reinf_height= 32;
nut_reinf_pushback=0.92;
nut_reinf_wall=4.5;
nut_reinf_rotate=20;


nut_outer_corr=correctedRadius(nut_outer,sides(nut_outer));
nut_inner_corr=correctedRadius(nut_inner,sides(nut_inner));

rod_z_flange=nut_offset+correctedRadius(nut_outer,sides(nut_outer));
rp_depth=rod_z_flange-rod_xend_z_distance; //depth of rodpocket


bearing_size = bearing_diameter + 2 * bearing_holder_wall;
cube_depth=overhang_rear+rod_z_flange+bearing_holder_wall+bearing_diameter/2;
bs_d=cube_depth+end_adjust; //depth beltslot
module pushfit_rod() {

    rp_dia_corr=correctedDiameter(rp_dia);
    dia_wp_corr=correctedDiameter(dia_wp);
    rp_h_straight=1+rp_depth-wp_length_straight-wp_length_taper;
    translate ([0,0,-1]) union(){
    cylinder (h=rp_h_straight, d=rp_dia_corr);
    translate (v=[0,0,rp_h_straight]) cylinder(h=wp_length_taper, d1=2*correctedRadius(rp_dia/2,sides(dia_wp_corr)), d2=dia_wp_corr);
    translate (v=[0,0,rp_h_straight+wp_length_taper]) cylinder (h=wp_length_straight, d=dia_wp_corr);
    translate (v=[1.416,0,0]) rotate (a=[0,0,22.5]) cylinder (h=rp_depth, d=0.8*rp_dia, $fn=8);
    }
}





module window(){
    h3=cube_height-rod_distance-rod_h;
    translate ([-2,-4+rp_depth,-h3+cube_height])cube (size=[4,4,h3+1]);
}

module belt_cutout(bs_ww){
    module cubec(){
        cube(size = [bs_ww,bs_d+1,bs_h], center = true);}
    translate(v=[0,bs_d/2-0.5,bs_h/2])
    {
        difference()
        {
        cubec();
        // Nice edges
        mout=5-(bs_ww/2);
        translate(v=[-bs_ww/2+mout,0,23]) rotate([0,20,0]) cubec();
        translate(v=[bs_ww/2-mout,0,23]) rotate([0,-20,0]) cubec();
        translate(v=[bs_ww/2-5-mout,0,-23]) rotate([0,45,0]) cubec();
        translate(v=[-bs_ww/2+5+mout,0,-23]) rotate([0,-45,0]) cubec();

        }
    }}
        
module stress_relieve(){
    
    }
 module bigcube(){
     translate (v=[-cube_width/2,0,0]) cube([cube_width,cube_depth,cube_height]);
 }
 module bigcube_pretty1(){
     module center(){translate ([0,0,-cube_height/2])bigcube();} 
     module rotate1(alpha) {rotate ([0,alpha,0]) scale ([1,1.1,1])center();}
     translate([cube_width/1.3,-0.01,5]) rotate1(20);
     translate([cube_width/1.3,-0.01,cube_height-5]) rotate1(-20);
 }
module bigcube_pretty2(){
     difference(){
            translate([belt_offset,0,0]) bigcube();
            translate([belt_offset,0,0]) bigcube_pretty1();

            }}


module vertical_bearing_base()
{
 translate ([-rod_xz_distance+cube_width/2,-bearing_size/2,0])cube([rod_xz_distance-cube_width/2,bearing_size,cube_height]);
 cylinder(h = 58, r=bearing_size/2, $fn = 90);
}

module vertical_bearing_holes()
{
    
    
  translate(v=[0,0,-1]) poly_cylinder(h = cube_height+4, r=(bearing_diameter/2));
  translate(v=[0,0,-0.1]) cylinder(r1=(bearing_diameter/2)+0.7,r2=(bearing_diameter/2), h=0.5);
  rotate(a=[0,0,-40]) translate(v=[bearing_diameter/2-2.9,-0.5,0.5]) cube(size = [bearing_holder_wall*2,1,cube_height+4]);

}

module nut_cylinder(h){
        cylinder(h = h, r=nut_outer_corr, $fn=sides(nut_outer));
        
    }
    
module nut_reinf(){
    module nut_reinf_add(){
         translate([0,0,nut_height]) nut_cylinder(nut_trap_reinf_height);   
        rotate([0,0,-135]) translate([-nut_outer_corr,0,nut_height])cube([nut_reinf_wall,nut_outer_corr,nut_trap_reinf_height]);
    }
    
    module nut_reinf_rem(){
         translate([0,0,nut_height-0.001]) cylinder(r=nut_outer_corr-nut_reinf_wall,h=nut_trap_reinf_height+0.01);
        rotate([0,0,-135])  translate([-nut_outer_corr+nut_reinf_wall,0,nut_height+0.001]) cube([2*(nut_outer_corr-nut_reinf_wall),nut_outer_corr,nut_trap_reinf_height]);  
        translate([0,nut_outer_corr,nut_trap_reinf_height+nut_height]) rotate ([0,90,nut_reinf_rotate])linear_extrude(height=3*nut_outer_corr,center=true)scale([nut_trap_reinf_height/nut_outer_corr,nut_reinf_pushback]) circle(r=nut_outer_corr);
    }
    difference(){
        nut_reinf_add();
        nut_reinf_rem();}
}
module nut_trap()
{

    //Nut trap
    // Cylinder
    
    nut_cylinder(nut_height);
    rotate([0,0,-135])  translate([-nut_outer_corr,0,0]) cube([2*nut_outer_corr,nut_outer_corr,nut_height]);
    
    
    
    

}
    module nut_trap_cutout()
{
 
   // Hole for the nut
    translate(v=[0,0, -1]) poly_cylinder(h = nut_height+1.01, r = nut_inner, $fn = 25);
    translate(v=[0,0, -0.1]) cylinder(h = 0.5, r1 = 1.085*nut_inner, r = nut_inner, $fn = 25);

// Screw holes for TR nut
    translate([0, 9.5, -1]) cylinder(h = 10, r = 1.8, $fn=25);
    translate([0, -9.5, -1]) cylinder(h = 8, r = 1.8, $fn=25);

// Nut traps for TR nut screws
    translate([0, bolt_distance_nut/2, 4]) cylinder(h = 10, r = 3.45, $fn=6);

    translate([0, -bolt_distance_nut/2, 4]) rotate([0,0, 30]) cylinder(h = 3, r = 3.2, $fn=6);
    
    translate([0,- bolt_distance_nut/2+5.5,4]) cylinder(h=3, r=5,$fn=6);

}
module x_interface(){
difference() {
    union(){
    bigcube();
       bigcube_pretty2();
        translate ([rod_xz_distance,rod_z_flange-nut_offset,0]) rotate ([0,0,-135])nut_reinf();
        }
     translate([belt_offset,0,bs_to_top])belt_cutout(bs_w);
    
    window();
    translate ([-cube_width+0.001,-1,0]) scale ([1,2,1])bigcube_pretty2();
    
    }
}



module x_end(){
    difference(){
        union() {
            translate([-rod_xz_distance,-rod_z_flange,0])     x_interface();
            vertical_bearing_base();
            translate ([0,-17,0]) rotate ([0,0,-135]) nut_trap();
            

        }
       // translate([belt_offset-rod_xz_distance,- rod_z_flange,bs_to_top])belt_cutout();
        vertical_bearing_holes();
        translate ([0,-17,0]) rotate ([0,0,-135]) nut_trap_cutout();
        translate (v=[-rod_xz_distance,-rod_z_flange,rod_h])rotate    ([-90    ,-90,0]) pushfit_rod();
        translate (v=[-rod_xz_distance,-rod_z_flange,rod_h+rod_distance     ])rotate ([-90,-90,0]) pushfit_rod();
        translate([belt_offset-rod_xz_distance,-rod_z_flange,bs_to_top])belt_cutout(bs_w-2*bearing_reinforcement);
        
    }
}


module selective_infill(){
    intersection(){
        x_end();
        translate([0,-nut_offset,-0.2])infill_cylinder(2*nut_outer_corr-0.4,2*     nut_inner_corr, nut_height);
    }
}

x_end();
//selective_infill();
