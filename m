Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759953FD96E;
	Mon,  3 Aug 2026 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756385; cv=none; b=Zqi1y0PfM2v5puyTs/yuAekh2h37fwUCr8XKTb98qfrflnp6WGB3WSdg+ofbSIRxETXqApTK1MtFDCn/IyKGzKDs1a9tWygkXufAkLg8rGgUsw+GD8UUaIwhwOYfuhX27unETwOwbJgnA8A3TrPFgBm7CKysk98J5IaDh1YvDng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756385; c=relaxed/simple;
	bh=aDTGshOsiYTbYRJA9mazudvRohgfTZWuSF0tWAc8fWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kOpWuFQbaRfqWJSuNJcMz+V+Y4cVnaPm+YXYrV8gemM8Lq3KTeB+rwIX8tq3iHx/tfk2uc9tfVRFzSDU2O4aprLfSdA5j4CzTMyai7ZO00tJicSL1xGmRHWDdXIbbynwppi1J/CK9aUjRyQx3NsUzWzqq3QwsQpeh1m1Dyu9pDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ByfhD7kl; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ByfhD7kl"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3049143D;
	Mon,  3 Aug 2026 04:26:17 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE42B3F632;
	Mon,  3 Aug 2026 04:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785756381; bh=aDTGshOsiYTbYRJA9mazudvRohgfTZWuSF0tWAc8fWo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ByfhD7kl5yxb3usGa+BOB9Ag5G+wi+PyhAMuB5jk8UE350Y1XUDEadPIio8sVQf03
	 3td1Zm4YHx3df0KSrhcdnu0wib2jLV4GjiN0tBEciXf8KbMMXJOxRBKMF4qvCkQfpg
	 +fG4vDZYnFdhlWnhA7RtZB0Ti7qUM8BkkcXCy/cw=
Message-ID: <58706067-9e7b-4e02-8869-3a8659dd8083@arm.com>
Date: Mon, 3 Aug 2026 12:26:19 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/9] perf/cxl: Unfreeze counters after handling an
 overflow interrupt
To: Richard Cheng <icheng@nvidia.com>, Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 jic23@kernel.org, will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 sashiko-bot@kernel.org
References: <20260731232827.401447-1-dave.jiang@intel.com>
 <20260731232827.401447-8-dave.jiang@intel.com> <anARd0nTEQMiv4qj@MWDK4CY14F>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <anARd0nTEQMiv4qj@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/08/2026 5:00 am, Richard Cheng wrote:
> On Fri, Jul 31, 2026 at 04:28:25PM +0800, Dave Jiang wrote:
>> The counters run with Freeze on Overflow set, so one overflow freezes every
>> counter in the block (CXL r4.0 8.2.7.2.1). cxl_pmu_irq() reads the
>> overflowed counters and clears the overflow status, but never unfreezes.
>> Everything stays frozen until the next pmu_enable(), and events in that
>> window are lost.
>>
>> Unfreeze after clearing the status, unless the PMU has been disabled in the
>> meantime. cxl_pmu_disable() freezes the block deliberately, and
>> cxl_pmu_offline_cpu() migrates the context before it moves the interrupt's
>> affinity, so an overflow can still land on the old CPU while the new one
>> reprograms. Track the enabled state and leave the block frozen in that
>> case. pmu_enable() unfreezes anyway.
>>
>> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
>> Reported-by: sashiko-bot@kernel.org
>> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v3:
>> - Don't unfreeze if the PMU has been disabled (Robin, Jonathan). Review tag
>>    dropped as the patch grew a hunk.
>> - Robin also asked whether this can release a counter that overflowed after
>>    the status read. It cannot. Global Freeze on Overflow stops every
>>    non-free-running counter and they stay frozen until software unfreezes
>>    them, so nothing the driver owns can advance, let alone newly overflow,
>>    between the readq and here. Two counters overflowing together both show
>>    up in the same pass. Only free-running counters move while frozen, and
>>    the driver never programs those.
>> - The enabled check is not a full exclusion, since the flag is read outside
>>    any lock. Say so in the comment rather than implying otherwise. A lock
>>    would buy nothing: pmu_disable() normally runs on the pinned CPU with
>>    interrupts off, and in the one window where it does not - the migration
>>    in cxl_pmu_offline_cpu() - event_stop() has already cleared Counter
>>    Enable, so a stray unfreeze resumes nothing (sashiko-bot).
>> ---
>>   drivers/perf/cxl_pmu.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
>> index 6fdc66a01fb6..580a75bc9210 100644
>> --- a/drivers/perf/cxl_pmu.c
>> +++ b/drivers/perf/cxl_pmu.c
>> @@ -108,6 +108,8 @@ struct cxl_pmu_info {
>>   	bool filter_hdm;
>>   	int msi_vec;
>>   	int irq;
>> +	/* Set between pmu_enable() and pmu_disable(), read by the IRQ handler */
>> +	bool enabled;
>>   };
>>   
>>   #define pmu_to_cxl_pmu_info(_pmu) container_of(_pmu, struct cxl_pmu_info, pmu)
>> @@ -596,6 +598,7 @@ static void cxl_pmu_enable(struct pmu *pmu)
>>   	void __iomem *base = info->base;
>>   
>>   	/* Can assume frozen at this stage */
>> +	WRITE_ONCE(info->enabled, true);
>>   	writeq(0, base + CXL_PMU_FREEZE_REG);
>>   }
>>   
>> @@ -604,6 +607,7 @@ static void cxl_pmu_disable(struct pmu *pmu)
>>   	struct cxl_pmu_info *info = pmu_to_cxl_pmu_info(pmu);
>>   	void __iomem *base = info->base;
>>   
>> +	WRITE_ONCE(info->enabled, false);
>>   	/*
>>   	 * Whilst bits above number of counters are RsvdZ
>>   	 * they are unlikely to be repurposed given
>> @@ -803,6 +807,9 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
>>   
>>   	writeq(overflowed, base + CXL_PMU_OVERFLOW_REG);
>>   
>> +	if (READ_ONCE(info->enabled))
>> +		writeq(0, base + CXL_PMU_FREEZE_REG);
>> +
> 
> The unfreeze looks right to me.
> Maybe we should quote the corresponding part in spec as needed?
> CXL 4.0 8.2.7.1.3 "CPMU Freeze (Offset 18h)", Table 8-183 - "Counter Unit
> N remains frozen until explicitly unfrozen by software" .
> 
> I guess Robin's hotplug rework is solving the issue of cross-CPU check-then-act ?

No, the existing CPU affinity stuff in general is there to enforce this 
- i.e. by design, perf_pmu_enable/disable should only ever be called on 
the same event->cpu that should also be handling the IRQ. My proposal 
just simplifies the amount of work every driver has to do to achieve that.

Thanks,
Robin.

> 
> --Richard
> 
> 
> 
>>   	return IRQ_HANDLED;
>>   }
>>   
>> -- 
>> 2.55.0
>>
>>

