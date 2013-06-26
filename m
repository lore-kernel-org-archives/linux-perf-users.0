From: Peipei Wang <wangpeipei.90@gmail.com>
Subject: How can I get the number of Generic counters and Fixed Counters in A computer
Date: Wed, 26 Jun 2013 15:00:19 -0400
Message-ID: <CAEuYUep2MwCdvWxjJKqSjLvTWPPdE6QTzUS-0AXkSnHBFiYYfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:59167 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab3FZTAV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 26 Jun 2013 15:00:21 -0400
Received: by mail-vc0-f175.google.com with SMTP id hr11so1278347vcb.20
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2013 12:00:19 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: perf group <linux-perf-users@vger.kernel.org>

Hi all,

I see from Perf wiki that if i put too many events in a perf stat,
there will be something called multiplexing and scaling because of the
number of counters provided by PMU. That wiki gives the Generic
counter and Fixed counters For Intel Core and Nehalem.

Does anybody know how to find the number of Both counters for Other
processors?? Mine is Xelon.

Another question. I found there is some events that are stored in
Generic counters, while others in Fixed Counters. Here is an example.
How can I get to know which kind of counter that actually each
performance events is stored in?

**********here is no scaling******************************
perf stat -e cycles -e instructions -e branches -a sleep 2

 Performance counter stats for 'sleep 2':

     1,166,790,650 cycles                    #    0.000 GHz
         [100.00%]
     1,197,347,780 instructions              #    1.03  insns per
cycle         [100.00%]
       227,330,156 branches

       2.000775070 seconds time elapsed



**********if I add branches-misses here, then it starts scaling for
the four******************************
***************So I guess they use generic counters and should be only
3, since 3/5=75%****************

perf stat -e cycles -e instructions -e branches -e branch-misses -a sleep 2

 Performance counter stats for 'sleep 2':

     1,028,005,876 cycles                    #    0.000 GHz
         [47.87%]
     1,177,117,294 instructions              #    1.15  insns per
cycle         [70.11%]
       229,233,872 branches
         [77.88%]
         3,276,060 branch-misses             #    1.43% of all
branches         [74.25%]

       2.000727148 seconds time elapsed



**********but if I change branches-misses to context-switches, then it
stops scaling ***********
***************So I guess branches instructions and cycles are for
generic counters, and context-switches is stored by another fixed
counter***************


perf stat -e cycles -e instructions -e branches -e context-switches -a sleep 2

 Performance counter stats for 'sleep 2':

     1,141,756,954 cycles                    #    0.000 GHz
         [100.00%]
     1,192,438,722 instructions              #    1.04  insns per
cycle         [100.00%]
       226,363,898 branches
             2,644 context-switches

       2.000766968 seconds time elapsed


Best wishes.
Yours,
Wang Peipei
