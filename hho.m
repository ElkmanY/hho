function [fbst, xbst, performance] = hho( objective, d, lmt, n, T, S)
%Harris hawks optimization algorithm
% inputs: 
%   objective - function handle, the objective function
%   d - scalar, dimension of the optimization problem
%   lmt - d-by-2 matrix, lower and upper constraints of the decision varable
%   n - scalar, swarm size
%   T - scalar, maximum iteration
%   S - scalar, times of independent runs
% data: 2021-05-09
% author: elkman, github.com/ElkmanY/
%% Levy flight
beta = 1.5;
sigma = ( gamma(1+beta)*sin(pi*beta/2)/gamma((1+beta)/2)*beta*2^((beta-1)/2) ).^(1/beta);
Levy = @(x) 0.01*normrnd(0,1,d,x)*sigma./abs(normrnd(0,1,d,x)).^(1/beta);
%% algorithm procedure
tic;
for s = 1:S
    %%  Initialization
    X = lmt(:,1) + (lmt(:,2) - lmt(:,1)).*rand(d,n);
    for t = 1:T
        F = objective(X);
        [f_rabbit(s,t), i_rabbit] = min(F);
        x_rabbit(:,t,s) = X(:,i_rabbit);
        xr = x_rabbit(:,t,s);
        J = 2*(1-rand(d,1));
        E0 = 2*rand(1,n)-1;
        E(t,:) = 2*E0*(1-t/T);
        
        absE = abs(E(t));
        p1 = absE>=1;   %eq(1)
        r = rand(1,n);
        p2 = (r>=0.5) & (absE>=0.5) & (absE<1); %eq(4)
        p3 = (r>=0.5) & (absE<0.5);  %eq(6)
        p4 = (r<0.5) & (absE>=0.5) & (absE<1); %eq(10)
        p5 = (r<0.5) & (absE<0.5); %eq(11)
        %% update locations 
        rh = randi([1,n],1,n);
        flag1 = rand(1,n)>=0.5;
        Y = xr - E(t,:).*abs( J.*xr - X );
        Z = Y + rand(d,n).*Levy(n);
        flag2 = (objective(Y)<objective(Z)) & (objective(Y)<F);
        flag3 = (objective(Y)>objective(Z)) & (objective(Z)<F);
        flag4 = (~flag2) & (~flag3);
        X_ =    p1.*(   (X(:,rh) - rand(1,n).*abs( X(:,rh) - 2*rand(1,n).*X )).*flag1 +...
            ((X(:,rh) - mean(X)) - rand(1,n).*( lmt(:,1) + (lmt(:,2) - lmt(:,1)).*rand(d,n) )).*(~flag1)   )...
            +   p2.*(   xr - X - E(t,:).*abs( J.*xr - X )   )...
            +   p3.*(   xr - E(t,:).*abs( xr - X )   )...
            +   p4.*(   Y.*flag2 + Z.*flag3 + ( lmt(:,1) + (lmt(:,2) - lmt(:,1)).*rand(d,n) ).*flag4  )...
            +   p5.*(   Y.*flag2 + Z.*flag3 + ( lmt(:,1) + (lmt(:,2) - lmt(:,1)).*rand(d,n) ).*flag4  );
        X_(:,i_rabbit) = xr;
        X = X_;
    end
end
%% Êä³ö-outputs
performance = [min(f_rabbit(:,T));mean(f_rabbit(:,T));std(f_rabbit(:,T))];
timecost = toc;
[fbst, ibst] = min(f_rabbit(:,T));
xbst = x_rabbit(:,T,ibst);
%% »æÍ¼-plot data
% Convergence Curve
figure('Name','Convergence Curve');
box on
semilogy(1:T,mean(f_rabbit,1),'b','LineWidth',1.5);
xlabel('Iteration','FontName','Aril');
ylabel('Fitness/Score','FontName','Aril');
title('Convergence Curve','FontName','Aril');

if d == 2
    % Trajectory of Global Optimal
    figure('Name','Trajectory of Global Optimal');
    x1 = linspace(lmt(1,1),lmt(1,2));
    x2 = linspace(lmt(2,1),lmt(2,2));
    [X1,X2] = meshgrid(x1,x2);
    V = reshape(objective([X1(:),X2(:)]'),[size(X1,1),size(X1,1)]);
    contour(X1,X2,log10(V),100); % notice log10(V)
    hold on
    plot(x_rabbit(1,:,1),x_rabbit(2,:,1),'r-x','LineWidth',1);
    hold off
    xlabel('\it{x}_1','FontName','Time New Roman');
    ylabel('\it{x}_2','FontName','Time New Roman');
    title('Trajectory of Global Optimal','FontName','Aril');
end
end
