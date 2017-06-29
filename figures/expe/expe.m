%% init
clear
tc_count = 6;
tc_name = {'IBMPG1', 'IBMPG2', 'IBMPG3', 'IBMPG4', 'IBMPG5', 'IBMPG6'};
core_count = 4;
core_number = [1 2 4 8];
comm_ratio = [0.00, 4.53401, 8.98097, 14.781
 0.00,  30.0997, 31.7822, 34.1403
 0.00, 1.23674, 17.4086, 21.1654
 0.00, 31.421, 52.708, 55.5142
 0.00,  4.34004,  5.76161, 6.59862
 0.00,   0.270222, 5.51331,  8.22062
 ];
run_time = [0.42688, 0.118502, 0.067713, 0.0810761
 3.00275, 1.29162, 0.699898,  0.458929
  9.66296, 5.24107, 3.5995, 2.44742
  41.5323, 29.8401,  19.6946, 12.1975
  25.119, 13.0883,  8.75678,  5.45925
  43.9363, 26.3894, 15.453, 9.83361 ];

runtime_speedup=zeros(tc_count,core_count);
for i=1:tc_count
    runtime_speedup(i,:)= run_time(i,1)./run_time(i,:);
end

%% plot speedup ratio

C = linspecer(tc_count+1);
p=[];

figure;
p(end+1)=plot(core_number, core_number, 'color', 'k', 'LineStyle','-.');
hold on

hXLabel = xlabel('?????(?)', 'FontSize', 18);
hYLabel = ylabel('???', 'FontSize', 18);

for tc=1:tc_count
    p(end+1)=plot(core_number, runtime_speedup(tc,:), 'color', C(tc+1,:), 'Marker', '.',  ...
        'MarkerSize', 25, 'LineWidth', 1.8);
    hold on
end

hLegend = legend(p, '??y=x', 'IBMPG1', 'IBMPG2', 'IBMPG3', 'IBMPG4', 'IBMPG5', 'IBMPG6', ...
    'location', 'NorthWest' );

set([hLegend, gca] ,'FontSize', 18 );

set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.02 .02] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'LineWidth'   , 1         );

%% plot histogram

C = linspecer(tc_count+1);
p=[];
alltc_name = {};
for tc=1:tc_count
   for core=1:core_count
      name = [tc_name{tc} '-Core#' int2str(core_number(core))];
      alltc_name{end+1}=name;
   end
end

alltc_cat = {'IBMPG1', 'IBMPG2','IBMPG3','IBMPG4','IBMPG5','IBMPG6'};
figure
bar(1:size(alltc_cat,2), run_time);
set(gca,'xticklabel',alltc_cat)

hLegend=legend({'Core#1', 'Core#2', 'Core#4', 'Core#8'},'location','northwest')
set(gca, 'FontSize', 24 );
set(hLegend, 'FontSize', 24 );

hXLabel = xlabel('?????', 'FontSize', 26);
hYLabel = ylabel('PCG????(?)', 'FontSize', 26);

set(gca, ...
  'TickLength'  , [.02 .02] , ...
  'YMinorTick'  , 'on'      , ...
  'YGrid'       , 'on'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'LineWidth'   , 1         );


%% plot communication costs

figure
p=[];
C = linspecer(tc_count);
for tci=1:3
   for tcj=1:2
      tc=(tci-1)*2+tcj;
      p(end+1)=subplot(3,2,tc);
      plot(core_number, comm_ratio(tc,:), 'color', C(tc,:), ...
          'Marker', 'o', 'LineWidth', 1.5);
      
      title(tc_name(tc), 'FontSize',23, 'FontWeight', 'Normal');
      hXLabel = xlabel('????(?)', 'FontSize', 21);
        hYLabel = ylabel('?????(%)', 'FontSize', 21);
      set(gca,'fontsize',19);
      set(gca, ...
      'Box'         , 'off'     , ...
      'TickDir'     , 'out'     , ...
      'TickLength'  , [.02 .02] , ...
      'XMinorTick'  , 'off'      , ...
      'YMinorTick'  , 'on'      , ...
      'YGrid'       , 'on'      , ...
      'XColor'      , [.3 .3 .3], ...
      'YColor'      , [.3 .3 .3], ...
      'LineWidth'   , 1         );
   end
end
%% example usage of linspecer

% LINE COLORS 
N=6; 
X = linspace(0,pi*3,1000); 
Y = bsxfun(@(x,n)sin(x+2*n*pi/N), X.', 1:N); 
C = linspecer(N); 
axes('NextPlot','replacechildren', 'ColorOrder',C); 
plot(X,Y,'linewidth',5) 
ylim([-1.1 1.1]);

% SIMPLER LINE COLOR EXAMPLE 
N = 6; X = linspace(0,pi*3,1000); 
C = linspecer(N) 
hold off; 
for ii=1:N 
    Y = sin(X+2*ii*pi/N); 
    plot(X,Y,'color',C(ii,:),'linewidth',3); 
    hold on; 
end

% COLORMAP EXAMPLE 
A = rand(15); 
figure; imagesc(A); % default colormap 
figure; imagesc(A); colormap(linspecer); % linspecer colormap

clear