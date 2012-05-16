From: Abdul Wahid Memon <engrwahidmemon@gmail.com>
Subject: Perf on armv7
Date: Wed, 16 May 2012 21:14:39 +0200
Message-ID: <CAM8ts8c0ojRB80FSvLtTSFksn+1wpv0ABry_-=-63=_rHDfdSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48853 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758644Ab2EPTOk (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 16 May 2012 15:14:40 -0400
Received: by yenm10 with SMTP id m10so1041344yen.19
        for <linux-perf-users@vger.kernel.org>; Wed, 16 May 2012 12:14:39 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello everyone

I need some hints on how to proceed further. I am sorry if this is not
the right place to ask this type of question.

I need to collect some performance counters using perf tool. But I am
always getting the following output.

Kernel: 2.6.35-7

Performance counter stats for 'ls':

          2.624511  task-clock-msecs         #      0.677 CPUs
                 0  context-switches         #      0.000 M/sec
                 0  CPU-migrations           #      0.000 M/sec
                62  page-faults              #      0.024 M/sec
     <not counted>  cycles
     <not counted>  instructions
     <not counted>  branches
     <not counted>  branch-misses
     <not counted>  cache-references
     <not counted>  cache-misses

       0.003875716  seconds time elapsed

I have recompiled the kernel to enable the support for events and
counters but to no avail. Any help or tips would be beneficial.

Regards

Abdul
