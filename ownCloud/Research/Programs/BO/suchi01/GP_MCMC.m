function [mu, sigma] = GP_MCMC(X,Y,Xcan,Theta)
% function [mu, sigma] = GP_MCMC(X,Y,Xcan,Theta)

% Initial setting
[N,M] = size(X);
Ngen = size(Theta,1);

% x ‚ÉŠÖŒW‚¹‚¸–‘O‚ÉŒvZ‚Å‚«‚é•”•ª‚ğŒvZ‚µ‚Ä‚¨‚­
  Kmat = zeros(N,N,Ngen);
  ymat = zeros(Ngen,N);
  for s = 1 : Ngen
    Ktmp = MaternKernel( X, X, Theta(s,2:M+1), Theta(s,1) );
    Kmat(:,:,s) = inv(Ktmp);
    %     Kmat(:,:,s) = inv(Ktmp) + Theta(s,end) * eye(N);  % noise model
    ymat(s,:) = Kmat(:,:,s) * Y;
  end

  % x ‚ÉŠÖŒW‚·‚é•”•ª‚ÌŒvZ
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
  
  % Šú‘Ò’lŒvZi•½‹Ï‚ğæ‚é‚¾‚¯‚¾‚¯j
  mu    = mu    / Ngen;
  sigma = sigma / Ngen;