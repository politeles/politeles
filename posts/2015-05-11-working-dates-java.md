---
aliases:
- /2015/05/11/working-dates-java
categories:
- java 
- date
- time
date: '2015-05-11'
description: A post on how to work with dates in Java
layout: post
title: Working with dates in Java
toc: true

---

I recovered an old post from 2012 on my previous blog.
Here I translated and updated the post.

Working with dates is not an easy task in a programming language.
Usually, because there is no standard (like it happens on databases) or sometimes, the standard is not implemented.
On 2012 I talked that [joda time](http://www.joda.org/joda-time/) was planned to be the new data standard on Java, and in fact, in 2015, Joda time is the facto standard ( as they claim on their site):

>Joda-Time is the de facto standard date and time library for Java. From Java SE 8 onwards, users are asked to migrate to java.time (JSR-310).

I was interested in doing some calculations to check if a time point was inside a time interval or not. This is useful when implementing all Allen time operations.
Here you will find the [original paper from the '82](http://www.iscas2007.org/~logan/521_f08/Doc/p832-allen.pdf)
And some more friendly approaches here: 
 - [Allen's algebra](http://en.wikipedia.org/wiki/Allen's_interval_algebra).
 - [More Allen's time intervals.](http://www.ics.uci.edu/~alspaugh/cls/shr/allen.html).

Working with dates on Joda time is really easy:
 
```java
String startDate = "18/09/2012";
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
        }
```