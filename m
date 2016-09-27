From: Christian Neugebauer <christian@neugemail.de>
Subject: RE: Haswell EP some uncore imc counter are missing
Date: Wed, 28 Sep 2016 00:20:08 +0200
Message-ID: <1475014808.6854.0@smtp.gmail.com>
References: <20160917180155.Horde.5aCQxGa9_V0-tbqDKZDTDx2@horde.inf.h-brs.de>
        <alpine.LRH.2.20.1609211355400.10180@Diego>
        <37D7C6CF3E00A74B8858931C1DB2F07750C6289A@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35805 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752151AbcI0WUN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Sep 2016 18:20:13 -0400
Received: by mail-wm0-f44.google.com with SMTP id l132so202328837wmf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Sep 2016 15:20:11 -0700 (PDT)
In-Reply-To: <37D7C6CF3E00A74B8858931C1DB2F07750C6289A@SHSMSX103.ccr.corp.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Liang, Kan" <kan.liang@intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>, Christian Neugebauer <christian.neugebauer@smail.inf.h-brs.de>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Sorry for my late reply, I was gone.

@Kan: perfect, thanks a lot for the clarification! That was actually 
the point where I got confused, because I saw that there were 8 imc 
counter registered in the source code for Haswell-EP. Now, I don't have 
to worry to miss any information regarding the imc counter.

@Michael: thank you for your reply as well!


On Mi, Sep 21, 2016 at 10:16 , Liang, Kan <kan.liang@intel.com> wrote:
> 
> Haswell EP can only support at most 4 channels for each processor.
> That's correct that you only observe 4 IMCs.
> 
> However, there are 8 possible device location for IMC channels on 
> Haswell.
> Where are those channels located depends on the memory configuration, 
> which is different among machines.
> 
> In uncore driver, we have all 8 possible device coded.  It's from 
> imc_0 to imc_7.
> But there will be only 4 IMCs observed at runtime. The unused ones 
> are hidden.
> 
> Thanks,
> Kan
> 
> 
>>  On Sat, 17 Sep 2016, Christian Neugebauer wrote:
>>  >
>>  > Hi,
>>  >
>>  > We encountered the following problem with perf. We want to 
>> measure the
>>  > total memory bandwidth by using the uncore imc counter 
>> uncore_imc_0,
>>  > uncore_imc_1, ..., uncore_imc_7. In our system the counter
>>  > uncore_imc_2, uncore_imc_3, uncore_imc_6, uncore_imc_7 are NOT 
>> listed
>>  > under /sys/devices. Only uncore_imc_0, uncore_imc_1, uncore_imc_4,
>>  > uncore_imc_5 are available (linked under /sys/device and 
>> accessible via
>>  perf).
>>  >
>> 
>>  Hi,
>> 
>>  When I tested uncore with perf on (probably) the same (or very 
>> similar)
>>  Haswell EP CPU as the one of yours, I also have seen only imcs 0, 
>> 1, 4, 5. Are
>>  you sure the 2, 3, 6, 7 should really be there (are supported by 
>> the CPU itself)?
>> 
>>  My guess would be that the 2, 3, 6, 7 slots are reserved/unused.
>> 
>>  Could you attach more info about your CPU topology (cpuid, lstopo, 
>> ...)?
>> 
>>  This was the CPU I used:
>> 
>>  Intel(R) Xeon(R) CPU E5-2697 v3 @ 2.60GHz
>>  Family: 6
>>  Model: 63
>>  Stepping: 2
>>  RAM: 31976 MB
>>  56 processors on 28 cores organized into 2 numa nodes
>> 
>>  Unfortunatelly, I didn't stored my topology logs, however I think 
>> it is as I said
>>  above.
>> 
>>  Cheers,
>>  Michael
>> 
>> 
>>  > Our setup:
>>  >
>>  > - 2 x Intel Xeon E5-2697 v3 (Haswell EP)
>>  > - uname -a
>>  > Linux wr5 2.6.32-642.4.2.el6.x86_64 #1 SMP Tue Aug 23 11:15:56 CDT
>>  > 2016
>>  > x86_64 x86_64 x86_64 GNU/Linux
>>  > - perf --version
>>  > perf version 2.6.32-642.4.2.el6.x86_64.debug
>>  >
>>  > From my understanding 8 imc counter in total should be available 
>> for
>>  > Haswell EP. The kernel is a fresh build which seems to have all 
>> latest
>>  > perf changes in it. I also checked the perf source code briefly. I
>>  > could do more debugging and try to find out the problem but before
>>  > that I want to know if this is either a known problem, an unknown
>>  > problem or no problem at all because there are restrictions that 
>> I'm not
>>  aware of.
>>  >
>>  > I also double checked other machines (same kernel though). E.g 
>> Intel
>>  > Xeon
>>  > E5-2697 v2 (Ivy Bridge EP) shows me 8 counters as expected, and 
>> if I
>>  > remember correctly Intel Xeon EP E5-2670 (Sandy Bridge EP) had 4
>>  > counter, could double check that if necessary.
>>  >
>>  > Chris
>>  > --
>>  > Christian Neugebauer
>>  >
>>  > --
>>  > To unsubscribe from this list: send the line "unsubscribe 
>> linux-perf-users"
>>  > in
>>  > the body of a message to majordomo@vger.kernel.org More majordomo
>>  info
>>  > at  http://vger.kernel.org/majordomo-info.html
>>  >
>>  --
>>  To unsubscribe from this list: send the line "unsubscribe 
>> linux-perf-users" in
>>  the body of a message to majordomo@vger.kernel.org More majordomo
>>  info at  http://vger.kernel.org/majordomo-info.html
> 
