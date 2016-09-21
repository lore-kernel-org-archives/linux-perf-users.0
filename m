From: Michael Petlan <mpetlan@redhat.com>
Subject: Re: Haswell EP some uncore imc counter are missing
Date: Wed, 21 Sep 2016 14:07:46 +0200 (CEST)
Message-ID: <alpine.LRH.2.20.1609211355400.10180@Diego>
References: <20160917180155.Horde.5aCQxGa9_V0-tbqDKZDTDx2@horde.inf.h-brs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933865AbcIUMRO (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Sep 2016 08:17:14 -0400
In-Reply-To: <20160917180155.Horde.5aCQxGa9_V0-tbqDKZDTDx2@horde.inf.h-brs.de>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Christian Neugebauer <christian.neugebauer@smail.inf.h-brs.de>
Cc: linux-perf-users@vger.kernel.org

On Sat, 17 Sep 2016, Christian Neugebauer wrote:
>
> Hi,
>
> We encountered the following problem with perf. We want to measure the total 
> memory bandwidth by using the uncore imc counter uncore_imc_0, uncore_imc_1, 
> ..., uncore_imc_7. In our system the counter uncore_imc_2, uncore_imc_3, 
> uncore_imc_6, uncore_imc_7 are NOT listed under /sys/devices. Only 
> uncore_imc_0, uncore_imc_1, uncore_imc_4, uncore_imc_5 are available (linked 
> under /sys/device and accessible via perf).
>

Hi,

When I tested uncore with perf on (probably) the same (or very similar) Haswell
EP CPU as the one of yours, I also have seen only imcs 0, 1, 4, 5. Are you sure
the 2, 3, 6, 7 should really be there (are supported by the CPU itself)?

My guess would be that the 2, 3, 6, 7 slots are reserved/unused.

Could you attach more info about your CPU topology (cpuid, lstopo, ...)?

This was the CPU I used:

Intel(R) Xeon(R) CPU E5-2697 v3 @ 2.60GHz
Family: 6
Model: 63
Stepping: 2
RAM: 31976 MB
56 processors on 28 cores organized into 2 numa nodes

Unfortunatelly, I didn't stored my topology logs, however I think it is as I
said above.

Cheers,
Michael


> Our setup:
>
> - 2 x Intel Xeon E5-2697 v3 (Haswell EP)
> - uname -a
> Linux wr5 2.6.32-642.4.2.el6.x86_64 #1 SMP Tue Aug 23 11:15:56 CDT 2016 
> x86_64 x86_64 x86_64 GNU/Linux
> - perf --version
> perf version 2.6.32-642.4.2.el6.x86_64.debug
>
> From my understanding 8 imc counter in total should be available for Haswell 
> EP. The kernel is a fresh build which seems to have all latest perf changes 
> in it. I also checked the perf source code briefly. I could do more debugging 
> and try to find out the problem but before that I want to know if this is 
> either a known problem, an unknown problem or no problem at all because there 
> are restrictions that I'm not aware of.
>
> I also double checked other machines (same kernel though). E.g Intel Xeon 
> E5-2697 v2 (Ivy Bridge EP) shows me 8 counters as expected, and if I remember 
> correctly Intel Xeon EP E5-2670 (Sandy Bridge EP) had 4 counter, could double 
> check that if necessary.
>
> Chris
> -- 
> Christian Neugebauer
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
