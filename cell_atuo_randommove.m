% Complex systems 
% Home work 2
% Ahmed Sageer
% Anirudh Munnangi
% Chandrasekar Venkatesh
%
% Random Move
% %
% 
 inp = csvread('inp2.csv');
 maxepoch=100;

mat = inp;
happy = [];
meanhp = [];
stdev = [];
A = 1:900;
for epochs = 1:maxepoch        % number of epochs
    ranind = A(randperm(length(A)));     %order of traversal of this epoch
    happy = [];
    for p = 1:900         % traverse matrix
        j = fix(ranind(p)/30);                         % get y of point
        i = ranind(p) - j*30;                          % get x of point
        j = j + 1;
        if(i == 0)
            i = 30;
            j = j - 1;
        end
        if (mat(i,j) ~= 0)
            %%% find all zero value indices
            nonzeroinds = find(mat);
            zeroinds = find(mat < 1);
%             ctr = 1;
%             for k = 1:900
%                 if(k == nonzeroinds(ctr))
%                     ctr = ctr + 1;
%                 else 
%                 zeroinds(end+1) = k;
%                 end
%             end
            %%% we now have all zero value indices, lets calculate
            %%% happiness function
            cp = mat(i,j);  % cp - current point class
            hp = 0;         % happiness value
            x1 =  i - 1;
            x2 = i;
            x3 = i + 1;
            y1 = j - 1;
            y2 = j;
            y3 = j + 1;
            %%%% rorunding edges and corners
            if (i == 1)
                x1 = 30;
            end
            if (i == 30)
                x3 = 1;
            end
            if (j == 1)
                y1 = 30;
            end 
            if (j == 30)
                y3 = 1;
            end
            %%%%% happiness function check
            if (mat(x1,y1) == cp)
                hp = hp + 1;
            end
            if (mat(x1,y2) == cp)
                hp = hp + 1;
            end
            if (mat(x1,y3) == cp)
                hp = hp + 1;
            end
            if (mat(x2,y1) == cp)
                hp = hp + 1;
            end
            if (mat(x2,y3) == cp)
                hp = hp + 1;
            end
            if (mat(x3,y1) == cp)
                hp = hp + 1;
            end
            if (mat(x3,y2) == cp)
                hp = hp + 1;
            end
            if (mat(x3,y3) == cp)
                hp = hp + 1;
            end
            happy(end+1) = hp;
            %%% we now have the happiness value of the cell, now have to
            %%% check and move if necessary
            if (hp < 5)
                newloc = zeroinds(randi(length(zeroinds)));     % new location from zero value matrix
                nly = fix(newloc/30);                           % new y point
                nlx = newloc - nly*30;                          %new x point
                nly = nly + 1;
                if (nlx == 0)
                    nlx = 30;
                    nly = nly - 1;
%                 else
%                     nlx = nlx + 1;
                end
                %%% we have the new location, now swap
                if ( mat(nlx,nly) == 0)
                    mat(nlx,nly) = cp;
                    mat(i,j) = 0;
                end
            end
            %%% end of check and move
        end
        %%% end of point, move to next point
    end
    meanhp(end+1) = mean(happy(1:end));
    stdev(end+1) = std(happy(1:end));
    %%% end of epochs
end
% errorbar(meanhp,stdev);
%res = inp - mat;
