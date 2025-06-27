Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E9521B9D9
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751024461; cv=none; b=nfN1cjlZ/4AvKXLKtenj/JmoRSTHKLjZ36VDN6QFChOG4+k48JJW1it1YknHVWkL9sPO8+6CdwH9Wbt6u2uzHJB2s+51NgV2yWPAvFyGk1xaRVbP8oEknP4+4cpWLycS6UHSoj7HrZqUUg+MgdeVrq3jIXKypxYkAUFRJY2g1ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751024461; c=relaxed/simple;
	bh=MKXocNIcbIC6ny7HE0eUU8QP6jF2qGvB8B43Cag/3A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWKJDAMXyDFlA8AO4Ts5SPZgtdXlDUh7035ioMdcIJj8zsm+BX0ZYykeU3MYPxBpYvnspUbi5+PP5LFopJrWox47HJlf08YFi/aeMcv2pXjhN6AgNJ5e9bIx+f0pC3sri6Ehy+DtGeaIWXwHD8E1jiXvfdGADD21nSQKdMSowQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E4A31A00;
	Fri, 27 Jun 2025 04:40:36 -0700 (PDT)
Received: from [10.163.36.129] (unknown [10.163.36.129])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B0AA3F66E;
	Fri, 27 Jun 2025 04:40:51 -0700 (PDT)
Message-ID: <2996edbb-1223-4795-921b-fd86a4dc3f88@arm.com>
Date: Fri, 27 Jun 2025 17:10:47 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] perf: arm_spe: Relax period restriction
To: Leo Yan <leo.yan@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>
References: <20250627091659.3316899-1-leo.yan@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250627091659.3316899-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/06/25 2:46 PM, Leo Yan wrote:
> The minimum interval specified the PMSIDR_EL1.Interval field is a
> hardware recommendation. However, this value is set by hardware designer
> before the production. It may not accurately reflects actual hardware
> limitations, and tools currently have no way to test shorter periods.
> 
> This change relaxes the limitation by allowing any non-zero periods.
> This gives chance for experimenting smaller periods.

Is this going to be safe on all SPE implementations ?

> 
> The downside is that small periods may increase the risk of AUX ring
> buffer overruns. When an overrun occurs, the perf core layer will
> trigger an irq work to disable the event and wake up the tool in user
> space to read the trace data. After the tool finishes reading, it will
> re-enable the AUX event.
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>  drivers/perf/arm_spe_pmu.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 3efed8839a4e..e40e5daa838d 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -308,12 +308,16 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
>  
>  static void arm_spe_event_sanitise_period(struct perf_event *event)
>  {
> -	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
>  	u64 period = event->hw.sample_period;
>  	u64 max_period = PMSIRR_EL1_INTERVAL_MASK;
>  
> -	if (period < spe_pmu->min_period)
> -		period = spe_pmu->min_period;
> +	/*
> +	 * As per the Arm ARM (DDI 0487 L.a), section D24.7.12 PMSIRR_EL1,
> +	 * Sampling Interval Reload Register, the INTERVAL field (bits [31:8])
> +	 * states: "Software must set this to a nonzero value."
> +	 */The motivation (as explained in the commit message) for using arch permitted
minimum value instead of the recommended (PMSIDR_EL1.Interval) value, should
be explained in the comment here as well.

> +	if (period < FIELD_PREP(PMSIRR_EL1_INTERVAL_MASK, 1))
> +		period = FIELD_PREP(PMSIRR_EL1_INTERVAL_MASK, 1);
Given that FIELD_PREP(PMSIRR_EL1_INTERVAL_MASK, 1) is a constant - should
not it be defined as a macro e.g PMSIRR_EL1_MINIMUM_INTERVAL or something
similar instead of deriving it twice.

>  	else if (period > max_period)
>  		period = max_period;
>  	else

