Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD5D379987;
	Wed,  5 Aug 2026 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947818; cv=none; b=QFgTcGFt/gqu8Tw0jkgqeh2Tyx4SgyvQQEZeYAk6/nmXShVjXkJjdqs9/p8bd0Pq4795VMVeNzzb2SBv7FI6pqNZyCl7F1RtX/7gEyCcFlR8kpDWXMwcgbGqqfWwBP2AKzzuawWf3Yrql3heD1kWd+yy7BE3zpiL/VB7xXnwsTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947818; c=relaxed/simple;
	bh=siZXWbYQWMIg/+8AhVVPOzWO+rx6FEab5fiKZcAyGZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7ZIn9tSY9Z2yTipWGUlEy7St7CLgkM1mXwzA6riyCyuI1tDnly4ndC67OYPHQ9Ho6Evcb/Eub7k5yJkr0VTnvqf6w/eULXxaNwQjywo8bVe41lThzqGe124bR/SqwY75GOjkzCXlZ7NBn6gIIM1vg3MIIhJINlA3IhvMafv22Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4lguewy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4lguewy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785947817; x=1817483817;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=siZXWbYQWMIg/+8AhVVPOzWO+rx6FEab5fiKZcAyGZo=;
  b=Z4lguewyiP7IaksxTc1xmV9v62bXTLnuLAvbp2QGWBBaIZXjTpb7ESOR
   n6Eg1qIIJB9RtbpG6gV6ynSiIf0VUYAbbEpmho35HB98b9fEEyJePswBn
   oDIKnXZVV9DE7O0rG0XIiJlpXGAALW+Nkb22QW2aF3CtlZA2cebmtW+Dr
   c1irB0Yib+dFXBiE7/jXhy1KeFsGcg+lJz3DnSpXmwjRRySv0zgdTkL+3
   dj5nm/pvJXOQiLkAJUWTBph9iNRbinMvYB4bHbqYKr+olmi4Qfqx4OS/7
   +8fC7Mi4aB33sqPEIpS7iwlUIKaDBA1wQU9M/lZqCaxpuJp0hVaG2ZmXQ
   w==;
X-CSE-ConnectionGUID: vAhVuUeOQ/WnFVp+G8k8Ww==
X-CSE-MsgGUID: yVDIltZ4RJy+7AAff/ebqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="103931844"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="103931844"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 09:36:55 -0700
X-CSE-ConnectionGUID: +5+ijJ8wTTixWH9+2MpD6g==
X-CSE-MsgGUID: nqbD+/ORQcK7mmmW9RcuhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="258521262"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.42]) ([10.125.109.42])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 09:35:33 -0700
Message-ID: <74b88c40-c40a-464b-b6e9-9ee4f7f91145@intel.com>
Date: Wed, 5 Aug 2026 09:35:31 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v4 08/11] perf/cxl: Unfreeze counters after
 handling an overflow interrupt
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260805155911.1304807-1-dave.jiang@intel.com>
 <20260805155911.1304807-9-dave.jiang@intel.com>
 <20260805161558.D1C471F000E9@smtp.kernel.org>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260805161558.D1C471F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/5/26 9:15 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> 
> New issues:
> - [High] A cross-CPU TOCTOU race condition during CPU migration can leave the PMU permanently unfrozen when it is supposed to be disabled, leading to a specification violation where a running counter is written to.

The window is real but the spec conclusion is not. CXL r4.0 8.2.7.1.1,
Counters Writable while Frozen, ties writability to enabled or frozen,
not to running:

  1 = ... software is permitted to write and modify any Fixed-function
      Counter Data register or any Configurable Counter Data register while
      it is frozen.

cxl_pmu_parse_caps() refuses to probe unless that bit is set, so the write
event_start() does is explicitly permitted. The stray unfreeze takes away
the frozen state, which the grant does not cover. We get a garbage initial
count on one event, on a CPU that is going away, and the destination's
pmu_enable() unfreezes a moment later anyway.

A lock would close the gap between the flag read and the freeze write, but
the handler still races event_start() on the other CPU, so it narrows the
race rather than removing it.

The real fix is not depending on same-CPU semantics at all. Moving
prev_count and event->count off local64_t makes this class of question go
away. Needs follow changes if that is the direction we want to go.

DJ

> 
> Pre-existing issues:
> - [High] `__cxl_pmu_read` is vulnerable to a cross-CPU data race on `hwc->prev_count` during CPU migration because it relies on `local64_cmpxchg`.
> - [High] Pending overflow interrupts can be incorrectly attributed to newly scheduled events on the same counter, corrupting their counts by adding a spurious full period.
> - [High] Writing 1s to RsvdZ (Reserved, must be zero) bits in the Freeze register violates the CXL specification and risks fatal hardware errors.
> - [High] Concurrent PMU reads and overflows cause massive double-counting or loss of events due to stateless overflow handling.
> --
> 
> --- Patch [8]: [RESEND PATCH v4 08/11] perf/cxl: Unfreeze counters after handling an overflow interrupt ---
> commit 77054eb72889cfc4fca68e72d632bb6f5cfbe02d
> Author: Dave Jiang <dave.jiang@intel.com>
> 
> perf/cxl: Unfreeze counters after handling an overflow interrupt
> 
> The counters run with Freeze on Overflow set, so one overflow freezes every
> counter in the block. cxl_pmu_irq() reads the overflowed counters and clears
> the overflow status but never unfreezes, so everything stays frozen until the
> next pmu_enable(). This patch unfreezes after clearing the status, unless the
> PMU has been disabled in the meantime.
> 
> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
> 
>> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
>> index 448e1da3d59f9..a081fcba69917 100644
>> --- a/drivers/perf/cxl_pmu.c
>> +++ b/drivers/perf/cxl_pmu.c
> 
> [ ... ]
> 
>> @@ -604,6 +607,7 @@ static void cxl_pmu_disable(struct pmu *pmu)
>>  	struct cxl_pmu_info *info = pmu_to_cxl_pmu_info(pmu);
>>  	void __iomem *base = info->base;
>>  
>> +	WRITE_ONCE(info->enabled, false);
>>  	/*
>>  	 * Whilst bits above number of counters are RsvdZ
>>  	 * they are unlikely to be repurposed given
>>  	 * number of counters is allowed to be 64 leaving
>>  	 * no reserved bits.  Hence this is only slightly
>>  	 * naughty.
>>  	 */
>>  	writeq(GENMASK_ULL(63, 0), base + CXL_PMU_FREEZE_REG);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does writing a full 64-bit mask
> to the freeze register risk fatal hardware errors on strict CXL implementations?
> 
> In cxl_pmu_disable(), the driver writes GENMASK_ULL(63, 0) to
> CXL_PMU_FREEZE_REG to freeze all counters.
> 
> According to the CXL 3.0 specification, bits above the implemented number
> of counters (info->num_counters) are RsvdZ, and software is strictly
> required to write 0 to these fields.
> 
> Writing 1s to reserved fields could cause AER faults or Poisoned transactions.
> 
> [ ... ]
> 
>> @@ -802,6 +806,21 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
>>  
>>  	writeq(overflowed, base + CXL_PMU_OVERFLOW_REG);
>>  
>> +	/*
>> +	 * An overflow freezes every counter in the CPMU, so unfreeze once the
>> +	 * overflowed ones have been read and their status cleared. Otherwise
>> +	 * they stay frozen until the next pmu_enable() and events are lost.
>> +	 *
>> +	 * Not while the PMU is disabled, so as not to undo an intentional freeze.
>> +	 * The check is advisory, not exclusive: pmu_disable() normally runs on
>> +	 * info->on_cpu with interrupts off, where the pinned handler cannot
>> +	 * preempt it. In the one window where it does not - the migration in
>> +	 * cxl_pmu_offline_cpu() - the counters are legitimately running again,
>> +	 * so unfreezing is correct there anyway.
>> +	 */
>> +	if (READ_ONCE(info->enabled))
> 
> [Severity: High]
> Could this advisory check on info->enabled cause a cross-CPU race condition
> during CPU migration?
> 
> During CPU hotplug migration, perf_pmu_migrate_context() in
> cxl_pmu_offline_cpu() moves events to the target CPU, but the IRQ
> affinity is not updated until afterwards.
> 
> If the IRQ fires on the old CPU, it can read a stale true for info->enabled
> concurrently with the target CPU executing cxl_pmu_disable(), which sets
> it to false and freezes the PMU.
> 
> The old CPU would then write 0 to unfreeze the PMU here. The target CPU,
> expecting the PMU to be frozen, proceeds to cxl_pmu_event_start(), enabling
> the counter via CXL_PMU_COUNTER_CFG_ENABLE and writing 0 to
> CXL_PMU_COUNTER_REG.
> 
> Because the PMU was incorrectly unfrozen, the counter starts immediately,
> leading to a write to a running counter, which violates the CXL 3.0 spec.
> 
>> +		writeq(0, base + CXL_PMU_FREEZE_REG);
>> +
>>  	return IRQ_HANDLED;
>>  }
> 
> I also noticed a few other pre-existing issues in this file while reviewing.
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but is the use of local64_cmpxchg
> in __cxl_pmu_read() safe across multiple CPUs?
> 
> drivers/perf/cxl_pmu.c:__cxl_pmu_read() {
>     ...
>     do {
>         prev_cnt = local64_read(&hwc->prev_count);
>         new_cnt = cxl_pmu_read_counter(event);
>     } while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) != prev_cnt);
>     ...
> }
> 
> During the CPU hotplug migration window in cxl_pmu_offline_cpu(), events
> are migrated to the target CPU before IRQ affinity is updated via
> irq_set_affinity().
> 
> If an overflow IRQ fires in this window, it runs on the old CPU while the
> target CPU can concurrently execute cxl_pmu_read().
> 
> Since local64_t only guarantees atomicity for local CPU accesses, both CPUs
> iterating over the same event and concurrently executing local64_cmpxchg()
> could cause a data race and silent counter corruption.
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but can pending overflow interrupts
> be incorrectly attributed to newly scheduled events?
> 
> When a counter overflows, the hardware asserts an interrupt and sets the
> corresponding bit in CXL_PMU_OVERFLOW_REG.
> 
> If the current event is deleted before the IRQ is serviced, neither
> cxl_pmu_event_del() nor cxl_pmu_event_start() clears the overflow bit:
> 
> drivers/perf/cxl_pmu.c:cxl_pmu_event_start() {
>     ...
>     local64_set(&hwc->prev_count, 0);
>     writeq(0, base + CXL_PMU_COUNTER_REG(hwc->idx));
>     ...
> }
> 
> When cxl_pmu_event_add() maps a new event to the same counter index, and
> the pending IRQ is serviced, cxl_pmu_irq() calls __cxl_pmu_read(event, true).
> 
> For the new event, both new_cnt and prev_cnt are near 0, meaning the
> following check is satisfied:
> 
> drivers/perf/cxl_pmu.c:__cxl_pmu_read() {
>     ...
>     if (overflow && new_cnt >= prev_cnt)
>         delta += mask + 1;
>     ...
> }
> 
> Could this cause the driver to falsely believe a wrap occurred and corrupt
> the count by adding a spurious full period?
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the stateless overflow
> handling in __cxl_pmu_read() cause double-counting or lost events?
> 
> drivers/perf/cxl_pmu.c:__cxl_pmu_read() {
>     ...
>     delta = (new_cnt - prev_cnt) & mask;
>     if (overflow && new_cnt >= prev_cnt)
>         delta += mask + 1;
>     ...
> }
> 
> If a polled read (overflow = false) occurs after the counter wraps and
> freezes, but before the IRQ handler runs, it adds the correct delta and
> updates prev_cnt.
> 
> When the IRQ handler subsequently runs, new_cnt and prev_cnt will be equal,
> satisfying new_cnt >= prev_cnt.
> 
> Wouldn't the IRQ handler then erroneously add a full period on top of the
> already correct count? Conversely, if the event is deleted before the IRQ
> handler runs, could the full period be permanently lost?
> 

