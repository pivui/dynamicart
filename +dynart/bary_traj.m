function bary_traj(X, opt)
if nargin < 2
    opt = struct();
end
%
opt_default = struct('cmap', @parula,...
                     'alpha0', 0.9,...
                     'alpha_variation', 1,...
                     'background', 'black',...
                     'max_lw',10);
%
opt = dynart.default_opt(opt, opt_default);
%
[nx, nt, ntraj] = size(X);
% color map
coma    = opt.cmap(ntraj);
% angles 
thetas  = pi * (0:nx-1)/nx;
% Plot 
for j = 1:ntraj
    rgba = coma(j,:);
    %
    for i = 1:nt
        z(i) = 1/nx* sum(squeeze(X(:,i,j)) .* exp(1i * thetas(:)));
    end
    %
    max_lw = opt.max_lw;
    lw      = 1 + (max_lw - 1)* rand();
    if opt.alpha_variation
        alpha = 1-1/max_lw * lw;
    else
        alpha = opt.alpha0;
    end
    rgba    = [rgba, alpha];
    hold on
    lh          = plot(real(z), imag(z),'linewidth',lw);
    lh.Color    = rgba;
end
%
axis equal
axis off 
set(gcf,'color',opt.background);
set(gcf, 'InvertHardCopy', 'off');

end
