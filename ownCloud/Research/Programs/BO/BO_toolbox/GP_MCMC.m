function [mu, sigma] = GP_MCMC(X,Y,Xcan,Theta)
% function [mu, sigma] = GP_MCMC(X,Y,Xcan,Theta)

% Initial setting
[N,M] = size(X);
Ngen = size(Theta,1);

% x に関係せず事前に計算できる部分を計算しておく
  Kmat = zeros(N,N,Ngen);
  ymat = zeros(Ngen,N);
  for s = 1 : Ngen
    Ktmp = MaternKernel( X, X, Theta(s,2:M+1), Theta(s,1) );
    Kmat(:,:,s) = inv(Ktmp);
    %     Kmat(:,:,s) = inv(Ktmp) + Theta(s,end) * eye(N);  % noise model
    ymat(s,:) = Kmat(:,:,s) * Y;
  end

  % x に関係する部分の計算
  Ncan  = length(Xcan);
  mu    = zeros(Ncan,1);
  sigma = zeros(Ncan,1);

  for ci = 1 : Ncan
    xc = Xcan(ci,:);

    for s = 1 : Ngen

      % common preparation
      kvec = MaternKernel( xc, X,  Theta(s,2:M+1), Theta(s,1) );
      k    = MaternKernel( xc, xc, Theta(s,2:M+1), Theta(s,1) );

      % mu
      mu(ci) = mu(ci) + kvec * ymat(s,:)';

      % sigma
      sigma(ci) = sigma(ci) + k - kvec * Kmat(:,:,s) * kvec';

    end

  end
  
  % 期待値計算（平均を取るだけだけ）
  mu    = mu    / Ngen;
  sigma = sigma / Ngen;