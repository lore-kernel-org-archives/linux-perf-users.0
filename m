From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 2/4] perf, tools: Implement duration_time as a proper
 event
Date: Wed, 27 Mar 2019 09:58:13 +0100
Message-ID: <20190327085813.GB24156@krava>
References: <20190326221823.11518-1-andi@firstfloor.org>
 <20190326221823.11518-3-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190326221823.11518-3-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Tue, Mar 26, 2019 at 03:18:21PM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The perf metric expression use duration_time internally to normalize
> events. Normal perf stat without -x also prints the duration time.
> But when using -x, the interval is not output anywhere, which
> is inconvenient for any post processing which often wants to
> normalize values to time.
> 
> So implement duration_time as a proper perf event that
> can be specified explicitely with -e.
> 
> The previous implementation of duration_time only worked
> for metric processing. This adds the concept of a tool
> event that is handled by the tool. On the kernel level
> it is still mapped to the dummy software event, but the
> values are not read anymore, but instead computed by the tool.
> 
> Add proper plumbing to handle this in the event parser,
> and display it in perf stat. We don't want duration_time to be added up,
> so it's only printed for the first CPU.
> 
> % perf stat -e duration_time,cycles true
> 
>  Performance counter stats for 'true':
> 
>            555,476 ns   duration_time
>            771,958      cycles
> 
>        0.000555476 seconds time elapsed
> 
>        0.000644000 seconds user
>        0.000000000 seconds sys
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/builtin-stat.c      | 28 ++++++++++++++++++-------
>  tools/perf/util/evsel.h        |  6 ++++++
>  tools/perf/util/parse-events.c | 38 +++++++++++++++++++++++++++++-----
>  tools/perf/util/parse-events.h |  4 ++++
>  tools/perf/util/parse-events.l | 11 +++++++++-
>  tools/perf/util/parse-events.y | 12 +++++++++++
>  6 files changed, 86 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 49ee3c2033ec..7f9c4b7f5d69 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -244,11 +244,25 @@ perf_evsel__write_stat_event(struct perf_evsel *counter, u32 cpu, u32 thread,
>  					   process_synthesized_event, NULL);
>  }
>  
> +static int read_single_counter(struct perf_evsel *counter, int cpu,
> +			       int thread, struct timespec *rs)
> +{
> +	if (counter->tool_event == PERF_TOOL_DURATION_TIME) {
> +		u64 val = rs->tv_nsec + rs->tv_sec*1000000000ULL;
> +		struct perf_counts_values *count =
> +			perf_counts(counter->counts, cpu, thread);
> +		count->ena = count->run = val;
> +		count->val = val;
> +		return 0;
> +	}
> +	return perf_evsel__read_counter(counter, cpu, thread);
> +}

so now that we have time in a separate event, we could
get rid of the isolated update_stats(&walltime_nsecs_stats) calls
and move them to perf_stat__update_shadow_stats?

jirka
