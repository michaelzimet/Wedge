clear all
load('calc/LFP_Resid.mat')

Resid = Resid(time,:);

%% Create table

Contact = {'C4'; 'C3a'; 'C3b'; 'C3c'; 'C2a'; 'C2b'; 'C2c'; 'C1'};

Mean = zeros(8,1);

Median = zeros(8,1);

Stdev = zeros(8,1);

RMSE = zeros(8,1);

for r=1:8
    switch r
        case 1
            col=8;
        case 2
            col=5;
        case 3
            col=6;
        case 4
            col=7;
        case 5
            col=2;
        case 6
            col = 3;
        case 7
            col = 4;
        case 8
            col =1;
    end

    Mean(r) = mean(Resid(:, col));
    Median(r) = median(Resid(:, col));
    Stdev(r) = std(Resid(:, col));
    RMSE(r) = sqrt(mean(Resid(:, col).^2));

end

Mean = Mean*1e3;
Median = Median*1e3;
Stdev = Stdev*1e2;
RMSE = RMSE * 1e2;

T = table(Contact, Mean, Median, Stdev, RMSE);

%% Display table
disp(T)    