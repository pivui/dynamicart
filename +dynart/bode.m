function bode(h, w, opt)
if nargin < 3
    opt = struct();
end
%
opt_default = struct('cmap', @parula,...
                     'alpha0', 0.9,...
                     'background', 'black',...
                     'normalize',1,...
                     'phase_offset',0);
%
opt     = dynart.default_opt(opt, opt_default);
%
ny = size(h,1);
nu = size(h,2);
ctr = 0;
for j =1:nu
    for i = 1:ny
        ctr = ctr+1;
        subplot(ny,nu,ctr)
        dynart.siso_bode(h(i,j,:),w,opt);
    end
end


end