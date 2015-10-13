function [RMSEP, R] = LWPLS2_validation(Xtrain,Ytrain,Xtest,Ytest,LV,phi,scflag)
% -----------------------------------------------------------------
% [RMSEP, R] = LWPLS2_validation(Xtrain,Ytrain,Xtest,Ytest,LV,scflag)
%
% Description:
%  This function calculate RMSEP for LWPLS2
%
%  Input:
%    Xtrain   (N1 * M) : input variable matrix for training
%    Ytrain   (N1 * L) : output variable matrix for training
%    Xtest    (N2 * M) : input variable matrix for testing
%    Ytest    (N2 * L) : output variable matrix for testing
%    LV       (1 * 1)  : number of latent variable
%    phi      (1 * 1)  : localization parameter
%    scflag   (1 * 1)  : scaling flag (default: 0)
%                          0 -> not scaling
%                          1 -> scaling within alogorithm only
%                          2 -> scaling within algorithm and yq scaled
%
%  Output:
%    RMSEP    (1 * L) : root mean squared error of prediction
%    R        (1 * L) : correlation between Ytest and Yhat
%
%  Coded by Ryosuke YOSHIZAKI, Kyoto Univ., Apr. 07, 2015
% -----------------------------------------------------------------

%%% setting %%%
N    = size(Xtest,1);
L    = size(Ytest,2);
Yhat = zeros(N,L);
R    = zeros(1,L);

%%% calculate RMSEP %%%
% estimation
for n = 1 : N
  [Yhat(n,:),~,~,~,~,~,~,~,~,~,~,~,~] = ...
    LWPLS2(Xtrain,Ytrain,Xtest(n,:),LV,phi,scflag);
end
% calculate RMSEP
if scflag == 2
  [~,ym,ys] = autoscale(Ytrain);
  Ytest = ( Ytest - repmat(ym,N,1) ) ./ repmat(ys,N,1);
end
E     = Ytest - Yhat;
RMSEP = sqrt( sum(E.^2) / N );

%%% calculate R %%%
for l = 1 : L
  R(l) = corr( Ytest(:,l), Yhat(:,l) );
end



% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% Copyright (c) 2015. The Human Systems Laboratory, 
% Department of Systems Science, Graduated School of Informatics,
% Kyoto University (HSL).
% All rights reserved.
% Republication or redistribution is prohibited without the prior
% written consent of HSL.
%
% IN NO EVENT SHALL HSL BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT,
% SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS,
% ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION.
%
% HSL SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING,
% BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
% FITNESS FOR A PARTICULAR PURPOSE. 
% THE SOFTWARE AND ACCOMPANYING DOCUMENTATION, 
% IF ANY, PROVIDED HEREUNDER IS PROVIDED "AS IS".
% HSL HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, 
% UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++