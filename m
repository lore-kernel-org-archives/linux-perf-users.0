Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6791E631A;
	Mon,  4 Nov 2024 20:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752377; cv=none; b=s5wu2+bLXJFSjNJIltP1QtqA9mLo0nSkzDSfj0aDXPdIN1UHycvOsp8KVsRblpWAJajpbGSQnmUnbaDpsvslygp8apCqy/XikjldA+k+9Ry4bKwJ4dkmDiLAiwUEgaVhlFo15zjGWkYzHgHMp4pVRz22FQPtVy9pr99GzXLL5Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752377; c=relaxed/simple;
	bh=6JOFTXPAMGciBT2ihX0VJ+WB0kKtmWPUmtAfoMozhOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GLeHx9gWgVlj+bgAs8zRF4/32ALfNmwKA2xvv5nIqjjo21FGpw4QWizEl4l123RGCvi2RqKA9rjLY/ZzsuKIM3/W6gAeDmudHjd3ckoBUDvpBPn11qNeQCZcnfa+iCbrMU0y0hgYko0suBsLKaquE0R/V4HQoo29w/F0dM/XCbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9cMZubT; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9cMZubT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730752375; x=1762288375;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=6JOFTXPAMGciBT2ihX0VJ+WB0kKtmWPUmtAfoMozhOU=;
  b=U9cMZubTdrOjT29ikPUTOd6ObIn30oT3w/z8ycBxh0KbR5ItiCIgI0yf
   iqWXBOFdleRSQsxeq/Y6in70Wcg6E2o2fyAAoGVP92trKnVU2rORY9neu
   ei4WmP20GhU42Qbqgc8cPzVdd2OJlIHduLUzmqUAT7pr48ay8qtdj7xf/
   i4ihdyHmEdba9RZV5gBCAe+hdVoxzeOQqrnEEJD6rURL9iXX05Yon8Bwo
   2+mJJE6AKxX9uhxKH1OpiKTiQtQAYfHTwcNov1+ucOCrOPoUktHHAICV8
   qQePeiKRcbZ76qijwRfRW7jG2N7edo+aY2XoBD59tY3dhnMG4ae+EdaNR
   A==;
X-CSE-ConnectionGUID: kPTeRgr0QfKT1YFbdWplYQ==
X-CSE-MsgGUID: iMSQwo0iTdmAsCR+1QU1LA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30321662"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30321662"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 12:32:55 -0800
X-CSE-ConnectionGUID: dNZWarN3R+6BOcUk10Y1Mg==
X-CSE-MsgGUID: MqNOm0eOQ+uy5GYL4AB3Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="84584413"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 12:32:55 -0800
Received: from [10.212.67.175] (kliang2-mobl1.ccr.corp.intel.com [10.212.67.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 6B63820B5703;
	Mon,  4 Nov 2024 12:32:53 -0800 (PST)
Message-ID: <38738c32-0435-42ea-a96e-bb1ba7b22e3b@linux.intel.com>
Date: Mon, 4 Nov 2024 15:32:52 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] perf/x86/intel: New start period for the freq mode
To: peterz@infradead.org, mingo@kernel.org, tglx@linutronix.de,
 acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, ak@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20241022130414.2493923-1-kan.liang@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20241022130414.2493923-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter,

Ping. Could you please let me know if you have any comments.

Thanks,
Kan

On 2024-10-22 9:04 a.m., kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The freq mode is the current default mode of Linux perf. 1 period is
> used as a start period. The period is auto-adjusted in each tick or an
> overflow to meet the frequency target.
> 
> The start period 1 is too low and may trigger some issues.
> - Many HWs do not support period 1 well.
>   https://lore.kernel.org/lkml/875xs2oh69.ffs@tglx/
> - For an event that occurs frequently, period 1 is too far away from the
>   real period. Lots of the samples are generated at the beginning.
>   The distribution of samples may not be even.
> - A low start period for the frequently occurring event also challenges
>   virtualization, which has a longer path to handle a PMI.
> 
> The limit_period only checks the minimum acceptable value for HW.
> It cannot be used to set the start period. Because, some events may
> need a very low period. The limit_period cannot be set too high. It
> doesn't help with the events that occur frequently.
> 
> It's hard to find a universal start period for all events. The idea is
> only to give an estimate for the popular HW and HW cache events. For the
> rest of the events, start from the lowest possible recommended value.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
> 
> Changes since V1:
> - Move to Intel specific code
> 
>  arch/x86/events/intel/core.c | 85 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 812b1a1cdf47..d3b133384361 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4076,6 +4076,85 @@ static void intel_pmu_set_acr_dyn_mask(struct perf_event *event, int idx,
>  		event->hw.dyn_mask &= mask;
>  }
>  
> +static u64 intel_pmu_freq_start_period(struct perf_event *event)
> +{
> +	int type = event->attr.type;
> +	u64 config, factor;
> +	s64 start;
> +
> +	/*
> +	 * The 127 is the lowest possible recommended SAV (sample after value)
> +	 * for a 4000 freq (default freq), according to the event list JSON file.
> +	 * Also, assume the workload is idle 50% time.
> +	 */
> +	factor = 64 * 4000;
> +	if (type != PERF_TYPE_HARDWARE && type != PERF_TYPE_HW_CACHE)
> +		goto end;
> +
> +	/*
> +	 * The estimation of the start period in the freq mode is
> +	 * based on the below assumption.
> +	 *
> +	 * For a cycles or an instructions event, 1GHZ of the
> +	 * underlying platform, 1 IPC. The workload is idle 50% time.
> +	 * The start period = 1,000,000,000 * 1 / freq / 2.
> +	 *		    = 500,000,000 / freq
> +	 *
> +	 * Usually, the branch-related events occur less than the
> +	 * instructions event. According to the Intel event list JSON
> +	 * file, the SAV (sample after value) of a branch-related event
> +	 * is usually 1/4 of an instruction event.
> +	 * The start period of branch-related events = 125,000,000 / freq.
> +	 *
> +	 * The cache-related events occurs even less. The SAV is usually
> +	 * 1/20 of an instruction event.
> +	 * The start period of cache-related events = 25,000,000 / freq.
> +	 */
> +	config = event->attr.config & PERF_HW_EVENT_MASK;
> +	if (type == PERF_TYPE_HARDWARE) {
> +		switch (config) {
> +		case PERF_COUNT_HW_CPU_CYCLES:
> +		case PERF_COUNT_HW_INSTRUCTIONS:
> +		case PERF_COUNT_HW_BUS_CYCLES:
> +		case PERF_COUNT_HW_STALLED_CYCLES_FRONTEND:
> +		case PERF_COUNT_HW_STALLED_CYCLES_BACKEND:
> +		case PERF_COUNT_HW_REF_CPU_CYCLES:
> +			factor = 500000000;
> +			break;
> +		case PERF_COUNT_HW_BRANCH_INSTRUCTIONS:
> +		case PERF_COUNT_HW_BRANCH_MISSES:
> +			factor = 125000000;
> +			break;
> +		case PERF_COUNT_HW_CACHE_REFERENCES:
> +		case PERF_COUNT_HW_CACHE_MISSES:
> +			factor = 25000000;
> +			break;
> +		default:
> +			goto end;
> +		}
> +	}
> +
> +	if (type == PERF_TYPE_HW_CACHE)
> +		factor = 25000000;
> +end:
> +	/*
> +	 * Usually, a prime or a number with less factors (close to prime)
> +	 * is chosen as an SAV, which makes it less likely that the sampling
> +	 * period synchronizes with some periodic event in the workload.
> +	 * Minus 1 to make it at least avoiding values near power of twos
> +	 * for the default freq.
> +	 */
> +	start = DIV_ROUND_UP_ULL(factor, event->attr.sample_freq) - 1;
> +
> +	if (start > x86_pmu.max_period)
> +		start = x86_pmu.max_period;
> +
> +	if (x86_pmu.limit_period)
> +		x86_pmu.limit_period(event, &start);
> +
> +	return start;
> +}
> +
>  static int intel_pmu_hw_config(struct perf_event *event)
>  {
>  	int ret = x86_pmu_hw_config(event);
> @@ -4087,6 +4166,12 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  	if (ret)
>  		return ret;
>  
> +	if (event->attr.freq && event->attr.sample_freq) {
> +		event->hw.sample_period = intel_pmu_freq_start_period(event);
> +		event->hw.last_period = event->hw.sample_period;
> +		local64_set(&event->hw.period_left, event->hw.sample_period);
> +	}
> +
>  	if (event->attr.precise_ip) {
>  		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) == INTEL_FIXED_VLBR_EVENT)
>  			return -EINVAL;

