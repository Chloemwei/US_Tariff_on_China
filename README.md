# US_Tariff_on_China
An estimation of the impact of tariff reduction on industries based on price elasticity.   
   
For the good of the U.S. and world economy, the International Monetary Fund (IMF) has advised the Biden administration to end the tariffs imposed by Donald Trump and his administration. However, without indications of which We want to estimate the impact of Biden's possible tariff reduction on Chinese industries, but where shall we start?  
  
There are a few recommended methods:  
  
1) After a few rounds of imposition of Trump's Chinese Tariffs, we can follow the track of which product groups had been granted the reduction/elimination. We assume that groups once were granted the tariff elimination are most likely to be eliminated again by Biden and his administration.  
  
2) The already tariff-free groups of products. Mostly due to COVID-19, US has excluded a few medical products from the tariff section with China. We assume they are more likely to be retrieved.  

  
3) We go Economics! By calculating the price elasticity of groups, we know information of which groups are less substitutable for US economy, e.g. Machinery. We assume that groups with less elasticity were less sensitive to tariffs, and therefore more significant to US economy.   

In this repo, I share the scripts of method 3.

The traditional price elasticity formula is written as:  

*Price Elasticity of Demand = % Change in Quantity Demanded / % Change in Price*

We redefined it as:

Both
*% Change in Quantity Demanded of Chinese Export to US - % Change in Quantity Demanded of World's Export to US* > -.05  
&  

*% Change in Price of Chinese Export to US - % Change in Price of World's Export to US* > -.05
