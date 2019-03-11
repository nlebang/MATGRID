 function [data] = produce_Abv(data, user, sys, se)

%--------------------------------------------------------------------------
% Exports the system in the matrix and vector forms, for the linear state
% estimation cases.
%
% The function exports the matrix and vector forms for the DC and PMU state
% estimation. Export of data is possible to do without slack bus
% (estimate.linear = 1), or with slack bus (estimate.linear = 2).
%
%  Input:
%	- data: input power system data with measurements
%	- sys: power system data
%	- se: state estimation data
%
%  Outputs:
%	- data.A: Jacobian matrix
%	- data.b: vector of observations;
%	- data.v: variances vector
%
% Local function which is used to export data in the matrix and vector
% forms.
%--------------------------------------------------------------------------


%-------------------------------Export System------------------------------
 if user.linear_estimate == 1
	h = sparse(1, sys.Nbu);
	b = [];
	v = [];
 elseif user.linear_estimate == 2
	h = sparse(1, sys.Nbu);
	h(sys.sck(1)) = 1;
	b = sys.sck(2);
	v = 10^-60;
 end

 data.extras.A = [sys.H; h];
 data.extras.b = [sys.b; b];
 data.extras.v = [se.estimate(:,2); v];
%--------------------------------------------------------------------------