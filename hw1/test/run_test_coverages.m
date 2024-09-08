addpath(fullfile(pwd, '..', 'src'));

rezultatiInterpoliraj = runtests('test', 'ReportCoverageFor', '../src/interpoliraj.m');
reszultatiZlepek = runtests('test', 'ReportCoverageFor', '../src/Zlepek.m');
