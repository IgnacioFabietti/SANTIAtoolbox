function subtractArtifact(signalFilePath, artifactFilePath)

signal = load(signalFilePath);

artifact = load(artifactFilePath);

% time = downsample(signal(:,1),2);
% signal = downsample(signal(:,2),2);

newSignal = signal(1:length(artifact),2)-artifact(:,2);

arSignal = 1;

figure;

plot( newSignal);