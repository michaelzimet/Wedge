<a href="https://doi.org/10.5281/zenodo.18316699"><img src="https://zenodo.org/badge/1138418139.svg" alt="DOI"></a>

# Calculus of the Deep Brain Stimulation Voltage Distribution

# Voltage Distribution

The scripts plot_Electrode_cyl.m and plot_Electrode_dir.m generate Figures 1 and 2 respectively. These are based on the scripts calc_runCyl.m and calc_runDir.m along with the functions cylPot.m and dirPot.m respectively. 

The script plot_at_mesh_nodes.m along with calc_at_mesh_nodes.m generates Figures S1 and S2. The script plot_scalers_analytic_soma.m along with calc_scalers_analytic_soma.m generates Figure S3. The script plot_scalers_analytic_compartments.m generates Figure S4. The helper function fn_calc_scalers_analytic_compartments.m and the script compile_scalers_analytic.m are used to parallelize the computation of the compartment potentials on the computing cluster.

# Axonal Activation

The script plot_axon_threshold.m, along with calc_axon_analytic.m and calc_axon_threshold.m generates the right panel of Figure 3.

# LFP

The script plot_LFP.m generates the right side of Figure 4, Figure 5, and Figure S5.
