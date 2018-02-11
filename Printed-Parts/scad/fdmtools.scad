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
    
infill_cylinder(21,14,10);
    
//infill_cube(16,10,10);    
