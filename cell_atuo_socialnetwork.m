% Complex systems 
% Home work 2
% Ahmed Sageer
% Anirudh Munnangi
% Chandrasekar Venkatesh
%
% Random Move
%

% maxepoch=1000;
% inp = csvread('inp10.csv');

numoffriends = 10;
neighbourhood = 5;
mat = inp;
happy = [];
meanhp = [];
stdev = [];
A = 1:900;
nh = fix(neighbourhood/2);
for epochs = 1:maxepoch       % number of epochs
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
                %%% form the friends array
                happypos = [];          %%% will keep track of all happy neighbours of friends
                hpctr = 1;
                friends = [];
                for fr = 1:numoffriends
                    friends(end+1) = nonzeroinds(randi(length(nonzeroinds)));
                end
                %%% Traverse friends array and find happiest location close
                %%% to each friend
                for fr = 1:length(friends)
                    %%% setp 1 - find firend's x,y coord
                    fj = fix(friends(fr)/30);                         % get y of point
                    fi = friends(fr) - fj*30;                          % get x of point
                    fj = fj + 1;
                    if(fi == 0)
                        fi = 30;
                        fj = fj - 1;
                    end
                    %%% we have x,y; now find happiest position in
                    %%% surrounding cells
                    %%% Identify neighbours
                    frx = []; fry = [];
                    for fr2 = (-nh):(nh)
                        frx(end + 1) = fi + fr2;
                        fry(end + 1) = fj + fr2;
                        if(frx(end) > 30)
                            frx(end) = frx(end) -30;
                        end
                        if(fry(end) > 30)
                            fry(end) = fry(end) -30;
                        end
                        if(frx(end) < 1)
                            frx(end) = frx(end) +30;
                        end
                        if(fry(end) < 1)
                            fry(end) = fry(end) +30;
                        end
                    end
                    %happytrack = 0;
                    for fr2 = 1:length(frx)
                        %%% happiness check
                        frx1 =  frx(fr2) - 1;
                        frx2 = frx(fr2);
                        frx3 = frx(fr2) + 1;
                        fry1 = fry(fr2) - 1;
                        fry2 = fry(fr2);
                        fry3 = fry(fr2) + 1;
                        %%%% rorunding edges and corners
                        if (frx(fr2) == 1)
                            frx1 = 30;
                        end
                        if (frx(fr2) == 30)
                            frx3 = 1;
                        end
                        if (fry(fr2) == 1)
                            fry1 = 30;
                        end
                        if (fry(fr2) == 30)
                            fry3 = 1;
                        end
                        %%%%% happiness function check
                        hc = 0;
                        if (mat(frx1,fry1) == cp)
                            hc = hc + 1;
                        end
                        if (mat(frx1,fry2) == cp)
                            hc = hc + 1;
                        end
                        if (mat(frx1,fry3) == cp)
                            hc = hc + 1;
                        end
                        if (mat(frx2,fry1) == cp)
                            hc = hc + 1;
                        end
                        if (mat(frx2,fry3) == cp)
                            hc = hc + 1;
                        end
                        if (mat(frx3,fry1) == cp)
                            hc = hc + 1;
                        end
                        if (mat(frx3,fry2) == cp)
                            hc = hc + 1;
                        end
                        if (mat(frx3,fry3) == cp)
                            hc = hc + 1;
                        end
                        if (hc > 4)
                            happypos(hpctr,1) = hc;
                            happypos(hpctr,2) = frx(fr2);
                            happypos(hpctr,3) = fry(fr2);
                            hpctr = hpctr + 1;
                        end
                    end
                end
                %%% decide new location
                if (hpctr == 1)
                    newloc = zeroinds(randi(length(zeroinds)));     % new location from zero value matrix
                    nly = fix(newloc/30);                           % new y point
                    nlx = newloc - nly*30;                          %new x point
                    nly = nly + 1;
                    if (nlx == 0)
                        nlx = 30;
                        nly = nly - 1;
                    end
                else
                    %%% chose a random happy position
                    newloc = abs(randi(hpctr-1));
                    nlx = happypos(newloc,2);
                    nly = happypos(newloc,3);
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
