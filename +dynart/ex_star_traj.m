function ex_star_traj(H, ntraj)
nx = size(H.A,1);
t = [];
for i = 1:ntraj
    x0          = 10 * randn(nx,1);
    if isempty(t)
        [~, t, x]   = initial(H,x0);
    else
        [~, ~, x]   = initial(H,x0,t);
    end
    X(:,:,i)    = x';
end
opt.compresst = t(2)-t(1);
figure
subplot(121)
opt.reverse = 0;
opt.circle  = 8;
dynart.star_traj(X,opt);
subplot(122)
opt.reverse = 1;
opt.circle  = 0.5;
opt.scale  = 0.01;
dynart.star_traj(X,opt);

end