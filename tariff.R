library(tidyverse)
library(writexl)
write_xlsx(china.im,"china.xlsx")  
write_xlsx(world.im,"world.xlsx")

#volume
delta_china <- china.im 
  
delta_china$delta_last_first <- (china.im[67] - china.im[14])/china.im[14]
#delta_china$early_mean <- apply(delta_china[,14:19], 1, mean)
#delta_china$later_mean <- apply(delta_china[,62:67], 1, mean)
#delta_china$delta_mean <- (delta_china$later_mean-delta_china$early_mean)/delta_china$early_mean
#delta_china$delta_last_first
#delta_china$delta_mean
#output <- cbind(delta_china$delta_last_first,delta_china$delta_mean)
delta_china$if_tariff <- apply(delta_china[,70:73],1,sum)


delta_world <- world.im 
delta_world$delta_last_first <- (world.im[67] - world.im[14])/world.im[14]
#delta_world$early_mean <- apply(delta_world[,14:19], 1, mean)
#delta_world$later_mean <- apply(delta_world[,62:67], 1, mean)
#delta_world$delta_mean <- (delta_world$later_mean-delta_world$early_mean)/delta_world$early_mean
delta_world$if_tariff <- apply(delta_world[,70:73],1,sum)

delta_volume <- cbind(china.im[1],delta_china$if_tariff,delta_china$delta_last_first,delta_world$if_tariff,delta_world$delta_last_first)
colnames(delta_volume) <- c('IMPORT','china_tariff','china_delta','world_tariff','world_delta')

#value

#china
head(china.price.2)
china <- china.price.2
world <- world.price.2
test<-china %>%
  select(-c(price.change.2))%>%
  pivot_wider(names_from = variable, values_from = value) 

test$if_tariff <- apply(test[,4:7],1,sum)
test$delta_last_first <- (test$`6月 2021`-test$`6月 2017`)/test$`6月 2017`
#test$early_mean <- apply(test1[,22:27], 1, mean)
#test$later_mean <- apply(test1[,70:75], 1, mean)
#test1$delta_mean <- (test1$later_mean-test1$early_mean)/test1$early_mean


#world
tt<-world %>%
  select(-c(price.change.2))%>%
  pivot_wider(names_from = variable, values_from = value) 
#tt1 <- tt %>% distinct(PRICE,.keep_all = TRUE)

tt$delta_last_first <- (tt$`6月 2021`-tt$`6月 2017`)/tt$`6月 2017`
tt$if_tariff <- apply(tt[,4:7],1,sum)
delta_value <- cbind(test[1],test$if_tariff,test$delta_last_first,tt$if_tariff,tt$delta_last_first)
colnames(delta_value) <- c('IMPORT','china_tariff','china_delta','world_tariff','world_delta')

#filter
final <- cbind(delta_value,delta_volume) 
colnames(final) <- c("IMPORT",'china_tariff',"china_value",'world_tariff',"world_value","IM",'china_tariff2',
                     "china_volume",'world_tariff2',"world_volume")

final %>%
  filter(world_tariff != china_tariff)

final1 <- final %>%
  select(-c(IM,china_tariff2,world_tariff2,world_tariff))

final1$flag <- ifelse((final1$china_value-final1$world_value > -.05)&(final1$china_volume - final1$world_volume > -.05),1,0)
final1 <- final1 %>% 
  drop_na()

final1$IMPORT <- substring(final1$IMPORT,1,10)
final1$HS2012 <- substring(final1$IMPORT,1,6)

dic <- readxl::read_excel("HS与工业行业对应.xlsx")
final2 <- final1 %>%
  left_join(dic,by = "HS2012")

write_xlsx(final2, "Neg0.05_final2.xlsx")

