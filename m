From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2] perf record: add dummy event during system wide
 synthesis
Date: Wed, 22 Apr 2020 10:46:35 +0200
Message-ID: <20200422084635.GF962614@krava>
References: <20200421061103.109440-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200421061103.109440-1-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Apr 20, 2020 at 11:11:03PM -0700, Ian Rogers wrote:
> During the processing of /proc during event synthesis new processes may
> start. Add a dummy event if /proc is to be processed, to capture mmaps
> for starting processes. This reuses the existing logic for
> initial-delay.
> 
> v2 fixes the dummy event configuration and a branch stack issue.

heya,
it's breaking attr tests for me:

[jolsa@krava perf]$ sudo ./perf test -v 17
17: Setup struct perf_event_attr                          :
--- start ---
test child forked, pid 1046560
running './tests/attr/test-record-graph-default'
running './tests/attr/test-record-raw'
running './tests/attr/test-record-branch-filter-any'
running './tests/attr/test-record-freq'
running './tests/attr/test-record-branch-any'
running './tests/attr/test-stat-group1'
running './tests/attr/test-record-no-samples'
running './tests/attr/test-record-graph-dwarf'
running './tests/attr/test-stat-C0'
running './tests/attr/test-stat-basic'
running './tests/attr/test-record-group'
running './tests/attr/test-record-branch-filter-k'
running './tests/attr/test-stat-group'
running './tests/attr/test-record-C0'
expected config=0, got 9
expected sample_type=391, got 455
expected disabled=1, got 0
FAILED './tests/attr/test-record-C0' - match failure
test child finished with -1
---- end ----
Setup struct perf_event_attr: FAILED!

jirka

> 
> Suggested-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-record.c | 19 ++++++++++++++-----
>  tools/perf/util/evsel.c     |  5 ++++-
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 1ab349abe904..8d1e93351298 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -805,19 +805,28 @@ static int record__open(struct record *rec)
>  	int rc = 0;
>  
>  	/*
> -	 * For initial_delay we need to add a dummy event so that we can track
> -	 * PERF_RECORD_MMAP while we wait for the initial delay to enable the
> -	 * real events, the ones asked by the user.
> +	 * For initial_delay or system wide, we need to add a dummy event so
> +	 * that we can track PERF_RECORD_MMAP to cover the delay of waiting or
> +	 * event synthesis.
>  	 */
> -	if (opts->initial_delay) {
> +	if (opts->initial_delay || target__has_cpu(&opts->target)) {
>  		if (perf_evlist__add_dummy(evlist))
>  			return -ENOMEM;
>  
> +		/* Disable tracking of mmaps on lead event. */
>  		pos = evlist__first(evlist);
>  		pos->tracking = 0;
> +		/* Set up dummy event. */
>  		pos = evlist__last(evlist);
>  		pos->tracking = 1;
> -		pos->core.attr.enable_on_exec = 1;
> +		/*
> +		 * Enable the dummy event when the process is forked for
> +		 * initial_delay, immediately for system wide.
> +		 */
> +		if (opts->initial_delay)
> +			pos->core.attr.enable_on_exec = 1;
> +		else
> +			pos->immediate = 1;
>  	}
>  
>  	perf_evlist__config(evlist, opts, &callchain_param);
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 6a571d322bb2..ca8f9533d8f9 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1163,11 +1163,14 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
>  	}
>  
>  	/*
> +	 * A dummy event never triggers any actual counter and therefore
> +	 * cannot be used with branch_stack.
> +	 *
>  	 * For initial_delay, a dummy event is added implicitly.
>  	 * The software event will trigger -EOPNOTSUPP error out,
>  	 * if BRANCH_STACK bit is set.
>  	 */
> -	if (opts->initial_delay && is_dummy_event(evsel))
> +	if (is_dummy_event(evsel))
>  		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
>  }
>  
> -- 
> 2.26.1.301.g55bc3eb7cb9-goog
> 
