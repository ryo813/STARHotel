% Gauss Process をプロット
clear all

f = @(x) sin(x) + 2 * cos(x/2) + 3 * sin(x/3) - 8 * cos(x/10);

gamma = 0;
X = RandRange(-50,50,1,1);
y = f(X);

M = size(X,2);
% Theta_init = unifrnd(0,1,1,M+2);
Theta_init = unifrnd(0,1,1,M+1);

for i = 1 : 19

  %% 適当な非線形な1次元の関数
  % f = @(x) sum(x.^2);

  x = -50 : 0.1 : 50;
  yplot  = f(x);

  plot(x,yplot,'m-.','linewidth',2); hold on;


  %% Gauss Process で近似  候補値集合の mu と sigma を計算

  % Gauss Process に与えるサンプル
  plot(X,y,'ro','linewidth',2);

  [N,M] = size(X);

  % MCMC の fast ver.
  Theta = MCMC(y,X,Theta_init);
  
  % 次の Theta_init はとりあえず中央値で
  Theta_init = median(Theta);

  % x に関係せず事前に計算できる部分を計算しておく
  S = length(Theta);
  Kmat = zeros(N,N,S);
  ymat = zeros(S,N);
  for s = 1 : S
    Ktmp = MaternKernel( X, X, Theta(s,2:M+1), Theta(s,1) );
    Kmat(:,:,s) = inv(Ktmp);
    %     Kmat(:,:,s) = inv(Ktmp) + Theta(s,end) * eye(N);
    ymat(s,:) = Kmat(:,:,s) * y;
  end

  % x に関係する部分の計算
%   Xcan  = (-20 : 0.1 : 20)';
  Xcan = sort( 100 * rand(300,1) - 50 );
  Nc    = length(Xcan);
  mu    = zeros(Nc,1);
  sigma = zeros(Nc,1);

  for ci = 1 : Nc
    xc = Xcan(ci,:);

    for s = 1 : S

      % common preparation
      kvec = MaternKernel( xc, X,  Theta(s,2:M+1), Theta(s,1) );
      k    = MaternKernel( xc, xc, Theta(s,2:M+1), Theta(s,1) );

      % mu
      mu(ci) = mu(ci) + kvec * ymat(s,:)';

      % sigma
      sigma(ci) = sigma(ci) + k - kvec * Kmat(:,:,s) * kvec';

    end

  end
  mu    = mu / S;
  sigma = sigma / S;
  plot(Xcan,mu,'b');

  % % MCMC の slow ver.
  % % Theta = MCMC(y,X);
  % tic
  % for s = 1 : length(Theta)
  %   count = 1;
  %   K = MaternKernel(X,X,Theta(s,2:end),Theta(s,1));
  %   for x = -20 : 0.1 : 20
  %     kvec = MaternKernel( x, X,    Theta(s,2:end), Theta(s,1) );
  %     k    = MaternKernel( x, x,    Theta(s,2:end), Theta(s,1) );
  %     
  %     mu    = kvec / K * y;
  %     sigma = k - kvec / K * kvec';
  % 
  %     Xplot(count,:) = x;
  %     Yplot(s,count) = mu;
  % 
  %     count = count + 1;
  %   end
  % end
  % 
  % Yplot = sum(Yplot) / length(Theta);
  % toc
  % plot(Xplot,Yplot,'b','linewidth',3);


  %% 獲得関数の計算 mu と sigma から導出
  [next_pos, gamma] = MutualInformation(mu,sigma,gamma);
  Xnew = Xcan(next_pos);
  ynew = f(Xnew);
  
  X = [X; Xnew];
  y = [y; ynew];
  
  plot(Xnew,ynew,'bo','linewidth',2);
  
  hold off;
  
  print('-depsc',['img/img_',num2str(i),'.eps']);
  
  if gamma == -inf || gamma == inf
    return
  end

end

return

m = -100;
count = 1;
for x = -20 : 0.1 : 20
  kvec = MaternKernel( x, X,    theta, theta0 );
  k    = MaternKernel( x, x,    theta, theta0 );

  mu    = kvec * inv(K) * y;
  sigma = k - kvec * inv(K) * kvec';
  
  Xplot(count) = x;
  Yplot(count) = mu;
  
  count = count + 1;
end

plot(Xplot,Yplot);


% 

hold off;