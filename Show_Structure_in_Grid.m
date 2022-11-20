addpath('C:\Users\XIAOCHEN-FU\Dropbox (OIST)\Fukunaga_Lab_Joined\Code\Basic_Allen_3D_Brain\allenCCF-master')
addpath('C:\Users\XIAOCHEN-FU\Dropbox (OIST)\Fukunaga_Lab_Joined\Code\Basic_Allen_3D_Brain\allenCCF-master\Histology Functions')
addpath('C:\Users\XIAOCHEN-FU\Dropbox (OIST)\Fukunaga_Lab_Joined\Code\Basic_Allen_3D_Brain\allenCCF-master\Browsing Functions')
addpath('C:\Users\XIAOCHEN-FU\Dropbox (OIST)\Fukunaga_Lab_Joined\Code\Basic_Allen_3D_Brain\allenCCF-master\npy-matlab-master\npy-matlab')
addpath('C:\Users\XIAOCHEN-FU\Dropbox (OIST)\Fukunaga_Lab_Joined\Code\Basic_Allen_3D_Brain\BrainMesh-master')
addpath('C:\Users\XIAOCHEN-FU\Dropbox (OIST)\Fukunaga_Lab_Joined\Code\Basic_Allen_3D_Brain\BrainMesh-master\functions')

plotBrainGrid()
[f, h] = plotBrainGrid();
cd('C:\Users\XIAOCHEN-FU\Dropbox (OIST)\Fukunaga_Lab_Joined\Code\Basic_Allen_3D_Brain\BrainMesh-master')
% glot,general lot
[v,F]=loadawobj('Data\Allen_obj_files\21.obj'); v = v/10; v([2 3],:) = v([3 2],:);
patch('Vertices',v','Faces',F','EdgeColor','none','FaceColor', '#77AC30','FaceAlpha',0.5)
hold on
% mob,main OB
[v,F]=loadawobj('Data\Allen_obj_files\507.obj'); v = v/10;v([2 3],:) = v([3 2],:);
patch('Vertices',v','Faces',F','EdgeColor','none','FaceColor', '#9AD2BD','FaceAlpha',0.5)
% OT, olfactory turbucle
[v,F]=loadawobj('Data\Allen_obj_files\754.obj'); v = v/10;v([2 3],:) = v([3 2],:);
patch('Vertices',v','Faces',F','EdgeColor','none','FaceColor', '#80CDF8','FaceAlpha',0.5)
% PCX, olfactory turbucle
[v,F]=loadawobj('Data\Allen_obj_files\961.obj'); v = v/10;v([2 3],:) = v([3 2],:);
patch('Vertices',v','Faces',F','EdgeColor','none','FaceColor', '#6ACBBA','FaceAlpha',0.5)
% AON, anterior olfactory nucleur
[v,F]=loadawobj('Data\Allen_obj_files\159.obj'); v = v/10;v([2 3],:) = v([3 2],:);
patch('Vertices',v','Faces',F','EdgeColor','none','FaceColor', '#54BF94','FaceAlpha',0.5)