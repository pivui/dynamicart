function siso_bode(h, w, opt)
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
nw      = length(w);
coma    = opt.cmap(nw);
%
if iscell(h)
    m = h{1};
    p = 2*pi/360 * h{2};
else
    m           = abs(h);
    p(1,1,:)    = phase(squeeze(h));
end
if opt.normalize
    m = m/max(abs(m));
end
[~,idx] = sort(squeeze(m), 'ascend');
hold on 
z0  = zeros(nw,1);
z   = z0;
for i = 1:nw
    j       = idx(i);
    z0(j)   = log10(w(j));
    z(j)    = z0(j) + abs(m(1,1,j)) * exp(1i* (p(1,1,j) +opt.phase_offset)); 
    %
    s = [z0(j), z(j)];
    plot(real(s), imag(s), 'color',[coma(i,:),opt.alpha0],'linewidth',1.4);
end
% axis equal
axis off 
set(gcf,'color',opt.background);
set(gcf, 'InvertHardCopy', 'off');
end