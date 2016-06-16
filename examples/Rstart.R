library(readr)
library(dplyr)
library(ggplot2)
library(extrafont)
library(scales)
library(grid)
library(RColorBrewer)
library(digest)
library(readr)
library(stringr)


fontFamily <- "Source Sans Pro"
fontTitle <- "Source Sans Pro Semibold"

color_palette = c("#16a085","#27ae60","#2980b9","#8e44ad","#f39c12","#c0392b","#1abc9c", "#2ecc71", "#3498db", "#9b59b6", "#f1c40f","#e74c3c")

neutral_colors = function(number) {
	return (brewer.pal(11, "RdYlBu")[-c(5:7)][(number %% 8) + 1])
}

set1_colors = function(number) {
	return (brewer.pal(9, "Set1")[c(-6,-8)][(number %% 7) + 1])
}

theme_custom <- function() {theme_bw(base_size = 8) + 
                             theme(panel.background = element_rect(fill="#eaeaea"),
                                   plot.background = element_rect(fill="white"),
                                   panel.grid.minor = element_blank(),
                                   panel.grid.major = element_line(color="#dddddd"),
                                   axis.ticks.x = element_blank(),
                                   axis.ticks.y = element_blank(),
                                   axis.title.x = element_text(family=fontTitle, size=8, vjust=-.3),
                                   axis.title.y = element_text(family=fontTitle, size=8, vjust=1.5),
                                   panel.border = element_rect(color="#cccccc"),
                                   text = element_text(color = "#1a1a1a", family=fontFamily),
                                   plot.margin = unit(c(0.25,0.1,0.1,0.35), "cm"),
                                   plot.title = element_text(family=fontTitle, size=9, vjust=1))                          
}

create_watermark <- function(source = '', filename = '', dark=F) {

bg_white = "#FFFFFF"
bg_text = '#969696'

if (dark) {
	bg_white = "#000000"
	bg_text = '#666666'
}

watermark <- ggplot(aes(x,y), data=data.frame(x=c(0.5), y=c(0.5))) + geom_point(color = "transparent") +
geom_text(x=0, y=1.25, label="By Max Woolf — minimaxir.com", family="Source Sans Pro", color=bg_text, size=1.75, hjust=0) +

geom_text(x=5, y=1.25, label="Made using R and ggplot2", family="Source Sans Pro", color=bg_text, size=1.75) +
scale_x_continuous(limits=c(0,10)) +
scale_y_continuous(limits=c(0.5,1.5)) +
annotate("segment", x = 0, xend = 10, y=1.5, yend=1.5, color=bg_text, size=0.1) +
theme_bw() +
theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.position = "none",
         panel.border = element_blank(), axis.text.x = element_blank(), axis.text.y = element_blank(), axis.title.x = element_blank(), axis.title.y = element_blank(),
         axis.ticks = element_blank(), plot.margin = unit(c(0.0,0,-0.4,0), "cm")) +
theme(plot.background=element_rect(fill=bg_white, color=bg_white),panel.background=element_rect(fill=bg_white, color=bg_white)) +
scale_color_manual(values=bg_text)

if (nchar(source) > 0) {watermark <- watermark + geom_text(x=10, y=1.25, label=paste("Data via",source), family="Source Sans Pro", color=bg_text, size=1.75, hjust=1)}

return (watermark)
}

web_Layout <- grid.layout(nrow = 2, ncol = 1, heights = unit(c(2,
     0.125), c("null", "null")), )
tallweb_Layout <- grid.layout(nrow = 2, ncol = 1, heights = unit(c(3.5,
     0.125), c("null", "null")), )
video_Layout <- grid.layout(nrow = 1, ncol = 2, widths = unit(c(2,
     1), c("null", "null")), )
     
     #grid.show.layout(Layout)
 vplayout <- function(...) {
     grid.newpage()
     pushViewport(viewport(layout = web_Layout))
 }
 
 talllayout <- function(...) {
     grid.newpage()
     pushViewport(viewport(layout = tallweb_Layout))
 }
 
 vidlayout <- function(...) {
     grid.newpage()
     pushViewport(viewport(layout = video_Layout))
 }
 
 subplot <- function(x, y) viewport(layout.pos.row = x,
     layout.pos.col = y)
     
web_plot <- function(a, b) {
     vplayout()
     print(a, vp = subplot(1, 1))
     print(b, vp = subplot(2, 1))
 }
 
 tallweb_plot <- function(a, b) {
     talllayout()
     print(a, vp = subplot(1, 1))
     print(b, vp = subplot(2, 1))
 }
 
 video_plot <- function(a, b) {
     vidlayout()
     print(a, vp = subplot(1, 1))
     print(b, vp = subplot(1, 2))
 }
 
max_save <- function(plot1, filename, source = '', pdf = FALSE, w=4, h=3, tall=F, dark=F, bg_overide=NA) {
	png(paste(filename,"png",sep="."),res=300,units="in",width=w,height=h)
plot.new()
#if (!is.na(bg_overide)) {par(bg = bg_overide)}
ifelse(tall,tallweb_plot(plot1,create_watermark(source, filename, dark)),web_plot(plot1,create_watermark(source, filename, dark)))
dev.off()

if (pdf) {
quartz(width=w,height=h,dpi=144)
#if (!is.na(bg_overide)) {par(bg = bg_overide)}
web_plot(plot1,create_watermark(source, filename, dark))
quartz.save(paste(filename,"pdf",sep="."), type = "pdf", device = dev.cur())
}
}

video_save <- function(plot1, plot2, filename) {
	png(paste(filename,"png",sep="."),res=300,units="in",width=1920/300,height=1080/300)
video_plot(plot1,plot2)
dev.off()

}

fte_theme <- function (palate_color = "Greys") {
  
  #display.brewer.all(n=9,type="seq",exact.n=TRUE)
  palate <- brewer.pal(palate_color, n=9)
  color.background = palate[1]
  color.grid.minor = palate[3]
  color.grid.major = palate[3]
  color.axis.text = palate[6]
  color.axis.title = palate[7]
  color.title = palate[9]
  #color.title = "#2c3e50"
  
  font.title <- "Source Sans Pro"
  font.axis <- "Open Sans Condensed Bold"
  #font.axis <- "M+ 1m regular"
  #font.title <- "Arial"
  #font.axis <- "Arial"
  

  theme_bw(base_size=9) +
    # Set the entire chart region to a light gray color
    theme(panel.background=element_rect(fill=color.background, color=color.background)) +
    theme(plot.background=element_rect(fill=color.background, color=color.background)) +
    theme(panel.border=element_rect(color=color.background)) +
    # Format the grid
    theme(panel.grid.major=element_line(color=color.grid.major,size=.25)) +
    theme(panel.grid.minor=element_blank()) +
    #scale_x_continuous(minor_breaks=0,breaks=seq(0,100,10),limits=c(0,100)) +
    #scale_y_continuous(minor_breaks=0,breaks=seq(0,26,4),limits=c(0,25)) +
    theme(axis.ticks=element_blank()) +
    # Dispose of the legend
    theme(legend.position="none") +
    theme(legend.background = element_rect(fill=color.background)) +
    theme(legend.text = element_text(size=7,colour=color.axis.title,family=font.axis)) +
    # Set title and axis labels, and format these and tick marks
    theme(plot.title=element_text(colour=color.title,family=font.title, size=9, vjust=1.25, lineheight=0.1)) +
    theme(axis.text.x=element_text(size=7,colour=color.axis.text,family=font.axis)) +
    theme(axis.text.y=element_text(size=7,colour=color.axis.text,family=font.axis)) +
    theme(axis.title.y=element_text(size=7,colour=color.axis.title,family=font.title, vjust=1.25)) +
    theme(axis.title.x=element_text(size=7,colour=color.axis.title,family=font.title, vjust=0)) +
    
    # Big bold line at y=0
    #geom_hline(yintercept=0,size=0.75,colour=palate[9]) +
    # Plot margins and finally line annotations
    theme(plot.margin = unit(c(0.35, 0.2, 0.15, 0.4), "cm")) +
    
    theme(strip.background = element_rect(fill=color.background, color=color.background),strip.text=element_text(size=7,colour=color.axis.title,family=font.title))

}
