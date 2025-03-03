Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4A3208A9;
	Mon,  3 Mar 2025 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741036604; cv=none; b=OT+O9OKuxSqZL6jpPu51HuIhdnUaejV7DIevCOfHgb+ZepFEpbCuTFxaK2kiEzCq/wKhsK/a0tRMjA39IZWs2Owk1RFktZGJDCQWrf+sC+m4yzzocx6iyTaOjAyj22etti57qcrxhXVL9bDRHfq4D2P5IIhl4bFMsdOKVjct3YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741036604; c=relaxed/simple;
	bh=4yCx8RM2Log51QCoNGpRsUX49OvBQOQMd1GTJhQf8qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rm/zAzL2ByFrUTbNHJdJuEcuBaMSIXwhqG61VUZXzGl3bqF03buNVd7CRd7qrboJVV4aIVthWnKZG9E9oc4SuR5WQHSioHiCFMU4oj4gcE4HcZbl3Jxiz5XuB9AFi9a1XMX+7Y/WKXL2V/QNu3G2NXerrNF23eDuOW2Y7x98dNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMx4l2gX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMx4l2gX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB2DC4CED6;
	Mon,  3 Mar 2025 21:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741036604;
	bh=4yCx8RM2Log51QCoNGpRsUX49OvBQOQMd1GTJhQf8qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMx4l2gXAWf62Jb1V8umispwrGuZVsgn5MyubgiePPjUpVhvipEUU8eAdqlcqE3NM
	 jzGcvwEEVNlOm31ESr6jNHI9/IQrZogjq25wBqaIUpQ3+Zjyh7zQYpDRT93bwJgRD/
	 Ftgp1xRRt/p4hAR2BN+bsscUgutZtr5I5T0aVyL2uzXuCqnw/19n4a2b4GLycbyfQG
	 36P+ipLiWdnDSym2mz1uew/8P2po4JRmU9sy7RUeQ1Ip9/uH2g18YzXhD1Mt11L/3e
	 +TG5g2skM7Qo1OQvhbf+Y2jfEBo96l7FL2cAsQlRTMHrDQO80X80SUykEbH3mhLUqO
	 lzyEDvD1356LA==
Date: Mon, 3 Mar 2025 13:16:42 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	Kan Liang <kan.liang@intel.com>
Subject: Re: [PATCH v4] perf script: Fix output type for dynamically
 allocated core PMU's
Message-ID: <Z8YcOidenzGofq7R@google.com>
References: <20250226170043.762219-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226170043.762219-1-thomas.falcon@intel.com>

Hello,

On Wed, Feb 26, 2025 at 11:00:43AM -0600, Thomas Falcon wrote:
> This patch was originally posted here:
> 
> https://lore.kernel.org/all/20241213215421.661139-1-thomas.falcon@intel.com/
> 
> I have rebased on top of Arnaldo's patch here:
> 
> https://lore.kernel.org/all/Z2XCi3PgstSrV0SE@x1/
> 
> The original commit message:
> "
> perf script output may show different fields on different core PMU's
> that exist on heterogeneous platforms. For example,
> 
> perf record -e "{cpu_core/mem-loads-aux/,cpu_core/event=0xcd,\
> umask=0x01,ldlat=3,name=MEM_UOPS_RETIRED.LOAD_LATENCY/}:upp"\
> -c10000 -W -d -a -- sleep 1
> 
> perf script:
> 
> chromium-browse   46572 [002] 544966.882384:      10000 	cpu_core/MEM_UOPS_RETIRED.LOAD_LATENCY/: 7ffdf1391b0c     10268100142 \
>  |OP LOAD|LVL L1 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK    N/A    5   7    0   7fad7c47425d [unknown] (/usr/lib64/libglib-2.0.so.0.8000.3)
> 
> perf record -e cpu_atom/event=0xd0,umask=0x05,ldlat=3,\
> name=MEM_UOPS_RETIRED.LOAD_LATENCY/upp -c10000 -W -d -a -- sleep 1
> 
> perf script:
> 
> gnome-control-c  534224 [023] 544951.816227:      10000 cpu_atom/MEM_UOPS_RETIRED.LOAD_LATENCY/:   7f0aaaa0aae0  [unknown] (/usr/lib64/libglib-2.0.so.0.8000.3)
> 
> Some fields, such as data_src, are not included by default.
> 
> The cause is that while one PMU may be assigned a type such as
> PERF_TYPE_RAW, other core PMU's are dynamically allocated at boot time.
> If this value does not match an existing PERF_TYPE_X value,
> output_type(perf_event_attr.type) will return OUTPUT_TYPE_OTHER.
> 
> Instead search for a core PMU with a matching perf_event_attr type
> and, if one is found, return PERF_TYPE_RAW to match output of other
> core PMU's.
> "
> 
> Suggested-by: Kan Liang <kan.liang@intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
> v2: restrict pmu lookup to platforms with more than one core pmu
> v3: only scan core pmu list
> v4: rebase on top of Arnaldo's patch
> ---
>  tools/perf/builtin-script.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index d797cec4f054..abc860d01420 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -398,10 +398,28 @@ static inline int output_type(unsigned int type)
>  	return OUTPUT_TYPE_OTHER;
>  }
>  
> +static bool output_type_check_core_pmus(unsigned int type)

How about renaming to is_core_pmu_type() ?

> +{
> +	struct perf_pmu *pmu = NULL;
> +
> +	if (perf_pmus__num_core_pmus() > 1) {
> +		while ((pmu = perf_pmus__scan_core(pmu)) != NULL) {
> +			if (pmu->type == type)
> +				return true;
> +		}
> +	}
> +	return false;

To be more generic, it could be

	return type == PERF_TYPE_RAW;

> +}
> +
>  static inline int evsel__output_type(struct evsel *evsel)
>  {
> -	if (evsel->script_output_type == OUTPUT_TYPE_UNSET)
> -		evsel->script_output_type = output_type(evsel->core.attr.type);
> +	if (evsel->script_output_type == OUTPUT_TYPE_UNSET) {
> +		if (output_type(evsel->core.attr.type) == OUTPUT_TYPE_OTHER &&
> +		    output_type_check_core_pmus(evsel->core.attr.type))
> +			evsel->script_output_type = PERF_TYPE_RAW;
> +		else
> +			evsel->script_output_type = output_type(evsel->core.attr.type);
> +	}

It seems better to put this logic inside output_type().

Thanks,
Namhyung

>  
>  	return evsel->script_output_type;
>  }
> -- 
> 2.48.1
> 
