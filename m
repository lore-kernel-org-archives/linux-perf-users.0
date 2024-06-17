Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F824819;
	Mon, 17 Jun 2024 04:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718599088; cv=none; b=pSmeBm9oteuy8swqzDocas019w6KSCCht8Ap35MfL5H3EPGFCrzw9mz/sqOAatR9XvpMvrAI39QSZMNyKxeq/06hphhM044AXgku9H7aiWFv0hr+ho+eHbxEYs0woJYMBtUikrv8myTWL1SIWd6WEbR/ZgtYMLI5w8/D4HSY/1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718599088; c=relaxed/simple;
	bh=eJIz2tyShgz40sZq8k/Py1zA+0bWXqJRV39NwDCcjHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=retyccuwxMD7vB7FhP8G/PeNuggdVB+eVlw9mPTG+9fkU/atMC7Zz1RvUnyRtq5qP+YqougdeztGIzrTNf9UQh5dCnFCJjOs1wKho2Ze716PY+GEhyYgp1UgKHMB8FgGl3hqUGZ2SX9hJu94zJ1iaCz/HUYai5qMbl/w+X9guuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98B96DA7;
	Sun, 16 Jun 2024 21:38:28 -0700 (PDT)
Received: from [10.162.16.42] (a077893.blr.arm.com [10.162.16.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DDAC3F64C;
	Sun, 16 Jun 2024 21:37:59 -0700 (PDT)
Message-ID: <e7307246-95e4-406c-802e-c1d190e39b36@arm.com>
Date: Mon, 17 Jun 2024 10:07:57 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V18 3/9] drivers: perf: arm_pmu: Add infrastructure for
 branch stack sampling
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 will@kernel.org, catalin.marinas@arm.com, Mark Brown <broonie@kernel.org>,
 James Clark <james.clark@arm.com>, Rob Herring <robh@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Suzuki Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org
References: <20240613061731.3109448-1-anshuman.khandual@arm.com>
 <20240613061731.3109448-4-anshuman.khandual@arm.com>
 <ZmxbYxE5PBl4CHzE@J2N7QTR9R3.cambridge.arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZmxbYxE5PBl4CHzE@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/14/24 20:31, Mark Rutland wrote:
> On Thu, Jun 13, 2024 at 11:47:25AM +0530, Anshuman Khandual wrote:
>> @@ -289,6 +289,23 @@ static void armpmu_start(struct perf_event *event, int flags)
>>  {
>>  	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
>>  	struct hw_perf_event *hwc = &event->hw;
>> +	struct pmu_hw_events *cpuc = this_cpu_ptr(armpmu->hw_events);
>> +	int idx;
>> +
>> +	/*
>> +	 * Merge all branch filter requests from different perf
>> +	 * events being added into this PMU. This includes both
>> +	 * privilege and branch type filters.
>> +	 */
>> +	if (armpmu->has_branch_stack) {
>> +		cpuc->branch_sample_type = 0;
>> +		for (idx = 0; idx < ARMPMU_MAX_HWEVENTS; idx++) {
>> +			struct perf_event *event_idx = cpuc->events[idx];
>> +
>> +			if (event_idx && has_branch_stack(event_idx))
>> +				cpuc->branch_sample_type |= event_idx->attr.branch_sample_type;
>> +		}
>> +	}
> 
> When we spoke about this, I meant that we should do this under armpmu::start(),
> or a callee or caller thereof once we know all the events are configured, just
> before we actually enable the PMU.
> 
> For example, this could live in armv8pmu_branch_enable(), which'd allow
> all the actual logic to be added in the BRBE enablement patch.
> 
> Doing this in armpmu_start() doesn't work as well because it won't handle
> events being removed.

Sure, will move this filter aggregation inside armv8pmu_branch_enable() instead
which is being added via the BRBE driver.

diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
index d795e8fd646f..9cf824bdc8b7 100644
--- a/drivers/perf/arm_brbe.c
+++ b/drivers/perf/arm_brbe.c
@@ -856,6 +856,22 @@ void armv8pmu_branch_enable(struct arm_pmu *arm_pmu)
 {
        struct pmu_hw_events *cpuc = this_cpu_ptr(arm_pmu->hw_events);
        u64 brbfcr, brbcr;
+       int idx;
+
+       /*
+        * Merge all branch filter requests from different perf
+        * events being added into this PMU. This includes both
+        * privilege and branch type filters.
+        */
+       if (arm_pmu->has_branch_stack) {
+               cpuc->branch_sample_type = 0;
+               for (idx = 0; idx < ARMPMU_MAX_HWEVENTS; idx++) {
+                       struct perf_event *event_idx = cpuc->events[idx];
+
+                       if (event_idx && has_branch_stack(event_idx))
+                               cpuc->branch_sample_type |= event_idx->attr.branch_sample_type;
+               }
+       }
 
        if (!(cpuc->branch_sample_type && cpuc->branch_users))
                return;

> 
> [...]
> 
>> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
>> index b3b34f6670cf..9eda16dd684e 100644
>> --- a/include/linux/perf/arm_pmu.h
>> +++ b/include/linux/perf/arm_pmu.h
>> @@ -46,6 +46,18 @@ static_assert((PERF_EVENT_FLAG_ARCH & ARMPMU_EVT_63BIT) == ARMPMU_EVT_63BIT);
>>  	},								\
>>  }
>>  
>> +/*
>> + * Maximum branch record entries which could be processed
>> + * for core perf branch stack sampling support, regardless
>> + * of the hardware support available on a given ARM PMU.
>> + */
>> +#define MAX_BRANCH_RECORDS 64
>> +
>> +struct branch_records {
>> +	struct perf_branch_stack	branch_stack;
>> +	struct perf_branch_entry	branch_entries[MAX_BRANCH_RECORDS];
>> +};
>> +
>>  /* The events for a given PMU register set. */
>>  struct pmu_hw_events {
>>  	/*
>> @@ -66,6 +78,17 @@ struct pmu_hw_events {
>>  	struct arm_pmu		*percpu_pmu;
>>  
>>  	int irq;
>> +
>> +	struct branch_records	*branches;
>> +
>> +	/* Active context for task events */
>> +	void			*branch_context;
> 
> Using 'void *' here makes this harder to reason about and hides type
> safety issues.
> 
> Give this a real type. IIUC it should be 'perf_event_context *'.

Sure, will change the type.

> 
>> +
>> +	/* Active events requesting branch records */
>> +	unsigned int		branch_users;
>> +
>> +	/* Active branch sample type filters */
>> +	unsigned long		branch_sample_type;
>>  };
>>  
>>  enum armpmu_attr_groups {
>> @@ -96,8 +119,15 @@ struct arm_pmu {
>>  	void		(*stop)(struct arm_pmu *);
>>  	void		(*reset)(void *);
>>  	int		(*map_event)(struct perf_event *event);
>> +	void		(*sched_task)(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
>> +	bool		(*branch_stack_init)(struct perf_event *event);
>> +	void		(*branch_stack_add)(struct perf_event *event, struct pmu_hw_events *cpuc);
>> +	void		(*branch_stack_del)(struct perf_event *event, struct pmu_hw_events *cpuc);
>> +	void		(*branch_stack_reset)(void);
> 
> The reset callback isn't used in this series; s
> 
> Subsequent patches call armv8pmu_branch_stack_reset() directly from
> PMUv3 and the BRBE driver, and arm_pmu::branch_stack_reset() is never
> used, so we can delete it.

Sure, will drop branch_stack_reset() callback.
