function s = permutation_entropy(x, order, delay, normalize)
x=x(:)';
x=x(randperm(length(x)));
N=length(x);
Y=zeros(order, N-(order-1)*delay);
hash_mult=(ones(order)*order);
hash_mult=power(hash_mult,[0:order-1]);
hash_mult=hash_mult(1,:);
for i=1:order
    Y(i,:)=x(i*delay:i*delay+size(Y,2)-1);
end;
for i=1:size(Y,2)
    [out, idx]=sort(Y(:,i));
    Y(:,i)=idx;
end
%Y=Y';
hashval=hash_mult*Y;
[cnt_unique, unique_a] = hist(hashval,unique(hashval));
p=cnt_unique/sum(cnt_unique);
pe=sum(-(p*log2(p)'));

if normalize==1
    pe=pe/log2(factorial(order));

end
s=[pe, 0];