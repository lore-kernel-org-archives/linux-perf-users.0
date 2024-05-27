Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A1A160787;
	Mon, 27 May 2024 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716829494; cv=none; b=e2R4OY4KHWtO8nHYfBO4FGarGi+/+30noOoC95fTK0mBj+6PqBEBd1LWg0IGlwJM//Qq3X6AR2ociT1sdo0Cj8v5+ZcHDZPUmrGP9AgbcN0d9Bmfd5Tjf4qAgJfhD++2F5mlig2dWjnDiSpIUGhgJye5aE9Yb5Hw9DnwKqRsVSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716829494; c=relaxed/simple;
	bh=Ss96GuXy17v7Th+HNM1BpRAXEUSk/pcAonNE3D3kaZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWxE0+YfiZQf/cK+7DhgRxSS7Lxc/cMxp7QnNVrv2pKyQ+aA/RACWvxDhk4DUQ5vFsLMEVYOHyvzp9p8zRjgE61kIgKhtCox2wfJMw+yfp2Hm7CoA5k5iIuM2y4slq2pBr5ih1V3ixHum+A/IY0oZtqKHXATWzEhGhIZySrALtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GncH9LIh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GncH9LIh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0CAC2BBFC;
	Mon, 27 May 2024 17:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716829494;
	bh=Ss96GuXy17v7Th+HNM1BpRAXEUSk/pcAonNE3D3kaZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GncH9LIhVMuBXkdZI8ut7QZTK0zxcl9o5ju1sEqnvvUoPfx9XGha0V5R/BIbph6pM
	 Mmtx5XEi0gzLQATWJuyQDZnMGxx3v1aZqRvrVf66Wbi21vB73GNbLU0CBj6+JAS7fV
	 acJht0baNC4wwFbkicKbErtGFoaU+m8OUfM3waZZTS4m0L6LzdoVnOvXwuU0uLPSah
	 KyWaZYhP24YK2v5hcGDnC9IIgTiLNWWZEoIk0huDTN+bj/sYOKEDzRjfR8K7BE/G+a
	 ieiuMeu33VZAsJ98Zbm+vF+BGaUM96p0WDGBc/QOmCfBFsji1DuuVsJDYKyNkhb+l3
	 oAfA1YkB3s9KA==
Date: Mon, 27 May 2024 14:04:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Artem Savkov <asavkov@redhat.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: add a shortcut for metrics
Message-ID: <ZlS9M1vcxZ3Qsx_B@x1>
References: <20240527101519.356342-1-asavkov@redhat.com>
 <ZlS8pc39t2c1WFye@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlS8pc39t2c1WFye@x1>

On Mon, May 27, 2024 at 02:02:33PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, May 27, 2024 at 12:15:19PM +0200, Artem Savkov wrote:
> > Add -M/--metrics option to perf-record providing a shortcut to record
> > metrics and metricgroups. This option mirrors the one in perf-stat.
> > 
> > Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Signed-off-by: Artem Savkov <asavkov@redhat.com>
> 
> Not building for me, I needed to add the rblist.h header and also I
> think we need to use metricgroup__rblist_init(&mevents), right?

Argh, that is a static function, it seems we trigger it by having
nr_entries = 0, so the following should do the trick:

  struct rblist mevents = { .nr_entries = 0, }

So that we don't depend on the compiler zeroing that field, which for
local variables it should not.

- Arnaldo
 
> Testing it now.
> 
> - Arnaldo
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 18da3ce380152ad1..5d67b0711c166fae 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -27,6 +27,7 @@
>  #include "util/session.h"
>  #include "util/tool.h"
>  #include "util/symbol.h"
> +#include "util/rblist.h"
>  #include "util/record.h"
>  #include "util/cpumap.h"
>  #include "util/thread_map.h"
> @@ -4017,6 +4018,7 @@ int cmd_record(int argc, const char **argv)
>  	set_nobuild('\0', "off-cpu", "no BUILD_BPF_SKEL=1", true);
>  # undef set_nobuild
>  #endif
> +	metricgroup__rblist_init(&mevents);
>  
>  	/* Disable eager loading of kernel symbols that adds overhead to perf record. */
>  	symbol_conf.lazy_load_kernel_maps = true;
> 
> > ---
> >  tools/perf/Documentation/perf-record.txt |  7 +++-
> >  tools/perf/builtin-record.c              | 43 ++++++++++++++++++++++++
> >  2 files changed, 49 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> > index 6015fdd08fb63..ebb560d137e62 100644
> > --- a/tools/perf/Documentation/perf-record.txt
> > +++ b/tools/perf/Documentation/perf-record.txt
> > @@ -18,7 +18,6 @@ from it, into perf.data - without displaying anything.
> >  
> >  This file can then be inspected later on, using 'perf report'.
> >  
> > -
> >  OPTIONS
> >  -------
> >  <command>...::
> > @@ -216,6 +215,12 @@ OPTIONS
> >  	  na, by_data, by_addr (for mem_blk)
> >  	  hops0, hops1, hops2, hops3 (for mem_hops)
> >  
> > +-M::
> > +--metrics::
> > +Record metrics or metricgroups specified in a comma separated list.
> > +For a group all metrics from the group are added.
> > +See perf list output for the possible metrics and metricgroups.
> > +
> >  --exclude-perf::
> >  	Don't record events issued by perf itself. This option should follow
> >  	an event selector (-e) which selects tracepoint event(s). It adds a
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 66a3de8ac6618..5828051ff2736 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -40,6 +40,7 @@
> >  #include "util/trigger.h"
> >  #include "util/perf-hooks.h"
> >  #include "util/cpu-set-sched.h"
> > +#include "util/metricgroup.h"
> >  #include "util/synthetic-events.h"
> >  #include "util/time-utils.h"
> >  #include "util/units.h"
> > @@ -188,6 +189,7 @@ static volatile int done;
> >  static volatile int auxtrace_record__snapshot_started;
> >  static DEFINE_TRIGGER(auxtrace_snapshot_trigger);
> >  static DEFINE_TRIGGER(switch_output_trigger);
> > +static char *metrics;
> >  
> >  static const char *affinity_tags[PERF_AFFINITY_MAX] = {
> >  	"SYS", "NODE", "CPU"
> > @@ -200,6 +202,25 @@ static inline pid_t gettid(void)
> >  }
> >  #endif
> >  
> > +static int append_metric_groups(const struct option *opt __maybe_unused,
> > +			       const char *str,
> > +			       int unset __maybe_unused)
> > +{
> > +	if (metrics) {
> > +		char *tmp;
> > +
> > +		if (asprintf(&tmp, "%s,%s", metrics, str) < 0)
> > +			return -ENOMEM;
> > +		free(metrics);
> > +		metrics = tmp;
> > +	} else {
> > +		metrics = strdup(str);
> > +		if (!metrics)
> > +			return -ENOMEM;
> > +	}
> > +	return 0;
> > +}
> > +
> >  static int record__threads_enabled(struct record *rec)
> >  {
> >  	return rec->opts.threads_spec;
> > @@ -3382,6 +3403,9 @@ static struct option __record_options[] = {
> >  		     parse_events_option),
> >  	OPT_CALLBACK(0, "filter", &record.evlist, "filter",
> >  		     "event filter", parse_filter),
> > +	OPT_CALLBACK('M', "metrics", &record.evlist, "metric/metric group list",
> > +		     "monitor specified metrics or metric groups (separated by ,)",
> > +		     append_metric_groups),
> >  	OPT_CALLBACK_NOOPT(0, "exclude-perf", &record.evlist,
> >  			   NULL, "don't record events from perf itself",
> >  			   exclude_perf),
> > @@ -3984,6 +4008,7 @@ int cmd_record(int argc, const char **argv)
> >  	int err;
> >  	struct record *rec = &record;
> >  	char errbuf[BUFSIZ];
> > +	struct rblist mevents;
> >  
> >  	setlocale(LC_ALL, "");
> >  
> > @@ -4153,6 +4178,23 @@ int cmd_record(int argc, const char **argv)
> >  	if (record.opts.overwrite)
> >  		record.opts.tail_synthesize = true;
> >  
> > +	if (metrics) {
> > +		const char *pmu = parse_events_option_args.pmu_filter ?: "all";
> > +		int ret = metricgroup__parse_groups(rec->evlist, pmu, metrics,
> > +						false, /* metric_no_group */
> > +						false, /* metric_no_merge */
> > +						false, /* metric_no_threshold */
> > +						rec->opts.target.cpu_list,
> > +						rec->opts.target.system_wide,
> > +						false, /* hardware_aware_grouping */
> > +						&mevents);
> > +		if (ret) {
> > +			err = ret;
> > +			goto out;
> > +		}
> > +		zfree(&metrics);
> > +	}
> > +
> >  	if (rec->evlist->core.nr_entries == 0) {
> >  		bool can_profile_kernel = perf_event_paranoid_check(1);
> >  
> > @@ -4264,6 +4306,7 @@ int cmd_record(int argc, const char **argv)
> >  out_opts:
> >  	record__free_thread_masks(rec, rec->nr_threads);
> >  	rec->nr_threads = 0;
> > +	metricgroup__rblist_exit(&mevents);
> >  	evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &rec->opts.ctl_fd_close);
> >  	return err;
> >  }
> > -- 
> > 2.45.1
