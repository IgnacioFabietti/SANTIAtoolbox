function [average_fet_time, average_fet_data, odd_average_data, even_average_data] = rootMeanSquare(fileList)
    
    
%     average_fet_time = 0;
%     average_fet_data = 0;
    
    time_fet_matrix = [];
    data_fet_matrix = [];
    
    for i = 1 : length(fileList)
        loaded_file = load (fileList{i}); % load the file into loaded_file from the filename provided as an array of strings
        
        time_fet = loaded_file(:,1);
        data_fet = loaded_file(:,4);

%         time_fet = time_fet.^2 ; %calculate the square
        data_fet = data_fet.^2; %calculate the square
        
        time_fet_matrix = time_fet_matrix';
        data_fet_matrix = data_fet_matrix'; % transpose the original matrix for adding the column as a row
        
        time_fet = time_fet';
        data_fet = data_fet'; % transpose the column vector to a row vector to add to the matrix
        
        time_fet_matrix = [time_fet_matrix; time_fet];
        data_fet_matrix = [data_fet_matrix; data_fet]; % add the vector to the existing matrix
        
        time_fet_matrix = time_fet_matrix';
        data_fet_matrix = data_fet_matrix'; % transpose the matrix back to the original format
    end

    time_fet_matrix = time_fet_matrix';
    data_fet_matrix = data_fet_matrix'; % transpose the final data matrix to find the mean values of the recordings
    
    average_fet_time = sum(time_fet_matrix)/length(time_fet_matrix);
    average_fet_data = sum(data_fet_matrix)/length(data_fet_matrix); % calculate the mean of the recordings
    
    average_fet_data = sqrt(average_fet_data);
%     temp = data_fet_matrix(1:2:length(data_fet_matrix))
    odd_average_data = sum(data_fet_matrix(:,1:2:length(data_fet_matrix)))/(length(data_fet_matrix)/2);
    even_average_data = sum(data_fet_matrix(:,2:2:length(data_fet_matrix)))/(length(data_fet_matrix)/2);
    
    odd_average_data = sqrt(odd_average_data);
    even_average_data = sqrt(even_average_data);
    
    average_fet_time = average_fet_time';
    average_fet_data = average_fet_data'; % transpose and bring it back to original for plotting
    
    odd_average_data = odd_average_data';
    even_average_data = even_average_data';    
    
%     newFigure = figure;
    
%     plot(average_fet_time, odd_average_data, 'r');
%     plot(average_fet_time, even_average_data, 'g');
    
%     time = fileList{1}(:,1);
%     data_base = fileList{1}(:,4);
    
%     clf;
   
%     subplot(2,1,1);
%     plot(time,data_base,'-g');
%     xlabel('Time');
%     ylabel('FET Vj');
%     title('Base Line Reading for Fets');
    
    
%     subplot(2,1,2);
    
%     color = {'r','g','b','c','m','y','k'}; 
%     hold on;    
%     for i = 1 : length(fileList)
%          a = rand;
%          b = a * 7;
%          c = floor(b);
%          c = c + 1;
         
         %create a new figure
%          newFig = figure;

         %get the units and position of the axes object
%          axes_units = get(axesObject,'Units');
%          axes_pos = get(axesObject,'Position');

         %copies axesObject onto new figure
%          axesObject2 = copyobj(axesObject,newFig);

         %realign the axes object on the new figure
%          set(axesObject2,'Units',axes_units);
%          set(axesObject2,'Position',[15 5 axes_pos(3) axes_pos(4)]);

         %if a legendObject was passed to this function . . .
%          if (exist('legendObject'))

             %get the units and position of the legend object
%              legend_units = get(legendObject,'Units');
%              legend_pos = get(legendObject,'Position');

             %copies the legend onto the the new figure
%              legendObject2 = copyobj(legendObject,newFig);

             %realign the legend object on the new figure
%              set(legendObject2,'Units',legend_units);
%              set(legendObject2,'Position',[15-axes_pos(1)+legend_pos(1) 5-axes_pos(2)+legend_pos(2) legend_pos(3) legend_pos(4)] );

%          end

         %adjusts the new figure accordingly
%          set(newFig,'Units',axes_units);
%          set(newFig,'Position',[15 5 axes_pos(3)+30 axes_pos(4)+10]);

%          plot(time,data_fet{i},color{c});
%     end
%     hold off;
%     xlabel('Time');
%     ylabel('FET Vj');
%     title('Difference Between Baseline & Recorded Vj of Fets');
    
%     h = legend('Base Line','Recorded Vj',2);
%     set(h, 'Interpreter', 'none')
    
    
    