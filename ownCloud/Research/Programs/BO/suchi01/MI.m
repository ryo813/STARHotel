function [next_pos, gamma] = MI(mu,sigma,gamma)
% function [next_pos, gamma] = MI(mu,sigma,gamma)

% initial setting
% delta = 1e-1;
delta = 1e-50;   % delta ‚Ì’l‚ğ¬‚³‚­‚·‚é‚Ù‚ÇC’Tõ‚É”ï‚â‚·‰ñ”‚ª‘½‚­‚È‚é
alpha = log(2/delta);

% calculate acquisition function value of Xcan
Nc = length(mu);
acq_value = zeros(Nc,1);
for ci = 1 : Nc
  phi = sqrt(alpha) * ( sqrt(sigma(ci) + gamma ) - sqrt(gamma) );
  acq_value(ci) = mu(ci) + phi;
end

% determine next values of input variable
[~,next_pos] = max(acq_value);
gamma        = gamma + sigma(next_pos);