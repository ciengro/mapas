##CIENGRO plots
#devtools::install_github("sjmgarnier/viridis")
#install.packages("devtools")
#devtools::install_github("diegovalle/mxmaps")

library("mxmaps")
library("viridis")
library("scales")
library("ggplot2")
library("ggmap")


data("df_mxmunicipio")

data(mxstate.map, package = "mxmaps")
data(mxmunicipio.map, package = "mxmaps")

aspirantes<-read.csv("Concurso_CIENGRO_aspirantes.csv")

aspirantes.municipios<-data.frame(table(aspirantes$Municipio ))

mapa.guerrero<-subset(df_mxmunicipio,state_name_official=="Guerrero")

mapa.guerrero$aspirantes<-0

indx<-match(aspirantes.municipios$Var1,df_mxmunicipio$municipio_name)

df_mxmunicipio$value<-0
df_mxmunicipio$value[indx]<-aspirantes.municipios$Freq

gg = MXMunicipioChoropleth$new(df_mxmunicipio)
gg$title <- "Aspirantes para la beca de ingreso a Universidad"
gg$set_num_colors(1)
gg$ggplot_scale <- scale_fill_gradient(low="white",high = "darkgreen")
gg$set_zoom( subset(df_mxmunicipio, state_abbr %in% c("GRO"))$region)

pdf("aspirantes.pdf")
gg$render()
dev.off()
