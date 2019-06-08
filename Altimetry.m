function Altimetry(cruise)  %creates function for reference

meta = MetaInfo(cruise);  %links to metainfo so we can call variables, etc from other mfiles

A = load(meta.AltimFile);  %links to the AltimFile within the MetaInfo file 

parts = strread(cruise,'%s','delimiter','_');
year = parts{1};
area = parts{2};

clf;

figure(1)

hold on 

title(['Aviso SLA on May 9th 2018 for ',strrep(area,'_','\_')],'FontSize',16) %creates title
ylabel('Latitude (degrees)','FontSize',16)    %add y label for Latitude
xlabel('Longitude (degrees)','FontSize',16)   %add x label for Longitude

imagesc(A.lon,A.lat,A.sla) % creates the basic image we want to edit
set(gca,'YLim',[meta.LatMin meta.LatMax]); % sets map y-limits to the Latitudes specified for your area
set(gca,'XLim',[meta.LonMin meta.LonMax]); % sets map x-limits to the Latitudes specified for your area
set(gca,'FontSize',18)

contour(A.lon,A.lat,A.sla,[0 0],'Color','k')                  % outline the coasts with black contour by accessing Bathymetry file lon/lat/dep
[L,m] = contour(A.lon,A.lat,A.sla,[-0.4:0.1:0.8],'Color','k'); % -2000m isobath (farthest floats go to) black countour and assign lon/lat positions to L/M
clabel(L,m,'LabelSpacing',200); %labels the contours

%======================================================================================
%The below code is for the combined cruise plots for 3 cruises 
if meta.Station1 == false             %if your location does NOT have a station file
    StationF = false;           %assign StationF as "false"
else %if your location has a station file (or a current Argo float position as with CSIRO)
    StationF = true; %assign StationF as "true"
    StationFile1 = load(meta.Station1);  %load station file              
end

if meta.Floats1 == false              %if your location does NOT have a proposed float file
    Floaty = false;             %make Floaty "false"
else                            %if your location has a proposed float file
    Floaty = true;              %make Floaty "true"
    FloatFile1 = load(meta.Floats1);   %load Float file
end

%x1 = StationFile1(:,3);
%y1 = StationFile1(:,2); %creates x vector for cruise line if you want to use stations
x1 = FloatFile1(:,3);  %creates x vector for cruise line if you want to use floats
y1 = FloatFile1(:,2);  %creates y vector for cruise line if you want to use floats
Cruise1 = line(x1,y1,'LineWidth',2,'Color',[0 0 0]);  %creates cruise line

if StationF == true             %if your area has a station file, the stations will plot
    numbrows = size(StationFile1);   %find how many rows are in the station file
    for row = 1:numbrows            %loops through every station
        Stat = plot(StationFile1(row,3),StationFile1(row,2),'.','MarkerSize',meta.MarkerSize,'LineWidth',2,'MarkerEdgeColor',[0 0 0]);  %plots station locations with bright green X and assigns to Stat for 'legendary' usage
        plot(StationFile1(row,3),StationFile1(row,2),'o','MarkerSize',meta.MarkerSize*0.5,'MarkerEdgeColor',[0 0 0]); 
    end
end

if Floaty == true                    %if your area has a float file plot the proposed float locations
   [numrows numcols] = size(FloatFile1);  %find how many rows and columns are in FloatFile to find how many rows to loop through
    for row = 1:numrows    %loop through the positions in the file
        Latitude = FloatFile1(:,2);   %get Latitude variable
        Longitude = FloatFile1(:,3);  %get Longitude variable
        Flo1 = plot(Longitude(row),Latitude(row),'x','MarkerSize',meta.MarkerSize,'LineWidth',4,'MarkerEdgeColor',[1 0 1]); %plot the proposed floats with magenta Xs and assign to Flo for legendary use
    end
end

%==================================================
%==================================================
%==================================================
%==================================================


if meta.Station2 == false             %if your location does NOT have a station file
    StationF = false;           %assign StationF as "false"
else %if your location has a station file (or a current Argo float position as with CSIRO)
    StationF = true; %assign StationF as "true"
    StationFile2 = load(meta.Station2);  %load station file              
end

if meta.Floats2 == false              %if your location does NOT have a proposed float file
    Floaty = false;             %make Floaty "false"
else                            %if your location has a proposed float file
    Floaty = true;              %make Floaty "true"
    FloatFile2 = load(meta.Floats2);   %load Float file
end


x2 = StationFile2(:,3); %creates y vector for cruise line if you want to use stations
y2 = StationFile2(:,2); %creates x vector for cruise line if you want to use stations
%x2 = FloatFile2(:,3);  %creates x vector for cruise line if you want to use floats
%y2 = FloatFile2(:,2);  %creates y vector for cruise line if you want to use floats
Cruise2 = line(x2,y2,'LineWidth',2,'Color',[0 0 1]);  %creates cruise line

if StationF == true             %if your area has a station file, the stations will plot
    numbrows = size(StationFile2);   %find how many rows are in the station file
    for row = 1:numbrows            %loops through every station
        Stat2 = plot(StationFile2(row,3),StationFile2(row,2),'.','MarkerSize',meta.MarkerSize,'LineWidth',2,'MarkerEdgeColor',[0 0 0]);  %plots station locations with bright green X and assigns to Stat for 'legendary' usage
        plot(StationFile2(row,3),StationFile2(row,2),'o','MarkerSize',meta.MarkerSize*0.5,'MarkerEdgeColor',[0 0 0]); 
    end
end

if Floaty == true                    %if your area has a float file plot the proposed float locations
   [numrows numcols] = size(FloatFile2);  %find how many rows and columns are in FloatFile to find how many rows to loop through
    for row = 1:numrows    %loop through the positions in the file
        Latitude = FloatFile2(:,2);   %get Latitude variable
        Longitude = FloatFile2(:,3);  %get Longitude variable
        Flo2 = plot(Longitude(row),Latitude(row),'.','MarkerSize',meta.MarkerSize,'LineWidth',4,'MarkerEdgeColor',[1 0 1]); %plot the proposed floats with magenta Xs and assign to Flo for legendary use
    end
end


%==================================================
%==================================================
%==================================================
%==================================================
%The below code is for the combined cruise plots for 3 cruises 
if meta.Station3 == false             %if your location does NOT have a station file
    StationF = false;           %assign StationF as "false"
else %if your location has a station file (or a current Argo float position as with CSIRO)
    StationF = true; %assign StationF as "true"
    StationFile3 = load(meta.Station3);  %load station file              
end

if meta.Floats3 == false              %if your location does NOT have a proposed float file
    Floaty = false;             %make Floaty "false"
else                            %if your location has a proposed float file
    Floaty = true;              %make Floaty "true"
    FloatFile3 = load(meta.Floats3);   %load Float file
end


x3 = StationFile3(:,3); %creates y vector for cruise line if you want to use stations
y3 = StationFile3(:,2); %creates x vector for cruise line if you want to use stations
%x3 = FloatFile3(:,3);  %creates x vector for cruise line if you want to use floats
%y3 = FloatFile3(:,2);  %creates y vector for cruise line if you want to use floats
Cruise3 = line(x3,y3,'LineWidth',2,'Color',[0.4 0.3 0.4]);  %creates cruise line

if StationF == true             %if your area has a station file, the stations will plot
    numbrows = size(StationFile3);   %find how many rows are in the station file
    for row = 1:numbrows            %loops through every station
        Stat3 = plot(StationFile3(row,3),StationFile3(row,2),'.','MarkerSize',meta.MarkerSize,'LineWidth',2,'MarkerEdgeColor',[0 0 0]);  %plots station locations with bright green X and assigns to Stat for 'legendary' usage
        plot(StationFile3(row,3),StationFile3(row,2),'o','MarkerSize',meta.MarkerSize*0.5,'MarkerEdgeColor',[0 0 0]); 
    end
end

if Floaty == true                    %if your area has a float file plot the proposed float locations
   [numrows numcols] = size(FloatFile3);  %find how many rows and columns are in FloatFile to find how many rows to loop through
    for row = 1:numrows    %loop through the positions in the file
        Latitude = FloatFile3(:,2);   %get Latitude variable
        Longitude = FloatFile3(:,3);  %get Longitude variable
        Flo3 = plot(Longitude(row),Latitude(row),'*','MarkerSize',meta.MarkerSize,'LineWidth',4,'MarkerEdgeColor',[1 0 1]); %plot the proposed floats with magenta Xs and assign to Flo for legendary use
    end
end
%===================================================================================

legend([Cruise1 Cruise2 Cruise3 Stat2 Stat3 Flo1 Flo2 Flo3],'I06S Cruise Track','AndrexII Cruise Track','Polarstern Cruise Track','AndrexII Station Locations','Polarstern Station Locations','I06S Float Locations','AndrexII Float Locations','Polarstern Float Locations','Location','Northeast')

coast = load('coast'); %loads coast
geoshow ('landareas.shp','FaceColor','black'); %creates continent on map

h = colorbar; %creates colorbar
set(get(h,'label'),'string','[m]','FontSize',16) %labels colorbar

%legend([Cruise Flo],'Cruise Track I06S','Station Locations', 'Proposed Float','location','northwest') %MUST CHANGE PER CRUISE

hold off

%===========
%===========
%^SLA map
%below: ADT map
%===========
%===========

figure(2)

hold on 

title(['Aviso ADT on May 9th 2018 for ',strrep(area,'_','\_')],'FontSize',16)
ylabel('Latitude (degrees)','FontSize',16)    %add y label for Latitude
xlabel('Longitude (degrees)','FontSize',16)   %add x label for Longitude

imagesc(A.lon,A.lat,A.adt) % creates the basic image we want to edit
set(gca,'YLim',[meta.LatMin meta.LatMax]); % sets map y-limits to the Latitudes specified for your area
set(gca,'XLim',[meta.LonMin meta.LonMax]); % sets map x-limits to the Latitudes specified for your area
set(gca,'FontSize',18)

contour(A.lon,A.lat,A.adt,[0 0],'Color','k')                  % outline the coasts with black contour by accessing Bathymetry file lon/lat/dep
[L,m] = contour(A.lon,A.lat,A.adt,[-0.4:0.1:0.8],'Color','k'); % -2000m isobath (farthest floats go to) black countour and assign lon/lat positions to L/M
clabel(L,m,'LabelSpacing',200); %label contour
[Z,b] = contour(A.lon,A.lat,A.adt,[-1.5:0.1:-0.5],'Color','k');
clabel(Z,b,'LabelSpacing',200); %label contour


%======================================================================================
%The below code is for the combined cruise plots for 3 cruises 
if meta.Station1 == false             %if your location does NOT have a station file
    StationF = false;           %assign StationF as "false"
else %if your location has a station file (or a current Argo float position as with CSIRO)
    StationF = true; %assign StationF as "true"
    StationFile1 = load(meta.Station1);  %load station file              
end

if meta.Floats1 == false              %if your location does NOT have a proposed float file
    Floaty = false;             %make Floaty "false"
else                            %if your location has a proposed float file
    Floaty = true;              %make Floaty "true"
    FloatFile1 = load(meta.Floats1);   %load Float file
end

%x1 = StationFile1(:,3);
%y1 = StationFile1(:,2); %creates x vector for cruise line if you want to use stations
x1 = FloatFile1(:,3);  %creates x vector for cruise line if you want to use floats
y1 = FloatFile1(:,2);  %creates y vector for cruise line if you want to use floats
Cruise1 = line(x1,y1,'LineWidth',2,'Color',[0 0 0]);  %creates cruise line

if StationF == true             %if your area has a station file, the stations will plot
    numbrows = size(StationFile1);   %find how many rows are in the station file
    for row = 1:numbrows            %loops through every station
        Stat = plot(StationFile1(row,3),StationFile1(row,2),'.','MarkerSize',meta.MarkerSize,'LineWidth',2,'MarkerEdgeColor',[0 0 0]);  %plots station locations with bright green X and assigns to Stat for 'legendary' usage
        plot(StationFile1(row,3),StationFile1(row,2),'o','MarkerSize',meta.MarkerSize*0.5,'MarkerEdgeColor',[0 0 0]); 
    end
end

if Floaty == true                    %if your area has a float file plot the proposed float locations
   [numrows numcols] = size(FloatFile1);  %find how many rows and columns are in FloatFile to find how many rows to loop through
    for row = 1:numrows    %loop through the positions in the file
        Latitude = FloatFile1(:,2);   %get Latitude variable
        Longitude = FloatFile1(:,3);  %get Longitude variable
        Flo1 = plot(Longitude(row),Latitude(row),'x','MarkerSize',meta.MarkerSize,'LineWidth',4,'MarkerEdgeColor',[1 0 1]); %plot the proposed floats with magenta Xs and assign to Flo for legendary use
    end
end

%==================================================
%==================================================
%==================================================
%==================================================


if meta.Station2 == false             %if your location does NOT have a station file
    StationF = false;           %assign StationF as "false"
else %if your location has a station file (or a current Argo float position as with CSIRO)
    StationF = true; %assign StationF as "true"
    StationFile2 = load(meta.Station2);  %load station file              
end

if meta.Floats2 == false              %if your location does NOT have a proposed float file
    Floaty = false;             %make Floaty "false"
else                            %if your location has a proposed float file
    Floaty = true;              %make Floaty "true"
    FloatFile2 = load(meta.Floats2);   %load Float file
end


x2 = StationFile2(:,3); %creates y vector for cruise line if you want to use stations
y2 = StationFile2(:,2); %creates x vector for cruise line if you want to use stations
%x2 = FloatFile2(:,3);  %creates x vector for cruise line if you want to use floats
%y2 = FloatFile2(:,2);  %creates y vector for cruise line if you want to use floats
Cruise2 = line(x2,y2,'LineWidth',2,'Color',[0 0 1]);  %creates cruise line

if StationF == true             %if your area has a station file, the stations will plot
    numbrows = size(StationFile2);   %find how many rows are in the station file
    for row = 1:numbrows            %loops through every station
        Stat2 = plot(StationFile2(row,3),StationFile2(row,2),'.','MarkerSize',meta.MarkerSize,'LineWidth',2,'MarkerEdgeColor',[0 0 0]);  %plots station locations with bright green X and assigns to Stat for 'legendary' usage
        plot(StationFile2(row,3),StationFile2(row,2),'o','MarkerSize',meta.MarkerSize*0.5,'MarkerEdgeColor',[0 0 0]); 
    end
end

if Floaty == true                    %if your area has a float file plot the proposed float locations
   [numrows numcols] = size(FloatFile2);  %find how many rows and columns are in FloatFile to find how many rows to loop through
    for row = 1:numrows    %loop through the positions in the file
        Latitude = FloatFile2(:,2);   %get Latitude variable
        Longitude = FloatFile2(:,3);  %get Longitude variable
        Flo2 = plot(Longitude(row),Latitude(row),'.','MarkerSize',meta.MarkerSize,'LineWidth',4,'MarkerEdgeColor',[1 0 1]); %plot the proposed floats with magenta Xs and assign to Flo for legendary use
    end
end


%==================================================
%==================================================
%==================================================
%==================================================
%The below code is for the combined cruise plots for 3 cruises 
if meta.Station3 == false             %if your location does NOT have a station file
    StationF = false;           %assign StationF as "false"
else %if your location has a station file (or a current Argo float position as with CSIRO)
    StationF = true; %assign StationF as "true"
    StationFile3 = load(meta.Station3);  %load station file              
end

if meta.Floats3 == false              %if your location does NOT have a proposed float file
    Floaty = false;             %make Floaty "false"
else                            %if your location has a proposed float file
    Floaty = true;              %make Floaty "true"
    FloatFile3 = load(meta.Floats3);   %load Float file
end


x3 = StationFile3(:,3); %creates y vector for cruise line if you want to use stations
y3 = StationFile3(:,2); %creates x vector for cruise line if you want to use stations
%x3 = FloatFile3(:,3);  %creates x vector for cruise line if you want to use floats
%y3 = FloatFile3(:,2);  %creates y vector for cruise line if you want to use floats
Cruise3 = line(x3,y3,'LineWidth',2,'Color',[0.4 0.3 0.4]);  %creates cruise line

if StationF == true             %if your area has a station file, the stations will plot
    numbrows = size(StationFile3);   %find how many rows are in the station file
    for row = 1:numbrows            %loops through every station
        Stat3 = plot(StationFile3(row,3),StationFile3(row,2),'.','MarkerSize',meta.MarkerSize,'LineWidth',2,'MarkerEdgeColor',[0 0 0]);  %plots station locations with bright green X and assigns to Stat for 'legendary' usage
        plot(StationFile3(row,3),StationFile3(row,2),'o','MarkerSize',meta.MarkerSize*0.5,'MarkerEdgeColor',[0 0 0]); 
    end
end

if Floaty == true                    %if your area has a float file plot the proposed float locations
   [numrows numcols] = size(FloatFile3);  %find how many rows and columns are in FloatFile to find how many rows to loop through
    for row = 1:numrows    %loop through the positions in the file
        Latitude = FloatFile3(:,2);   %get Latitude variable
        Longitude = FloatFile3(:,3);  %get Longitude variable
        Flo3 = plot(Longitude(row),Latitude(row),'*','MarkerSize',meta.MarkerSize,'LineWidth',4,'MarkerEdgeColor',[1 0 1]); %plot the proposed floats with magenta Xs and assign to Flo for legendary use
    end
end
%===================================================================================

legend([Cruise1 Cruise2 Cruise3 Stat2 Stat3 Flo1 Flo2 Flo3],'I06S Cruise Track','AndrexII Cruise Track','Polarstern Cruise Track','AndrexII Station Locations','Polarstern Station Locations','I06S Float Locations','AndrexII Float Locations','Polarstern Float Locations','Location','Northeast')

coast = load('coast'); %loads coast
geoshow ('landareas.shp','FaceColor','black'); %creates continents

h = colorbar; %creates colorbar
set(get(h,'label'),'string','[m]') %labels colorbar

%legend([Cruise Flo],'Cruise Line I06S','Proposed Float','location','northwest') %MUST CHANGE FOR EACH CRUISE

hold off







