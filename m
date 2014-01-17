From: Manuel Selva <selva.manuel@gmail.com>
Subject: Remote Cache Accesses (1 Hop)
Date: Fri, 17 Jan 2014 14:24:09 +0100
Message-ID: <52D92EF9.8000903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:54619 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbaAQNYM (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 17 Jan 2014 08:24:12 -0500
Received: by mail-we0-f172.google.com with SMTP id q58so4586096wes.17
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Jan 2014 05:24:11 -0800 (PST)
Received: from [192.168.0.10] (mut38-6-88-167-68-98.fbx.proxad.net. [88.167.68.98])
        by mx.google.com with ESMTPSA id q15sm9356747wjw.18.2014.01.17.05.24.10
        for <linux-perf-users@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 05:24:10 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

I wrote a benchmarking program, in order to play with perf_event_open 
memory sampling capabilities (as discussed earlier on this list).

My benchmark is allocating a large array of memory (120 megas by 
default), then I am starting sampling with perf_event_open and the 
MEM_INST_RETIRED_LATENCY_ABOVE_THRESHOLD event (with threshold = 3, the 
minimal one according to Intel's doc) along with memory accesses 
counting (uncore event QMC_NORMAL_READ.ANY) and I access all the 
allocated memory either sequentially or randomly. The benchmark is mono 
thread, pinned to a given core, and memory is allocate don the core 
associated with this node using numa_alloc functions. perf_event_open is 
thus called to monitor only this core/numa node. The code is compiled 
without any optimization and I tried as possible to increase the ratio 
of memory accesses codes vs branching, and other stuff code.

I can clearly see with the QMC_NORMAL_READ.ANY events count that my 
random accesses test case generate far more memory accesses than the 
sequential one (I guess the prefetcher and sequential access are 
responsible for that).

Regarding the sampled event, I successfully mmap the result of perf 
event open and I am able to read the samples. My problem is that even 
for the random accesses test case on the 120 megas, I don't have any 
samples served by the RAM (I am using the PERF_SAMPLE_DATA_SRC field) 
(the sampling period is 1000 events and I only get ~700 samples). 
Nevertheless, in the sequential case I have 0,01% of my samples that are 
remote cache accesses (1 Hop) where as this percentage is ~20% in the 
random case.

So my questions are:

- What is exactly remote cache (1 hop) ? A data found in another core's 
private cache (L1 or L2 in my case) on the same processor ?

- How can I interpret my results, I was expecting to have local memory 
accesses samples increasing in the random case instead of remote cache 
(1 hop). How can I have remote cache accesses with malloced data not 
shared, and used by a thread pinned to a given core.

- I didn't yet look at that on details, but 700~ samples for accessing 
120 megas with sampling every 1000 events seems small. I am going to 
check the assembly code generated and also count the total number of 
memory requests (a core event) and compare that to the 700 samples * 
1000 events.

Thanks in advance for any suggestions you may have in order to help 
understand what's happening there.

-- 
Manu
