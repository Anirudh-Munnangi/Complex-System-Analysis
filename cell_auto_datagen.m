% Complex systems 
% Home work 2
% Ahmed Sageer
% Anirudh Munnangi
% Chandrasekar Venkatesh
%
% Data Generation
%

cellaut = zeros(30:30);
ind = randi(899,10000,1);
popsize = 50;
c = 0;
for i = 1:16
    c = 0;
    while c<popsize
        curind = ind(1);
        x = fix(curind/30);
        y = curind - x*30;
        if cellaut(x+1,y+1) == 0
            cellaut(x+1,y+1) = i;
            c = c + 1;
        end
        ind(1) = [];
    end
end
csvwrite('E:\matlab assignments\Complex systems\HW2\inp16.csv',cellaut);        
