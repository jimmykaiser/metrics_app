## Function to make scatter plot based on input
make_scatter <- function(df, x_var, y_var,
                         title_label, year_over_year = 0) {
  names(df) <- c("id", "varname", "val")

  if (length(df$id) > 0) {
  	df <- df[(df["varname"] == x_var) | (df["varname"] == y_var), ]
	  dups <- df %>%
	    group_by(id, varname) %>%
	    filter(n() > 1)
	  df <- transform(df, val = as.numeric(val))
	  df <- df %>% spread(varname, val)
	  x_vals = unlist(df[x_var])
	  y_vals = unlist(df[y_var])
	  allvals <- c(x_vals, y_vals)
	}

  # Check to make sure metric exists in data set
  if (length(df$id) > 0) {
    if (year_over_year == 1) {
      # Find maximum and minimum values across years
      x_max <- max(allvals, na.rm = TRUE) + 0.05
      y_max <- max(allvals, na.rm = TRUE) + 0.05
      x_min <- min(allvals, na.rm = TRUE) - 0.05
      y_min <- min(allvals, na.rm = TRUE) - 0.05
    } else {
      # Find max and min for each variable, but use zero as min if it is lowest
      x_min <- min(-0.05, min(x_vals, na.rm = TRUE))
      y_min <- min(-0.05, min(y_vals, na.rm = TRUE))
      x_max <- max(x_vals, na.rm = TRUE) + .05
      y_max <- max(y_vals, na.rm = TRUE) + .05
    }
    # Get summary stats
    r_val <- round(cor(y_vals, x_vals, use = "pairwise.complete.obs"), 2)
    r2 <- round(r_val ** 2, 2)
    n <- sum(!is.na(y_vals))
    n_miss <- sum(is.na(y_vals))
    # Generate scatterplot
    df <- df[complete.cases(df), ] # remove rows with missing values
    names(df) <- c("id", "x_col", "y_col")
    g <- ggplot(df, aes(x_col, y_col, label = id))
    g <- g + geom_text() # + coord_equal()
    g <- g + xlim(x_min, x_max) + ylim(y_min, y_max)
    # Display summary stats in title of plot
    g <- g + labs(title = paste0(title_label, " (R = ", r_val,
                                 ", R2 = ", r2, 
                                 ", N = ", n, ", NAs = ",
                                 n_miss, ")"),
                  x = x_var, y = y_var)
    if (year_over_year == 1) {
      g <- g + geom_abline(slope = 1, intercept = 0)
    } else {
      mod <- coef(lm(y_vals ~ x_vals, data = df))
      g <- g + geom_abline(slope = mod[2], intercept = mod[1])
    }
    # Change theme
    g <- g + theme_bw(base_size = 14) + theme(legend.position = "none")
    g <- g + theme(panel.grid.major = element_line(size = .5, color = "grey"),
                   axis.line = element_line(size = .7, color = "black"),
                   text = element_text(size = 16),
                   plot.title = element_text(size = 20))
    return(g)
  }
}