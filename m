From: Guru Prasad <gurupras@buffalo.edu>
Subject: Fwd: Logging PMU counters during context switch
Date: Fri, 10 Jan 2014 00:59:48 -0500
Message-ID: <CAMefCkAJ9UgVNe5HHmKfTT9QsMOJ9o52XRqQo4+1C1ATSYrJ-g@mail.gmail.com>
References: <CAMefCkD0QsYAcTtXr8UfBgJ4JfunmVmHEem2nMknK_5_Ddx6tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:57481 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947AbaAJF7t (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 10 Jan 2014 00:59:49 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so4119393pde.41
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2014 21:59:49 -0800 (PST)
In-Reply-To: <CAMefCkD0QsYAcTtXr8UfBgJ4JfunmVmHEem2nMknK_5_Ddx6tg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Architecture: ARM
CPU: Cortex-A9

Hi,
My goal is to log PMU counters during context switches.

Is there any documentation available in kernel on how to use perf
functions within the kernel itself?
I'm having a lot of difficulty setting up struct perf_event from
within the kernel.

What I currently have is the following

#ifdef CONFIG_PERIODIC_PMU_LOG
    if(unlikely(!initialize_pmu_log)) {
        unsigned int value;
        asm volatile("mrc p15, 0, %0, c9, c12, 0" : "=r" (value));
//Read PMCR register
        value |= 0x00000005;    //Set reset-PMCCNTR-bit and enable-bit
        asm volatile("mcr p15, 0, %0, c9, c12, 0" : : "r" (value));
//Write PMCR register

        asm volatile("mrc p15, 0, %0, c9, c12, 1" : "=r" (value));
//Read PMCNTENSET
        value |= 0x80000000;    //Set cycle counter enable
        asm volatile("mcr p15, 0, %0, c9, c12, 1" : : "r" (value));
//Write PMCNTENSET
        initialize_pmu_log = 1;
    }
    else {
        unsigned int value;
        asm volatile("mrc p15, 0, %0, c9, c13, 0" : "=r" (value));
//Read PMCCNTR
        printk(KERN_DEBUG "periodic_perf:  PMCCNTR  :%u\n", value);
    }
#endif


This works..for a while..however, at some point, the counter just
hangs at an arbitrary value relatively close to 2^32 - 1 (example
0xBFB69F7F)
and sometimes it alternates between 2~3 values..in my last run, these were
0xBEB49F3B
0xBEB69F3B
0xBFB69F7F

Is this somehow because of overflows?
I also tried adding an extra line to the initialization condition to
disable cycle counter interrupt in PMINTENCLR but this did not help..
value = 0x800000000
asm volatile("mcr p15, 0, %0, c9, c14, 2" : : "r" (value));


Regards
Guru
