From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 5/7] perf tools: add perf_evlist__terminate() for
 terminate
Date: Mon, 27 Jan 2020 13:31:08 +0100
Message-ID: <20200127123108.GC1114818@krava>
References: <20200123160734.3775-1-james.clark@arm.com>
 <20200123160734.3775-6-james.clark@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200123160734.3775-6-james.clark@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Clark <james.clark@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, suzuki.poulose@arm.com, gengdongjiu@huawei.com, wxf.wang@hisilicon.com, liwei391@huawei.com, liuqi115@hisilicon.com, huawei.libin@huawei.com, nd@arm.com, linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Tan Xiaojun <tanxiaojun@huawei.com>, Al Grant <al.grant@arm.com>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

On Thu, Jan 23, 2020 at 04:07:32PM +0000, James Clark wrote:
> From: Wei Li <liwei391@huawei.com>
> 
> In __cmd_record(), when receiving SIGINT(ctrl + c), a done flag will
> be set and the event list will be disabled by perf_evlist__disable()
> once.
> 
> While in auxtrace_record.read_finish(), the related events will be
> enabled again, if they are continuous, the recording seems to be endless.
> 
> Mark the evlist's state as terminated, preparing for the following fix.
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> Tested-by: Qi Liu <liuqi115@hisilicon.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Tan Xiaojun <tanxiaojun@huawei.com>
> Cc: Al Grant <al.grant@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-record.c |  1 +
>  tools/perf/util/evlist.c    | 14 ++++++++++++++
>  tools/perf/util/evlist.h    |  1 +
>  tools/perf/util/evsel.h     |  1 +
>  4 files changed, 17 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4c301466101b..e7c917f9534d 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1722,6 +1722,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		if (done && !disabled && !target__none(&opts->target)) {
>  			trigger_off(&auxtrace_snapshot_trigger);
>  			evlist__disable(rec->evlist);
> +			evlist__terminate(rec->evlist);
>  			disabled = true;
>  		}
>  	}
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index b9c7e5271611..b04794cd8586 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -377,6 +377,20 @@ bool evsel__cpu_iter_skip(struct evsel *ev, int cpu)
>  	return true;
>  }
>  
> +void evlist__terminate(struct evlist *evlist)
> +{
> +	struct evsel *pos;
> +
> +	evlist__for_each_entry(evlist, pos) {
> +		if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->core.fd)
> +			continue;
> +		evsel__disable(pos);
> +		pos->terminated = true;
> +	}

how is this different from evlist__disable? other than it does not
follow the cpu affinity ;-) can't you just call evlist__disable and
check later on evlist->enabled instead of evlist->terminated?

jirka
