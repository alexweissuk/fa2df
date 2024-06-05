fa2df.R is a helper file. It converts fa objects from Bill Revelle's psych package's fa and principal functions into data frames, which can be directly used by kable for
inclusion in a knitr/sweave document.

fa2df(x, huc="huc", phi=T, varacc=c("ssl", "prp", "cvr", "exp", "cpx"), big=.4, digits=2)

x = object from fa() or principal()

huc = string that can be used to report any combination of communalities (h), uniquenesses (u), and complexity (c).

phi = if an oblique transformation was used, the interfactor correlations can be suppressed by setting this to F.

varacc = string that lets user select whether to report SS Loadings (ssl), Proportion of variance accounted for by factor (prp), 
  Cumulative variance accounted for by factor (cvr), the proportion of explained variance (exp), and the cumulative proportion of explained variance (cpx)

big = what is the cutpoint for salient loadings?

digits = maximum number of digits reported.
