+++ 
draft = false
date = 2015-05-11T00:09:12+02:00
title = "Working with dates in Java"
description = ""
slug = "working-dates-java" 
tags = []
categories = []
externalLink = ""
series = []
+++

I recovered an old post from 2012 on my previous blog.
Here I translated and updated the post.

Working with dates is not an easy task in a programming language.
Usually, because there is no standard (like it happens on databases) or sometimes, the standard is not implemented.
On 2012 I talked that <a href="http://www.joda.org/joda-time/" target="_blank">joda time</a> was planned to be the new data standard on Java, and in fact, in 2015, Joda time is the facto standard ( as they claim on their site):
<blockquote>Joda-Time is the de facto standard date and time library for Java. From Java SE 8 onwards, users are asked to migrate to java.time (JSR-310).</blockquote>

I was interested in doing some calculations to check if a time point was inside a time interval or not. This is useful when implementing all Allen time operations.
Here you will find the original paper from the '82: <a href="http://www.iscas2007.org/~logan/521_f08/Doc/p832-allen.pdf" target="_blank">http://www.iscas2007.org/~logan/521_f08/Doc/p832-allen.pdf</a>
And some more friendly approaches here: 
<a href="http://en.wikipedia.org/wiki/Allen's_interval_algebra" target="_blank">http://en.wikipedia.org/wiki/Allen's_interval_algebra</a>
<a href="http://www.ics.uci.edu/~alspaugh/cls/shr/allen.html" target="_blank">http://www.ics.uci.edu/~alspaugh/cls/shr/allen.html</a>

Working with dates on Joda time is really easy:
 
<pre class="lang:java decode:true " >String startDate = "18/09/2012";
String endDate = "22/09/2012";
// datetime formatter, allows to read and write strings
DateTimeFormatter dtf = new DateTimeFormatterBuilder().
                appendDayOfMonth(2).
                appendLiteral("/").
                appendMonthOfYear(2).
                appendLiteral("/").
                appendYear(4, 4).toFormatter();
 
 
DateTime start = dtf.parseDateTime(startDate);
DateTime end = dtf.parseDateTime(endDate);
       
int months = Months.monthsBetween(start, end).getMonths();
    DateTime newdate = lastRule.plusDays(28);
    for(int i=0;i&lt;months;i++){
        newdate = lastRule.plusDays(28);
            }      
        Interval interval = new Interval(start,end);
        if(interval.contains(newdate)){         
            jTextArea2.setText(
"That day is included: "
             + dtf.print(newdate));
        }else{
            jTextArea2.setText(
"The day is not included: "
           + dtf.print(newdate));
        }</pre> 

