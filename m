From: Christian Neugebauer <christian.neugebauer@smail.inf.h-brs.de>
Subject: Haswell EP some uncore imc counter are missing
Date: Sat, 17 Sep 2016 18:01:55 +0200
Message-ID: <20160917180155.Horde.5aCQxGa9_V0-tbqDKZDTDx2@horde.inf.h-brs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from ux-2s11.inf.fh-bonn-rhein-sieg.de ([194.95.66.8]:42003 "EHLO
        ux-2s11.inf.fh-bonn-rhein-sieg.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752346AbcIQQCD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 17 Sep 2016 12:02:03 -0400
Received: from mail.inf.h-brs.de (sv-2s07z.inf.fh-bonn-rhein-sieg.de [10.20.1.38])
        (authenticated bits=0)
        by ux-2s11.inf.fh-bonn-rhein-sieg.de (8.14.4/8.14.4/Debian-4ska2) with ESMTP id u8HG1te9016677
        for <linux-perf-users@vger.kernel.org>; Sat, 17 Sep 2016 18:01:55 +0200
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org


Hi,

We encountered the following problem with perf. We want to measure the  
total memory bandwidth by using the uncore imc counter uncore_imc_0,  
uncore_imc_1, ..., uncore_imc_7. In our system the counter  
uncore_imc_2, uncore_imc_3, uncore_imc_6, uncore_imc_7 are NOT listed  
under /sys/devices. Only uncore_imc_0, uncore_imc_1, uncore_imc_4,  
uncore_imc_5 are available (linked under /sys/device and accessible  
via perf).

Our setup:

- 2 x Intel Xeon E5-2697 v3 (Haswell EP)
- uname -a
Linux wr5 2.6.32-642.4.2.el6.x86_64 #1 SMP Tue Aug 23 11:15:56 CDT  
2016 x86_64 x86_64 x86_64 GNU/Linux
- perf --version
perf version 2.6.32-642.4.2.el6.x86_64.debug

 From my understanding 8 imc counter in total should be available for  
Haswell EP. The kernel is a fresh build which seems to have all latest  
perf changes in it. I also checked the perf source code briefly. I  
could do more debugging and try to find out the problem but before  
that I want to know if this is either a known problem, an unknown  
problem or no problem at all because there are restrictions that I'm  
not aware of.

I also double checked other machines (same kernel though). E.g Intel  
Xeon E5-2697 v2 (Ivy Bridge EP) shows me 8 counters as expected, and  
if I remember correctly Intel Xeon EP E5-2670 (Sandy Bridge EP) had 4  
counter, could double check that if necessary.

Chris
-- 
Christian Neugebauer
