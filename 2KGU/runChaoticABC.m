clear all
close all
clc

global sequence
sequence = [1 0 1 1 0 0 1 1 1 1 1 0 0 1 0 0];


D = size(sequence,2)*2 - 5;
maxCycle = 5000; 
runtime = 15;




NP = 26;
FoodNumber=NP/2; 
GlobalMins=zeros(1,runtime);
ObjVal = zeros(FoodNumber,1);
Fitness = ObjVal;
trial=zeros(1,FoodNumber);
ObjValSol=ObjVal;
FitnessSol = ObjVal;
labc=zeros(runtime,maxCycle);
qq=zeros(1,maxCycle);


for r=1:runtime
tic


ub = ones(1,D)*180;
lb = ones(1,D).*-180;
Range = repmat((ub-lb),[FoodNumber 1]);
Lower = repmat(lb, [FoodNumber 1]);
Foods = rand(FoodNumber,D) .* Range + Lower;


for ky = 1:FoodNumber
    ObjVal(ky,1) = libai(Foods(ky,:));
    Fitness(ky,1) = calculateFitness(ObjVal(ky,1));
end

trial=zeros(1,FoodNumber);

BestInd=find(ObjVal==min(ObjVal));
BestInd=BestInd(end);
GlobalMin=ObjVal(BestInd);
GlobalParams=Foods(BestInd,:);

iter=1;
while ((iter <= maxCycle)),

    for i=1:(FoodNumber)
            Param2Change=fix(rand*D)+1;
            neighbour=fix(rand*(FoodNumber))+1;
            while(neighbour==i)
                neighbour=fix(rand*(FoodNumber))+1;
            end;
            sol=Foods(i,:);
            sol(Param2Change)=Foods(i,Param2Change)+(Foods(i,Param2Change)-Foods(neighbour,Param2Change))*(rand-0.5)*2;
            ind=find(sol<lb);
            sol(ind)=lb(ind);
            ind=find(sol>ub);
            sol(ind)=ub(ind);
            ObjValSol = libai(sol);
            FitnessSol = calculateFitness(ObjValSol);
            if (FitnessSol>Fitness(i))
                Foods(i,:)=sol;
                Fitness(i)=FitnessSol;
                ObjVal(i)=ObjValSol;
                trial(i) = 1;
            else
                trial(i) = trial(i) + 1;
            end;     
    end;


    prob = Fitness./max(Fitness);
    i=1;
    t=0;
    for t = 1:FoodNumber
        if(rand < prob(i))
            Param2Change=fix(rand*D)+1;
            neighbour=fix(rand*(FoodNumber))+1; 
            while(neighbour==i)
                neighbour=fix(rand*(FoodNumber))+1;
            end; 
            sol=Foods(i,:);
            sol(Param2Change)=Foods(i,Param2Change)+(Foods(i,Param2Change)-Foods(neighbour,Param2Change))*(rand-0.5)*2;
            ind=find(sol<lb);
            sol(ind)=lb(ind);
            ind=find(sol>ub);
            sol(ind)=ub(ind);
            ObjValSol = libai(sol);
            FitnessSol = calculateFitness(ObjValSol);
        
            if (FitnessSol>Fitness(i)) 
                Foods(i,:)=sol;
                Fitness(i)=FitnessSol;
                ObjVal(i)=ObjValSol;
                trial(i) = 1;
            else
                trial(i) = trial(i)+1; 
            end;
        end;
        i=i+1;
        if (i==(FoodNumber)+1) 
            i=1;
        end;  
    end;
    
    for ind = 1 : FoodNumber
        sol = Foods(ind,:);
        inv_sol = (sol - lb)./(ub - lb);
        inv_sol = upadte_chatoic(inv_sol);
        sol = inv_sol.*(ub - lb) + lb;
        
        ObjValSol = libai(sol);
        FitnessSol = calculateFitness(ObjValSol);
        
        if (FitnessSol > Fitness(i)) 
        	Foods(i,:) = sol;
        	Fitness(i) = FitnessSol;
        	ObjVal(i) = ObjValSol;
        end
    end
    
    
    ind = find(ObjVal == min(ObjVal));
    ind=ind(end);
    if (ObjVal(ind)<GlobalMin)
        GlobalMin=ObjVal(ind);
        GlobalParams=Foods(ind,:);
    end;

    
    %fprintf('iter=%d ObjVal=%f\n',iter,GlobalMin);
    cabc(r, iter) = GlobalMin;
    iter = iter+1;
end % End of ABC

timer(r) = toc;
save CABC
end; %end of runs






