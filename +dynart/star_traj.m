function star_traj(X, opt)
if nargin < 2
    opt = struct();
end
%
opt_default = struct('cmap', @parula,...
                     'alpha0', 0.6,...
                     'alpha_variation', 1,...
                     'background', 'black',...
                     'reverse', 0,...
                     'compresst',0.1,...
                     'circle',6,...
                     'scaley',0.3);
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
% angles 
thetas = 2 * pi * (0:nx-1)/nx;
% Plot 
X = opt.scaley * X;
for j = 1:ntraj
    rgba = coma(j,:);
    %
    alpha   = alpha_fun(j);
    rgba    = [rgba, alpha];
    for i = 1:nx
        hold on
        if opt.reverse
            dynart.plot_star_traj(squeeze(X(i,end:-1:1,j)),opt.compresst, opt.circle, thetas(i), rgba);
        else
            dynart.plot_star_traj(squeeze(X(i,:,j)), opt.compresst, opt.circle, thetas(i), rgba);
        end
    end
end
%
axis equal
axis off 
set(gcf,'color',opt.background);
set(gcf, 'InvertHardCopy', 'off');

end
