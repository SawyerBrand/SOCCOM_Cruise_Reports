function BuoyancyFluxMap(cruise); 

meta = MetaInfo(cruise);
buoyancy = load(meta.BuoyancyFluxFile);

mSmoMin = min(min(-1*buoyancy.BuoyancyImage)); %finds minimum of data for the special colormap
mSmoMax = max(max(-1*buoyancy.BuoyancyImage)); %finds maximum of data for the special colormap

ncolors = 2;  % number of colors between integers

vmax = max(abs(floor(mSmoMin)),abs(ceil(mSmoMax))); 
[brcmap, rlims, rticks, rbfncol, rctable] = cptcmap('GMT_Buoyancy.cpt', 'mapping', 'direct', 'ncol' ,vmax*2*ncolors);


clf 


hold on
title([ strrep(cruise,'_','\_'), ' Buoyancy Flux (Large & Yeager 2009)']) %creates title for the plot

h = colorbar; %creates colorbar
set(get(h,'label'),'string','(W m^-2)','FontSize',16) %labels colorbar
caxis([-20 80])

colormap(brcmap) %calls the special colormap created above

set(gca,'YDir','normal'); %makes it so y values count down in the negative y direction
set(gca,'YLim',[meta.LatMin meta.LatMax]); % sets map y-limits to the Latitudes specified for your area
set(gca,'XLim',[meta.LonMin meta.LonMax]); %sets map x-limits to the Longitudes specified for your area
set(gca,'FontSize',19)

imagesc(buoyancy.BuoyancyLon,buoyancy.BuoyancyLat,(-1*buoyancy.BuoyancyImage)) %creates the map background from the data (the buoyancy itself needs to be multiplied by neg 1)

[L,m] = contour(buoyancy.BuoyancyLon,buoyancy.BuoyancyLat,(-1*buoyancy.BuoyancyImage),[-160:10:160],'Color','k'); %creates black contour of values
clabel(L,m,'LabelSpacing',200); %labels the contours

%INSERT CODE FOR STATIONS,FLOATS,TRACK BELOW THIS - choose from README code
%choose based on number of cruises per map

%===================================================================================
%This is for a single cruise
if meta.Station == false             %if your location does NOT have a station file
    StationF = false;           %assign StationF as "false"
else                              %if your location has a station file (or a current Argo float position as with CSIRO)
    StationFile = load(meta.Station);  %load station file
    StationF = true;              %assign StationF as "true"
end

if meta.Floats == false              %if your location does NOT have a proposed float file
    Floaty = false;             %make Floaty "false"
else                            %if your location has a proposed float file
    Floaty = true;              %make Floaty "true"
    FloatFile = load(meta.Floats);   %load Float file
end


%x = StationFile(:,3); %creates y vector for cruise line if you want to use stations
%y = StationFile(:,2); %creates x vector for cruise line if you want to use stations
x = FloatFile(:,3);  %creates x vector for cruise line if you want to use floats
y = FloatFile(:,2);  %creates y vector for cruise line if you want to use floats
Cruise = line(x,y,'LineWidth',2,'Color',[0 0 1]);  %creates cruise line

if StationF == true             %if your area has a station file, the stations will plot
    numbrows = size(StationFile);   %find how many rows are in the station file
    for row = 1:numbrows            %loops through every station
        Stat = plot(StationFile(row,3),StationFile(row,2),'.','MarkerSize',meta.MarkerSize,'LineWidth',2,'MarkerEdgeColor',[0 0 0]);  %plots station locations with bright green X and assigns to Stat for 'legendary' usage
        plot(StationFile(row,3),StationFile(row,2),'o','MarkerSize',meta.MarkerSize*0.5,'MarkerEdgeColor',[0 0 0]); 
    end
end

if Floaty == true                    %if your area has a float file plot the proposed float locations
    [numrows numcols] = size(FloatFile);  %find how many rows and columns are in FloatFile to find how many rows to loop through
    for row = 1:numrows    %loop through the positions in the file
        Latitude = FloatFile(:,2);   %get Latitude variable
        Longitude = FloatFile(:,3);  %get Longitude variable
        Flo = plot(Longitude(row),Latitude(row),'x','MarkerSize',meta.MarkerSize,'LineWidth',4,'MarkerEdgeColor',[1 0 0]); %plot the proposed floats with magenta Xs and assign to Flo for legendary use

    end
end 
%======================================================================================


legend([Cruise Flo],'I06S Cruise Track','I06S Float Locations','Location','Northeast')

xlabel('Longitude','FontSize',16) %labels xaxis
ylabel('Latitude','FontSize',16) %labels yaxis

coast = load('coast'); %loads coast 
continent = geoshow('landareas.shp','FaceColor','black'); %maps the continents on the map

%legend([Cruise1 Cruise2 Flo1 Flo2 Stat],'Cruise Track Polarstern','Cruise Track Andrex','Float Locations','Float Locations','Station Locations','Location','Northwest') %change based on what files you got

hold off
