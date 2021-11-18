function plot_polar_x(x, m0, thetas, rgba)
%    Radial projection of the state
x = x(:);
z = (m0+x) .* exp(1i * thetas(:));
z = [z;z(1)]; % Repeat first value to close the circle
%
lh          = plot(real(z), imag(z));
lh.Color    = rgba;
end 