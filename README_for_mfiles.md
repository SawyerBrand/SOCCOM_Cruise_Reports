

CONTENTS: listing of maps for pre-cruise, how they are created, the code for one cruise track, and the code for two cruise tracks

LatLonDepth 
1. get_bathy_from_etopo2.m (gets data for the right cruise area)
2. LatLonDepth.m (plots the bathy for that area)

Wind Stress Plot: 
1. GMT_to_MAT.m (for the data) ??? IS IT FIXED FOR THE BREAK AT 0
2. get_curl.m (for the data)
3. GMT_to_vectorMAT.m (for the vector data) 
4. get_vector_curl.m (for the vector data) 
5. CurlMap.m (compiles both vector data and other data to create map)

Mixed Layer Depth
1. MixedLayerDepth.m (creates data for a specific area and maps it - from 'Mixed_Layer_Depths.mat')
*still needs to be fixed to get right on NaN values

CO2
CO2 is a one-step function that uses several files (all within the file cpt_matlab)

Heat Flux 
1. GMT_to_HEAT.m (loads the file 'LargeYeager_GlobalFluxes.dat' to get the variables and correct the Lon to -180 to 180)
2. get_heat.m (limits the data to the right area for the cruise)
3. HeatFluxMap.m (does the actual plotting of values with stat and flo)

Fresh Water Flux 
1. GMT_to_FreshWater.m (loads the variables from the file 'LargeYeager_GlobalFluxes.dat' and corrects the longitude to -180 to 180 and creates 'FreshWater.mat')
2. get_fresh_water.m (limits data to the right area from the cruise using 'FreshWater.mat')
3. FreshWaterMap.m

Buoyancy
1. GMT_to_Buoyancy.m (loads the variables from the file 'LargeYeager_GlobalFluxes.dat' and corrects the longitude to -180 to 180 and creates 'BuoyancyData.mat'
2. get_buoyancyflux.m (limits data to the right area from the cruise using 'BuoyancyData.mat')
3. BuoyancyFluxMap.m (creates map of buoyancy flux using stat,flo,etc)

SST - still needs to be made

Chlorophyll Map:
1. GMT_to_Chlorophyll.m (to read data from original file - this must be done multiple times if you want to make plots between certain values)
2. get_chloro.m (creates file for the exact cruise)
3. chloro_map.m (creates map for the cruise)

Most Recent ARGO
Needs to be created individually from LatLonDepth using just float locations from online, no cruise line

Aviso
1. GMT_to_Aviso.m (loads variables from 'nrt_global_allsat_phy_l4_20180509_20180509.nc' and fixes the longitude to be -180 to 180, creating data file 'Aviso_Data.mat');
2. get_aviso.m (limits data to the right area for the cruise using 'AvisoData.mat')
3. Altimetry.m (creates the maps for sla and adt using stat, flo, etc)

FLOAT TRAJECTORY MAPPING
%==================================================================
d = load('6901814data.mat');

for row = 10:1:length(d.data.lat)    %loop through the positions in the file
    Latitude = d.data.lat;   %get Latitude variable
    Longitude = d.data.lon;  %get Longitude variable
    Flo = plot(Longitude(row),Latitude(row),'.','MarkerSize',meta.MarkerSize,'LineWidth',4,'MarkerEdgeColor',[1 0 0]); 
end

Cruise = line(Longitude(10:442),Latitude(10:442),'LineWidth',2,'Color',[0 0 1]);


%==================================================================


POST-CRUISE SIMPLE PLOT
%===================================================================================

if meta.Floats == false              %if your location does NOT have a proposed float file
    Floaty = false;             %make Floaty "false"
else                            %if your location has a proposed float file
    Floaty = true;              %make Floaty "true"
    FloatFile = load(meta.Floats);   %load Float file
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





BELOW IS THE STAT/FLO/TRACK CODE FOR ONE CRUISE TRACK AND FOR TWO:
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


x = StationFile(:,3); %creates y vector for cruise line if you want to use stations
y = StationFile(:,2); %creates x vector for cruise line if you want to use stations
%x = FloatFile(:,3);  %creates x vector for cruise line if you want to use floats
%y = FloatFile(:,2);  %creates y vector for cruise line if you want to use floats
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


%======================================================================================
%The below code is for the combined cruise plots for multiple cruises 
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


x1 = StationFile1(:,3); %creates y vector for cruise line if you want to use stations
y1 = StationFile1(:,2); %creates x vector for cruise line if you want to use stations
%x1 = FloatFile1(:,3);  %creates x vector for cruise line if you want to use floats
%y1 = FloatFile1(:,2);  %creates y vector for cruise line if you want to use floats
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
        Flo = plot(Longitude(row),Latitude(row),'x','MarkerSize',meta.MarkerSize,'LineWidth',4,'MarkerEdgeColor',[1 0 1]); %plot the proposed floats with magenta Xs and assign to Flo for legendary use
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
        Stat = plot(StationFile2(row,3),StationFile2(row,2),'.','MarkerSize',meta.MarkerSize,'LineWidth',2,'MarkerEdgeColor',[0 0 0]);  %plots station locations with bright green X and assigns to Stat for 'legendary' usage
        plot(StationFile2(row,3),StationFile2(row,2),'o','MarkerSize',meta.MarkerSize*0.5,'MarkerEdgeColor',[0 0 0]); 
    end
end

if Floaty == true                    %if your area has a float file plot the proposed float locations
   [numrows numcols] = size(FloatFile2);  %find how many rows and columns are in FloatFile to find how many rows to loop through
    for row = 1:numrows    %loop through the positions in the file
        Latitude = FloatFile2(:,2);   %get Latitude variable
        Longitude = FloatFile2(:,3);  %get Longitude variable
        Flo = plot(Longitude(row),Latitude(row),'.','MarkerSize',meta.MarkerSize,'LineWidth',4,'MarkerEdgeColor',[1 0 1]); %plot the proposed floats with magenta Xs and assign to Flo for legendary use
    end
end
%===================================================================================

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


x1 = StationFile1(:,3); %creates y vector for cruise line if you want to use stations
y1 = StationFile1(:,2); %creates x vector for cruise line if you want to use stations
%x1 = FloatFile1(:,3);  %creates x vector for cruise line if you want to use floats
%y1 = FloatFile1(:,2);  %creates y vector for cruise line if you want to use floats
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
        Stat = plot(StationFile2(row,3),StationFile2(row,2),'.','MarkerSize',meta.MarkerSize,'LineWidth',2,'MarkerEdgeColor',[0 0 0]);  %plots station locations with bright green X and assigns to Stat for 'legendary' usage
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


%x3 = StationFile3(:,3); %creates y vector for cruise line if you want to use stations
%y3 = StationFile3(:,2); %creates x vector for cruise line if you want to use stations
x3 = FloatFile3(:,3);  %creates x vector for cruise line if you want to use floats
y3 = FloatFile3(:,2);  %creates y vector for cruise line if you want to use floats
Cruise3 = line(x3,y3,'LineWidth',2,'Color',[0.4 0.3 0.4]);  %creates cruise line

if StationF == true             %if your area has a station file, the stations will plot
    numbrows = size(StationFile1);   %find how many rows are in the station file
    for row = 1:numbrows            %loops through every station
        Stat = plot(StationFile3(row,3),StationFile3(row,2),'.','MarkerSize',meta.MarkerSize,'LineWidth',2,'MarkerEdgeColor',[0 0 0]);  %plots station locations with bright green X and assigns to Stat for 'legendary' usage
        plot(StationFile1(row,3),StationFile1(row,2),'o','MarkerSize',meta.MarkerSize*0.5,'MarkerEdgeColor',[0 0 0]); 
    end
end

if Floaty == true                    %if your area has a float file plot the proposed float locations
   [numrows numcols] = size(FloatFile1);  %find how many rows and columns are in FloatFile to find how many rows to loop through
    for row = 1:numrows    %loop through the positions in the file
        Latitude = FloatFile3(:,2);   %get Latitude variable
        Longitude = FloatFile3(:,3);  %get Longitude variable
        Flo3 = plot(Longitude(row),Latitude(row),'*','MarkerSize',meta.MarkerSize,'LineWidth',4,'MarkerEdgeColor',[1 0 1]); %plot the proposed floats with magenta Xs and assign to Flo for legendary use
    end
end
%===================================================================================

[Cruise1 Cruise2 Cruise3 Flo1 Flo2 Flo3],'Polarstern Track','AndrexII Track','I06S Track','Float Locations','Float Locations','Float Locations','Location','Northwest')
