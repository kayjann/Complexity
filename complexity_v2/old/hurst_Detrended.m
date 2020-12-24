function hh = hurst_Detrended(x,d,fontsize);
%DFA [H,pval95,p]
%   Calculate the Hurst exponent using DFA analysis.
%   H = DFA(X) calculates the Hurst exponent of time series X using 
%   Detrended Fluctuation Analysis (DFA). If a vector of increasing natural 
%   numbers is given as the second input parameter, i.e. DFA(X,D), then it 
%   defines the box sizes that the sample is divided into (the values in D 
%   have to be divisors of the length of series X). If D is a scalar 
%   (default value D = 10) it is treated as the smallest box size that the 
%   sample can be divided into. In this case the optimal sample size OptN 
%   and the vector of divisors for this size are automatically computed. 
%   OptN is defined as the length that possesses the most divisors among 
%   series shorter than X by no more than 1%. The input series X is 
%   truncated at the OptN-th value. 
%   [H,PV95] = DFA(X) returns the empirical 95% confidence intervals PV95  
%   (see [2]).
%   [H,PV95,P] = DFA(X) returns the average standard deviations P of the 
%   detrended walk for all the divisors.
%
%   If there are no output parameters, the DFA statistics is automatically 
%   plotted against the divisors on a loglog paper and the results of the 
%   analysis are displayed in the command window. DFA(X,D,FONTSIZE) allows 
%   to specify a fontsize different than 14 in the plotted figure.
%
%  

x = double(x(:)');

if nargin<3, 
    fontsize = 14; 
end;
if nargin<2, 
    d = 10; 
end;
if max(size(d)) == 1, 
    % For scalar d set dmin=d and find the 'optimal' vector d
    dmin = d;
    % Find such a natural number OptN that possesses the largest number of 
    % divisors among all natural numbers in the interval [0.99*N,N] 
    N = length(x); 
    N0 = floor(0.99*N);
    dv = zeros(N-N0+1,1);
    for i = N0:N,
        dv(i-N0+1) = length(divisors(i,dmin));
    end
    OptN = N0 + max(find(max(dv)==dv)) - 1;
    % Use the first OptN values of x for further analysis
    x = x(1:OptN);
    % Find the divisors of x
    d = divisors(OptN,dmin);
else
    OptN = length(x);
end

% Construct a 'random walk' out of the return time series x and calculate
% the root mean square fluctuation (i.e. standard deviation) of the 
% integrated and detrended time series (see p.288 in [2])
p = zeros(length(d),1);
y = cumsum(x);
for i = 1:length(d)
   p(i) = RMSfluctuation(y,d(i));
end

% Compute the Hurst exponent as the slope on a loglog scale
pp = polyfit(log10(d),log10(p),1);
hh = [pp(1),1];
[s,err]=sprintf('Hurst exponent = %.2f',hh(1));disp(s);
% Compute empirical confidence intervals (see [2])
L = log2(OptN);
if dmin > 50,
    % DFA (min(divisor)>50) two-sided empirical confidence intervals
    pval95 = [0.5-exp(-2.93*log(L)+4.45) exp(-3.10*log(L)+4.77)+0.5];
    C = [   0.5-exp(-2.99*log(L)+4.45) exp(-3.09*log(L)+4.57)+0.5 .90];
    C = [C; pval95                                                .95];
    C = [C; 0.5-exp(-2.67*log(L)+4.06) exp(-3.19*log(L)+5.28)+0.5 .99];
else  
    % DFA (min(divisor)>10) two-sided empirical confidence intervals
    pval95 = [0.5-exp(-2.33*log(L)+3.25) exp(-2.46*log(L)+3.38)+0.5];
    C = [   0.5-exp(-2.33*log(L)+3.09) exp(-2.44*log(L)+3.13)+0.5 .90];
    C = [C; pval95                                                .95];
    C = [C; 0.5-exp(-2.20*log(L)+3.18) exp(-2.45*log(L)+3.62)+0.5 .99];
end

% Display and plot results if no output arguments are specified
% if nargout < 1,
%     % Display results
%     disp('---------------------------------------------------------------')
%     disp(['DFA using ' num2str(length(d)) ' divisors (' num2str(d(1)) ',...,' num2str(d(length(d))) ...
%         ') for a sample of ' num2str(OptN) ' values'])
%     disp(['Theoretical Hurst exponent              ' num2str(0.5,4)])
%     disp(['Empirical Hurst exponent                ' num2str(H,4)])
%     disp('---------------------------------------------------------------')
% 
%     % Display empirical confidence intervals
%     if dmin > 50,
%         disp('DFA (min(divisor)>50) two-sided empirical confidence intervals')
%     else      
%         disp('DFA (min(divisor)>10) two-sided empirical confidence intervals')
%     end
%     disp('--- conf_lo   conf_hi   level ---------------------------------')
%     disp(C)
%     disp('---------------------------------------------------------------')

    % Plot DFA
 %   h2 = plot(log10(d),log10((d.^(0.5))/(d(1)^(0.5)/p(1))),'b-');
  %  if fontsize>10, 
   %     set(h2,'linewidth',2); 
  %  end;
  %  hold on
  %  h1 = plot(log10(d),log10(p),'ro-');
   % if fontsize>10, 
    %    set(h1,'linewidth',2); 
   % end;
   % hold off
   % set(gca,'Box','on','fontsize',fontsize);
   % xlabel('log_{10}n','fontsize',fontsize);
   % ylabel('log_{10}DFA','fontsize',fontsize);
  %  legend('Theoretical','Empirical')
end

function d = divisors(n,n0)
% Find all divisors of the natural number N greater or equal to N0
i = n0:floor(n/2);
d = find((n./i)==floor(n./i))' + n0 - 1;
end
function m = RMSfluctuation(x,d)
% Calculate the root mean square fluctuation
n = length(x)/d;
X = reshape(x,d,n);
Y = X;
t = (1:d)';
for i = 1:n,
    p = polyfit(t,X(:,i),1);
    Y(:,i) = X(:,i) - t*p(1) - p(2);
end
m = mean(std(Y));
end