function sol = boundarysmooth(a)

global ub
global lb
sol = a;


           ind=find(sol<lb);
           sol(ind)=lb(ind);
           ind=find(sol>ub);
           sol(ind)=ub(ind);