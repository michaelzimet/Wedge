clear
clc
%addpath('/Users/msohailnoor/Documents/Sohail_Projects/Tools/Nifti_toolbox');
dir = '/Users/mj217/Documents/MATLAB/';

subject = 'P1';
%side = 'RightSTN';

file_name = ['nrnlocshet_',subject,'.mat'];
load([dir, 'nrn_locs/',file_name]);

disp('Loading Scalers')
load([dir, 'scalers/','scalers_',subject,'_no_encap.mat']);
disp('Scalers Loaded')

load([dir, 'nrn_locs/', 'sectionNames.mat']);
load([dir, 'calc/scalers_analytic_',subject,'_comp_approx2.mat']);

mask = isnan(scalers_analytic);
scalers_analytic(mask) = 0;

nrnlocs(:,4)=[];

deltas = 0.7;
rads = 1.4; 

synchoffset = [0, 0, 0]; 
numsecs = length(sectionnames); 
numneu = length(nrnlocs); 
synchcenters = zeros(length(deltas),3); 

for z = 1:length(deltas)
    synchcenters(z,1:3) = (longvector(2,:).*deltas(z))+(longvector(1,:).*(1-deltas(z)));
end


for j = 1:size(synchcenters,1) 
    
    delta = deltas(j);
    synchcenter = synchcenters(j,:)+synchoffset;

    for i = 1:length(rads) 
        radius = rads(i); 
        check = [0,0];
        synchpoolindex = 1;
        randpoolindex = 1;
        lfp = zeros(1000,8);
        lfp_analytic = zeros(size(lfp));
        scaledpots = zeros(1000,365,8);
        scaledpots_analytic = zeros(size(scaledpots));
        tic
        runtime = 0;

        for nrn = 1:numneu    

            if mod(nrn,round(numneu/100)) == 0 
                disp(strcat([num2str(round(nrn/numneu*100)),'% done. ',num2str(nrn),'/',num2str(numneu),' took ',num2str(toc),'s']))
                runtime = runtime+toc;
                tic
            end

            if  sqrt(sum((nrnlocs(nrn,:)-synchcenter).^2)) < radius 
                check(1) = check(1)+1; 
                nrnnum = synchpoolindex;
                pool = '/sync_Nic/sig_6_N_';
                if synchpoolindex > 10000 
                    synchpoolindex = 1;
                    nrnnum = 1;
                else
                    synchpoolindex = synchpoolindex+1;
                end

            else
                check(2) = check(2)+1; 
                nrnnum = randpoolindex;
                pool = '/async_Nic/sig_15_N_';
                if randpoolindex > 3000 
                    randpoolindex = 1;
                    nrnnum = 1;
                else
                    randpoolindex = randpoolindex+1;
                end
            end 

            potfname = [dir, 'nrns/',pool,num2str(nrnnum),'.bin']; 
            fileIDp = fopen(potfname,'r');
            secpots = fread(fileIDp,[1000 numsecs],'double'); 
            fclose(fileIDp);                                    

            % use analytical function here
            % change second entry


            for contact=1:8
                scaledpots(:,:,contact) = bsxfun(@times,secpots,squeeze(scalers(contact,nrn,:))');
                scaledpots_analytic(:,:,contact) = bsxfun(@times,secpots,squeeze(scalers_analytic(contact,nrn,:))'); 
            end
                      
            lfp = lfp + squeeze(sum(scaledpots,2));
            lfp_analytic = lfp_analytic + squeeze(sum(scaledpots_analytic,2));
            %disp(lfp_analytic)

            clearvars potfname fileIDp
        end 

        disp(['check = ',num2str(check)]) 
        name = [dir,'LFP_data/','tempresult_del',num2str(delta),'_rad',num2str(radius),'.mat']; 
        save(name,'check','lfp','synchcenter','radius','delta'); 
    end 
end 

save("calc/sim_result_approx2.mat", "lfp", "lfp_analytic", '-mat')
