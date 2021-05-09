%% test of benchmark function: schwefel_222 
schwefel_222 = @(x) sum(abs(x))+prod(abs(x));   %   benchmar function
%%  
n = 50; % population size
T = 1000;   % maximum iteration
S = 10; % independent run times
%%
d = 30; % dimension
lmt = ones(d,1)*[-32,32];   % constraints
[fbst_50d, xbst_50d, performance_50d] = hho( schwefel_222, d, lmt, n, T, S);
%%
d = 2; % dimension
lmt = ones(d,1)*[-32,32];   % constraints
[fbst_2d, xbst_2d, performance_2d] = hho( schwefel_222, d, lmt, n, T, S);