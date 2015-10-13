function [xopt,fopt] = LWPLS_jDE(X,Y)


  %%% setting %%%
  % acquiring matrix size
  [N,M]  = size(X);   % N : number of samples of Xtrain
                      % M : number of input variables of Xtrain
  
  %% Estimation
                           
                           
  % candidate vector of latent variable
  vecLV  = 1 : M;
  % candidate vector of localization parameter
  vecPhi = 0 : 0.1 : 20;
  % scaling flag
  scflag = 1;         %   0 -> not scaling
                      %   1 -> scaling within alogorithm only
                      %   2 -> scaling within algorithm and yq scaled

  %%% parameter tuning using leave-one-out cross validation %%%
  %  PRESS : prediction error sum of squares using the best parameters
  %  LV    : best number of latent variables
  %  phi   : best localization parameter
  [PRESS, LV, phi] = LWPLS2_cv(X,Y,vecLV,vecPhi,scflag);
  
  

  %%% calculation of the estimation performance for test data %%%
  %  RMSEP : root mean squared error of prediction
  %  R     : correlation between Ytest and Estimation value
  [RMSEP, R] = LWPLS2_validation(X,Y,X,Y,LV,phi,scflag);

  %%% display result %%%
  fprintf('     LV      =    %2.4f \n', LV);
  fprintf('     phi     =    %1.4f \n', phi);
  fprintf('     RMSEP   =    %1.4f \n', RMSEP);
  fprintf('     R       =    %1.4f \n\n', R);

  
  %% Optimization
  weight = ones(M,1);
  optFunc = @(x) max_LWPLS2(X,Y,x,LV,phi,scflag,weight);
  
  Xl = -1 * ones(1,M);
  Xu = ones(1,M);
  
  %%% generate initial population %%%
  Gene = 50;
  Nq   = 30;  % number of initial individuals in the population
  x0   = zeros(Nq,M);
  for m = 1 : M
    x0(:,m) = RandRange(Xl(m), Xu(m), Nq, 1);
  end
  
  
  %%% optimization of process parameters in jDE algorithm
  %  input:
  %    @optFunc          : calculation objective function and constraints
  %    @penalty          : penalty method for constraints optimization
  %    @jDE_update_rand  : DE/rand/1/bin strategy
  %    @jDE_update_best  : DE/best/1/bin strategy
  %  output:
  %    xbest             : best process parameter obtained by jDE algorithm
  %    gbest             : objective function value of xg
  %    ghist             : history of gbest every evolutionary process
  % DE/best/1/bin strategy
  
  [xopt, fopt] = ...
      jDE(optFunc, @penalty, @jDEupdate_best, x0, Xl, Xu, Gene);
    
  fopt = - fopt;  % 最大化の際にマイナスをかけていたため，元に戻している