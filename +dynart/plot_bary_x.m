function plot_bary_x(x, thetas, rgba)
x = x(:);
z = (m0+x) .* exp(1i * thetas(:));
z = [z;z(1)]; % Repeat first value to close the circle
%
lh          = plot(real(z), imag(z));
lh.Color    = rgba;
end 