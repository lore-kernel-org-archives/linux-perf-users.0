Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3339E1DE2D0;
	Mon,  7 Oct 2024 19:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728329422; cv=none; b=sxbYuCQtDjJRmDtjA9Ca3ofdSKeZuGPYJRZtaiRDU25MnXZLeBYcOg6gSHIh/dO31ULCLUhv+Rjn6abJR9/wlAwQwyB+Wql28NIDmOovoYqKd3OLrPk0G9lI2svLNZkkFFTuXlXkh4YUPuIBjlKz63jY4a/20549BsIPrMFPPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728329422; c=relaxed/simple;
	bh=ZdksU2UK/9o4uz78W+rwA8yZ/N8Pqbt78nI+dJedfHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVo2roq9zSMPXDxSz1VBJhaqVmJ+5swrd6YUZ0OapgP+xTn9/8YbcTHxmZoFj7X+LlP7KJUX93GQTZLb5fTmumXVzt3NYSPz5zr40XOLPSBhjVmEMLAhlXAUvmLKQyIT1QzGJVTGhhTmDo7a7Jz/tKkL+MoPLey/yciEauEThzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gE44st9e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gE44st9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5ADC4CEC6;
	Mon,  7 Oct 2024 19:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728329421;
	bh=ZdksU2UK/9o4uz78W+rwA8yZ/N8Pqbt78nI+dJedfHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gE44st9eejAqrmZbz6dQPoXOWo8IpoXACrvKLaOXncSfV3See04z78JTFqywzoing
	 stdUlhKTPoJE6dftIFRZOdgjmn2oUkOP3hyjQZ+YX0CybJvSOzQD2CBiBKBUKw2YU1
	 LUuozY4SSLxrqaR8O0xkLbvxjltw+HfoOpnwK5rYbugCKgTUqmboTdD7MtFPEZaDfZ
	 EreOe5MMxWv8PxIjz0iQYHpSrHASAkZ1Hp589jMoZsVv+8wtpVtB0PaOhd5YTP78Qp
	 QLoUwH4qGYcYydcA5sSWW8/VgJ/ZW+buCKX0M09+lfE3D9BvtTiHdtfW8kG3Uyk8p4
	 wxc5PnAVum/eA==
Date: Mon, 7 Oct 2024 12:30:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	eranian@google.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	santosh.shukla@amd.com, ananth.narayan@amd.com,
	sandipan.das@amd.com
Subject: Re: [PATCH 6/8] perf/amd/ibs: Add pmu specific minimum period
Message-ID: <ZwQ2yzLm2yyaYOcJ@google.com>
References: <20241007034810.754-1-ravi.bangoria@amd.com>
 <20241007034810.754-7-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007034810.754-7-ravi.bangoria@amd.com>

On Mon, Oct 07, 2024 at 03:48:08AM +0000, Ravi Bangoria wrote:
> 0x10 is the minimum sample period for IBS Fetch and 0x90 for IBS Op.
> Current IBS pmu driver uses 0x10 for both the pmus, which is incorrect.
> Fix it by adding pmu specific minimum period values in struct perf_ibs.
> 
> Also, bail out opening a 'sample period mode' event if the user requested
> sample period is less than pmu supported minimum value. For a 'freq mode'
> event, start calibrating sample period from pmu specific minimum period.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 368ed839b612..e7522ba45a7e 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -83,6 +83,7 @@ struct perf_ibs {
>  	u64				cnt_mask;
>  	u64				enable_mask;
>  	u64				valid_mask;
> +	u16				min_period;
>  	u64				max_period;
>  	unsigned long			offset_mask[1];
>  	int				offset_max;
> @@ -295,10 +296,14 @@ static int perf_ibs_init(struct perf_event *event)
>  			/* raw max_cnt may not be set */
>  			return -EINVAL;
>  
> -		/* Silently mask off lower nibble. IBS hw mandates it. */
> -		hwc->sample_period &= ~0x0FULL;
> -		if (!hwc->sample_period)
> -			hwc->sample_period = 0x10;
> +		if (event->attr.freq) {
> +			hwc->sample_period = perf_ibs->min_period;
> +		} else {
> +			/* Silently mask off lower nibble. IBS hw mandates it. */
> +			hwc->sample_period &= ~0x0FULL;
> +			if (hwc->sample_period < perf_ibs->min_period)
> +				return -EINVAL;

Maybe it needs to check perf_ibs->max_period as well.

Thanks,
Namhyung

> +		}
>  	} else {
>  		u64 period = 0;
>  
> @@ -316,10 +321,10 @@ static int perf_ibs_init(struct perf_event *event)
>  		config &= ~perf_ibs->cnt_mask;
>  		event->attr.sample_period = period;
>  		hwc->sample_period = period;
> -	}
>  
> -	if (!hwc->sample_period)
> -		return -EINVAL;
> +		if (hwc->sample_period < perf_ibs->min_period)
> +			return -EINVAL;
> +	}
>  
>  	/*
>  	 * If we modify hwc->sample_period, we also need to update
> @@ -340,7 +345,8 @@ static int perf_ibs_set_period(struct perf_ibs *perf_ibs,
>  	int overflow;
>  
>  	/* ignore lower 4 bits in min count: */
> -	overflow = perf_event_set_period(hwc, 1<<4, perf_ibs->max_period, period);
> +	overflow = perf_event_set_period(hwc, perf_ibs->min_period,
> +					 perf_ibs->max_period, period);
>  	local64_set(&hwc->prev_count, 0);
>  
>  	return overflow;
> @@ -677,6 +683,7 @@ static struct perf_ibs perf_ibs_fetch = {
>  	.cnt_mask		= IBS_FETCH_MAX_CNT,
>  	.enable_mask		= IBS_FETCH_ENABLE,
>  	.valid_mask		= IBS_FETCH_VAL,
> +	.min_period		= 0x10,
>  	.max_period		= IBS_FETCH_MAX_CNT << 4,
>  	.offset_mask		= { MSR_AMD64_IBSFETCH_REG_MASK },
>  	.offset_max		= MSR_AMD64_IBSFETCH_REG_COUNT,
> @@ -702,6 +709,7 @@ static struct perf_ibs perf_ibs_op = {
>  				  IBS_OP_CUR_CNT_RAND,
>  	.enable_mask		= IBS_OP_ENABLE,
>  	.valid_mask		= IBS_OP_VAL,
> +	.min_period		= 0x90,
>  	.max_period		= IBS_OP_MAX_CNT << 4,
>  	.offset_mask		= { MSR_AMD64_IBSOP_REG_MASK },
>  	.offset_max		= MSR_AMD64_IBSOP_REG_COUNT,
> -- 
> 2.46.2
> 
