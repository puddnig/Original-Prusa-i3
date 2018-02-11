// GNU GPL v3
// 2018 <puddnig@gmail.com>


use <polyholes.scad>

infill_width=0.2;
infill_distance=0.9;

function nfills(x1,x2)=floor((x1-x2)/infill_distance);
function xdiff(x1,x2)=(x1-x2)-(nfills(x1,x2)-1)*infill_distance-infill_width;
module hollow_cube(y,z){
    cube([infill_width,y,z]);
}

module infill_cube(x,y,z){
    for (a=[0:infill_distance:nfills(x,0)*infill_distance-0.0001]) 
    translate(v=[a+xdiff(x,0)/2,infill_width,infill_width] )hollow_cube(y-2*infill_width,z-2*infill_width);
}


module wall_cylinder(dd1,hh){
    difference() {
       
        cylinder (d=dd1+2*infill_width,h=hh, $fn=sides(dd1/2));
        translate ([0,0,-hh/2]) cylinder (d=dd1,h=2*hh, $fn=sides(dd1/2) );
        }
    }
    
module infill_cylinder (dd1,dd2,hh) //dd1>dd2
    {
    rout=dd1/2;
    rin=dd2/2;
    for (a=[rin:infill_distance:nfills(rout,0)*infill_distance-0.0001]) translate([0,0,infill_width])
        wall_cylinder(2*a+xdiff(rout,0)/2,hh-2*infill_width);
    }
    
//infill_cylinder(21,14,10);  
//infill_cube(16,10,10);
module longhole(length,dia,hh){
    cylinder(d=dia,h=hh,$fn=25);
    translate([length,0,0])cylinder(d=dia,h=hh,$fn=25);
    translate([0,-dia/2,0])cube([length,dia,hh]);
}

module longhole_taper(length,dia1,dia2,hh){
    cylinder(d1=dia1,d2=dia2,h=hh,$fn=25);
    translate([length,0,0])cylinder(d1=dia1,d2=dia2,h=hh,$fn=25);
    rotate([90,0,90]) linear_extrude(height=length) polygon( points=[[-dia1/2,0],[dia1/2,0],[dia2/2,hh],[-dia2/2,hh]] );
}

module chamfer(xx,width){
    rotate([45,0,0])cube([width,1.41*xx,1.41*xx],center=true);
}

chamfer(1,10);