# TAB
**Instructions for Replicating TAB Analysis**

Jordan M. McKaig, MinGyu Kim, Christopher E. Carr. Translation as a Biosignature. Preprint: bioRxiv (submitted 2023-08-10). Intended for submission to Astrobiology.

1. Download repository files from https://osf.io/56qkv/. Save in a folder titled "data". 

2. Verify installation of prerequisites: MATLAB (tested on version R2023a), MATLAB Statistics and Machine Learning Toolbox, MATLAB Image Processing Toolbox, MATLAB Classification Learner tool.

3. Generate sample runtime data from Table S1 by running *sample_information.m*.

4. Generate plots of example events (dsDNA high range ladder event #3 and ribosome event #1000) from Figure 1 by running *fig1_event_examples.m*.

5. Generate Δconductance vs. dwell time overlaid plots for DNA samples and buffers by running *fig2_overlaid_DNA_plots.m*.

6. Generate example DNA events (pUC19 event #57, dsDNA 1 kb ladder event #25, dsDNA high range ladder event #10) from Figure 3 Panels A, D, G, J by running *fig3_ADGJ_DNA_event_examples.m*.

7. Generate weighted Δconductance vs. dwell time heat maps for pUC19, 1 kb ladder, and high range ladder DNA samples from Figure 3 Panels B, E, H by running *fig3_BEH_heatmap_indv_DNA.m*.

8. Generate plots of events within the red boxes on the heat maps from Figure 3 Panels C, F, I by running *fig3_CFI_DNA_box_events.m*.

9. Generate weighted Δconductance vs. dwell time heat maps for all DNA samples together from Figure 3 Panel K by running *fig3_K_heatmap_all_DNA.m*.

10. Generate example RNA events (dsRNA event #852, ssRNA event #55) from Figure 4 Panels A, D, G by running *fig4_ADG_RNA_event_examples.m*. 

11. Generate weighted Δconductance vs. dwell time heat maps for dsRNA and ssRNA samples from Figure 4 Panels B, E by running *fig4_BE_heatmap_indv_RNA.m*.

12. Generate plots of events within the red boxes on the heat maps from Figure 4 Panels C, F by running *fig4_CF_RNA_box_events.m*.

13. Generate weighted Δconductance vs. dwell time heat maps for all RNA samples together from Figure 4 Panel H by running *fig4_H_heatmap_all_RNA.m*.

14. Generate ribosome heat map from Figure 5 Panel A by running *fig5_A_heatmap_ribosome.m*.

15. Generate example intact ribosome and ribosomal fragment events (ribosome event #81, #7) by running *fig5_B_ribosome_event_examples.m*.

16. Generate plots of events withi the red boxes on the heat maps from Figure 5 Panels C, D by running *fig5_CD_plot_ribosome_box_events.m*.

17. Generate Δconductance vs. dwell time overlaid plots for all samples and all samples excluding ribosomes from Figure 6 by running *fig6_overlaid_event_plot.m*.

18. Navigate into the machine_learning folder.

19. Open the MATLAB Classification Learner app. Within this session, open *ClassificationLearner.mat*. This session was generated with input event data formatted with *get_event_table_unlabeled.m*. View machine learning models and results, including the confusion matrix from Figure 7 (output from the Medium Tree model).

20. Open *trees.mat*. Generate Medium Tree decision points from Figure S1 by running *viewtree.m*.

<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/">Creative Commons Attribution-NonCommercial 4.0 International License</a>.
