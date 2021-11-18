function ex_wheel_traj(H, ntraj)
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

figure
dynart.wheel_traj(X);
end