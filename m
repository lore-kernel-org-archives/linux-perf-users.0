Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E914C39850;
	Mon,  3 Jun 2024 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396823; cv=none; b=TRL8e7JtjbOM43LuzQUTvZQXZB+6fOU/3rcwsJKEIcVNPcMxN7X5KPqDqfGxrIgo+QTwY9/zM5ZCic1wZICZSn+UL/bZhr8gJenAjqSOz4qmCthp8A5T1Vqj3CotcLabY/h64g9/diZ+mX7F84CePJKaNlZv/qPcVmVdTNEJxUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396823; c=relaxed/simple;
	bh=4qCOD28+gDDPVxKSgnmdGBRMHQNm8b5CkFtYsnujVjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMYB07yG43SDv4mYfFEFt2uT4CGutI2IWoPirCZ/W0vHjOsrbAn4PpVNLuHf2id+zAiYcdLHkX2KrJ7/iQiUsccOxIeiqCjUkYp1cU7PCIrxJ95gtcqqb2WGINdecS9Gtd0MjHc5MvL8M426TQmy/8PODA9mvPVlWPJutFlgQRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 484E11042;
	Sun,  2 Jun 2024 23:40:44 -0700 (PDT)
Received: from [10.162.40.16] (a077893.blr.arm.com [10.162.40.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59D243F792;
	Sun,  2 Jun 2024 23:40:15 -0700 (PDT)
Message-ID: <8ec0f93a-a1f9-4b04-875c-dd4a9172e339@arm.com>
Date: Mon, 3 Jun 2024 12:10:12 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V17 3/9] drivers: perf: arm_pmu: Add infrastructure for
 branch stack sampling
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 will@kernel.org, catalin.marinas@arm.com, Mark Brown <broonie@kernel.org>,
 James Clark <james.clark@arm.com>, Rob Herring <robh@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Suzuki Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org
References: <20240405024639.1179064-1-anshuman.khandual@arm.com>
 <20240405024639.1179064-4-anshuman.khandual@arm.com>
 <ZkylUT0R9lwseF4a@J2N7QTR9R3>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZkylUT0R9lwseF4a@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/21/24 19:14, Mark Rutland wrote:
> On Fri, Apr 05, 2024 at 08:16:33AM +0530, Anshuman Khandual wrote:
>> In order to support the Branch Record Buffer Extension (BRBE), we need to
>> extend the arm_pmu framework with some basic infrastructure for the branch
>> stack sampling which arm_pmu drivers can opt-in using a new feature flag
>> called 'has_branch_stack'. Subsequent patches will use this to add support
>> for BRBE in the PMUv3 driver.
> 
> Please, just use ther *exact* wording I asked for last time:
> 
> | In order to support the Branch Record Buffer Extension (BRBE), we need to
> | extend the arm_pmu framework with some basic infrastructure for branch stack
> | sampling which arm_pmu drivers can opt-in to using. Subsequent patches will
> | use this to add support for BRBE in the PMUv3 driver.
> 
> At this point in the commit message, the 'has_branch_stack' flag doesn't
> matter, and dropping the 'to' after 'opt-in' makes this painful to read.

Okay, will replace with the original paragraph.

> 
>> Branch stack sampling support i.e capturing branch records during execution
>> in core perf, rides along with normal HW events being scheduled on the PMU.
>> This prepares ARMV8 PMU framework for branch stack support on relevant PMUs
>> with required HW implementation.
> 
> Please delete this paragraph.

Done.

> 
>> With BRBE, the hardware records branches into a hardware FIFO, which will
>> be sampled by software when perf events overflow. A task may be context-
>> switched an arbitrary number of times between overflows, and to avoid
>> losing samples we need to save the current records when a task is context-
>> switched out. To do these we'll need to use the pmu::sched_task() callback,
>> and we'll also need to allocate some per-task storage space via event flag
>> PERF_ATTACH_TASK_DATA.
> 
> [...]
> 
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
>> +
>> +	/* Active events requesting branch records */
>> +	unsigned int		branch_users;
>> +
>> +	/* Active branch sample type filters */
>> +	unsigned long		branch_sample_type;
>>  };
> 
> At this point in the series I understand why we have the 'branches' and
> 'branch_users' fields, but the 'branch_context' and 'branch_sample_type'
> fields haven't been introduced and are not obvious.
> 
> What exactly is branch_context, and why is that a 'void *' ?

branch_context tracks event->ctx which is 'struct perf_event_context *'. The
'void *' seemed more generic in case this tracking structure changes later.
But this could be changed as 'struct perf_event_context *' if required.

> 
> I can understand if that's a PMU-specific structure to track the active
> branch records, but if so I don't understand why 'branch_sample_type'
> isn't folded into that.

branch_sample_type is applicable both for cpu and task bound events, where as
branch_context is applicable only for task bound events tracking their active
branch records that need to be dropped (or saved), in case a cpu bound event
comes in.
