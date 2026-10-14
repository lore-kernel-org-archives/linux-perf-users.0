Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1243549E5DE;
	Wed, 14 Oct 2026 14:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987981; cv=none; b=anqk/F9jCRy6+qKfIsCn7SRXrlGMfMKwvKMj1w828EDrRr572yBkeTWWtFWThAyjrGEyhZPBx2B9yQeqpYlhODQQM41gshzagDmrxdRS+fGQ7NqfmqU/0DeWOtryXG8V/t2/JpT/iDbqI/mbOiwfn7JuLSaPnnoSPgdod0jLpRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987981; c=relaxed/simple;
	bh=F84HomwI7RDpju62PoqCWgA1Ivfs4haiBD/st0o+QzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkFnXced1FTmq6+K2fmGfXKbIpH36hBvJxSq32lzM3nQpIYWEj8k8qw8Pz5vUQr1XcFbtO37SKQtjbUcvxxuHsg51cNYoQc30WIAB618oMnxyDvXPGIr4omJgfjULwZ77B9jsLVJBMDAne1zHqoo470yr3nYzAi5hAfL2Xe7O74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=nFBgg7xs; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="nFBgg7xs"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09D311570;
	Wed, 14 Oct 2026 07:26:16 -0700 (PDT)
Received: from [10.57.12.254] (unknown [10.57.12.254])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 313283F673;
	Wed, 14 Oct 2026 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791987979; bh=F84HomwI7RDpju62PoqCWgA1Ivfs4haiBD/st0o+QzE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nFBgg7xs78iiK+yIReZwBNw+qWrI1JYs6yVae8edJkk6j+F+8YkDvGcapDQbql5Tn
	 e6OBc+S6BRxNLQ3McUWK/8p+/tYmsXTU/3Qp5IsgdadZPyjlSTYLNI/4GJLLLyDnLf
	 3AyF8VMWuq2wd7jYlcyw46wh5qQHawDBjcE/sOF8=
Message-ID: <e9d01b93-3658-4ba3-a15c-e6b4122b5c08@arm.com>
Date: Wed, 14 Oct 2026 15:26:10 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] perf/core: Add PERF_PMU_SCOPE_DEVICE
To: Peter Zijlstra <peterz@infradead.org>,
 Haris Okanovic <harisokn@amazon.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261013185603.1347265-1-harisokn@amazon.com>
 <20261013185603.1347265-3-harisokn@amazon.com>
 <20261014102700.GC4121339@noisy.programming.kicks-ass.net>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20261014102700.GC4121339@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-10-14 11:27 am, Peter Zijlstra wrote:
> On Tue, Oct 13, 2026 at 01:56:01PM -0500, Haris Okanovic wrote:
>> Add a "device" pmu::scope for PMUs counted on a single CPU drawn
>> from a driver-supplied set instead of a fixed topology.
>>
>> This mechanism is implemented by new callbacks: filter_allowed_cpus()
>> is invoked to constrain the running CPU set to an allowed set for a
>> particular device; migrate_cpu() is used to perform any device specific
>> migration steps. Both are optional, e.g. for devices that can run on
>> any CPU or have no additional migration steps.
>>
>> Placement initially happens in perf_pmu_register() before the PMU
>> becomes visible, and is subsequently re-evaluated on hotplug events.
>> A new CPU selection is made by cpumask_any_distribute() to spread out
>> load from multiple devices, but only when the previous CPU selection is
>> offline or no longer allowed by filter_allowed_cpus().
>>
>> PMU events of these devices follow the chosen CPU. They are initially
>> bound to a CPU in perf_try_init_event() then reassigned by
>> perf_pmu_migrate_context() when a new CPU is selected.
> 
>>
>> The initial CPU assignment can race with migration, leaving a stranded
>> event. A sequence counter is added to close this gap without additional
>> locks. A count in struct pmu increments on each migration and is copied
>> to struct perf_event on init. The copied count is checked again before
>> the event is installed, under the same context mutex, which causes
>> perf_event_open() and perf_event_create_kernel_counter() to return -EBUSY
>> during migration periods.
> 
> I'm not entirely sure on this. How is this race different from changing
> CPU on hotplug?

Not much, other than that hotplug is at least already serialised against 
perf_event_open on the perf core side via perf_online_mask. This is also 
where I was heading with my generic hotplug proposal[1] - once perf core 
can be in charge of that, it should then be viable to also migrate PMUs 
for reasons other than hotplug, and it would all look the same to the 
drivers.

(Yes, as-is my patch still preserves the status quo of drivers picking 
their own target CPU to keep things simple, but that was one of the 
points I was hoping to generate some discussion on...)

Thanks,
Robin.

[1] 
https://lore.kernel.org/linux-arm-kernel/cover.1784911757.git.robin.murphy@arm.com/
