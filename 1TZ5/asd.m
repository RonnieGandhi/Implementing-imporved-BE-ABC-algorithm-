chrom = GlobalParams;
warning off
n = length(sequence);
dim = 2*n - 5;  
array = zeros(1,n);

array(1,2:(n+1)) = chrom(1,1:n);
beta(1,3:(n-1)) = chrom(1,(n-1):(2*n-5));
position(1,1:3) = [0,0,0];
position(2,1:3) = [0,1,0];
position(3,1:3) = [cosd(array(1,2)),1 + sind(array(1,2)),0];
for j = 4:n
    ax = position((j-1),1);
    ay = position((j-1),2);
    az = position((j-1),3);
    position(j,1:3) = [ax + cosd(array(j-1)).* cosd(beta(j-1)), ay + sind(array(j-1)).* cosd(beta(j-1)), az + sind(beta(j-1))];
end

lz=position(:,3);
ly=position(:,2);
lx=position(:,1);
line(lx,ly,lz,'LineWidth',3,'Color',[255,1,1]./255)
grid on
hold on
temp = find(sequence == 1);
RR = 0.3;
for i = 1:length(temp)
    II = temp(i);
    [xxxx,yx,zx] = ellipsoid(lx(II),ly(II),lz(II),RR,RR,RR,90);  
    surf(xxxx,yx,zx)
    colormap([1 200/255 227/255])
    freezeColors
end



temp = find(sequence == 0);

for i = 1:length(temp)
    II = temp(i);
    [xxxx,yx,zx] = ellipsoid(lx(II),ly(II),lz(II),RR,RR,RR,90);  
    surf(xxxx,yx,zx)
    colormap([0 0.2 0.4])
    freezeColors
end



axis equal
shading flat
axis([min(position(:,1))-1,max(position(:,1))+1,min(position(:,2)),max(position(:,2))+1,min(position(:,3))-1,max(position(:,1))+1])
axis off
box off