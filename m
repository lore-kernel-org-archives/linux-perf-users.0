From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC V4] perf, tools: Support wildcards on pmu name in dynamic
 pmu events
Date: Thu, 8 Mar 2018 10:03:58 -0300
Message-ID: <20180308130358.GC3701@kernel.org>
References: <1520454947-16977-1-git-send-email-agustinv@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1520454947-16977-1-git-send-email-agustinv@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Andi Kleen <ak@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, timur@codeaurora.org
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Mar 07, 2018 at 03:35:47PM -0500, Agustin Vega-Frias escreveu:
> +++ b/tools/perf/util/parse-events.y
> @@ -8,6 +8,7 @@
> 
>  #define YYDEBUG 1
> 
> +#include <fnmatch.h>
>  #include <linux/compiler.h>
>  #include <linux/list.h>
>  #include <linux/types.h>
> @@ -234,6 +235,10 @@ PE_NAME opt_event_config
>  	if (parse_events_add_pmu(_parse_state, list, $1, $2)) {
>  		struct perf_pmu *pmu = NULL;
>  		int ok = 0;
> +		char *pattern;
> +
> +		if (asprintf(&pattern, "%s*", $1) < 0)
> +			YYABORT;

+               if (asprintf(&pattern, "?(uncore_)%s*", $1) < 0)

I completely overlook that you were using this and thus needed that
extension, duh, thanks for the patience 8-) and for the new patch.

- Arnaldo
