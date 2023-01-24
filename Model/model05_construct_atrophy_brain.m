%% copy all additional layers to the new folder and then use the new folder for GUI

subjectList = {'110411', '101309', '117122', '120111', '122317', '122620', '124422', '128632', '130013'};

absoluteShrink = [2]; % total distance by which to decrease the bounding box of GM

addpath('..\Engine\');
cd Connectome;
for i = 1:length(absoluteShrink)
    for j = 1:1%length(subjectList)
        cd(['Model ' subjectList{j}]);
        csf = load([subjectList{j} '_csf']);
        gm = load([subjectList{j} '_gm']);
        wm = load([subjectList{j} '_wm']);
        ventricles = load([subjectList{j} '_ventricles']);

        csfCM = mean(csf.P);
        gm.P = gm.P - csfCM;
        wm.P = wm.P - csfCM;
        ventricles.P = ventricles.P - csfCM;

        gmBB = max(gm.P) - min(gm.P);
        shrinkRatio = (max(gmBB) - absoluteShrink(i)) / max(gmBB);
        gm.P = gm.P * shrinkRatio;
        wm.P = wm.P * shrinkRatio;
        ventricles.P = ventricles.P * shrinkRatio;

        gm.P = gm.P + csfCM;
        wm.P = wm.P + csfCM;
        ventricles.P = ventricles.P + csfCM;

        gm.normals = meshnormals(gm.P, gm.t);
        wm.normals = meshnormals(wm.P, wm.t);
        ventricles.normals = meshnormals(ventricles.P, ventricles.t);

        cd ..
        newFolderName = ['Model ' subjectList{j} '_shrunk' num2str(absoluteShrink(i))];
        copyfile(['Model ' subjectList{j}], newFolderName);
        % mkdir(newFolderName);
        cd(newFolderName);
        P = gm.P; t = gm.t; normals = gm.normals; save([subjectList{j} '_gm'], 'P', 't', 'normals');
        stlwrite([subjectList{j} '_gm.stl'],t,P);
        P = wm.P; t = wm.t; normals = wm.normals; save([subjectList{j} '_wm'], 'P', 't', 'normals');
        stlwrite([subjectList{j} '_wm.stl'],t,P);
        P = ventricles.P; t = ventricles.t; normals = ventricles.normals; save([subjectList{j} '_ventricles'], 'P', 't', 'normals');
        stlwrite([subjectList{j} '_ventricles.stl'],t,P);
        cd ..
    end
end