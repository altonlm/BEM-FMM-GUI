function stl_to_mat_GUI_CSFExpansion(outputName, stlFile, expansionAmount)

[P, t, normals, ~] = stlReadArbitrary(stlFile);

display(stlFile);

% Code for running prediction tests on brain atrophy
if (contains(stlFile, 'csf'))

    %   Find vertex neighbors and vertex normals for FS
    DT          = triangulation(t, P); 
    V           = vertexAttachments(DT);
    Vnormals    = zeros(size(V, 1), 3);
    for m = 1:size(V, 1)
        Vnormals(m, :)  = sum(normals(V{m}, :), 1);
        Vnormals(m, :)  = Vnormals(m, :)/norm(Vnormals(m, :));
    end
    
    for m = 1:size(P, 1)
        P(m, :) = P(m, :) + expansionAmount*Vnormals(m, :); 
    end
end

save(outputName, 'P', 't', 'normals');

end