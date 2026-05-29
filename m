Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE501368947;
	Fri, 29 May 2026 11:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053115; cv=none; b=NvzqbbAVQ2QIF3vMsGFUfGNYKLcO4ZrfXLmzYZJ4oXc35BOaEs9ng8jHf2AiKgEPl6X+pzJTjqeKBCdlqkXOL/tSefCXb7IQvwyyalJR2Humo5tWQR/y7JGT9HayVUdri7fO5jOcdffgwmM/K4k0sfnmh6Z8b5Q+DpFvIVuh42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053115; c=relaxed/simple;
	bh=SvCgEWqzulEwhVXFzoiFBOKcd8hkzA4OrFfbsPeY7vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASL02m+/UKemrHsbSFqbyTo9+6u5kBlfjHIkcjr1hDF4nlzs0YQ9EaG8bMny+KcCGeUMtqyCIDLJ9R8jy2vJlRdU/hg5M2hrcGMMhZw8k7qPQ8OzV0D27q9bVcrqIpaozdX5tN6n/6qLO4BeJJjHpJNez/9eox1+DIIstqULKVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TKn5Icn5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TKn5Icn5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wm1nON44y9HcNCJk/qn3x7pPNDII+AeEwXd9iKPTeSg=; b=TKn5Icn56wXXy6CNEjzQ1mkVS+
	dG2UqZZ87BF+uVpXLtOHEzR32WheGmFK8ZxF6VnIqnogPqA5BzzS/AdQN+A+iUzGQIDP2asfKeOwT
	fmBuWnX0xTEFNQMrk/2P7S5ea1oL4ys/++I43vo4iGZFMHCWnhMvcmpsivkPg1qsHl724vl055xGR
	sW3LAqi5F02cHWxYh/COXhqDLLcUZxhNJt3aGnh8SfzLwAHCZdQRaqaCEPdw2AACGAJtCU5XAv8/6
	z8A0LGzybPeIShGWxq4Flo0dv04fFLjCh3cTQwU/8aI9Pnx1nsLev60JZYk9MseVjHhSsNIRigqhR
	go7cs4WQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSv80-000000060Zr-02Cu;
	Fri, 29 May 2026 11:11:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 73FC030036F; Fri, 29 May 2026 13:11:47 +0200 (CEST)
Date: Fri, 29 May 2026 13:11:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v8 01/23] perf/x86/intel: Validate return value of
 intel_pmu_init_hybrid()
Message-ID: <20260529111147.GI3493090@noisy.programming.kicks-ass.net>
References: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
 <20260529075645.580362-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529075645.580362-2-dapeng1.mi@linux.intel.com>

On Fri, May 29, 2026 at 03:56:23PM +0800, Dapeng Mi wrote:
> The memory allocation for the x86_pmu.hybrid_pmu[] array in
> intel_pmu_init_hybrid() can theoretically fail due to memory shortages.
> If this occurs, the initialization of the x86 hybrid PMU would fail.
> 
> Currently, the code does not check the return value of the
> intel_pmu_init_hybrid() function, which could lead to attempts to access
> the uninitialized x86_pmu.hybrid_pmu[] array, potentially causing a
> system panic.
> 
> So, adds a check for the return value of intel_pmu_init_hybrid() to
> prevent invalid memory access in such scenarios.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
> 
> V8: New patch.
> 
>  arch/x86/events/intel/core.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 0217e701aeeb..85c329bd52be 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -7870,6 +7870,7 @@ __init int intel_pmu_init(void)
>  	int version, i;
>  	char *name;
>  	struct x86_hybrid_pmu *pmu;
> +	int ret;
>  
>  	/* Architectural Perfmon was introduced starting with Core "Yonah" */
>  	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
> @@ -8545,7 +8546,9 @@ __init int intel_pmu_init(void)
>  		 *
>  		 * Initialize the common PerfMon capabilities here.
>  		 */
> -		intel_pmu_init_hybrid(hybrid_big_small);
> +		ret = intel_pmu_init_hybrid(hybrid_big_small);
> +		if (ret < 0)
> +			return ret;

Sashiko notes this will leak the intel_pmu_arch_lbt_init() kmemcache.

I'm not entirely sure we care much about that, but its not really nice.
