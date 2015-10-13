%% BO 数値例 (1次元)

% 最適化（最大化）したい評価関数の設定
optfunc = @(x) sin(x) + 2 * cos(x/2) + 3 * sin(x/3) - 8 * cos(x/10);

xplot = - 50 : 0.01 : 50;
yplot = optfunc(xplot);

figure(1);
plot(xplot,yplot,'m-.','linewidth',2);
hold on;
xlabel('$x$','interpreter','latex','fontsize',26);
ylabel('$f(x)$','interpreter','latex','fontsize',26);
set(gca,'fontsize',22);
set(gca,'xtick',[-50 : 25 : 50])


% 最大値を数値的に探索
[max_val,pos] = max(yplot);
xopt = xplot(pos);

% 最大値にマーク
plot(xopt,max_val,'ro','linewidth',2,'markersize',10);
hold off;
print -depsc suchi1.eps