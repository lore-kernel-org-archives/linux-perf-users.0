Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3122146000
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Oct 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728830902; cv=none; b=jFOESkMQyVBtcEIZ5Jc59UPIZ5zF4H9ItXdXEYPe5uBGVZXou6qPL4EKb6/RIoYsHYoraTeez0rtI/6ZaKJB707/Imy10ijgtES81stHN4yjFCxtshgTzMzmLGmCyPnE3MJTcyWJCwUC0sIzQTqu2wJmW6+OsMwR8bp9sPFHBlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728830902; c=relaxed/simple;
	bh=AUvPmuSjI+rSvTcZ0TXHVxonicItQiBtNVeLunp3GO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZ6SasK/RX8vq7+JXPRMuUTAaDzmSuwiujs+eyCYkN/6ML7eSxZbiyRU3TnFIfDjYnb7TolNB/HT2uPj4BcFSIHt2PiWIIq8/nsk5LRmGoIqgJ0ROkvjX+8f9Y4XtNIsgplxEe8BUll5n7oM3TYERq8T6uy0zfMnbLjy7/952+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WqB/oQK5; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WqB/oQK5"
Date: Sun, 13 Oct 2024 22:48:08 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728830893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qI54PFvBT5PcOYDFV+12ZGlyTxkytu6jiXpb+llrzHU=;
	b=WqB/oQK5zMokzc6EZ5aJNHBlcHl2JlV72AphlV2ZqLzNP94S2H5Q93foU9SGtJfFGvNWAC
	ClsRLz5CegxfxEfUI5clAIe4R2WDvraNsz01JsOUesl3jES5bdb2Gs3Ss918xxkZgsmL1O
	SLAFrH+D5N1c4e5+vT9NA1CRWYOV1zY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leo Yan <leo.yan@linux.dev>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	H Peter Anvin <hpa@zytor.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Zhenyu Wang <zhenyuw@linux.intel.com>, kvm@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V12 11/14] perf tools: Add missing_features for
 aux_start_paused, aux_pause, aux_resume
Message-ID: <20241013144808.GA45976@debian-dev>
References: <20241010143152.19071-1-adrian.hunter@intel.com>
 <20241010143152.19071-12-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010143152.19071-12-adrian.hunter@intel.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 10, 2024 at 05:31:48PM +0300, Adrian Hunter wrote:
> Display "feature is not supported" error message if aux_start_paused,
> aux_pause or aux_resume result in a perf_event_open() error.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Acked-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

This patch looks good to me.

A case is the Linux kernel has supported aux_pause_resume feature, but
the PMU event does not support it. So we might consider to add a extra
patch in perf:

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 927aa61e7b14..9a3191df2ec5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3373,6 +3373,10 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
                        return scnprintf(msg, size,
        "%s: PMU Hardware doesn't support 'aux_output' feature",
                                         evsel__name(evsel));
+               if (evsel->core.attr.aux_action)
+                       return scnprintf(msg, size,
+       "%s: PMU Hardware doesn't support 'aux_action' feature",
+                                        evsel__name(evsel));
                if (evsel->core.attr.sample_period != 0)
                        return scnprintf(msg, size,
        "%s: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'",

Thanks,
Leo

> ---
>  tools/perf/util/evsel.c | 10 +++++++++-
>  tools/perf/util/evsel.h |  1 +
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d34ceab9e454..927aa61e7b14 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2147,7 +2147,13 @@ bool evsel__detect_missing_features(struct evsel *evsel)
>  	 * Must probe features in the order they were added to the
>  	 * perf_event_attr interface.
>  	 */
> -	if (!perf_missing_features.branch_counters &&
> +	if (!perf_missing_features.aux_pause_resume &&
> +	    (evsel->core.attr.aux_pause || evsel->core.attr.aux_resume ||
> +	     evsel->core.attr.aux_start_paused)) {
> +		perf_missing_features.aux_pause_resume = true;
> +		pr_debug2_peo("Kernel has no aux_pause/aux_resume support, bailing out\n");
> +		return false;
> +	} else if (!perf_missing_features.branch_counters &&
>  	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS)) {
>  		perf_missing_features.branch_counters = true;
>  		pr_debug2("switching off branch counters support\n");
> @@ -3397,6 +3403,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>  			return scnprintf(msg, size, "clockid feature not supported.");
>  		if (perf_missing_features.clockid_wrong)
>  			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
> +		if (perf_missing_features.aux_pause_resume)
> +			return scnprintf(msg, size, "The 'aux_pause / aux_resume' feature is not supported, update the kernel.");
>  		if (perf_missing_features.aux_output)
>  			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
>  		if (!target__has_cpu(target))
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 15e745a9a798..778fcdb8261f 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -221,6 +221,7 @@ struct perf_missing_features {
>  	bool weight_struct;
>  	bool read_lost;
>  	bool branch_counters;
> +	bool aux_pause_resume;
>  };
>  
>  extern struct perf_missing_features perf_missing_features;
> -- 
> 2.43.0
> 
> 
