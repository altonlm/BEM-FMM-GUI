function stl_to_mat_GUI(outputName, stlFile)

[P, t, normals, ~] = stlReadArbitrary(stlFile);
display(stlFile);

save(outputName, 'P', 't', 'normals');

end