function [Xscaled,meanX,stdX] = autoscale(X,meanX,stdX)
% -------------------------------------------------
% ***  Autoscale  *** 
% Coded by Manabu KANO, Kyoto Univ., Feb. 27, 2000
%                     last updated : Aug.  8, 2001
%
% USAGE : 
% [Xscaled,meanX,stdX] = autoscale(X,meanX,stdX)
%
% DESCRITION :
% This function autoscales X.  The mean and the standard 
% deviation of Xscaled are 0 and 1, or X is scaled by 
% using meanX and stdX.
%
% --- Input ---
% X     	: data matrix (samples*variables)
%   ( option )
% meanX		: means of variables
% stdX		: standard deviations of variables
%       	  If meanX or stdX is empty '[]', 
%       	  then X is not scaled.
% 
% --- Output --- 
% Xscaled	: autoscaled X
% meanX		: means of variables
% stdX		: standard deviations of variables
% 
% ----------------------------------------------------


if nargin < 3, stdX = std(X); end
if isempty(stdX)==1,  stdX  = ones(1,size(X,2));  end
if nargin < 2, meanX = mean(X); end
if isempty(meanX)==1, meanX = zeros(1,size(X,2)); end

rowX = size(X,1);

std0 = find(stdX==0);
for i=1:length(std0)
	stdX(1,std0(i)) = inf;
end
Xscaled = (X-meanX(ones(rowX,1),:))./stdX(ones(rowX,1),:);
for i=1:length(std0)
	stdX(1,std0(i)) = 0;
end


%
% Copyright (c) 2000-2001. Manabu KANO
% All rights reserved.
% e-mail: kano@cheme.kyoto-u.ac.jp
% http://www-pse.cheme.kyoto-u.ac.jp/~kano/
%


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