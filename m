Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9211BD01F
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Jun 2025 05:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751260222; cv=none; b=Wu+xUyWcXH3T1buoZCH7w56Wn/wU/s6B6jmjulsXhtj0QFvgqAbWdyxpysytqronJ7C5teyouEZ+v+vLFTaqmcjveQvuRxO7SzmpZOJxejJfDmYwnijFrTy+gQF+L5xgiKofr7jWdwdh580Ze2qnp/rB4EFGALgL4WEEsVZ7frA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751260222; c=relaxed/simple;
	bh=0YHOXVMQlqrRbHPl2zojb0i+F3zE4rnIfKh07NacOR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BpK80GPKkzDxn2bpqwe9vEjlnH+kSixwKkk3ed9cGUcW83uuuaO0qlFnGvurpyLITDtrg02tiDZAa4VJJChaD7A/fOfquLn0iueaqwSIlqoVkQ+bFa5M5bY+UnDKkljRjycQmipC+I2hTcelQxARCiN59ZZqLgmlDUeG584nINo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61ABB1F60;
	Sun, 29 Jun 2025 22:10:03 -0700 (PDT)
Received: from [10.163.37.132] (unknown [10.163.37.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 33BDC3F6A8;
	Sun, 29 Jun 2025 22:10:16 -0700 (PDT)
Message-ID: <bb7e5014-a32a-4630-b01f-9a74969c804f@arm.com>
Date: Mon, 30 Jun 2025 10:40:13 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf: arm_spe: Relax period restriction
To: Leo Yan <leo.yan@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, James Clark <james.clark@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org
References: <20250627163028.3503122-1-leo.yan@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250627163028.3503122-1-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/06/25 10:00 PM, Leo Yan wrote:
> The minimum interval specified the PMSIDR_EL1.Interval field is a
> hardware recommendation. However, this value is set by hardware designer
> before the production. It is not actual hardware limitation but tools
> currently have no way to test shorter periods.
> 
> This change relaxes the limitation by allowing any non-zero periods,
> with simplifying code with clamp_t().
> 
> The downside is that small periods may increase the risk of AUX ring
> buffer overruns. When an overrun occurs, the perf core layer will
> trigger an irq work to disable the event and wake up the tool in user
> space to read the trace data. After the tool finishes reading, it will
> re-enable the AUX event.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>

LGTM

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
> 
> Changes from v2:
> - Updated comment for the difference between minimum interval
>   recommendation and hardware limitation (Anshuman).
> - Refactored with clamp_t().
> - Removed review tag as the refactoring.
> 
>  drivers/perf/arm_spe_pmu.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 3efed8839a4e..369e77ad5f13 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -308,17 +308,21 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
>  
>  static void arm_spe_event_sanitise_period(struct perf_event *event)
>  {
> -	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
>  	u64 period = event->hw.sample_period;
>  	u64 max_period = PMSIRR_EL1_INTERVAL_MASK;
>  
> -	if (period < spe_pmu->min_period)
> -		period = spe_pmu->min_period;
> -	else if (period > max_period)
> -		period = max_period;
> -	else
> -		period &= max_period;
> +	/*
> +	 * The PMSIDR_EL1.Interval field (stored in spe_pmu->min_period) is a
> +	 * recommendation for the minimum interval, not a hardware limitation.
> +	 *
> +	 * According to the Arm ARM (DDI 0487 L.a), section D24.7.12 PMSIRR_EL1,
> +	 * Sampling Interval Reload Register, the INTERVAL field (bits [31:8])
> +	 * states: "Software must set this to a nonzero value". Use 1 as the
> +	 * minimum value.
> +	 */
> +	u64 min_period = FIELD_PREP(PMSIRR_EL1_INTERVAL_MASK, 1);
>  
> +	period = clamp_t(u64, period, min_period, max_period) & max_period;
>  	event->hw.sample_period = period;
>  }
>  
