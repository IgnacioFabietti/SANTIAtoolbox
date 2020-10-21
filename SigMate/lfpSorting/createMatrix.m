function[z] = createMatrix(filePath, fileName)

finalPath=[filePath,fileName];
data = load (finalPath);

z = data(:,2);