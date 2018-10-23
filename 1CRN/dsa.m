pp = zeros(1,18);
load ABC.mat
pp(1,1) = mean(abc(:,5000));
pp(1,2) = std(abc(:,5000));
pp(1,3) = max(timer);


load Gbest.mat
pp(1,4) = mean(gabc(:,5000));
pp(1,5) = std(gabc(:,5000));
pp(1,6) = max(timer);


load CABC.mat
pp(1,7) = mean(cabc(:,5000));
pp(1,8) = std(cabc(:,5000));
pp(1,9) = mean(timer);


load IABC.mat
pp(1,10) = mean(iabc(:,5000));
pp(1,11) = std(iabc(:,5000));
pp(1,12) = mean(timer);



load IF.mat
pp(1,13) = mean(ifabc(:,5000));
pp(1,14) = std(ifabc(:,5000));
pp(1,15) = mean(timer);



load BE.mat
pp(1,16) = mean(be(:,5000));
pp(1,17) = std(be(:,5000));
pp(1,18) = min(timer);
