Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE89136E3F;
	Fri, 30 Aug 2024 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724998426; cv=none; b=p0DTvP5RAvlrkQ5jlgCHW6ZOAcvsgSfKdkBnFKs9XE7Ca/fTPSGMnaZbFB8Xyv1nMUyN106UL4P0Gx1Vehw2w4KO/m9RWXWiOIj5cWbdiwmwMoVw3YRTFQyGAhRQv0J90uMuAPZOwJK6W9USPA1b5hNbOFqz83ad5rzJHc38gjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724998426; c=relaxed/simple;
	bh=apBdBhGYDEIgPSX8O85iHr2OVAYQZauF8WnD58crLVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESqttQR/k/SXwPmBouT27W7NkyYog5kZFWZIEMa8EaOAa64D0PZoJ/YZPI7SxT3JfaLjqn059KK+EKmvP+SEj+5ooEpL27BEVoWW7cKk2Wz5Cc/Wmv9koxuas7Z/H5WKKwPfefwnTu2aCMrQDS+CjvFL+bSbdwR/0J6U1HHDv6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdQY4DwX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdQY4DwX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2FDC4CEC4;
	Fri, 30 Aug 2024 06:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724998425;
	bh=apBdBhGYDEIgPSX8O85iHr2OVAYQZauF8WnD58crLVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mdQY4DwX+SmrhNvdHvXMX+yZs0g3qsdTp5fhCufHsca8W7Pp7uZIQtUekflhHUxsq
	 z2pAweXKH2W+iHjMSg/Kf9IKzCXRNFEJ3Nq2CXmsif8gRoWMuWH5180k/l9bAbFind
	 yy8oU4tcCg6iLm5lo9R3pQfWEdiOZICd7e0IP7PST2ARZcW8+IbYhiEmkpVS8GevKt
	 Q8+7tXLuyNANpRPSXmNUGWigDV5+tfB0zcl7Kt9TVbIzAS/NfoayLuL2aqyDejjC+X
	 gsLIjUuSmSGdzBOd2yVMYqvGkKmeERtmgOKXvda6yU4i22zD25/n7ULi+NAHqXh8Zz
	 Nl3bZF3SXAFmQ==
Date: Thu, 29 Aug 2024 23:13:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	ravi.bangoria@amd.com, sandipan.das@amd.com,
	atrajeev@linux.vnet.ibm.com, luogengkun@huaweicloud.com,
	ak@linux.intel.com
Subject: Re: [RFC PATCH] perf: New start period for the freq mode
Message-ID: <ZtFjFpg0MCcLbgnq@google.com>
References: <20240829152036.3923842-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829152036.3923842-1-kan.liang@linux.intel.com>

Hi Kan,

On Thu, Aug 29, 2024 at 08:20:36AM -0700, kan.liang@linux.intel.com wrote:
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
> 
> It's hard to find a universal start period for all events. The idea is
> only to give an estimate for the popular HW and HW cache events. For the
> rest of the events, start from the lowest possible recommended value.
> 
> Only the Intel event list JSON file provides the recommended SAV
> (sample after value) for each event. The estimation is based on the
> Intel's SAV.
> 
> This patch implements a generic perf_freq_start_period() which impacts
> all ARCHs.
> If the other ARCHs don't like the start period, a per-pmu
> (*freq_start_period) may be introduced instead. Or make it a __weak
> function.
> The other option would be exposing a start_period knob in the sysfs or a
> per-event config. So the end users can set their preferred start period.
> Please let me know your thoughts.
> 
> SW events may need to be specially handled, which is not implemented in
> the patch.

Sounds like a per-pmu callback is fine.  PMUs don't have the callback
(including SW) can use 1 same as of now.

Thanks,
Namhyung

> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  kernel/events/core.c | 65 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4b855b018a79..7a028474caef 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -12017,6 +12017,69 @@ static void account_event(struct perf_event *event)
>  	account_pmu_sb_event(event);
>  }
>  
> +static u64 perf_freq_start_period(struct perf_event *event)
> +{
> +	int type = event->attr.type;
> +	u64 config, factor;
> +
> +	/*
> +	 * The 127 is the lowest possible recommended SAV (sample after value)
> +	 * for a 4000 freq (default freq), according to Intel event list JSON
> +	 * file, which is the only JSON file that provides a recommended value.
> +	 */
> +	factor = 127 * 4000;
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
> +	return DIV_ROUND_UP_ULL(factor, event->attr.sample_freq);
> +}
> +
>  /*
>   * Allocate and initialize an event structure
>   */
> @@ -12140,7 +12203,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>  	hwc = &event->hw;
>  	hwc->sample_period = attr->sample_period;
>  	if (attr->freq && attr->sample_freq)
> -		hwc->sample_period = 1;
> +		hwc->sample_period = perf_freq_start_period(event);
>  	hwc->last_period = hwc->sample_period;
>  
>  	local64_set(&hwc->period_left, hwc->sample_period);
> -- 
> 2.38.1
> 
