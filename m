Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0662580D5;
	Wed, 30 Apr 2025 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746032319; cv=none; b=ZGkRNzD0CMzqdKNj6305bwpAHVO8Rkcs1DT7/bkmskp0MlJCvDWUEuZDGYoM1nGUIVexb/kr3X2xHw1Si18MeQsN536w+V+OrJHNHxTEzekMGSxbSHN79bww8jSf8MRM2bLnesMMa2/AOYLTBTTveas+ca/dLHTBRbOzbFA9N98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746032319; c=relaxed/simple;
	bh=IHQZr7lGpJ8t+/rizich5GtpDGJI9PPkZu7s7u3vswc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiaOskkIS/Gt99CVJJcLjuRW+OqHmNxSN4YnRArfIqLltRom3BWsp4uEhdkFFZ6NnIY2I27a55vDK9Zdc1bTGws0zofaKlUvxoMbr/6lfc8OaEnCqMNQSIReDlr7y0sN9lgXmfwx1Imc8iu/FJGl5gEuHkRFc+fPj9qDWVa2v6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYMuPA/R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYMuPA/R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3997C4CEE7;
	Wed, 30 Apr 2025 16:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746032318;
	bh=IHQZr7lGpJ8t+/rizich5GtpDGJI9PPkZu7s7u3vswc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZYMuPA/RVFgMtF2HaxEoiV2z99ULz9jUdl4H9+s4mkl6V5HX8ga42F5F+J+05e0aA
	 VehGldG9vaZJ9Fk8QiwevxnHh5ZJqadZUlS/XA3Y6UJlXSW5uIjfU+tbm5Sl81UOow
	 lDQrJWnMURmvg1WZrjLvtMPeVKIXD63WygPrxzgGgq/7y3JYIClEf6v+qKr7EK9YCw
	 UjxEHsu+Axs+3MMyh1CJ8g46RrEoNq+WcF5vA+flMTKWh5TiBx7cJ0wEgu24cHtq0b
	 jkLucjOfsNfyMrO6k1xyscLYtz6JfYM0fX9kyqHhzPnFFcFPMOLn8pSfxZ/CxfBAPL
	 +asX4HqaTiysg==
Date: Wed, 30 Apr 2025 09:58:36 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Joe Mario <jmario@redhat.com>,
	Stephane Eranian <eranian@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v4 1/4] perf amd ibs: Add Load Latency bits in raw dump
Message-ID: <aBJWvAQc0wF6EV9g@google.com>
References: <20250429035938.1301-1-ravi.bangoria@amd.com>
 <20250429035938.1301-2-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250429035938.1301-2-ravi.bangoria@amd.com>

Hello,

On Tue, Apr 29, 2025 at 03:59:35AM +0000, Ravi Bangoria wrote:
> IBS OP PMU on Zen5 supports Load Latency filtering. Decode and dump Load
> Latency filtering related bits into perf script raw dump.
> 
> Also add oneliner example in the perf-amd-ibs man page.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/perf/Documentation/perf-amd-ibs.txt |  9 +++++++++
>  tools/perf/util/amd-sample-raw.c          | 14 ++++++++++++--
>  2 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-amd-ibs.txt b/tools/perf/Documentation/perf-amd-ibs.txt
> index 2fd31d9d7b71..55f80beae037 100644
> --- a/tools/perf/Documentation/perf-amd-ibs.txt
> +++ b/tools/perf/Documentation/perf-amd-ibs.txt
> @@ -85,6 +85,15 @@ System-wide profile, uOps event, sampling period: 100000, L3MissOnly (Zen4 onwar
>  
>  	# perf record -e ibs_op/cnt_ctl=1,l3missonly=1/ -c 100000 -a
>  
> +System-wide profile, cycles event, sampling period: 100000, LdLat filtering (Zen5
> +onward)
> +
> +	# perf record -e ibs_op/ldlat=128/ -c 100000 -a
> +
> +	Supported load latency threshold values are 128 to 2048 (both inclusive).

What happens if user gives an out of range value?


> +	Latency value which is a multiple of 128 incurs a little less profiling
> +	overhead compared to other values.
> +
>  Per process(upstream v6.2 onward), uOps event, sampling period: 100000
>  
>  	# perf record -e ibs_op/cnt_ctl=1/ -c 100000 -p 1234
> diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
> index 9d0ce88e90e4..ac34b18ccc0c 100644
> --- a/tools/perf/util/amd-sample-raw.c
> +++ b/tools/perf/util/amd-sample-raw.c
> @@ -19,6 +19,7 @@
>  
>  static u32 cpu_family, cpu_model, ibs_fetch_type, ibs_op_type;
>  static bool zen4_ibs_extensions;
> +static bool ldlat_cap;
>  
>  static void pr_ibs_fetch_ctl(union ibs_fetch_ctl reg)
>  {
> @@ -78,14 +79,20 @@ static void pr_ic_ibs_extd_ctl(union ic_ibs_extd_ctl reg)
>  static void pr_ibs_op_ctl(union ibs_op_ctl reg)
>  {
>  	char l3_miss_only[sizeof(" L3MissOnly _")] = "";
> +	char ldlat[sizeof(" LdLatThrsh __ LdLatEn _")] = "";

Shouldn't it reserve 4 characters for the threshold since it can be up
to 2048?

>  
>  	if (zen4_ibs_extensions)
>  		snprintf(l3_miss_only, sizeof(l3_miss_only), " L3MissOnly %d", reg.l3_miss_only);
>  
> -	printf("ibs_op_ctl:\t%016llx MaxCnt %9d%s En %d Val %d CntCtl %d=%s CurCnt %9d\n",
> +	if (ldlat_cap) {
> +		snprintf(ldlat, sizeof(ldlat), " LdLatThrsh %2d LdLatEn %d",

Here, it would be %4d.

Thanks,
Namhyung


> +			 reg.ldlat_thrsh, reg.ldlat_en);
> +	}
> +
> +	printf("ibs_op_ctl:\t%016llx MaxCnt %9d%s En %d Val %d CntCtl %d=%s CurCnt %9d%s\n",
>  		reg.val, ((reg.opmaxcnt_ext << 16) | reg.opmaxcnt) << 4, l3_miss_only,
>  		reg.op_en, reg.op_val, reg.cnt_ctl,
> -		reg.cnt_ctl ? "uOps" : "cycles", reg.opcurcnt);
> +		reg.cnt_ctl ? "uOps" : "cycles", reg.opcurcnt, ldlat);
>  }
>  
>  static void pr_ibs_op_data(union ibs_op_data reg)
> @@ -331,6 +338,9 @@ bool evlist__has_amd_ibs(struct evlist *evlist)
>  	if (perf_env__find_pmu_cap(env, "ibs_op", "zen4_ibs_extensions"))
>  		zen4_ibs_extensions = 1;
>  
> +	if (perf_env__find_pmu_cap(env, "ibs_op", "ldlat"))
> +		ldlat_cap = 1;
> +
>  	if (ibs_fetch_type || ibs_op_type) {
>  		if (!cpu_family)
>  			parse_cpuid(env);
> -- 
> 2.43.0
> 
