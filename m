From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Adding cache misses and references to list of default events for perf stat?
Date: Wed, 05 Nov 2014 11:26:36 +0900
Message-ID: <87tx2exu03.fsf@sejong.aot.lge.com>
References: <2902317.tSPbunES6b@milian-kdab2>
	<87mw86k9gm.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:46617 "EHLO
	lgemrelse7q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbaKEC0j (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 4 Nov 2014 21:26:39 -0500
In-Reply-To: <87mw86k9gm.fsf@tassilo.jf.intel.com> (Andi Kleen's message of
	"Tue, 04 Nov 2014 12:16:25 -0800")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Milian Wolff <mail@milianw.de>, linux-perf-users@vger.kernel.org

Hi Andi and Milian,

On Tue, 04 Nov 2014 12:16:25 -0800, Andi Kleen wrote:
> Milian Wolff <mail@milianw.de> writes:
>
>> Hello all,
>>
>> could we have the cache-references,cache-misses events added to the list of 
>> default events for perf stat? I think it is a very valuable metric for all 
>> user-space applications.
>>
>> Currently, I run perf stat twice, once with the default events, and once with
>>
>> perf stat -e cache-references,cache-misses ...
>>
>> there is no easy way to append two events to the list of default events.
>>
>> So, what do you think?
>
> On most systems with only four counters it'll start multiplexing, which
> will give much worse results. Defaulting to non multiplexing is much
> better.

Anyway it has -d/--detailed option which can be specified up to 3 times.

 # perf stat -ad sleep 1

 Performance counter stats for 'system wide':

       8021.100443      task-clock (msec)         #    8.013 CPUs utilized           [100.00%]
               574      context-switches          #    0.072 K/sec                   [100.00%]
                10      cpu-migrations            #    0.001 K/sec                   [100.00%]
                61      page-faults               #    0.008 K/sec                  
       153,639,037      cycles                    #    0.019 GHz                     [40.05%]
       223,846,109      stalled-cycles-frontend   #  145.70% frontend cycles idle    [40.14%]
       205,555,693      stalled-cycles-backend    #  133.79% backend  cycles idle    [40.15%]
       173,763,228      instructions              #    1.13  insns per cycle        
                                                  #    1.29  stalled cycles per insn [50.12%]
        34,553,334      branches                  #    4.308 M/sec                   [50.12%]
           410,018      branch-misses             #    1.19% of all branches         [50.02%]
        45,617,877      L1-dcache-loads           #    5.687 M/sec                   [49.93%]
         2,232,930      L1-dcache-load-misses     #    4.89% of all L1-dcache hits   [49.88%]
           563,164      LLC-loads                 #    0.070 M/sec                   [39.92%]
           240,780      LLC-load-misses           #   42.75% of all LL-cache hits    [39.92%]

       1.000997709 seconds time elapsed

Thanks,
Namhyung


>
> Reproducing the standard perf stat output isn't that difficult. It's 
>
> perf stat -e task-clock,cs,migrations,page-faults,cycles,instructions,branches,branch-misses
>
> and then add more events. If you remove the bogus stalled-* events you
> have even two free counters.
>
> If you exceed four you should define appropiate groups with {} 
>
> -Andi
