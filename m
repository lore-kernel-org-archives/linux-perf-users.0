Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B599176FBD;
	Mon, 12 Aug 2024 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470067; cv=none; b=sHh6vOfpAF5QXn9C4IuxjoBHLcCyFFNz29FZwuwZr1R1ycl1vCaZqPFQHnsvhWmhEtCM+gBIb1E46GZIgll90uJaz7KPhwEZ87JEs+XEPR6FagsUKmHMwXzt/05yLEU78BnPsn1yXtRNpxj/MKcnza4Ctbtv/Z5/geNtJjBFWlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470067; c=relaxed/simple;
	bh=0U71nSacs8CvY2GFvLzDN/Eotxf8ZzQ3z7yjHNWVXlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tuk1P7gD+Nqo+gSf4LITeIZxg3Ac1Xh9RW2EEzB7oou8UevbOBCHY9PzfNToapb5QVcr3Hd1HeW3gS1XuND54OSEPaiXKxHcusZ+x/BJvac7ghUEYZg57g1uVA8aePsPMBeQLYFfErRnzAG3ETmVJVZtkjiF3IJcXHC6MwEkjCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrqyAyLC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrqyAyLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFB5C32782;
	Mon, 12 Aug 2024 13:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723470066;
	bh=0U71nSacs8CvY2GFvLzDN/Eotxf8ZzQ3z7yjHNWVXlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BrqyAyLCFvlmNS1x9QAPN2qnQng9taz6Q02ptIj3G4gdwZOsZxJWu02sk0D6nzTcu
	 g8zbt4ODUrc3NZW8DKs8ZadqVWMBz+A0zz5477nAf4IEeev4tv5B0CEuCSnI8zV6iB
	 JbI0mNk+eAfrKAaDyR0zQFcEDJEBR6TbNo08fGSLncTLuNVRs2wZz0nKKdMYi3Z/BO
	 Lz22yk9UH3Wodo+wW4sQ/r0h/NJ/e6EYmYvH9NRFcKLF8hYCjU2jnnrJ9xrJZSk2Qh
	 Ervvd6ZJBnlE/HhyygXWJTNh+3P4Vtq57CzuHFHM3BlKuOLIIhhxRigb2/zryRA58J
	 Y+gIi02vNqjbQ==
Date: Mon, 12 Aug 2024 10:41:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v3 1/5] perf x86/topdown: Complete topdown slots/metrics
 events check
Message-ID: <ZroQ7wiw6JB-sjps@x1>
References: <20240712170339.185824-1-dapeng1.mi@linux.intel.com>
 <20240712170339.185824-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712170339.185824-2-dapeng1.mi@linux.intel.com>

On Fri, Jul 12, 2024 at 05:03:35PM +0000, Dapeng Mi wrote:
> It's not complete to check whether an event is a topdown slots or
> topdown metrics event by only comparing the event name since user
> may assign the event by RAW format, e.g.
> 
> perf stat -e '{instructions,cpu/r400/,cpu/r8300/}' sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>      <not counted>      instructions
>      <not counted>      cpu/r400/
>    <not supported>      cpu/r8300/
> 
>        1.002917796 seconds time elapsed
> 
>        0.002955000 seconds user
>        0.000000000 seconds sys
> 
> The RAW format slots and topdown-be-bound events are not recognized and
> not regroup the events, and eventually cause error.
> 
> Thus add two helpers arch_is_topdown_slots()/arch_is_topdown_metrics()
> to detect whether an event is topdown slots/metrics event by comparing
> the event config directly, and use these two helpers to replace the
> original event name comparisons.

Looks ok, I made a comment below, please take a look
 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/evlist.c  |  8 ++---
>  tools/perf/arch/x86/util/evsel.c   |  3 +-
>  tools/perf/arch/x86/util/topdown.c | 48 +++++++++++++++++++++++++++++-
>  tools/perf/arch/x86/util/topdown.h |  2 ++
>  4 files changed, 55 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> index b1ce0c52d88d..332e8907f43e 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -78,14 +78,14 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
>  	if (topdown_sys_has_perf_metrics() &&
>  	    (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_group(rhs))) {
>  		/* Ensure the topdown slots comes first. */
> -		if (strcasestr(lhs->name, "slots") && !strcasestr(lhs->name, "uops_retired.slots"))
> +		if (arch_is_topdown_slots(lhs))
>  			return -1;
> -		if (strcasestr(rhs->name, "slots") && !strcasestr(rhs->name, "uops_retired.slots"))
> +		if (arch_is_topdown_slots(rhs))
>  			return 1;
>  		/* Followed by topdown events. */
> -		if (strcasestr(lhs->name, "topdown") && !strcasestr(rhs->name, "topdown"))
> +		if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
>  			return -1;
> -		if (!strcasestr(lhs->name, "topdown") && strcasestr(rhs->name, "topdown"))
> +		if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
>  			return 1;
>  	}
>  
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> index 090d0f371891..181f2ba0bb2a 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -6,6 +6,7 @@
>  #include "util/pmu.h"
>  #include "util/pmus.h"
>  #include "linux/string.h"
> +#include "topdown.h"
>  #include "evsel.h"
>  #include "util/debug.h"
>  #include "env.h"
> @@ -44,7 +45,7 @@ bool arch_evsel__must_be_in_group(const struct evsel *evsel)
>  	    strcasestr(evsel->name, "uops_retired.slots"))
>  		return false;
>  
> -	return strcasestr(evsel->name, "topdown") || strcasestr(evsel->name, "slots");
> +	return arch_is_topdown_metrics(evsel) || arch_is_topdown_slots(evsel);
>  }
>  
>  int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
> index 3f9a267d4501..49f25d67ed77 100644
> --- a/tools/perf/arch/x86/util/topdown.c
> +++ b/tools/perf/arch/x86/util/topdown.c
> @@ -32,6 +32,52 @@ bool topdown_sys_has_perf_metrics(void)
>  }
>  
>  #define TOPDOWN_SLOTS		0x0400
> +bool arch_is_topdown_slots(const struct evsel *evsel)
> +{
> +	if (evsel->core.attr.config == TOPDOWN_SLOTS)
> +		return true;
> +
> +	return false;
> +}
> +
> +static int compare_topdown_event(void *vstate, struct pmu_event_info *info)
> +{
> +	int *config = vstate;
> +	int event = 0;
> +	int umask = 0;
> +	char *str;
> +
> +	if (!strcasestr(info->name, "topdown"))
> +		return 0;
> +
> +	str = strcasestr(info->str, "event=");
> +	if (str)
> +		sscanf(str, "event=%x", &event);
> +
> +	str = strcasestr(info->str, "umask=");
> +	if (str)
> +		sscanf(str, "umask=%x", &umask);
> +
> +	if (event == 0 && *config == (event | umask << 8))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +bool arch_is_topdown_metrics(const struct evsel *evsel)
> +{
> +	struct perf_pmu *pmu = evsel__find_pmu(evsel);
> +	int config = evsel->core.attr.config;

Humm, can we cache this information? I.e. have some evsel->is_topdown:1
bit to avoid having to traverse all events if we call this multiple
times for the same evsel? 

- Arnaldo

> +	if (!pmu || !pmu->is_core)
> +		return false;
> +
> +	if (perf_pmu__for_each_event(pmu, false, &config,
> +				     compare_topdown_event))
> +		return true;
> +
> +	return false;
> +}
>  
>  /*
>   * Check whether a topdown group supports sample-read.
> @@ -44,7 +90,7 @@ bool arch_topdown_sample_read(struct evsel *leader)
>  	if (!evsel__sys_has_perf_metrics(leader))
>  		return false;
>  
> -	if (leader->core.attr.config == TOPDOWN_SLOTS)
> +	if (arch_is_topdown_slots(leader))
>  		return true;
>  
>  	return false;
> diff --git a/tools/perf/arch/x86/util/topdown.h b/tools/perf/arch/x86/util/topdown.h
> index 46bf9273e572..1bae9b1822d7 100644
> --- a/tools/perf/arch/x86/util/topdown.h
> +++ b/tools/perf/arch/x86/util/topdown.h
> @@ -3,5 +3,7 @@
>  #define _TOPDOWN_H 1
>  
>  bool topdown_sys_has_perf_metrics(void);
> +bool arch_is_topdown_slots(const struct evsel *evsel);
> +bool arch_is_topdown_metrics(const struct evsel *evsel);
>  
>  #endif
> -- 
> 2.40.1
> 
