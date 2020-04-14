From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v8 4/4] perf tools: add support for libpfm4
Date: Tue, 14 Apr 2020 17:21:02 +0200
Message-ID: <20200414152102.GC208694@krava>
References: <20200411074631.9486-1-irogers@google.com>
 <20200411074631.9486-5-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200411074631.9486-5-irogers@google.com>
Sender: netdev-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Igor Lubashev <ilubashe@akamai.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiwei Sun <jiwei.sun@windriver.com>, yuzhouji
List-Id: linux-perf-users.vger.kernel.org

On Sat, Apr 11, 2020 at 12:46:31AM -0700, Ian Rogers wrote:

SNIP

>  TAG_FOLDERS= . ../lib ../include
>  TAG_FILES= ../../include/uapi/linux/perf_event.h
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 965ef017496f..7b64cd34266e 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -18,6 +18,10 @@
>  #include <subcmd/parse-options.h>
>  #include <stdio.h>
>  
> +#ifdef HAVE_LIBPFM
> +#include "util/pfm.h"
> +#endif

so we have the HAVE_LIBPFM you could do the:

#ifdef HAVE_LIBPFM
#else
#endif

in util/pfm.h and add stubs for libpfm_initialize and others
in case HAVE_LIBPFM is not defined.. that clear out all the
#ifdefs in the change


SNIP

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index b6322eb0f423..8b323151f22c 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -313,6 +313,15 @@ static struct test generic_tests[] = {
>  		.desc = "maps__merge_in",
>  		.func = test__maps__merge_in,
>  	},
> +	{
> +		.desc = "Test libpfm4 support",
> +		.func = test__pfm,
> +		.subtest = {
> +			.skip_if_fail	= true,
> +			.get_nr		= test__pfm_subtest_get_nr,
> +			.get_desc	= test__pfm_subtest_get_desc,
> +		}

awesome :)

SNIP

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d23db6755f51..83ad76d3d2be 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2447,9 +2447,15 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
>  		const char *sep = ":";
>  
>  		/* Is there already the separator in the name. */
> +#ifndef HAVE_LIBPFM
>  		if (strchr(name, '/') ||
>  		    strchr(name, ':'))
>  			sep = "";
> +#else
> +		if (strchr(name, '/') ||
> +		    (strchr(name, ':') && !evsel->is_libpfm_event))
> +			sep = "";
> +#endif


  ^^^^^^^^

>  
>  		if (asprintf(&new_name, "%s%su", name, sep) < 0)
>  			return false;
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 53187c501ee8..397d335d5e24 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -76,6 +76,9 @@ struct evsel {
>  	bool			ignore_missing_thread;
>  	bool			forced_leader;
>  	bool			use_uncore_alias;
> +#ifdef HAVE_LIBPFM
> +	bool			is_libpfm_event;
> +#endif

perhaps we could had this one in unconditionaly,
because I think we have some members like that
for aux tracing.. and that would remove the #ifdef
above


SNIP

>  
> +#ifdef HAVE_LIBPFM
> +struct evsel *parse_events__pfm_add_event(int idx, struct perf_event_attr *attr,
> +					char *name, struct perf_pmu *pmu)
> +{
> +	return __add_event(NULL, &idx, attr, false, name, pmu, NULL, false,
> +			   NULL);
> +}
> +#endif

could you instead add parse_events__add_event and call it from pfm code?

SNIP

> +		pmu = perf_pmu__find_by_type((unsigned int)attr.type);
> +		evsel = parse_events__pfm_add_event(evlist->core.nr_entries,
> +						&attr, q, pmu);
> +		if (evsel == NULL)
> +			goto error;
> +
> +		evsel->is_libpfm_event = true;
> +
> +		evlist__add(evlist, evsel);
> +
> +		if (grp_evt == 0)
> +			grp_leader = evsel;
> +
> +		if (grp_evt > -1) {
> +			evsel->leader = grp_leader;
> +			grp_leader->core.nr_members++;
> +			grp_evt++;
> +		}
> +
> +		if (*sep == '}') {
> +			if (grp_evt < 0) {
> +				ui__error("cannot close a non-existing event group\n");
> +				goto error;
> +			}
> +			evlist->nr_groups++;
> +			grp_leader = NULL;
> +			grp_evt = -1;
> +		}
> +		evsel->is_libpfm_event = true;

seems to be set twice in here


> +	}
> +	return 0;
> +error:
> +	free(p_orig);
> +	return -1;
> +}
> +
> +static const char *srcs[PFM_ATTR_CTRL_MAX] = {
> +	[PFM_ATTR_CTRL_UNKNOWN] = "???",
> +	[PFM_ATTR_CTRL_PMU] = "PMU",
> +	[PFM_ATTR_CTRL_PERF_EVENT] = "perf_event",
> +};

SNIP

thanks,
jirka
