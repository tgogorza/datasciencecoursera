---
title       : Developing Data Products
subtitle    : Myo Armband Reader
author      : Tomas Gogorza
job         : 
framework   : revealjs        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

<!-- Limit image width and height -->
<style type='text/css'>
img {
    max-height: 450px;
    max-width: 964px;
}
</style>

<!-- Center image on slide -->
<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.min.js"></script>
<script type='text/javascript'>
$(function() {
    $("p:has(img)").addClass('centered');
});
</script>

## Developing Data Products

# Myo Armband Reader

Tomas Gogorza

---

## Myo Armband

The Myo Armband (http://www.myo.com) lets you remotely control technology with gestures and motion.
It reads information from 4 different types of sensors:


- EMG (electromyographic)
- Gyroscope     
- Accelerometer 
- Orientation

---

## Reading the Data

The Reader web app loads sample data captured from the armband and stored into CSV files.
The data is read from 4 different files (one for each sensor)

This is a sample read from the accelerometer: 

```
##     timestamp         x        y        z
## 1 1.44329e+15 -0.493652 0.563965 0.700684
## 2 1.44329e+15 -0.489746 0.561035 0.698242
## 3 1.44329e+15 -0.488770 0.565430 0.704590
## 4 1.44329e+15 -0.489746 0.564941 0.703125
## 5 1.44329e+15 -0.490234 0.575684 0.694336
## 6 1.44329e+15 -0.494141 0.565918 0.696289
## 7 1.44329e+15 -0.497070 0.568359 0.688965
## 8 1.44329e+15 -0.498047 0.565430 0.702148
```

---

## Data Plots

Sensor data is plotted into an easy to visualize format, which lets the user get a better understanding and perform a quick analysis of the sensor data:

![plot of chunk unnamed-chunk-2](assets/fig/unnamed-chunk-2-1.png)

---

## MyoReader Web

You can access the shiny app at http://tgogorza.shinyapps.io/MyoReader

![width](assets/img/MyoReader.jpg)
