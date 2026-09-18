Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51E450B407;
	Fri, 18 Sep 2026 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746304; cv=none; b=uPPz7iRGvTQkaWwYbhqQ/0wNeaQR73B0LGFyi1jnnx3P08OcflSMVLyl3ql7FgMfdABF6YcsTjLxPGuMWyvj4yCe9CZ805EHbH0sr9V9YBBk/AHT/dNfChsUkM2kuBOwpOhYqB2LiEI6k4wuKM+6AelQhsvDIGFq1fucLiAbLrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746304; c=relaxed/simple;
	bh=+H4uf0sIVpGoI3CtsxxEtlvPECXYCKHuF81LNHIc0r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1tNf9gvWO3KrMD2fXnvbI2fw2gy4w6kar0hepauQwsSZTZ4vdlEaGYu1QGDLaNyUzzQCMUhuogDo327O7FAQv3hS0t06Us/jAmxFg341SsEeNvHCYDNd8ceBIuUGHqXYQpbOPzfo5NKjvwMcfnjUdPjhoGEhKJ+gmytm5sWibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlrlgdAa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlrlgdAa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB2D1F00898;
	Fri, 18 Sep 2026 15:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789746301;
	bh=Hn88baiQHEq6tgCu2zk56WRxOn/3pQC6K00mUTUJd9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WlrlgdAa/L2h+UvcKWVn+ewxfyr0KONxsE5v6+2p8+8/qvWTCYQegjnmsPR5J3A2m
	 UXvmA+bU2D+dS6cydjOUMY8sxlMtaQ0uMumT6t25FfvTtL9kbp270zEM/EvOMXq6EP
	 U2u7SECOBO7m0i3AQiDo/gIBh7glcjdLimzjThsmr87GSnnR+Zw67KTDWAcrpLW/pA
	 zq77YeL1NymaUKz2D31SqZLm+HsuwY8IsxR3JUu9vhrBVgK4tvkcYmlbq14wSir7+k
	 AXlsktlJ4Kh/YjGmJCdEtFUnn28XwT/Nm9lKhdrouksmnLA9AGixE597wWJRcNwLJG
	 VLwQ89uyadNcQ==
Date: Fri, 18 Sep 2026 12:44:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 12/12] perf mem record: Use the IBS swfilt filter when
 available
Message-ID: <aq1ceh61m-n2-b0z@x2>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-13-acme@kernel.org>
 <aqsRVABj23jaaiSq@google.com>
 <4349c387-5b8a-4e8d-932a-5175a7598e1e@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4349c387-5b8a-4e8d-932a-5175a7598e1e@amd.com>

On Fri, Sep 18, 2026 at 09:05:34AM +0530, Ravi Bangoria wrote:
> > It's a bit unfortunate we hardcode "swfilt" here.  Probably better to
> > have it in the mem-events array and add it to the name format
> > dynamically.  But as it's only needed for IBS, I think it's ok for now.
> 
> Something like this? (Untested):

Seems ok, I'm trying to use it now, ok?

- Arnaldo
 
> diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
> index b38f519020ff..816c73d75bc4 100644
> --- a/tools/perf/arch/x86/util/mem-events.c
> +++ b/tools/perf/arch/x86/util/mem-events.c
> @@ -27,8 +27,20 @@ struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
>  	E("mem-ldst",	"%s//",		NULL,	false,	0),
>  };
>  
> +struct perf_mem_event perf_mem_events_amd_swfilt[PERF_MEM_EVENTS__MAX] = {
> +	E(NULL,		NULL,		NULL,	false,	0),
> +	E(NULL,		NULL,		NULL,	false,	0),
> +	E("mem-ldst",	"%s/swfilt=1/",	NULL,	false,	0),
> +};
> +
>  struct perf_mem_event perf_mem_events_amd_ldlat[PERF_MEM_EVENTS__MAX] = {
>  	E(NULL,		NULL,		NULL,	false,	0),
>  	E(NULL,		NULL,		NULL,	false,	0),
>  	E("mem-ldst",	"%s/ldlat=%u/",	NULL,	true,	0),
>  };
> +
> +struct perf_mem_event perf_mem_events_amd_ldlat_swfilt[PERF_MEM_EVENTS__MAX] = {
> +	E(NULL,		NULL,				NULL,	false,	0),
> +	E(NULL,		NULL,				NULL,	false,	0),
> +	E("mem-ldst",	"%s/ldlat=%u,swfilt=1/",	NULL,	true,	0),
> +};
> diff --git a/tools/perf/arch/x86/util/mem-events.h b/tools/perf/arch/x86/util/mem-events.h
> index 11e09a256f5b..f707de380370 100644
> --- a/tools/perf/arch/x86/util/mem-events.h
> +++ b/tools/perf/arch/x86/util/mem-events.h
> @@ -6,6 +6,8 @@ extern struct perf_mem_event perf_mem_events_intel[PERF_MEM_EVENTS__MAX];
>  extern struct perf_mem_event perf_mem_events_intel_aux[PERF_MEM_EVENTS__MAX];
>  
>  extern struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX];
> +extern struct perf_mem_event perf_mem_events_amd_swfilt[PERF_MEM_EVENTS__MAX];
>  extern struct perf_mem_event perf_mem_events_amd_ldlat[PERF_MEM_EVENTS__MAX];
> +extern struct perf_mem_event perf_mem_events_amd_ldlat_swfilt[PERF_MEM_EVENTS__MAX];
>  
>  #endif /* _X86_MEM_EVENTS_H */
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> index 2c24ef3140da..fd4491fda117 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -333,6 +333,7 @@ static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha
>  void perf_pmu__arch_init(struct perf_pmu *pmu)
>  {
>  	struct perf_pmu_caps *ldlat_cap;
> +	bool swfilt_format;
>  
>  	if (!strcmp(pmu->name, INTEL_PT_PMU_NAME)) {
>  		pmu->auxtrace = true;
> @@ -348,7 +349,10 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>  		if (strcmp(pmu->name, "ibs_op"))
>  			return;
>  
> -		pmu->mem_events = perf_mem_events_amd;
> +		swfilt_format = perf_pmu__has_format(pmu, "swfilt");
> +		pmu->mem_events = swfilt_format ?
> +				  perf_mem_events_amd_swfilt :
> +				  perf_mem_events_amd;
>  
>  		if (!perf_pmu__caps_parse(pmu))
>  			return;
> @@ -358,7 +362,9 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>  			return;
>  
>  		perf_mem_events__loads_ldlat = 0;
> -		pmu->mem_events = perf_mem_events_amd_ldlat;
> +		pmu->mem_events = swfilt_format ?
> +				  perf_mem_events_amd_ldlat_swfilt :
> +				  perf_mem_events_amd_ldlat;
>  	} else {
>  		if (pmu->is_core) {
>  			if (perf_pmu__have_event(pmu, "mem-loads-aux"))
> 
> ---
> 
> Thanks,
> Ravi
