Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389B61DE2D0;
	Mon,  7 Oct 2024 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728329611; cv=none; b=nfk+UtaoXy9cQGoDvdDKsBmG8TtWZOPkvBEte3gorrSqleI7drC/o6+8NFE6bSPa5k2zPlEK803hKMtcd8Z7k9hHdrUjRApRS9jI+F/G58OMac6LSdLkbmDIIJLgs4Wa3alhL5CsQD86PevsfvwNpgsmVBx7oyU7ElxglS9WltE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728329611; c=relaxed/simple;
	bh=aLAtEikUkzilXQ2Py4LyN/idwxSsEI83HqS0NigKqjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YB7VFudDQf4ChGjE8XiaWNgGHVQ2f2YpccJU3wYTAWM6bBa7KCobnFsL05N5ES/r8ZmES6SIe6EmRgdF8Mai9Q46DWrmCWWmkjOfVSTTpsXv3Fp8PuYw1sXGfk+z5npDUNlp0BZLgSuCZLTyVDO9qCDFtf1EH/nFmwUCwc13HPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHa+1Q8M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHa+1Q8M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BDFC4CEC6;
	Mon,  7 Oct 2024 19:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728329610;
	bh=aLAtEikUkzilXQ2Py4LyN/idwxSsEI83HqS0NigKqjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHa+1Q8MqT1SFSxhRZb/rjC92DPIj7VBX4199bmG467bKKky52tWuehWsPd7cgL6p
	 1UsQ1IuHkUqAtp7VfGHAFi8zqlfoloGBFw+2jZB1LqKHilDN+VpBivmF8ddRuUgxIB
	 sColV54uo+CD9MlEeo0ZaXjPf+a6N/n89d0obTEXV9gjTeiYu5V2Ff6ryzYZ1kKH2P
	 /piz9LLepDyjYUCutbNdEuf2NWcYqPspqMJKHJgxowl/5JRucZ4FE6Kw/idHfFavUA
	 k3+KpAYA3h7/DskzTJ2DtIFZ7R2PbXjWyGRkUAh7VZV5d5Tl0EST0tIfjUtIByhp5+
	 JovAYhtSDSdaw==
Date: Mon, 7 Oct 2024 12:33:28 -0700
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
Subject: Re: [PATCH 7/8] perf/amd/ibs: Add ->check_period() callback
Message-ID: <ZwQ3iEx5dBzVXZEl@google.com>
References: <20241007034810.754-1-ravi.bangoria@amd.com>
 <20241007034810.754-8-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007034810.754-8-ravi.bangoria@amd.com>

On Mon, Oct 07, 2024 at 03:48:09AM +0000, Ravi Bangoria wrote:
> IBS Fetch and IBS Op pmus have constraints on sample period. The sample
> period is verified at the time of opening an event but not at the ioctl()
> interface. Hence, a user can open an event with valid period but change
> it later with ioctl(). Add a ->check_period() callback to verify the
> period provided at ioctl() is also valid.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index e7522ba45a7e..33728ed6d7a6 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -551,6 +551,28 @@ static void perf_ibs_del(struct perf_event *event, int flags)
>  
>  static void perf_ibs_read(struct perf_event *event) { }
>  
> +static int perf_ibs_check_period(struct perf_event *event, u64 value)
> +{
> +	struct perf_ibs *perf_ibs;
> +	u64 low_nibble;
> +
> +	if (event->attr.freq)
> +		return 0;
> +
> +	perf_ibs = container_of(event->pmu, struct perf_ibs, pmu);
> +	low_nibble = value & 0xFULL;
> +
> +	/*
> +	 * This contradicts with perf_ibs_init() which allows sample period
> +	 * with lower nibble bits set but silently masks them off. Whereas
> +	 * this returns error.
> +	 */
> +	if (low_nibble || value < perf_ibs->min_period)
> +		return -EINVAL;

You may want to check max_period too.

Thanks,
Namhyung

> +
> +	return 0;
> +}
> +
>  /*
>   * We need to initialize with empty group if all attributes in the
>   * group are dynamic.
> @@ -676,6 +698,7 @@ static struct perf_ibs perf_ibs_fetch = {
>  		.start		= perf_ibs_start,
>  		.stop		= perf_ibs_stop,
>  		.read		= perf_ibs_read,
> +		.check_period	= perf_ibs_check_period,
>  		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>  	},
>  	.msr			= MSR_AMD64_IBSFETCHCTL,
> @@ -701,6 +724,7 @@ static struct perf_ibs perf_ibs_op = {
>  		.start		= perf_ibs_start,
>  		.stop		= perf_ibs_stop,
>  		.read		= perf_ibs_read,
> +		.check_period	= perf_ibs_check_period,
>  		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>  	},
>  	.msr			= MSR_AMD64_IBSOPCTL,
> -- 
> 2.46.2
> 
