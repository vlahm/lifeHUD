library(tidyverse)

# args = commandArgs(trailingOnly=TRUE)

setwd('~/git/lifeHUD/project_time_left/')

start = as.Date('2020-09-10')
end = as.Date('2021-02-28')
dur = abs(Sys.Date() - end)
pape_names = c('Hypoxia', 'NHC', 'Lot.Lent', 'SP', 'other')

# if(! exists('nprojects.txt')) readr::write_lines('365', 'nprojects.txt')
if(! exists('nprojects.txt')){
    # max_paperdays = floor(as.numeric(dur) / npapers)
    def_df = matrix(0,
                    ncol = 5,
                    dimnames = list(NULL, pape_names)) %>%
        as.data.frame()
    write.csv(def_df, 'docked_days.csv', row.names = FALSE)
}

docked_days = read.csv('docked_days.csv', stringsAsFactors = FALSE)

# npapers = ncol(docked_days)
npapers = 5
paper_days = floor(as.numeric(dur) / npapers)

orig_daynum = floor(as.numeric(end - start) / 5)

par(mar = c(4.5, 3.5, 1, 0))
barplot(rep(orig_daynum, npapers), yaxt = 'n', col = 'transparent', border='black',
        space = 0, bty = 'n', ylim = c(0, orig_daynum))
par(new = TRUE)
barplot(rep(orig_daynum, npapers), yaxt = 'n', col = 'white', border='transparent',
        space = 0, bty = 'n', ylim = c(0, orig_daynum))
par(new = TRUE)
barplot(rep(paper_days, npapers), yaxt = 'n', names.arg = pape_names, las=3,
        border='transparent', ylim = c(0, orig_daynum), bty = 'o', col = 'sienna4')
axis(2, at = orig_daynum, tick = FALSE, las = 1, line = -1.3, font = 2,
     cex.axis = 0.8, labels = start, xpd = NA)
axis(2, at = paper_days, tick = FALSE, las = 1, line = -1.3, font = 2,
     cex.axis = 0.8, labels = as.character(Sys.Date()), xpd = NA)

initials = c('h', 'n', 'l', 's', 'o')
pape_name_map = pape_names
names(pape_name_map) = initials

get_response_1char = function(msg, possible_chars){

    #msg is a message that will be used to prompt the user
    #possible_chars is a character vector of single-character responses

    message(msg)
    ch = readLines(con="stdin", 1)

    if(length(ch) == 1 && ch %in% possible_chars){
        return(ch)
    } else {
        get_response_1char(msg, possible_chars)
    }
}

dock_day = function(pape){

    r = get_response_1char(paste0("\nDay's effort spent on: (h)ypoxia, ",
                                  "(n)hc, (l)ot.lent, (s)p, (o)ther\n"),
                           initials)

    dock_paper = unname(pape_name_map[r])

    docked_days
