% function []=Lfrac(variables,start,rules,angle,iteration)

variables = 'X Y F'; 
start = 'FX'; 
rules = 'X+YF+ -FX-Y F';
angle = 1/2*pi; 
iteration = 10; 

% input arguments
var = strsplit(variables);
s = start;
r = strsplit(rules);
a = angle;
it = iteration;

varrep = cell(1,length(var));
for k = 1:length(varrep)
    varrep{k}=num2str(k-1);
end
str = s;
for k = 2:it
    for kk = 1:length(var)
        str=strrep(str,var{kk},varrep{kk});
    end
    for kk=1:length(varrep)
        str=strrep(str,varrep{kk},r{kk});
    end
end

h=1; A=eps; pos=1; Ap=zeros(length(str(str==']')),2); p=1;
pat = zeros(1,length(str(isletter(str)))+1+length(str(str==']'))*2);
for k = 1:length(str)
    if isletter(str(k))
        pat(pos+1) = pat(pos)+h*exp(1i*A);
        pos = pos+1;
    else
        switch str(k)
            case '+'
                A = A+a;
            case '-'
                A = A-a;
            case '['
                Ap(p,:) = [A,pos]; 
                p = p+1;
            case ']'
                p = p-1;
                A = Ap(p,1);
                pat(pos+1) = nan; pos=pos+1;
                pat(pos+1) = pat(Ap(p,2)); pos=pos+1;
        end
    end
end
plot(pat)
axis equal;axis off

% end