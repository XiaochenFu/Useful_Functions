S = dir('C:\Users\XIAOCHEN-FU\OneDrive - OIST\Xiaochen_Izumi\DataFromEphysSetup\TbxCre_Tetrode_3rdJune2022\SpikeData');
S = S(~[S.isdir]);
[~,idx] = sort([S.datenum]);
S1 = S(idx);