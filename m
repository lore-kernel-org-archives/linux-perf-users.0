From: Yuanfang Chen <cyfmxc@gmail.com>
Subject: event group without multiplexing
Date: Wed, 11 Nov 2015 17:05:33 -0500
Message-ID: <CAJh9x3q+g4Q4WfZ8XZ9ZOw0BcgYd_hdoUufu2YpRGtZt2tfu5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38159 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbbKKWFf (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 11 Nov 2015 17:05:35 -0500
Received: by wmec201 with SMTP id c201so66052680wme.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2015 14:05:33 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello

I am using a haswell box. (E3-1231 v3). HT enabled.

perf stat -e \{cycles,r148,r1000248,r8d1,r40d1\} -- sleep 1

with ubuntu version of perf

Performance counter stats for 'sleep 1':

            756066      cycles
              5740      r1000248
              5516      r8d1
              9064      r40d1
                 0        r148

       1.001770249 seconds time elapsed

with relatively new tip of perf/core:

 Performance counter stats for 'sleep 1':

            729403      cycles
              7250      r1000248
              5628      r8d1
              9273      r40d1
   <not supported>      r148

       1.001674174 seconds time elapsed

from https://download.01.org/perfmon/HSW/
                                                         SMT on
          SMT off
cpu_clk_unhalted.thread cycles           Fixed counter 2      Fixed counter 2
ld_blocks.no_sr    r803                        0,1,2,3
 0,1,2,3,4,5,6,7
mem_load_uops_retired.l1_miss r8d1   0,1,2,3                  0,1,2,3
mem_load_uops_retired.hit_lfb r40d1    0,1,2,3                  0,1,2,3
l1d_pend_miss.pending r148                2                          2

Seems these five events couldn't be counting at the same time,
although in terms of hardware they should get along.  Is this a bug or
a limitation I should be aware of? Thank you so much.

Yuanfang
