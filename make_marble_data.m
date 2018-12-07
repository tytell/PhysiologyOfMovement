% Build weights

nmachine = 3;
ncolor = 2;
nreps = 50;

machines = repmat({'A'; 'B'; 'C'}, [1 ncolor nreps]);
colors = repmat({'red','blue'}, [nmachine 1 nreps]);

weightmean = 2;
weightbymachine = [0; 0; 0.2];
weightbycolor = [0 -0.3];

weightbycolorxmachine = [0 0; -0.1 0.2; 0 -0.1];

weightsdbymachine = [0.1; 0.1; 0.3];

diammean = 8;
diambymachine = [1; 0; 0];
diambycolor = [0 -1];

diamsdbymachine = [0.2; 0.2; 0.4];

badmean = 0.05;
badbymachine = [0.03; -0.03; 0];
badbycolor = [0 0];

badbycolorxmachine = [0 0; 0 0; 0 0.02];

weightbymachine2 = repmat(weightbymachine, [1 ncolor nreps]);
weightbycolor2 = repmat(weightbycolor, [nmachine 1 nreps]);
weightbycolorxmachine2 = repmat(weightbycolorxmachine, [1 1 nreps]);
weightsd = repmat(weightsdbymachine, [1 ncolor nreps]);

weight = weightmean + randn([nmachine ncolor nreps]) .* weightsd + ...
    weightbymachine2 + weightbycolor2 + weightbycolorxmachine2;

diambymachine2 = repmat(diambymachine, [1 ncolor nreps]);
diambycolor2 = repmat(diambycolor, [nmachine 1 nreps]);
% diambycolorxmachine2 = repmat(diambycolorxmachine, [1 1 nreps]);
diamsd = repmat(diamsdbymachine, [1 ncolor nreps]);

diam = diammean + randn([nmachine ncolor nreps]) .* diamsd + ...
    diambymachine2 + diambycolor2;

badval = rand([nmachine ncolor nreps]);
badthresh = badmean + ...
    repmat(badbymachine, [1 ncolor nreps]) + ...
    repmat(badbycolor, [nmachine 1 nreps]) + ...
    repmat(badbycolorxmachine, [1 1 nreps]);
badthresh(diam > 9) = badthresh(diam > 9) + 0.01;

isbad = badval < badthresh;

bad = cell(size(isbad));
[bad{isbad}] = deal('bad');
[bad{~isbad}] = deal('good');

T = table(machines(:), colors(:), weight(:), diam(:), bad(:), ...
    'Variablenames',{'machine','color','weight','diameter','bad'});
writetable(T, 'marbles.csv');




