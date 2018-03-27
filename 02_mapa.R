
library("tidyverse")
library("geojsonio")
# libgdal1-dev
# sudo apt-get install  libgdal-dev libgeos-c1v5 libproj-dev libv8-dev libjq-dev
# sudo apt-get install libgdal-dev libproj-dev
# install.packages("rgdal", type = "source")
# install.packages("rgeos", type = "source")
library("leaflet")

ce <- geojson_read("dados/ce-municipalities.json", what = "sp")


atend <- read.table(file = "output/tidy.data.tsv", stringsAsFactors = T, header = T) %>% as_tibble()

ano2015 <- filter(atend, ano == 2015)
ano2016 <- filter(atend, ano == 2016)
ano2017 <- filter(atend, ano == 2017)

# remover acentos
ce$name <- iconv(x = ce$name, to = "ASCII//TRANSLIT")

# converter em texto
atend$municipio <- as.character(atend$municipio)

# falta parte dos municípios (19)
nrow(ce)
nrow(ano2017) 
nrow(ce) - nrow(ano2017) 


muni_order <- match(x = ano2015$municipio, table = ce$name)
length(muni_order)
muni_order

ce$ano_2015[muni_order] <- ano2015$total
ce$ano_2016[muni_order] <- ano2016$total
ce$ano_2017[muni_order] <- ano2017$total

pal <- colorNumeric("OrRd", NULL)


# 2015
leaflet(ce)  %>% 
	addTiles() %>%
	addPolygons(stroke = T, weight = 1, 
				smoothFactor = 0.3,
				fillOpacity = 1,
				fillColor = ~pal(as.numeric(ano_2015)),
				label = ~paste0(name, ": ", formatC(ano_2015, big.mark = ","))
				) %>%
	addLegend(pal = pal, values = ~ano_2015, opacity = 1.0
    #labFormat = labelFormat(transform = function(x) round(10))
	)

# 2016
leaflet(ce)  %>% 
	addTiles() %>%
	addPolygons(stroke = T, weight = 1, 
				smoothFactor = 0.3,
				fillOpacity = 1,
				fillColor = ~pal(as.numeric(ano_2016)),
				label = ~paste0(name, ": ", formatC(ano_2016, big.mark = ","))
				) %>%
	addLegend(pal = pal, values = ~ano_2016, opacity = 1.0
    #labFormat = labelFormat(transform = function(x) round(10))
	)


# 2017
leaflet(ce)  %>% 
	addTiles() %>%
	addPolygons(stroke = T, weight = 1, 
				smoothFactor = 0.3,
				fillOpacity = 1,
				fillColor = ~pal(as.numeric(ano_2017)),
				label = ~paste0(name, ": ", formatC(ano_2017, big.mark = ","))
				) %>%
	addLegend(pal = pal, values = ~ano_2017, opacity = 1.0
    #labFormat = labelFormat(transform = function(x) round(10))
	)