function [xopt, fopt] = BO(optfunc, Xinit, Yinit, Nite)
% -------------------------------------------------------------------------
% function [xopt, fopt] = BO(optfunc, Xinit, Yinit)
%
%  Description
%   This function executes Bayesian optimization (BO)
%
%  Input
%    optfunc  (function) : objective function for optimization
%                            ex) optfunc = @(x) sum(x);
%    Xinit    (N * M)    : input variable matrix
%    Yinit    (N * 1)    : output variable matrix 
%                            corresponding to objective function value
%    Nite     (1 * 1)    : Number of iteration of Bayesian optimization
%  
%  Output
%    xopt     (1 * M)    : input variable optimized by BO
%    fopt     (1 * 1)    : objective function value at xopt
% -------------------------------------------------------------------------

% Initial setting
M          = size(Xinit,2);
X          = Xinit;
Y          = Yinit;
Ncan       = 300;   % 解候補の数
theta_init = unifrnd(0,1,1,M+1);  % MCMCで使用する初期値
Ngen       = 300; % Parameter for MCMC
Nburn      = 500; % Parameter for MCMC
gamma      = 0;   % Parameter for Mutual Information

% Iteration until more than Nite
for ni = 1 : Nite
  
  % 解候補 (Xcan) の生成
  Xcan = lhsdesign(Ncan,M);  % Latin hypercube sampling による乱数生成
                             % Xcan ∈ [0,1] であるため，適宜スケール変換
  % スケール変換 (ついでプロットのためににソートもしてるよ)
  Xcan = sort( 100 * Xcan - 50 );

  % Step1 : hyperparameter の候補値集合を生成
  Theta = MCMC(X,Y,theta_init,Ngen,Nburn);
  
  % Step2 : hyperparameter の候補値集合から mu と sigma を計算
  [mu, sigma] = GP_MCMC(X,Y,Xcan,Theta);
  
  
  % Step3 : 獲得関数の計算および準最適点の探索
  [next_pos, gamma] = MI(mu,sigma,gamma);
  
  % Step4 : 準最適点における評価関数の計算およびデータの格納
  xnew = Xcan(next_pos,:);
  ynew = feval(optfunc,xnew);
  X = [ X; xnew ];
  Y = [ Y; ynew ];
  
  % おまけ：可視化（ここは適宜消してね）
  xplot = -50 : 0.1 : 50;
  yplot  = optfunc(xplot);
  plot(xplot,yplot,'m-.','linewidth',2);
  hold on;
  plot(X,Y,'ro','linewidth',2);
  plot(Xcan,mu,'b','linewidth',1);  % プロットしちゃう
  plot(xnew,ynew,'bo','linewidth',2); % つぎの点もプロットしちゃう
  hold off;
  print('-depsc',['img/img_',num2str(ni),'.eps']); % ついでに保存もしちゃう
  
end

% Bayesian Optimization で最適点を返す
[fopt, opt_pos] = max(Y);
xopt            = X(opt_pos,:);