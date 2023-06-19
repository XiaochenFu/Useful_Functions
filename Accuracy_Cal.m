function [Overall_Accuracy, SP_Accuracy, SM_Accuracy] = Accuracy_Cal(n_HIT,n_FA, n_SPlus, n_SMinus)
% by GPT4

% n_HIT: number of true positives, i.e., the participant correctly responded to a signal
% n_FA: number of false alarms, i.e., the participant incorrectly responded to a non-signal
% n_SPlus: total number of signal trials
% n_SMinus: total number of non-signal trials

% Calculate accuracy for signal trials (SP_Accuracy)
SP_Accuracy = n_HIT / n_SPlus;

% Calculate accuracy for non-signal trials (SM_Accuracy)
% Note: This is assuming you consider "correct rejections" as hits for non-signal trials
SM_Accuracy = (n_SMinus - n_FA) / n_SMinus;

% Calculate overall accuracy
Overall_Accuracy = (n_HIT + n_SMinus - n_FA) / (n_SPlus + n_SMinus);
end
