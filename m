Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BB5189BB0;
	Wed, 29 Jan 2025 04:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738126608; cv=none; b=mXNs/9iMX84EC9N/ja31HBMwD6uxINjDEUdtg1UldBRD3qD5/paexFbqowGqJp/rc5Lg91A2cvgIWyLtvjhbY2z0b8rgtOBOuuqvw7yFBBHiZK84lWADRF4oxhBDrdhmjr8fEDG8iWj1FrDV/IbfbJcXReB7wZepdHj38wKyzGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738126608; c=relaxed/simple;
	bh=5p4MaEUrlp23iijUapVk/2YUFnv3In4huiP7Is8iiAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSCDPSbX9/esXbug6X4D8Ns5kP82pPtPku1C+HFqRANDcffusBCq9mkGPY87yrrzVPbkqPamu1u9j5OQpaDw4CrcGwQ+zWPl2OHzUhrcWC7COXvapTaKTV1b/TWUtWTi91KQyCYV7OTWpAWzrZJfU3jLa71CHzn1G1dG7Q0Pw64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVW7kZvX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVW7kZvX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D656DC4CED3;
	Wed, 29 Jan 2025 04:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738126608;
	bh=5p4MaEUrlp23iijUapVk/2YUFnv3In4huiP7Is8iiAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LVW7kZvXGSdFxlmLzvkHYsHQS9oOS8FRu/hq8s8ywgDGPxoV/4g58cFKeT95vupAF
	 JAIsZ8IcZEjMkjqnVzJci7sXN432vAC16ELEjjA9J81SXopZyGUelJDPsOsGy2XvKB
	 zE+OdLH4m4Jna+ztqVWwVTnnnX/w8reR1qdFqkrnxm1BZWGj6+WVItkc10S9Z1BJnU
	 TK21+BF6IVAOXFAlA3K/F5Ly6XjnSE7p3ngHW06oWzouhTmxhAF7QjBrWHHT4Mt4Nz
	 Vdok4okvXEUQrbpLnMMNQS7gf7J7rVzAdOzlr69Fmd+y8AVH7zrgp78umoJWk0j4OC
	 aztlx50I3DH2w==
Date: Tue, 28 Jan 2025 20:56:46 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 5/7] perf report: Add latency output field
Message-ID: <Z5m1DqB2SK_Cj3iC@google.com>
References: <cover.1737971364.git.dvyukov@google.com>
 <e78918ee05f9aaa623f0cb402e3c53e7b8a6185b.1737971364.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e78918ee05f9aaa623f0cb402e3c53e7b8a6185b.1737971364.git.dvyukov@google.com>

On Mon, Jan 27, 2025 at 10:58:52AM +0100, Dmitry Vyukov wrote:
> Latency output field is similar to overhead, but represents overhead for
> latency rather than CPU consumption. It's re-scaled from overhead by dividing
> weight by the current parallelism level at the time of the sample.
> It effectively models profiling with 1 sample taken per unit of wall-clock
> time rather than unit of CPU time.
> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/perf/ui/browsers/hists.c  | 27 ++++++++++------
>  tools/perf/ui/hist.c            | 29 ++++++++++-------
>  tools/perf/util/addr_location.h |  2 ++
>  tools/perf/util/event.c         |  6 ++++
>  tools/perf/util/events_stats.h  |  2 ++
>  tools/perf/util/hist.c          | 55 ++++++++++++++++++++++++---------
>  tools/perf/util/hist.h          | 12 +++++++
>  tools/perf/util/sort.c          |  2 ++
>  8 files changed, 100 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index 49ba82bf33918..35c10509b797f 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -1226,7 +1226,7 @@ int __hpp__slsmg_color_printf(struct perf_hpp *hpp, const char *fmt, ...)
>  	return ret;
>  }
>  
> -#define __HPP_COLOR_PERCENT_FN(_type, _field)				\
> +#define __HPP_COLOR_PERCENT_FN(_type, _field, _fmttype)			\
>  static u64 __hpp_get_##_field(struct hist_entry *he)			\
>  {									\
>  	return he->stat._field;						\
> @@ -1238,10 +1238,10 @@ hist_browser__hpp_color_##_type(struct perf_hpp_fmt *fmt,		\
>  				struct hist_entry *he)			\
>  {									\
>  	return hpp__fmt(fmt, hpp, he, __hpp_get_##_field, " %*.2f%%",	\
> -			__hpp__slsmg_color_printf, true);		\
> +			__hpp__slsmg_color_printf, _fmttype);		\
>  }
>  
> -#define __HPP_COLOR_ACC_PERCENT_FN(_type, _field)			\
> +#define __HPP_COLOR_ACC_PERCENT_FN(_type, _field, _fmttype)		\
>  static u64 __hpp_get_acc_##_field(struct hist_entry *he)		\
>  {									\
>  	return he->stat_acc->_field;					\
> @@ -1262,15 +1262,18 @@ hist_browser__hpp_color_##_type(struct perf_hpp_fmt *fmt,		\
>  		return ret;						\
>  	}								\
>  	return hpp__fmt(fmt, hpp, he, __hpp_get_acc_##_field,		\
> -			" %*.2f%%", __hpp__slsmg_color_printf, true);	\
> +			" %*.2f%%", __hpp__slsmg_color_printf,		\
> +			_fmttype);					\
>  }
>  
> -__HPP_COLOR_PERCENT_FN(overhead, period)
> -__HPP_COLOR_PERCENT_FN(overhead_sys, period_sys)
> -__HPP_COLOR_PERCENT_FN(overhead_us, period_us)
> -__HPP_COLOR_PERCENT_FN(overhead_guest_sys, period_guest_sys)
> -__HPP_COLOR_PERCENT_FN(overhead_guest_us, period_guest_us)
> -__HPP_COLOR_ACC_PERCENT_FN(overhead_acc, period)
> +__HPP_COLOR_PERCENT_FN(overhead, period, PERF_HPP_FMT_TYPE__PERCENT)
> +__HPP_COLOR_PERCENT_FN(latency, latency, PERF_HPP_FMT_TYPE__LATENCY)
> +__HPP_COLOR_PERCENT_FN(overhead_sys, period_sys, PERF_HPP_FMT_TYPE__PERCENT)
> +__HPP_COLOR_PERCENT_FN(overhead_us, period_us, PERF_HPP_FMT_TYPE__PERCENT)
> +__HPP_COLOR_PERCENT_FN(overhead_guest_sys, period_guest_sys, PERF_HPP_FMT_TYPE__PERCENT)
> +__HPP_COLOR_PERCENT_FN(overhead_guest_us, period_guest_us, PERF_HPP_FMT_TYPE__PERCENT)
> +__HPP_COLOR_ACC_PERCENT_FN(overhead_acc, period, PERF_HPP_FMT_TYPE__PERCENT)
> +__HPP_COLOR_ACC_PERCENT_FN(latency_acc, latency, PERF_HPP_FMT_TYPE__LATENCY)
>  
>  #undef __HPP_COLOR_PERCENT_FN
>  #undef __HPP_COLOR_ACC_PERCENT_FN
> @@ -1279,6 +1282,8 @@ void hist_browser__init_hpp(void)
>  {
>  	perf_hpp__format[PERF_HPP__OVERHEAD].color =
>  				hist_browser__hpp_color_overhead;
> +	perf_hpp__format[PERF_HPP__LATENCY].color =
> +				hist_browser__hpp_color_latency;
>  	perf_hpp__format[PERF_HPP__OVERHEAD_SYS].color =
>  				hist_browser__hpp_color_overhead_sys;
>  	perf_hpp__format[PERF_HPP__OVERHEAD_US].color =
> @@ -1289,6 +1294,8 @@ void hist_browser__init_hpp(void)
>  				hist_browser__hpp_color_overhead_guest_us;
>  	perf_hpp__format[PERF_HPP__OVERHEAD_ACC].color =
>  				hist_browser__hpp_color_overhead_acc;
> +	perf_hpp__format[PERF_HPP__LATENCY_ACC].color =
> +				hist_browser__hpp_color_latency_acc;
>  
>  	res_sample_init();
>  }
> diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
> index 34fda1d5eccb4..22e31d835301e 100644
> --- a/tools/perf/ui/hist.c
> +++ b/tools/perf/ui/hist.c
> @@ -27,9 +27,10 @@ static int __hpp__fmt_print(struct perf_hpp *hpp, struct hists *hists, u64 val,
>  			    int nr_samples, const char *fmt, int len,
>  			    hpp_snprint_fn print_fn, enum perf_hpp_fmt_type fmtype)
>  {
> -	if (fmtype == PERF_HPP_FMT_TYPE__PERCENT) {
> +	if (fmtype == PERF_HPP_FMT_TYPE__PERCENT || fmtype == PERF_HPP_FMT_TYPE__LATENCY) {
>  		double percent = 0.0;
> -		u64 total = hists__total_period(hists);
> +		u64 total = fmtype == PERF_HPP_FMT_TYPE__PERCENT ? hists__total_period(hists) :
> +			hists__total_latency(hists);
>  
>  		if (total)
>  			percent = 100.0 * val / total;
> @@ -128,7 +129,7 @@ int hpp__fmt(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
>  				  print_fn, fmtype);
>  	}
>  
> -	if (fmtype == PERF_HPP_FMT_TYPE__PERCENT)
> +	if (fmtype == PERF_HPP_FMT_TYPE__PERCENT || fmtype == PERF_HPP_FMT_TYPE__LATENCY)
>  		len -= 2; /* 2 for a space and a % sign */
>  	else
>  		len -= 1;
> @@ -472,11 +473,13 @@ __HPP_ENTRY_AVERAGE_FN(_type, _field)					\
>  __HPP_SORT_AVERAGE_FN(_type, _field)
>  
>  HPP_PERCENT_FNS(overhead, period)
> +HPP_PERCENT_FNS(latency, latency)
>  HPP_PERCENT_FNS(overhead_sys, period_sys)
>  HPP_PERCENT_FNS(overhead_us, period_us)
>  HPP_PERCENT_FNS(overhead_guest_sys, period_guest_sys)
>  HPP_PERCENT_FNS(overhead_guest_us, period_guest_us)
>  HPP_PERCENT_ACC_FNS(overhead_acc, period)
> +HPP_PERCENT_ACC_FNS(latency_acc, latency)
>  
>  HPP_RAW_FNS(samples, nr_events)
>  HPP_RAW_FNS(period, period)
> @@ -548,11 +551,13 @@ static bool hpp__equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
>  
>  struct perf_hpp_fmt perf_hpp__format[] = {
>  	HPP__COLOR_PRINT_FNS("Overhead", overhead, OVERHEAD),
> +	HPP__COLOR_PRINT_FNS("Latency", latency, LATENCY),
>  	HPP__COLOR_PRINT_FNS("sys", overhead_sys, OVERHEAD_SYS),
>  	HPP__COLOR_PRINT_FNS("usr", overhead_us, OVERHEAD_US),
>  	HPP__COLOR_PRINT_FNS("guest sys", overhead_guest_sys, OVERHEAD_GUEST_SYS),
>  	HPP__COLOR_PRINT_FNS("guest usr", overhead_guest_us, OVERHEAD_GUEST_US),
>  	HPP__COLOR_ACC_PRINT_FNS("Children", overhead_acc, OVERHEAD_ACC),
> +	HPP__COLOR_ACC_PRINT_FNS("Latency", latency_acc, LATENCY_ACC),

Hmm.. two latency fields have the same name.  Maybe better to
distinguish them but "Children Latency" or "Total Latency" would be
too long.. :(

I think it's mostly ok since users will see them together with overhead
columns and it'll give the context ("Children" or "Self").  But it can 
e called with -F or -s option to manually select those columns only.

Thanks,
Namhyung


>  	HPP__PRINT_FNS("Samples", samples, SAMPLES),
>  	HPP__PRINT_FNS("Period", period, PERIOD),
>  	HPP__PRINT_FNS("Weight1", weight1, WEIGHT1),

>  		fmt->free(fmt);
>  }
