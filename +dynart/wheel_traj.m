function wheel_traj(X, opt)
if nargin < 2
    opt = struct();
end
%
opt_default = struct('cmap', @parula,...
                     'alpha0', 0.8,...
                     'alpha_variation', 1,...
                     'last_color', 'black',...
                     'background', 'black',...
                     'circle',1,...
                     'max_theta', pi);
%
opt = dynart.default_opt(opt, opt_default);
%
[nx, nt, ntraj] = size(X);
if opt.alpha_variation
    alpha_fun = @(j) opt.alpha0 * (1 - (j-1) /ntraj);
else
    alpha_fun = @(j) opt.alpha0;
end
% color map
coma    = opt.cmap(ntraj);
% bounds 
m       = opt.circle * abs(min(min(min(X))));
% angles 
thetas  = opt.max_theta * (0:nt-1)/nt;

% Plot 
for j = 1:ntraj
    if j == ntraj && ~isempty(opt.last_color)
        rgba = dynart.str2rgb(opt.last_color);
    else
        rgba = coma(j,:);
    end
    %
    alpha   = alpha_fun(j);
    rgba    = [rgba, alpha];
    for i = 1:nx
        hold on
        dynart.plot_wheel_x(squeeze(X(i,:,j)), thetas, m, rgba)
    end
%
axis equal
axis off 
set(gcf,'color',opt.background);
set(gcf, 'InvertHardCopy', 'off');

end
