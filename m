Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794754950;
	b=OKi0DQZyrElPCuWBdb9emKe509wp/kiNVPI1dsvwbhO1C9G9DpHUY+UcF4LBSQHMUmjD
	 1qZdRoISnugqrip1rJqLBNs9BJxHeCWlyNtqwQ3r7B93dcIpJytOpcRYKmEfVcUf9nSRL
	 4ctuHtO2PqiFYbMiPJHEFNjLn/ajDQM7MSYZaJV4wHiOT4dfDlrfNGknJjnl8LaRP0ja4
	 wYNHE2p8Fup5RkKXxYLLFZI177VP64FzS0ujWZB8kYvp+pYLvC5LwsgaYZ0iAgqcJ97rt
	 og7j2ekd7ms+B7o1AdJFzkQCBEem+pgAsipY8mFIg0o+jwzC8azQU5G6hoR5Cd2KBfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754950;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=w7uMVJxWJbX08TvvrTzW9r0IoQZP3juZ1oVI4w4CO0o=;
	b=ojvQGKtXlC2QxV0N0sO99jgd1mmHouXu1LAo3Fa/4J6pu/tTykCH7pkTNWnfiQ6LMfyY
	 3UyDuUb0LreVVZoZsQMge3urH7HcD985GWABNwvNm8cq9FsIAHABvkx3s2g1ZX3bKQIf/
	 T2QoGWXydC0MsrPdbn3bXSZX8vgcrXYmmPXpmrqR1i/yDYhKbZHN4eOVEbhWxXswm6mdO
	 QHzQewDPEawWQ/LYAKImrGn0LU4sfXYfi6h6MHpwZGBB1S+tPRzKqH2Ax3WcBfGL8prTz
	 isuEN74d3/Nh5N4aD7vO14D0LlUDK8aGuol2X4dwCWAibYkPmo8IqvWbbO9198KVabA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=I4ZkV+4m;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33E1606A31A;
	Sun, 15 Nov 2026 15:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B33E1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=I4ZkV+4m
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9ED8A1476;
	Sun, 15 Nov 2026 07:02:25 -0800 (PST)
Received: from [10.163.154.178] (unknown [10.163.154.178])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36F513F763;
	Sun, 15 Nov 2026 07:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794754948; bh=kpWMH2H2BaA/Bli+UmY1k78RuIDHHeR7QAG4ShQyMQ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I4ZkV+4mPNHxY+wx1WJZu+eAW6A8Jpj4g1ip2tKB/ccrEHmZQh0dljbAu2CuTAjzu
	 ysx8+EzSHWlUDSNVHB7eMs8JqkdOzPKILoj2Behvnjr0mBnTvTkmmQ5FEI/8EiQytv
	 Zmm3Q86O89uMDR4Tz1ju30dTvh4HlQN3gJ+1aqf4=
Message-ID: <307b4d48-00f2-40dc-bf3f-ffa0f2f58d33@arm.com>
Date: Sun, 15 Nov 2026 20:32:16 +0530
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "perf/aux: Allocate non-contiguous AUX pages by
 default"
To: Yabin Cui <yabinc@google.com>
Cc: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>,
 James Clark <james.clark@linaro.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Tamas Petz <tamas.petz@arm.com>, Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Michiel van Tol <michiel.vantol@arm.com>, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261025-perf_revert_prefer_large_alloc-v1-1-5fb431bbd624@arm.com>
 <57c34e26-3048-474d-8e74-f65799e32ff4@arm.com>
 <CALJ9ZPNWcDtajO+Luhxe1K3af64mPRFQSjvfvNornyFFkam-+g@mail.gmail.com>
 <CALJ9ZPO9XxF-kz5K67Jg8RtpiEmK7XFU3e+xDak6LyV_We7yBQ@mail.gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <CALJ9ZPO9XxF-kz5K67Jg8RtpiEmK7XFU3e+xDak6LyV_We7yBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 04/11/26 2:16 am, Yabin Cui wrote:
> [Resending in plain text for the mailing lists; sorry for the duplicate.]
> 
> Hi Leo, Will, Dev,
> 
> On Sun, Oct 25, 2026 at 04:24:06PM +0000, Leo Yan wrote:
>> The original commit claimed that contiguous AUX pages unnecessarily
>> exacerbate fragmentation for SPE, TRBE and ETR. This is not generally
>> valid: larger allocations can keep pages with the same lifetime together,
>> while order-0 allocations can scatter them across large blocks and prevent
>> free pages from coalescing [1]. The follow-up discussion [2] has not
>> established how forcing order-0 allocations addresses the reported problem.
> ...
>> Restore the previous policy of trying higher-order allocations first.
>> The allocator already uses __GFP_NORETRY and falls back to smaller
>> orders, including order 0, when larger allocations fail.
> 
> Sorry for the late reply, and sorry that the commit message in
> 18049c8cff9c ("perf/aux: Allocate non-contiguous AUX pages by default")
> was imprecise about "exacerbating memory fragmentation". You and Dev are
> right that grouping same-lifetime pages into higher-order allocations
> does not itself worsen fragmentation, and the TLB reduction numbers for
> TRBE and SPE with large vmap() mappings make total sense given TRBE's
> tiny TLB.
> 
> However, a straight revert will reintroduce a severe production issue we
> hit on Android devices, so I'd like to share what actually happened and
> suggest a way to get large mappings for SPE/TRBE without bringing back
> the regression.
> 
> ### What happened in production (even with __GFP_NORETRY)
> 
> On Android Pixel dogfood devices, a background daemon (profcollectd)
> periodically records short (1s) system-wide CoreSight ETM traces every
> ~10 minutes for AutoFDO, using a 4 MiB AUX buffer per CPU with default
> aux_watermark = 0 (so watermark = 2 MiB, max_order = 9).
> 
> Although PERF_AUX_GFP includes __GFP_NORETRY, it is based on GFP_KERNEL,
> which retains __GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM. __GFP_NORETRY
> only avoids retry loops and the kernel OOM killer at the end of
> __alloc_pages_slowpath(). On long-running phones where physical memory is
> already fragmented and order 9..4 pages are unavailable, every failed
> high-order call in rb_alloc_aux_page() still enters the slowpath and:
> 
>   1. Wakes kswapd/kcompactd at that high order.
>   2. Runs synchronous direct compaction (__alloc_pages_direct_compact()).
>   3. Runs synchronous direct reclaim (__alloc_pages_direct_reclaim()),
>      evicting pages and raising memory PSI pressure. On Android, PSI
>      reclaim stalls trigger userspace lmkd (Low Memory Killer daemon)
>      even though the kernel OOM killer is never invoked.
> 
> This is amplified by two loops in rb_alloc_aux():
>   - rb_alloc_aux_page() steps down one order at a time (9, 8, ..., 0),
>     hitting direct compaction/reclaim at each unavailable order.
>   - Worse, the outer loop in rb_alloc_aux() never lowers max_order when
>     rb_alloc_aux_page() falls back:
> 
>       order = min(max_order, ilog2(nr_pages - rb->aux_nr_pages));
>       page = rb_alloc_aux_page(node, order);
> 
>     When a 4 MiB buffer (1024 pages) only finds order-0 pages, it retries
>     orders 9..1 on almost every iteration -- thousands of failed
>     high-order slowpath compaction/reclaim attempts for a single
>     perf_mmap() call.
> 
> In field telemetry and local ftrace on Pixel devices (prior to
> 18049c8cff9c, so __GFP_NORETRY was already in place), we observed heavy
> rb_alloc_aux() -> __alloc_pages_direct_compact() stalls alongside
> kcompactd0 pinned on big cores scanning order-9, and this accounted for
>> 20% of all perceptible app kills (via lmkd) across dogfood devices
> until we stopped high-order AUX allocations.
> 
> Initially we worked around this in userspace (simpleperf) by setting
> perf_event_attr::aux_watermark = 4096 so get_order(watermark) == 0. That
> was fine for CoreSight ETR (which uses its own separate scatter-gather
> buffer and only copies into AUX on flush/stop), but when enabling TRBE
> (and SPE) it caused hardware maintenance interrupts every 4 KiB instead
> of every 2 MiB. Also, in overwrite/snapshot mode rb_alloc_aux() ignores
> aux_watermark and uses ilog2(nr_pages). That is why I sent 18049c8cff9c.
> 
> ### Possible solutions
> 
> For PMUs without PERF_PMU_CAP_AUX_NO_SG (such as SPE, TRBE, and modern
> Intel PT), higher-order AUX pages are an opportunistic optimization
> rather than a functional requirement -- very similar to THP allocations
> on fault (GFP_TRANSHUGE_LIGHT) or opportunistic high-order slabs in SLUB
> (allocate_slab()).
> 
> Instead of reverting to GFP_KERNEL reclaim/compaction for all high-order
> attempts, could we do the following?
> 
> 1. Make opportunistic high-order AUX allocations no-reclaim:
>    When !(event->pmu->capabilities & PERF_PMU_CAP_AUX_NO_SG) and
>    order > 0, clear __GFP_RECLAIM (and add __GFP_NOMEMALLOC, matching
>    SLUB's allocate_slab() and GFP_TRANSHUGE_LIGHT):
> 
>      gfp_t gfp = PERF_AUX_GFP;
> 
>      if (order && !has_no_sg)
>              gfp = (PERF_AUX_GFP | __GFP_NOMEMALLOC) & ~__GFP_RECLAIM;

Thanks for your reply.

This looks like the correct solution. Note commit 0e05a469c294
("mm/page_alloc: avoid direct reclaim and compaction for costly __GFP_NORETRY allocations")
post which the regression you report should reduce drastically. It only
removes GFP_DIRECT_RECLAIM flag, I assume you are seeing latency even
due to reclaim/compaction daemon wakeups.

So instead of enhancing this commit even more by making a page-allocator
change, I would rather make your proposed change on the perf side to
keep it simple. This should completely solve the problem.


> 
>    When order falls back to 0 (or when PERF_PMU_CAP_AUX_NO_SG is set),
>    keep PERF_AUX_GFP so single-page allocations still reclaim normally
>    under memory pressure.
> 
>    That way, when free order-9 / order-4 blocks exist, SPE and TRBE get
>    them immediately for PMD / contiguous-PTE vmap() mappings (and pages
>    stay grouped together); when memory is fragmented on a long-running
>    device, high-order probes fail fast on the freelist without waking
>    kcompactd/kswapd or triggering direct compaction and reclaim.
> 
> 2. Clamp max_order in rb_alloc_aux() after fallback:
>    If rb_alloc_aux_page() requested `order` and had to fall back to a
>    smaller order, update `max_order = page_private(page)` in
>    rb_alloc_aux() so subsequent iterations for the rest of the buffer do
>    not keep re-probing higher orders that just failed.
> 
> (Optionally, if server/benchmark workloads ever want synchronous
> compaction to form huge AUX mappings even on fragmented hosts, that could
> be gated behind an opt-in attr/sysfs knob similar to THP defrag modes,
> with light/no-reclaim as the default.)
> 
> Would this approach work for your SPE/TRBE use cases? Happy to help test
> on our side.
> 
> Thanks,
> Yabin
> 
> 
> On Tue, Nov 3, 2026 at 12:32 PM Yabin Cui <yabinc@google.com> wrote:
>>
>> Hi Leo, Will, Dev,
>>
>> Sorry for the late reply, and sorry that the commit message in
>> 18049c8cff9c ("perf/aux: Allocate non-contiguous AUX pages by default")
>> was imprecise about "exacerbating memory fragmentation". You and Dev are
>> right that grouping same-lifetime pages into higher-order allocations
>> does not itself worsen fragmentation, and the TLB reduction numbers for
>> TRBE and SPE with large vmap() mappings make total sense given TRBE's
>> tiny TLB.
>>
>> However, a straight revert will reintroduce a severe production issue we
>> hit on Android devices, so I'd like to share what actually happened and
>> suggest a way to get large mappings for SPE/TRBE without bringing back
>> the regression.
>>
>> ### What happened in production (even with __GFP_NORETRY)
>>
>> On Android Pixel dogfood devices, a background daemon (profcollectd)
>> periodically records short (1s) system-wide CoreSight ETM traces every
>> ~10 minutes for AutoFDO, using a 4 MiB AUX buffer per CPU with default
>> aux_watermark = 0 (so watermark = 2 MiB, max_order = 9).
>>
>> Although PERF_AUX_GFP includes __GFP_NORETRY, it is based on GFP_KERNEL,
>> which retains __GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM. __GFP_NORETRY
>> only avoids retry loops and the kernel OOM killer at the end of
>> __alloc_pages_slowpath(). On long-running phones where physical memory is
>> already fragmented and order 9..4 pages are unavailable, every failed
>> high-order call in rb_alloc_aux_page() still enters the slowpath and:
>>
>>   1. Wakes kswapd/kcompactd at that high order.
>>   2. Runs synchronous direct compaction (__alloc_pages_direct_compact()).
>>   3. Runs synchronous direct reclaim (__alloc_pages_direct_reclaim()),
>>      evicting pages and raising memory PSI pressure. On Android, PSI
>>      reclaim stalls trigger userspace lmkd (Low Memory Killer daemon)
>>      even though the kernel OOM killer is never invoked.
>>
>> This is amplified by two loops in rb_alloc_aux():
>>   - rb_alloc_aux_page() steps down one order at a time (9, 8, ..., 0),
>>     hitting direct compaction/reclaim at each unavailable order.
>>   - Worse, the outer loop in rb_alloc_aux() never lowers max_order when
>>     rb_alloc_aux_page() falls back:
>>
>>       order = min(max_order, ilog2(nr_pages - rb->aux_nr_pages));
>>       page = rb_alloc_aux_page(node, order);
>>
>>     When a 4 MiB buffer (1024 pages) only finds order-0 pages, it retries
>>     orders 9..1 on almost every iteration -- thousands of failed
>>     high-order slowpath compaction/reclaim attempts for a single
>>     perf_mmap() call.
>>
>> In field telemetry and local ftrace on Pixel devices (prior to
>> 18049c8cff9c, so __GFP_NORETRY was already in place), we observed heavy
>> rb_alloc_aux() -> __alloc_pages_direct_compact() stalls alongside
>> kcompactd0 pinned on big cores scanning order-9, and this accounted for
>>> 20% of all perceptible app kills (via lmkd) across dogfood devices
>> until we stopped high-order AUX allocations.
>>
>> Initially we worked around this in userspace (simpleperf) by setting
>> perf_event_attr::aux_watermark = 4096 so get_order(watermark) == 0. That
>> was fine for CoreSight ETR (which uses its own separate scatter-gather
>> buffer and only copies into AUX on flush/stop), but when enabling TRBE
>> (and SPE) it caused hardware maintenance interrupts every 4 KiB instead
>> of every 2 MiB. Also, in overwrite/snapshot mode rb_alloc_aux() ignores
>> aux_watermark and uses ilog2(nr_pages). That is why I sent 18049c8cff9c.
>>
>> ### Possible solutions
>>
>> For PMUs without PERF_PMU_CAP_AUX_NO_SG (such as SPE, TRBE, and modern
>> Intel PT), higher-order AUX pages are an opportunistic optimization
>> rather than a functional requirement -- very similar to THP allocations
>> on fault (GFP_TRANSHUGE_LIGHT) or opportunistic high-order slabs in SLUB
>> (allocate_slab()).
>>
>> Instead of reverting to GFP_KERNEL reclaim/compaction for all high-order
>> attempts, could we do the following?
>>
>> 1. Make opportunistic high-order AUX allocations no-reclaim:
>>    When !(event->pmu->capabilities & PERF_PMU_CAP_AUX_NO_SG) and
>>    order > 0, clear __GFP_RECLAIM (and add __GFP_NOMEMALLOC, matching
>>    SLUB's allocate_slab() and GFP_TRANSHUGE_LIGHT):
>>
>>      gfp_t gfp = PERF_AUX_GFP;
>>
>>      if (order && !has_no_sg)
>>              gfp = (PERF_AUX_GFP | __GFP_NOMEMALLOC) & ~__GFP_RECLAIM;
>>
>>    When order falls back to 0 (or when PERF_PMU_CAP_AUX_NO_SG is set),
>>    keep PERF_AUX_GFP so single-page allocations still reclaim normally
>>    under memory pressure.
>>
>>    That way, when free order-9 / order-4 blocks exist, SPE and TRBE get
>>    them immediately for PMD / contiguous-PTE vmap() mappings (and pages
>>    stay grouped together); when memory is fragmented on a long-running
>>    device, high-order probes fail fast on the freelist without waking
>>    kcompactd/kswapd or triggering direct compaction and reclaim.
>>
>> 2. Clamp max_order in rb_alloc_aux() after fallback:
>>    If rb_alloc_aux_page() requested `order` and had to fall back to a
>>    smaller order, update `max_order = page_private(page)` in
>>    rb_alloc_aux() so subsequent iterations for the rest of the buffer do
>>    not keep re-probing higher orders that just failed.
>>
>> (Optionally, if server/benchmark workloads ever want synchronous
>> compaction to form huge AUX mappings even on fragmented hosts, that could
>> be gated behind an opt-in attr/sysfs knob similar to THP defrag modes,
>> with light/no-reclaim as the default.)
>>
>> Would this approach work for your SPE/TRBE use cases? Happy to help test
>> on our side.
>>
>> Thanks,
>> Yabin
>>
>>
>> On Wed, Oct 28, 2026 at 11:56 PM Dev Jain <dev.jain@arm.com> wrote:
>>>
>>>
>>>
>>> On 25/10/26 9:54 pm, Leo Yan wrote:
>>>> This reverts commit 18049c8cff9cc89daadc4df6975f7d9069638926.
>>>>
>>>> The original commit claimed that contiguous AUX pages unnecessarily
>>>> exacerbate fragmentation for SPE, TRBE and ETR. This is not generally
>>>> valid: larger allocations can keep pages with the same lifetime
>>>> together, while order-0 allocations can scatter them across large
>>>> blocks and prevent free pages from coalescing [1]. The follow-up
>>>> discussion [2] has not established how forcing order-0 allocations
>>>> addresses the reported problem.
>>>>
>>>> TRBE and SPE write to virtually addressed buffers. The TRBE L1 TLB
>>>> has one entry on Neoverse V2 [3] and two on Neoverse V3 [4]. Small
>>>> mappings increase translation pressure, and TTW stalls can contribute
>>>> to FIFO overflow and trace loss on TRBE.
>>>>
>>>> Larger allocations provide contiguous, aligned chunks for PMD or
>>>> contiguous-PTE mappings with the proposed vmap() support [5].
>>>> With the proposed vmap() support already applied, the tests in [2]
>>>> showed that preferring larger AUX allocations reduced L2 data TLB
>>>> refills by 99.68% in the TRBE test and 34.74% in the SPE test.
>>>>
>>>> Restore the previous policy of trying higher-order allocations first.
>>>> The allocator already uses __GFP_NORETRY and falls back to smaller
>>>> orders, including order 0, when larger allocations fail.
>>>>
>>>> Remove PERF_PMU_CAP_AUX_PREFER_LARGE, since the restored default
>>>> provides that preference. Intel PT retains its existing allocation
>>>> behaviour, with no functional change.
>>>>
>>>> [1] https://lore.kernel.org/all/aPjrRkjiIt6HmXmT@casper.infradead.org/
>>>> [2] https://lore.kernel.org/linux-arm-kernel/20260810-perf_aux_trace_large_granule-v1-0-03306c9339e3@arm.com/
>>>> [3] https://documentation-service.arm.com/static/633fe1ec4c59b30b517730b8#page=52
>>>> [4] https://documentation-service.arm.com/static/67361bd2c7fc0d1f211da382#page=54
>>>> [5] https://lore.kernel.org/linux-mm/20260715120813.3609949-1-jiangwen6@xiaomi.com/
>>>>
>>>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>>>> ---
>>>
>>> Reviewed-by: Dev Jain <dev.jain@arm.com>
>>>
>>>
>>>>  arch/x86/events/intel/pt.c  |  2 --
>>>>  include/linux/perf_event.h  |  5 ++---
>>>>  kernel/events/ring_buffer.c | 29 +++++++++--------------------
>>>>  3 files changed, 11 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
>>>> index 49349afee6119fb6fad815c847cb3cd9daa97604..3782af40f0832a874a7f0b60961d6652513de241 100644
>>>> --- a/arch/x86/events/intel/pt.c
>>>> +++ b/arch/x86/events/intel/pt.c
>>>> @@ -1896,8 +1896,6 @@ static __init int pt_init(void)
>>>>
>>>>       if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries))
>>>>               pt_pmu.pmu.capabilities = PERF_PMU_CAP_AUX_NO_SG;
>>>> -     else
>>>> -             pt_pmu.pmu.capabilities = PERF_PMU_CAP_AUX_PREFER_LARGE;
>>>>
>>>>       pt_pmu.pmu.capabilities         |= PERF_PMU_CAP_EXCLUSIVE |
>>>>                                          PERF_PMU_CAP_ITRACE |
>>>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>>>> index eb3f7bab498ca9bee9ce7193744943b24ab2e0c5..b8d8b005f5c8a7c1def7cad02230bf9ffb876bd6 100644
>>>> --- a/include/linux/perf_event.h
>>>> +++ b/include/linux/perf_event.h
>>>> @@ -304,9 +304,8 @@ struct perf_event_pmu_context;
>>>>  #define PERF_PMU_CAP_AUX_OUTPUT              0x0080
>>>>  #define PERF_PMU_CAP_EXTENDED_HW_TYPE        0x0100
>>>>  #define PERF_PMU_CAP_AUX_PAUSE               0x0200
>>>> -#define PERF_PMU_CAP_AUX_PREFER_LARGE        0x0400
>>>> -#define PERF_PMU_CAP_MEDIATED_VPMU   0x0800
>>>> -#define PERF_PMU_CAP_SIMD_REGS               0x1000
>>>> +#define PERF_PMU_CAP_MEDIATED_VPMU   0x0400
>>>> +#define PERF_PMU_CAP_SIMD_REGS               0x0800
>>>>
>>>>  /**
>>>>   * pmu::scope
>>>> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
>>>> index 64d4dbdc6c071b72b670dd044616f52981206ae8..95f4fbdfd2764de5b72d901d778c46302f525fad 100644
>>>> --- a/kernel/events/ring_buffer.c
>>>> +++ b/kernel/events/ring_buffer.c
>>>> @@ -684,15 +684,7 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>>>>  {
>>>>       bool overwrite = !(flags & RING_BUFFER_WRITABLE);
>>>>       int node = (event->cpu == -1) ? -1 : cpu_to_node(event->cpu);
>>>> -     bool use_contiguous_pages = event->pmu->capabilities & (
>>>> -             PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_PREFER_LARGE);
>>>> -     /*
>>>> -      * Initialize max_order to 0 for page allocation. This allocates single
>>>> -      * pages to minimize memory fragmentation. This is overridden if the
>>>> -      * PMU needs or prefers contiguous pages (use_contiguous_pages = true).
>>>> -      */
>>>> -     int max_order = 0;
>>>> -     int ret = -ENOMEM;
>>>> +     int ret = -ENOMEM, max_order;
>>>>
>>>>       if (!has_aux(event))
>>>>               return -EOPNOTSUPP;
>>>> @@ -702,8 +694,8 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>>>>
>>>>       if (!overwrite) {
>>>>               /*
>>>> -              * Watermark defaults to half the buffer, to aid PMU drivers
>>>> -              * in double buffering.
>>>> +              * Watermark defaults to half the buffer, and so does the
>>>> +              * max_order, to aid PMU drivers in double buffering.
>>>>                */
>>>>               if (!watermark)
>>>>                       watermark = min_t(unsigned long,
>>>> @@ -711,19 +703,16 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>>>>                                         (unsigned long)nr_pages << (PAGE_SHIFT - 1));
>>>>
>>>>               /*
>>>> -              * If using contiguous pages, use aux_watermark as the basis
>>>> -              * for chunking to help PMU drivers honor the watermark.
>>>> +              * Use aux_watermark as the basis for chunking to
>>>> +              * help PMU drivers honor the watermark.
>>>>                */
>>>> -             if (use_contiguous_pages)
>>>> -                     max_order = get_order(watermark);
>>>> +             max_order = get_order(watermark);
>>>>       } else {
>>>>               /*
>>>> -              * If using contiguous pages, we need to start with the
>>>> -              * max_order that fits in nr_pages, not the other way around,
>>>> -              * hence ilog2() and not get_order.
>>>> +              * We need to start with the max_order that fits in nr_pages,
>>>> +              * not the other way around, hence ilog2() and not get_order.
>>>>                */
>>>> -             if (use_contiguous_pages)
>>>> -                     max_order = ilog2(nr_pages);
>>>> +             max_order = ilog2(nr_pages);
>>>>               watermark = 0;
>>>>       }
>>>>
>>>>
>>>> ---
>>>> base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
>>>> change-id: 20261025-perf_revert_prefer_large_alloc-a0177d6379f6
>>>>
>>>> Best regards,
>>>

