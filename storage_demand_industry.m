%% Export Energy production needed= (current energy export* world growth rates 
%   * avg fuel eff) / specific ren-fuel eff

clc
close all
clear all

%% notes!:

% --> Turkey is not yet evaluated, might be interesting

% --> No efficiency changes taken into account yet, other than that of the
%     exported fuels(<also not yet with acurate data)
% --> So far neglected the current industries from all the other
%     countries(other than SA, KU, IR)
% --> ALL energy units used are in MWh
% --> !! Check the values, now used from one of the excel docs (GDP growth
% --> Only used steel and alu for the energy intencive industries so far

%% assumptions:

% --> Saudi arabia, iraq and kuwait remain in the energy buisness
% --> The entire region will host a portion of the worlds energy intensive
%     industries , say we make 5%(see DATA chapt.) (yust a value taken, no
%     sourse) 
% --> At this poin, all industries run 24/7, without any changes in day and
%     sesonal fluctuations

%% DATA

% time passed for growth factors
    years= 2050-2015; %data used is from 2015

% share of energy intensive industries:
    SHARE_x = 0.05; % world wide share of the energy intensive industries in our region

% current energy usage in those industries:
    E_steel_2017= 10555555555;    %MWH/ YEAR % = 38 EJ/YEAR !! (from arnold lectures
    E_aluminium_2017= 2111111111; %MWh/YEAR % = 7.6 % EJ/YEAR !! 
    
    %%E_amonium_2017= ??
% omreken function
Ktoe_MWh=11630 % 1Ktoe = 11630MWh 


%% current energy usage (MWh)

    %Saudi arabia:
        % industry
            E_ind_use_SA_2015=43893*Ktoe_MWh; % 43893Ktoe ( combined energy sourses)
        % exports:          
            x_SA=374539*Ktoe_MWh;% crude oil: 
            y_SA= 78792*Ktoe_MWh;% oil      
            z_SA=0*Ktoe_MWh;% NG
          E_exp_cur_SA=x_SA + y_SA + z_SA;
    % IRAQ
        % industry
            E_ind_use_IR_2015=40786*Ktoe_MWh; % 40786Ktoe ( combined energy sourses)
        % exports:           
            x_IR=67282*Ktoe_MWh;% crude oil:          
            y_IR= 19314*Ktoe_MWh;% oil        
            z_IR=7668*Ktoe_MWh;% NG
          E_exp_cur_IR=x_IR + y_IR + z_IR;            
    % KUWAIT
        % industry
            E_ind_use_KU_2015=6494*Ktoe_MWh; % 6494Ktoe ( combined energy sourses)
        % exports:         
            x_KU=101147*Ktoe_MWh;% crude oil         
            y_KU= 32889*Ktoe_MWh;% oil
            z_KU=0*Ktoe_MWh;% NG
          E_exp_cur_KU=x_KU + y_KU + z_KU;
    % Turkey
        % industry only, energy exports are neglected
            E_ind_use_TU_2015 = 26158*Ktoe_MWh;
          
E_exp_cur = E_exp_cur_SA + E_exp_cur_KU + E_exp_cur_IR;

%% growth rates:

    %world growth rates: 
        GR_gdp_world= 2.4; % in [%] growt rate GDP:
        GF_gdp_world= (1 + GR_gdp_world/100)^years;%[-]
        GF_pop_world= 1.29;%[-]  Growth factor world population

    % Saudy arabia
        GR_gdp_SA= 2.4;                         %[%]    %growth rate GDP
        GF_gdp_SA= (1 + GR_gdp_SA/100)^years;   %[-]    %growth factor GDP
        GR_pop_SA= 1.01;                        %[%]    %growth rate population
        GF_pop_SA= (1 + GR_pop_SA/100)^years;   %[-]    %growth rate population

    % iraq
        GR_gdp_IR= 2.4; % in [%]
        GF_gdp_IR= (1 + GR_gdp_IR/100)^years;%[-]
        GR_pop_IR= 2.32; % in [%]
        GF_pop_IR= (1 + GR_pop_IR/100)^years;%[-]
        
    % Kuwait
        GR_gdp_KU= 2.4; % in [%]
        GF_gdp_KU= (1 + GR_gdp_KU/100)^years; %[-]
        GR_pop_KU= 1.02; % in [%]
        GF_pop_KU= (1 + GR_pop_KU/100)^years;%[-]
    
    % Turkey    
        GR_gdp_TU= 2.4; % in [%]
        GF_gdp_TU= (1 + GR_gdp_TU/100)^years; %[-]
        GR_pop_TU= 0.57; % in [%]
        GF_pop_TU= (1 + GR_pop_TU/100)^years;%[-]
        
        
%% efficiencies    

EFF_improv=1; % 1 is no change <-- this is not linked to fuel eff (yet)
EFF_imp_alu= 1;
EFF_imp_steel = 1; 

% avg fuel efficiency:
    AVG_fuel_eff= 0.20; %<< not based on true data, yust a value
    
% avg round trip efficiency of the renuable fuel:
    AVG_RT_eff_fuelx= 0.20; %<< not based on true data, yust a value

    
%% ------------Data calculations-------------------------------
    
%%    The energy industries: (SAUDI ARABIA , IRAQ, KUWAIT)


    % export energy production needed: (per year)
        E_exp_gen_2050= (E_exp_cur * GF_gdp_world * GF_pop_world * AVG_fuel_eff)/AVG_RT_eff_fuelx
    % no daily fluctuations taken into account, only seasonal, as that would not be cost efficient to store    
      % solar power generation seems fairly constant over the year  
      % so for now, we work with the essumption that generation is even over the seasons

    % there are 365*24*4 = 35040 15min time slots in a year(aboud,schrikerljaar?)  
        ndT_15=35040;
        E_exp_per15=E_exp_gen_2050/ndT_15;

    % energy usage industry, if only dependent on their own growth rates
    % without export energy generation 
        E_ind_use_SA_2050= E_ind_use_SA_2015 * GF_pop_SA * GF_gdp_SA * EFF_improv
        E_ind_use_IR_2050= E_ind_use_IR_2015 * GF_pop_IR * GF_gdp_IR * EFF_improv 
        E_ind_use_KU_2050= E_ind_use_KU_2015 * GF_pop_KU * GF_gdp_KU * EFF_improv
        E_ind_use_TU_2050= E_ind_use_TU_2015 * GF_pop_TU * GF_gdp_TU * EFF_improv

    % Assume industry energy usage to be constant for now aswel:
        E_ind_use_SA_per15= E_ind_use_SA_2050/ndT_15;
        E_ind_use_IR_per15= E_ind_use_IR_2050/ndT_15;
        E_ind_use_KU_per15= E_ind_use_KU_2050/ndT_15;
        E_ind_use_TU_per15= E_ind_use_TU_2050/ndT_15;

    %total energy use in idustury(no exp) in our region per 15
        E_ind_use_per15 = E_ind_use_SA_per15 + E_ind_use_IR_per15 + E_ind_use_KU_per15 + E_ind_use_TU_per15;

    %total energy use in idustury( incl export) in our region per 15
        E_industry_incl_per15=E_ind_use_per15+E_exp_per15
   
 %% The Shares of the energy intensive industries:
growthfactors = GF_gdp_world * GF_pop_world ; %// or use sourse saying 3.4%/Year growth for the intensive proceces
E_steel_2050= E_steel_2017 * growthfactors * EFF_imp_steel * SHARE_x; % 
E_aluminium_2050= E_aluminium_2017* growthfactors * EFF_imp_alu *SHARE_x; % 
% running all day 24/7? if so:--> equal energy use in all time slots
    
E_steel_2050_per15=E_steel_2050/ndT_15;    
E_aluminium_2050_per15=E_aluminium_2050/ndT_15;

E_intensive_indu_per15=E_aluminium_2050_per15+E_steel_2050_per15
    
    
%% ---TOTAL Industrial Enregy Demand per15---
E_total_industrial_per15= E_intensive_indu_per15+E_industry_incl_per15
E_tot_indu_year_MWh=E_total_industrial_per15*ndT_15     

l=linspace(0,8760,35040);
for a = 1:length(l)
    E_indu_15(a)= E_total_industrial_per15;
end
    
 plot(E_indu_15)  
 axis; ylabel('E [MWh]'); xlabel('15 min timeslot');   
 title('Energy usage in industry per 15 minutes');
      
 
 
 
 
 
 
 
 