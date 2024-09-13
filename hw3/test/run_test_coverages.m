addpath(fullfile(pwd, '..', 'src'));

rezultatiRK4 = runtests('test', 'ReportCoverageFor', '../src/RK4.m');
rezultatiNihalo = runtests('test', 'ReportCoverageFor', '../src/nihalo.m');

