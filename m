From: Michael Petlan <mpetlan@redhat.com>
Subject: Strange values of multiplexed hardware counters
Date: Fri, 22 Jan 2016 18:10:54 +0100
Message-ID: <1453482654.13794.155.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39254 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754458AbcAVRK5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 22 Jan 2016 12:10:57 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 311FE8F860
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Jan 2016 17:10:57 +0000 (UTC)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, 'William Cohen' <wcohen@redhat.com>

Hi all,

I have encountered a strange problem with perf-stat. My Intel Ivy Bridge
machine has 4 generic registers.

When running perf-stat with 4 times the same event, it seems to work
fine:


$ perf stat -e cycles -e cycles -e cycles -e cycles ls
 Performance counter stats for 'ls':
         3,527,771      cycles
         3,527,771      cycles
         3,527,771      cycles
         3,527,771      cycles
       0.003955878 seconds time elapsed elapsed


When adding a fifth event, we need multiplexing/scaling:


$ perf stat -e cycles -e cycles -e cycles -e cycles -e cycles ls
 Performance counter stats for 'ls':
         2,984,685      cycles       (79.86%)
         3,782,493      cycles       (86.79%)
         3,816,329      cycles       (85.90%)
         4,038,067      cycles       (70.61%)
         2,869,339      cycles       (78.36%)
       0.006683959 seconds time elapsed


Considering that scaling is enabled and 4 counters must do the job of
five, the results still look weird to me.

I know that number of hardware event occurrences vary from run to run,
but I would expect that the five lines would contain similar numbers
after scaling.

In case a counter counted an event only for 75% of the measurement run
time and the real value on it is 1,500,000 I would say, that perf should
either report:

      1,500,000    cycles     (75.00%)
(when no scaling is applied to the result)

or

      2,000,000    cycles     (75.00%)
(when the value is scaled by 100/75 (extrapolated))


In case the second is true, I would expect the values to be roughly the
same in the experiment with the 'cycles' event opened 5 times.

Since the values differ a lot, it looks like the values are not scaled.
But it is still weird, because it seems to be proportional with the
percentage in the right column sometimes, but not this time. If 4.038M
refers to 70.61%, 3.816M cannot refer to 85.90%.

The sum of the percent values is 401.52% and that would match the fact
that 4 counters were used. The 1.52% that are extra here might stand for
some overhead caused multiplexing (?) or a rounding error (???).

But still, the values differ more than 1.52%.


                       ***************

Does anyone know where is the problem? Do I understand it wrong? Is the
current behaviour correct?


Thanks in advance.
Michael




Note 1: When doing the same experiment with OProfile's ocount, the
effect is the same. Having the CPU_CLK_UNHALTED event opened four times,
the results are exactly the same, but when adding a fifth one,
multiplexing kicks in and the numbers become weird:

Events were actively counted for 4344151 nanoseconds.
Event counts (actual) for /usr/bin/ls:
        Event                   Count                    % time counted
        CPU_CLK_UNHALTED        3,534,782                100.00
        CPU_CLK_UNHALTED        3,534,782                100.00
        CPU_CLK_UNHALTED        3,534,782                100.00
        CPU_CLK_UNHALTED        3,534,782                100.00

When adding the fifth '-e CPU_CLK_UNHALTED':

Events were actively counted for 3506335 nanoseconds.
Event counts (scaled) for /usr/bin/ls:
        Event                   Count                    % time counted
        CPU_CLK_UNHALTED        5,747,077                73.66
        CPU_CLK_UNHALTED        5,236,339                65.44
        CPU_CLK_UNHALTED        4,927,556                100.00
        CPU_CLK_UNHALTED        4,927,556                100.00
        CPU_CLK_UNHALTED        3,342,282                65.68


The sum of percents makes 404.78% here. It is interesting that OProfile
usually leaves two counters count for 100% of the time and the remaining
two are doing the job of three.




Note 2: Sometimes perf-stat does not print the percentages everywhere:

 Performance counter stats for 'ls':
       5,258,849      cycles    (72.47%)
       5,272,885      cycles    (72.50%)
       4,228,707      cycles    (95.03%)
       4,513,546      cycles
       2,932,594      cycles    (64.38%)
     0.003473492 seconds time elapsed
