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
Ncan       = 300;   % �����̐�
theta_init = unifrnd(0,1,1,M+1);  % MCMC�Ŏg�p���鏉���l
Ngen       = 300; % Parameter for MCMC
Nburn      = 500; % Parameter for MCMC
gamma      = 0;   % Parameter for Mutual Information

% Iteration until more than Nite
for ni = 1 : Nite
  
  % ����� (Xcan) �̐���
  Xcan = lhsdesign(Ncan,M);  % Latin hypercube sampling �ɂ�闐������
                             % Xcan �� [0,1] �ł��邽�߁C�K�X�X�P�[���ϊ�
  % �X�P�[���ϊ� (���Ńv���b�g�̂��߂ɂɃ\�[�g�����Ă��)
  Xcan = sort( 100 * Xcan - 50 );

  % Step1 : hyperparameter �̌��l�W���𐶐�
  Theta = MCMC(X,Y,theta_init,Ngen,Nburn);
  
  % Step2 : hyperparameter �̌��l�W������ mu �� sigma ���v�Z
  [mu, sigma] = GP_MCMC(X,Y,Xcan,Theta);
  
  
  % Step3 : �l���֐��̌v�Z����я��œK�_�̒T��
  [next_pos, gamma] = MI(mu,sigma,gamma);
  
  % Step4 : ���œK�_�ɂ�����]���֐��̌v�Z����уf�[�^�̊i�[
  xnew = Xcan(next_pos,:);
  ynew = feval(optfunc,xnew);
  X = [ X; xnew ];
  Y = [ Y; ynew ];
  
  % ���܂��F�����i�����͓K�X�����Ăˁj
  xplot = -50 : 0.1 : 50;
  yplot  = optfunc(xplot);
  plot(xplot,yplot,'m-.','linewidth',2);
  hold on;
  plot(X,Y,'ro','linewidth',2);
  plot(Xcan,mu,'b','linewidth',1);  % �v���b�g�����Ⴄ
  plot(xnew,ynew,'bo','linewidth',2); % ���̓_���v���b�g�����Ⴄ
  hold off;
  print('-depsc',['img/img_',num2str(ni),'.eps']); % ���łɕۑ��������Ⴄ
  
end

% Bayesian Optimization �ōœK�_��Ԃ�
[fopt, opt_pos] = max(Y);
xopt            = X(opt_pos,:);