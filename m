From: William Cohen <wcohen@redhat.com>
Subject: Re: [Perfapi-devel] Lack of aarch64 checks for perf events
 schedulability
Date: Fri, 13 May 2016 20:22:07 -0400
Message-ID: <712b602c-d22f-2e8a-c31d-ca140212ea1b@redhat.com>
References: <5ce079ab-2a31-36f1-713a-8b355888e73d@redhat.com>
 <alpine.DEB.2.20.1605131345560.19648@macbook-air>
 <8a3259e1-e78f-cb50-8bc7-963f924cda70@redhat.com>
 <alpine.DEB.2.20.1605131501210.19648@macbook-air>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60829 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751208AbcENAWJ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 13 May 2016 20:22:09 -0400
In-Reply-To: <alpine.DEB.2.20.1605131501210.19648@macbook-air>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-perf-users@vger.kernel.org, PAPI Developers <perfapi-devel@cs.utk.edu>, Michael Petlan <mpetlan@redhat.com>

On 05/13/2016 03:02 PM, Vince Weaver wrote:
> On Fri, 13 May 2016, William Cohen wrote:
> 
>> It still is worth it to check whether that silent failure behavior of 
>> perf_event_open was expected.
>>
>> According to the cortex a53 manual there are six general purpose 
>> counters and one cycle counter.  Depending on how the event selection is 
>> done it might not be able to use that cycle counter.  It might also be 
>> taking a counter for a watchdog timer.  The Xgene machine I am using 
>> state in the /var/log/messages:
>>
>> hw perfevents: enabled with armv8_pmuv3 PMU driver, 5 counters available
>>
>> How many counters does the dragonboard kernel claim the machine has?
> 
> My dragonboard reports:
> 
> hw perfevents: enabled with arm/armv8-pmuv3 PMU driver, 7 counters available
> 
> and my jetson-tx1 reports:
> 
> hw perfevents: enabled with arm/armv8-pmuv3 PMU driver, 7 counters available
> 
> 
> Neither seems to have the NMI watchdog enabled, or at least it's not set 
> in /proc/sys/kernel/nmi_watchdog
> 
> Vince
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


Hi Vince,

I tried running on the current version of software that I have on my
dragonboard 410c and I see the same test failure for
overflow_allcounters.

-Will

from /var/log/messages:

 hw perfevents: enabled with armv8_pmuv3 PMU driver, 7 counters available     
                 
$ uname -a                      
Linux linaro-alip 4.4.0-linaro-lt-qcom #1 SMP PREEMPT Sat Feb 27 04:55:16 UTC 2 
$ ./ctests/overflow_allcounters >& out.log
$ more out.log
PAPI Error: Error! short read.
System error in PAPI_stop: Invalid argument
Trying to fill 6 hardware counters...
0x4000000f (perf::PERF_COUNT_HW_CPU_CYCLES:period=0) can't be added to the EventSet.
0x40000010 (perf::PERF_COUNT_HW_CPU_CYCLES:freq=0) can't be added to the EventSet.
event_code[0] = 0x40000011 (perf::PERF_COUNT_HW_CPU_CYCLES:precise=0)
event_code[1] = 0x40000012 (perf::PERF_COUNT_HW_CPU_CYCLES:excl=0)
0x40000013 (perf::PERF_COUNT_HW_CPU_CYCLES:mg=0) can't be added to the EventSet.
0x40000014 (perf::PERF_COUNT_HW_CPU_CYCLES:mh=0) can't be added to the EventSet.
0x40000015 (perf::PERF_COUNT_HW_CPU_CYCLES:cpu=0) can't be added to the EventSet.
0x40000016 (perf::PERF_COUNT_HW_CPU_CYCLES:pinned=0) can't be added to the EventSet.
0x40000018 (perf::CYCLES:period=0) can't be added to the EventSet.
0x40000019 (perf::CYCLES:freq=0) can't be added to the EventSet.
0x4000001a (perf::CYCLES:precise=0) can't be added to the EventSet.
0x4000001b (perf::CYCLES:excl=0) can't be added to the EventSet.
0x4000001c (perf::CYCLES:mg=0) can't be added to the EventSet.
0x4000001d (perf::CYCLES:mh=0) can't be added to the EventSet.
0x4000001e (perf::CYCLES:cpu=0) can't be added to the EventSet.
0x4000001f (perf::CYCLES:pinned=0) can't be added to the EventSet.
0x40000021 (perf::CPU-CYCLES:period=0) can't be added to the EventSet.
0x40000022 (perf::CPU-CYCLES:freq=0) can't be added to the EventSet.
0x40000023 (perf::CPU-CYCLES:precise=0) can't be added to the EventSet.
0x40000024 (perf::CPU-CYCLES:excl=0) can't be added to the EventSet.
0x40000025 (perf::CPU-CYCLES:mg=0) can't be added to the EventSet.
0x40000026 (perf::CPU-CYCLES:mh=0) can't be added to the EventSet.
0x40000027 (perf::CPU-CYCLES:cpu=0) can't be added to the EventSet.
0x40000028 (perf::CPU-CYCLES:pinned=0) can't be added to the EventSet.
0x4000002a (perf::PERF_COUNT_HW_INSTRUCTIONS:period=0) can't be added to the EventSet.
0x4000002b (perf::PERF_COUNT_HW_INSTRUCTIONS:freq=0) can't be added to the EventSet.
event_code[2] = 0x4000002c (perf::PERF_COUNT_HW_INSTRUCTIONS:precise=0)
event_code[3] = 0x4000002d (perf::PERF_COUNT_HW_INSTRUCTIONS:excl=0)
event_code[4] = 0x4000002e (perf::PERF_COUNT_HW_INSTRUCTIONS:mg=0)
event_code[5] = 0x4000002f (perf::PERF_COUNT_HW_INSTRUCTIONS:mh=0)
Tried to fill 6 counters with events, found 6
Trying 6 events
0: perf::PERF_COUNT_HW_CPU_CYCLES:precise=0
1: perf::PERF_COUNT_HW_CPU_CYCLES:excl=0
2: perf::PERF_COUNT_HW_INSTRUCTIONS:precise=0
3: perf::PERF_COUNT_HW_INSTRUCTIONS:excl=0
4: perf::PERF_COUNT_HW_INSTRUCTIONS:mg=0
5: perf::PERF_COUNT_HW_INSTRUCTIONS:mh=0
Using a threshold of 24180000 (20,000 * MHz)
Testing that the events all work with no overflow
overflow_allcounters.c       FAILED
Line # 137
