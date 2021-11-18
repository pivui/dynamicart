function plot_star_traj(xi, compress, offset, theta, rgba)
z           = complex(offset + compress*(1:length(xi))', xi(:));
z           = z * exp(1i*theta);
lh          = plot(real(z), imag(z));
lh.Color    = rgba;
end 