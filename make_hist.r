## Function to make histogram based on input
make_hist <- function(df, varname, compname, title_label) {
  names(df) <- c("id", "varname", "val")
  if (length(df$val) > 0) {
    df <- df[(df["varname"] == varname) | (df["varname"] == compname), ]
    df <- transform(df, val = as.numeric(val))
  }

  # Check to make sure metric exists in data set
  if (length(df$val) > 0) {
    # Get information about both years so that histogram scales match
    allvals <- unlist(df["val"])
    # Maximum and minimum x values
    globalmax <- max(allvals, na.rm = TRUE) + 0.05
    globalmin <- min(allvals, na.rm = TRUE) - 0.05
    # Shared binwidth based on range
    binwd = (IQR(allvals, na.rm = TRUE) / 8)
    # Find max Y value
    maxbar <- max(table(cut(unlist(df$val),
                            seq(globalmin, globalmax, binwd)))) + 5
    # Summary stats about desired year
    df <- df[df["varname"] == varname, ]
    n <- sum(!is.na(df$val))
    n_miss <- sum(is.na(df$val))
    sd <- round(sd(df$val, na.rm = TRUE), 2)
    avg <- round(mean(df$val, na.rm = TRUE), 2)
    # Generate histogram plot
    h <- ggplot(df, aes(val)) + geom_histogram(binwidth = binwd)
    # Display summary stats in title of plot
    h <- h + labs(title = paste0(title_label, " (N = ", n, ", NAs = ",
                                 n_miss, ", Mean = ", avg, ", SD = ", sd, ")"),
                  x = "value")
    # Set scales based on numbers calculated above
    h <- h + xlim(globalmin, globalmax) + ylim(0, maxbar)
    # Vertical line for average; generates "geom_segment" error
    h <- h + geom_vline(xintercept = avg)
    # Set the theme
    h <- h + theme_bw(base_size = 14)
    h <- h + theme(panel.grid.major = element_line(size = .5, color = "grey"),
                   axis.line = element_line(size = .7, color = "black"),
                   text = element_text(size = 16), plot.title = element_text(size = 20))
    return(h)
  }
}
