function s = higuchi_fractal_dimension(u, k_max)
% Function to compute Higuchi Fractal Dimension for a time series
% Inputs:
% - m : window length (scalar)
% - r : regularity (scalar)
% - u : first time series (a 1D row vector)
% - v : second time series (a 1D row vector)
% Example: hfd=higuchi_fractal_dimension(1,0.2,u,v);

u = double(u(:)');
%u=u(randperm(length(u)));
N = length(u);
if k_max+1>N
    error('Segment size cannot be larger than series length');
end
Lmk=zeros(k_max,k_max);
for k=1:k_max,
    for m=1:k_max,
        tmp_sum=0;
        for i=1:fix((N-m)/k),
            tmp_sum=tmp_sum+abs(u(m+i*k)-u(m+(i-1)*k));
        end;
        Lm=(1/k)*tmp_sum*(N-1)/(fix((N-m)/k)*k);
        Lmk(m,k)=Lm;
    end;
end;
Lk=zeros(1,k_max);
for k=1:k_max,
    Lk(1,k)=sum(Lmk(1:k,k))/k;
end;
ln_lk=log(Lk);
range=[1:k_max];
ln_k=log(1./range);
res=polyfit(ln_k,ln_lk,1);
s=[res(1) Lk];