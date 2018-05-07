From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 05/12] perf pmu: Fix pmu events parsing rule
Date: Mon, 7 May 2018 21:42:31 +0200
Message-ID: <20180507194231.GA6087@krava>
References: <20180425160008.3407-1-acme@kernel.org>
 <20180425160008.3407-6-acme@kernel.org>
 <448c4e21-8232-3d04-cac4-49b95c8bca3a@intel.com>
 <20180503103717.GA14776@krava>
 <0c33d3f9-4b76-c94c-7306-e93e8cd8d4aa@intel.com>
 <20180504160228.GA25229@krava>
 <87a7tdphyo.fsf@linux.intel.com>
 <20180507183749.GA2095@redhat.com>
 <20180507192408.GD13491@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180507192408.GD13491@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, kan.liang@linux.intel.com
List-Id: linux-perf-users.vger.kernel.org

On Mon, May 07, 2018 at 04:24:08PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, May 07, 2018 at 03:37:49PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Sat, May 05, 2018 at 08:43:11PM -0700, Andi Kleen escreveu:
> > > Jiri Olsa <jolsa@redhat.com> writes:
> > > 
> > > Please fix this quickly, PT is currently totally non functional in Linus
> > > mainline.
> > 
> > Ok, so I'm reverting this patch, the previous situation was just a
> > misleading error message, so it can wait for the discussion about the
> > parser fixes to come to a conclusion and a proper patch to be submitted.
> 
> ... and I'm adding this to my perf/core branch, so that we notice this
> faster in the future:

sry, overlooked this one.. good idea, looks ok to me, ack

jirka

> 
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 18b06444f230..6829dd416a99 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -1309,6 +1309,14 @@ static int test__checkevent_config_cache(struct perf_evlist *evlist)
>  	return 0;
>  }
>  
> +static int test__intel_pt(struct perf_evlist *evlist)
> +{
> +	struct perf_evsel *evsel = perf_evlist__first(evlist);
> +
> +	TEST_ASSERT_VAL("wrong name setting", strcmp(evsel->name, "intel_pt//u") == 0);
> +	return 0;
> +}
> +
>  static int count_tracepoints(void)
>  {
>  	struct dirent *events_ent;
> @@ -1637,6 +1645,11 @@ static struct evlist_test test__events[] = {
>  		.check = test__checkevent_config_cache,
>  		.id    = 51,
>  	},
> +	{
> +		.name  = "intel_pt//u",
> +		.check = test__intel_pt,
> +		.id    = 52,
> +	},
>  };
>  
>  static struct evlist_test test__events_pmu[] = {
