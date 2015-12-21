function Theta = MCMC(X,Y,theta_init,Ngen,Nburn)
% -------------------------------------------------------------------------
% function Theta = MCMC(X,y,theta_init,Ninit,Nburn)
%
%  Description
%   This function samples sets of hyperparameters
%    drawn from fiven posterior distribution
%
%  Input
%    X          (N * M)      : input variable matrix
%    Y          (N * 1)      : output variable matrix 
%                                corresponding to objective function value
%    theta_init (1 * M+1)    : initial values of hyperparameters
%    Ngen       (1 * 1)      : Number of generating sets of hyperparameters
%    Nburn      (1 * 1)      : Numver of burning in samples (e.g. Nburn = 1)
%  
%  Output
%    Theta      (Ngen * M+1) : Candidates of hyperparameters
% -------------------------------------------------------------------------

% To define posterior distribution
fpos = @(theta) posterior(theta,X,Y);

% To sample sets of hyperparameters by Slice Sampling
Theta = slicesample(theta_init,Ngen,'pdf',fpos,'thin',1,'burnin',Nburn);


% theta の事後分布
function fpos = posterior(theta_vec,X,y)

% theta_vec = [theta0, theta, m]
%   theta0 ~ logarithm Gaussian distribution
%   theta  ~ uniform distribution [0 10]
%   sigma  ~ normal distribution N(0,0.1)

[~,M] = size(X);

% いまは次元数1で固定とする
theta0 = theta_vec(1);
theta  = theta_vec(2:M+1);
% nu     = theta_vec(M+2);

% カーネルの計算
K = MaternKernel(X,X,theta,theta0);

% 尤度
if det(K) < 1e-10
  p_like = 1e-50;
else
  p_like =  exp( - y' / K * y / 2 ) / sqrt( det(K) );
end

% ハイパーパラメータの事前分布による確率密度関数の計算
% ただし，ハイパーパラメータの確率密度関数は互いに独立であると仮定
p_hyp = lognpdf(theta0, 0, 1 );
for i = 1 : length(theta)
  p_hyp = p_hyp * unifpdf(theta(i) , 0,  10 );
end
% p_hyp = p_hyp * normpdf(nu, 0, 0.1);

% theta の事後分布
fpos = p_like * p_hyp;