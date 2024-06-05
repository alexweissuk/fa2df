fa2df <- function(x, huc="huc", phi=T, varacc=c("ssl", "prp", "cvr", "exp", "cpx"), big=.4, digits=2)

{

### Create sprintf variable
    numfmt <- paste0("%.", digits, "f")

### Set up main matrices
    lmbmat <- x$loadings[,1:x$factors] # loading matrix

        if (big > 0) {
            temp <- sprintf(numfmt, lmbmat)
            q <- lmbmat
            temp[!is.na(q) & (abs(q) > big)] <- paste("\\bf{",
                temp[!is.na(q) & (abs(q) > big)], "}", sep = "")
            lmbmat <- matrix(temp, ncol=x$factors)
            colnames(lmbmat) <- colnames(x$loadings)
}

    hucmat <- cbind( # Matrix or vector(s) for communalities, uniquenesses, and/or complexity
        sprintf(numfmt, x[grepl("h", huc, ignore.case=T)]$communalities),
        sprintf(numfmt, x[grepl("u", huc, ignore.case=T)]$uniquenesses),
        sprintf(numfmt, x[grepl("c", huc, ignore.case=T)]$complexity)
    )

    colnames(hucmat) <- c("$h^2$"[grepl("h", huc)], "$u^2$"[grepl("u", huc)], "com"[grepl("c", huc)])

    varacc <- tolower(varacc) # Make sure that user input is case insensitive

    varmat <-
        rbind( # Create 'variance accounted for' matrix
            sprintf(numfmt, x["ssl" %in% varacc]$Vaccounted["SS loadings",]),
            sprintf(numfmt, x["prp" %in% varacc]$Vaccounted["Proportion Var",]),
            sprintf(numfmt, x["cvr" %in% varacc]$Vaccounted["Cumulative Var",]),
            sprintf(numfmt, x["exp" %in% varacc]$Vaccounted["Proportion Explained",]),
            sprintf(numfmt, x["cpx" %in% varacc]$Vaccounted["Cumulative Proportion",])
        )

    rownames(varmat) <- rownames(x$Vaccounted)[c("ssl", "prp", "cvr", "exp", "cpx") %in% varacc]

### Recombining matrices
    lmbhucmat <- cbind(lmbmat, hucmat)
    rownames(lmbhucmat) <- rownames(x$loadings)

    varmatnew <-
            cbind(varmat, matrix(nrow=nrow(varmat), ncol=ncol(hucmat)))

    if(phi==T & !is.null(x$Phi)) {
        phimat <-
            cbind(matrix(sprintf(numfmt, x$Phi), ncol=x$factors), matrix(nrow=nrow(x$Phi), ncol=ncol(hucmat)))
        rownames(phimat) <- c(colnames(x$loadings))

    } else {
        phimat=NULL
    }

### Creating dataframe
    fa_df <- as.data.frame(
        cbind(c(rownames(lmbhucmat), rownames(varmatnew), rownames(phimat)),
        rbind(lmbhucmat, varmatnew, phimat))
    )

    rownames(fa_df) <- NULL

    names(fa_df)[1] <- "Variable"

    return(fa_df)

}
