function s = lempel_ziv_complexity(x)
M=mean(x);
S=x;
n=length(S);
S(S<M)=0;
S(S>=M)=1;
i=0;
C=1;
u=1;
v=1;
vmax=v;
while u+v<=n
    if S(i+v) == S(u+v)
        v=v+1;
    else
        vmax=max([v,vmax]);
        i=i+1;
        if i==u
            C=C+1;
            u=u+vmax;
            v=1;
            i=0;
            vmax=v;
        else
            v=1;
        end
        
    end
end
if v~=1
    C=C+1;
end
s=[C 0];