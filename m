From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf record/stat: Explicitly call out event modifiers in
 the documentation
Date: Thu, 3 Sep 2020 16:01:01 -0300
Message-ID: <20200903190101.GH3495158@kernel.org>
References: <20200901215853.276234-1-kim.phillips@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200901215853.276234-1-kim.phillips@amd.com>
Sender: stable-owner@vger.kernel.org
To: Kim Phillips <kim.phillips@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Stephane Eranian <eranian@google.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Tony Jones <tonyj@suse.de>, Jin Yao <yao.jin@linux.intel.com>, Ian Rogers <irogers@google.com>, "Paul A. Clarke" <pc@us.ibm.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Sep 01, 2020 at 04:58:53PM -0500, Kim Phillips escreveu:
> Event modifiers are not mentioned in the perf record or perf stat
> manpages.  Add them to orient new users more effectively by pointing
> them to the perf list manpage for details.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> Fixes: 2055fdaf8703 ("perf list: Document precise event sampling for AMD IBS")
> Cc: Peter Zijlstra <peterz@infradead.org> 
> Cc: Ingo Molnar <mingo@redhat.com> 
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org> 
> Cc: Mark Rutland <mark.rutland@arm.com> 
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com> 
> Cc: Jiri Olsa <jolsa@redhat.com> 
> Cc: Namhyung Kim <namhyung@kernel.org> 
> Cc: Adrian Hunter <adrian.hunter@intel.com> 
> Cc: Stephane Eranian <eranian@google.com> 
> Cc: Alexey Budankov <alexey.budankov@linux.intel.com> 
> Cc: Tony Jones <tonyj@suse.de> 
> Cc: Jin Yao <yao.jin@linux.intel.com> 
> Cc: Ian Rogers <irogers@google.com> 
> Cc: "Paul A. Clarke" <pc@us.ibm.com> 
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>  tools/perf/Documentation/perf-record.txt | 4 ++++
>  tools/perf/Documentation/perf-stat.txt   | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 3f72d8e261f3..bd50cdff08a8 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -33,6 +33,10 @@ OPTIONS
>          - a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a
>  	  hexadecimal event descriptor.
>  
> +        - a symbolic or raw PMU event followed by an optional colon
> +	  and a list of event modifiers, e.g., cpu-cycles:p.  See the
> +	  linkperf:perf-list[1] man page for details on event modifiers.
> +
>  	- a symbolically formed PMU event like 'pmu/param1=0x3,param2/' where
>  	  'param1', 'param2', etc are defined as formats for the PMU in
>  	  /sys/bus/event_source/devices/<pmu>/format/*.
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index c9bfefc051fb..a4b1d11fefc8 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -39,6 +39,10 @@ report::
>  	- a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a
>  	  hexadecimal event descriptor.
>  
> +        - a symbolic or raw PMU event followed by an optional colon
> +	  and a list of event modifiers, e.g., cpu-cycles:p.  See the
> +	  linkperf:perf-list[1] man page for details on event modifiers.
> +
>  	- a symbolically formed event like 'pmu/param1=0x3,param2/' where
>  	  param1 and param2 are defined as formats for the PMU in
>  	  /sys/bus/event_source/devices/<pmu>/format/*
> -- 
> 2.27.0
> 

-- 

- Arnaldo
