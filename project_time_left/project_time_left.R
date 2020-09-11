# args = commandArgs(trailingOnly=TRUE)



end = as.Date('2021-02-28')
dur = abs(Sys.Date() - end)
npapers = 4
paper_days = floor(as.numeric(dur) / npapers)
pape_names = c('Hypoxia', 'NHC', 'Lot-Lent', 'SP')

par(mar = c(4.5, 3.5, 1, 0))
barplot(rep(42, npapers), yaxt = 'n', col = 'transparent', border='black',
        space = 0, bty = 'n', ylim = c(0, 42))
par(new = TRUE)
barplot(rep(42, npapers), yaxt = 'n', col = 'white', border='transparent',
        space = 0, bty = 'n', ylim = c(0, 42))
par(new = TRUE)
barplot(rep(paper_days, npapers), yaxt = 'n', names.arg = pape_names, las=3,
        border='transparent', ylim = c(0, 42), bty = 'o', col = 'sienna4')
axis(2, at = c(paper_days, 42), tick = FALSE, las = 1, line = -1.3, font = 2,
     cex.axis = 0.8, labels = c(as.character(Sys.Date()), '2020-09-10'))

# dock_day = function(pape){
