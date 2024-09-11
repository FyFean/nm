addpath(fullfile(pwd, '..', 'src'));

rezultatiSi = runtests('test', 'ReportCoverageFor', '../src/aproksimiraj_Si.m');
rezultatiSimpMetoda = runtests('test', 'ReportCoverageFor', '../src/simp_metoda.m');
rezultatiPlHipotrohoide = runtests('test', 'ReportCoverageFor', '../src/pl_hipotrohoide.m');
reszultatiNewtonovaMetoda = runtests('test', 'ReportCoverageFor', '../src/newt_iteracija.m');