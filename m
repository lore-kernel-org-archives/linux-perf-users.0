Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E372EEE63;
	Fri,  2 Oct 2026 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959387; cv=none; b=eW0F5tuW1HoUNIeH3Ow+TKF3/FpIvywyP01TOgToQdj0rga9yGGLdY5Jd3NUGYNcbZj9f/1W5TQB8mHkSXGglKYO0WsyRz8WKJpcDEl0dr4+cq8iFk398vGAIUSk+H/4V9Gzdg52DRPG2zyOBTOtiAPvqlA4fEThfxbXmdxGEso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959387; c=relaxed/simple;
	bh=S1ocxV/VbevQfXTqsaKRpnBp8nCL0tXpJMZQOIv/8vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNKN0mnLymNBpbA8dedwHSgiomCZ+oRSFZt0aXTCKqnCLpmjUxUeZ6QZGSwI7oFdDlgRpO8ZlHF9vHUEUuYVyW/tfRfYXMP3hIfexxWvCgRG8hawQdHUqSWL3cbV9TmJ4Q/9imShBXD71AFhXBK3aNNHqQv44sVDqLt0gCc6ZzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=J4Rcbcl1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="J4Rcbcl1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FDA31476;
	Fri,  2 Oct 2026 09:43:01 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 302C93F86F;
	Fri,  2 Oct 2026 09:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790959385; bh=S1ocxV/VbevQfXTqsaKRpnBp8nCL0tXpJMZQOIv/8vo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J4Rcbcl1TxRBmBGk0V26lf8P0Uwknezro9iX1Faz3t96bHD19HEEoIVqdA5R03QFU
	 OHmOvaRc9MxuYvvd1vNhxlfokUqhLZ1cbVPU3IZloxGFF3f4g0mFwIDHGWNO3F2XPI
	 WStR4GnjwYQ0rSmCeuzlSu5tuC2zyRWc6EgWHSVc=
Message-ID: <2d70be7b-12c0-46e0-b308-744a3159388a@arm.com>
Date: Fri, 2 Oct 2026 17:43:02 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/arm-cmn: Allow userspace to select the PMU's CPU
To: "Okanovic, Haris" <harisokn@amazon.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "will@kernel.org" <will@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260929223244.2411400-1-harisokn@amazon.com>
 <b782f893-e3ab-40f7-a7c5-ce19660be2c1@arm.com>
 <CY2PR18MB8432185386B28FBC1DA23F3333A88B2@CY2PR18MB843218.namprd18.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CY2PR18MB8432185386B28FBC1DA23F3333A88B2@CY2PR18MB843218.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/09/2026 8:29 pm, Okanovic, Haris wrote:
> Hi Robin,
> 
>>> All of the PMU's recurring work therefore lands on one CPU. This is
>>> problematic on systems which reserve particular CPUs for latency
>>> sensitive work or confine background activity to a chosen set of
>>> housekeeping CPUs.
> 
>>> There is no way to set it explicitly. perf_event_open() and 'perf stat
>>> -C' have no effect because arm_cmn_event_init() overwrites event->cpu;
>>> /proc/irq/*/smp_affinity is refused for the DTC interrupts, which are
>>> requested with IRQF_NOBALANCING because their affinity has to follow the
>>> owning CPU.
> 
>> All system PMU drivers have the same concern in this regard - why
>> should arm-cmn be special?
> 
> As I mentioned earlier, we can improve performance on certain system
> topologies by assigning PMU work to housekeeping CPUs.
> 
> arm-cmn has no constraints around CPU assignment, so this is possible.
> Every register access is MMIO and the DTC interrupts can be affinitised
> anywhere, so any online CPU can own it. That's what makes "write any
> online CPU" a sound interface here. I've moved it to CPUs in both NUMA
> nodes on the two platforms I tested.
> 
> You're right that the concern is general, but a single interface isn't
> easily shared, because the set of CPUs that a PMU may be driven from
> is platform/device-specific:
> 
> arm_dsu_pmu, for instance, can only be driven from the CPUs attached to
> the DSU, which it already exposes as "associated_cpus" and enforces in
> event_init(); hisi_uncore_pmu publishes the same attribute.
> 
> Intel uncore is per-die: MSR-accessed boxes must be read from a CPU on
> the target die, since rdmsr reads the executing CPU. Accepting an
> arbitrary CPU there would silently read a different die's counters.

You seem to have missed my point. Pretty much all system/uncore PMU 
drivers - other than the trivial ones with non-programmable free-running 
counters and no interrupt - have to pick a CPU to associate with, 
irrespective of whether it's from the whole system or some specific 
subset, and they all do so effectively arbitrarily, whether that's by 
cpumask_local_spread(), cpumask_any(), cpumask_any_and() or whatever. If 
one driver picking an arbitrary CPU is a problem that needs fixing, why 
do the dozens of other drivers which also pick an arbitrary CPU not also 
need fixing?

And the answer is that they do! Irrespective of whether systems might 
want particular CPUs to do particular things, we've already seen that in 
systems with lots of PMU instances, when they all end up on the same 
default "any CPU", it ends up severely over-serialising event scheduling 
to a degree that can start to significantly impact event runtimes.

> Do you have an alternate API in mind?

I don't see this being practical without first generalising the notion 
of CPU affinity so that it can at least be dealt with from a single 
place in the perf core. Inconsistent, ad-hoc hacks in individual drivers 
will not scale or be maintainable. Perf core also then has a reasonable 
chance of being able to reliably avoid racing against itself, whereas 
attempting to mitigate racy calls from within those calls when it's 
already too late is never really going to be a proper solution.

Thanks,
Robin.
