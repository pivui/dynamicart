function opt = default_opt(opt, opt_def)
fn = fieldnames(opt_def);
for i = 1:length(fn)
    if ~isfield(opt, fn{i})
        opt.(fn{i}) = opt_def.(fn{i});
    end
end
end