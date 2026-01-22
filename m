Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844262D0C63;
	Thu, 22 Jan 2026 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096550; cv=none; b=e42FMxcQwabBiiIy+YCR6Aw0IKBiQugMLbvNYbX1DoQ5+kgePh4aKkQJRJRzByh8kXmhQXseTaE97ogzcS2Nwm7oSDkGcpfmfG6CqNIWFcXuQrXH1uoKBTgJICBLDcHDLTkzCKbYGgeRxPeTjNTx7oVPJI4TI47A9gGUxmHrhuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096550; c=relaxed/simple;
	bh=zhEZL9vJlSbHOjGUJAw9TRT3/BY1VB1weu3W3oa9N4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m16Pr+pJB11wQX48TtGADHxh5cAJm04IIKZtVlQ7GecBdfUjDCVvj6io67RFt1ZDrj7aW6ytE8vznT4p7OH0ziYt+hH/t6Tsva/EtD3/WJxXU7nu2tA8llyc6YzDmvWiwHt73qFxV818lxrZhshshYlVkbZToTy8swgSuCAv2kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCEgC000; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCEgC000"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60996C116C6;
	Thu, 22 Jan 2026 15:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769096550;
	bh=zhEZL9vJlSbHOjGUJAw9TRT3/BY1VB1weu3W3oa9N4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DCEgC0005Jnb+2TvJRUOo20TqBmtwHty6uUy0gQuDBrkA/6KrHJo6Ftbhi7FiL6k6
	 F5WMT3hLi77R0K6CgFTxcJruwiQu8ZnufLspYUeR7ASKRzjXZ4O1JgiXCvjwQcQGA7
	 fwOYIP8Ie+9QZrqsJnuGaA8kt5JPZQSGZIYrJ2AYAWNwtd1hEV5HBIgqA5Mb5CV6ZA
	 PNt6iLZLQcObvje/qUqwXT1Ii3iP8TpPfoi5zPmRPUumCzaD5Uo5gnmibkppyTkWWy
	 HZElzjhZDLsIMcM0y6LFEmgKXvWQXakpw+D0URxl6o3A0dKFmTWblQqhZyrXWyFm6n
	 yGD0z/lr95aqA==
Date: Thu, 22 Jan 2026 12:42:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	irogers@google.com, james.clark@arm.com, ravi.bangoria@amd.com,
	yu.c.chen@intel.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	rostedt@goodmis.org, vincent.guittot@linaro.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	gautham.shenoy@amd.com, kprateek.nayak@amd.com,
	juri.lelli@redhat.com, yangjihong@bytedance.com, void@manifault.com,
	tj@kernel.org, sshegde@linux.ibm.com, ctshao@google.com,
	quic_zhonhan@quicinc.com, thomas.falcon@intel.com,
	blakejones@google.com, ashelat@redhat.com, leo.yan@arm.com,
	dvyukov@google.com, ak@linux.intel.com, yujie.liu@intel.com,
	graham.woodward@arm.com, ben.gainey@arm.com, vineethr@linux.ibm.com,
	tim.c.chen@linux.intel.com, linux@treblig.org,
	santosh.shukla@amd.com, sandipan.das@amd.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v5 07/10] perf sched stats: Add support for live mode
Message-ID: <aXJFYpY8_oL2GMhV@x1>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
 <20260119175833.340369-8-swapnil.sapkal@amd.com>
 <aXF1OECUByl0kgCF@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXF1OECUByl0kgCF@x1>

On Wed, Jan 21, 2026 at 09:54:16PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Jan 19, 2026 at 05:58:29PM +0000, Swapnil Sapkal wrote:
> > The live mode works similar to simple `perf stat` command, by profiling
> > the target and printing results on the terminal as soon as the target
> > finishes.
> > 
> > Example usage:
> > 
> >   # perf sched stats -- true
> >   Description
> >   ----------------------------------------------------------------------------------------------------
> >   DESC                          -> Description of the field
> >   COUNT                         -> Value of the field
> >   PCT_CHANGE                    -> Percent change with corresponding base value
> >   AVG_JIFFIES                   -> Avg time in jiffies between two consecutive occurrence of event
> >   ----------------------------------------------------------------------------------------------------
> > 
> >   Time elapsed (in jiffies)                                        :           1
> >   ----------------------------------------------------------------------------------------------------
> >   CPU: <ALL CPUS SUMMARY>
> >   ----------------------------------------------------------------------------------------------------
> >   DESC                                                                     COUNT   PCT_CHANGE
> >   ----------------------------------------------------------------------------------------------------
> >   yld_count                                                        :           0
> >   array_exp                                                        :           0
> >   sched_count                                                      :           0
> >   sched_goidle                                                     :           0  (     0.00% )
> >   ttwu_count                                                       :           0
> >   ttwu_local                                                       :           0  (     0.00% )
> >   rq_cpu_time                                                      :       27875
> >   run_delay                                                        :           0  (     0.00% )
> >   pcount                                                           :           0
> >   ----------------------------------------------------------------------------------------------------
> >   CPU: <ALL CPUS SUMMARY> | DOMAIN: SMT
> >   ----------------------------------------------------------------------------------------------------
> >   DESC                                                                     COUNT    AVG_JIFFIES
> >   ----------------------------------------- <Category busy> ------------------------------------------
> >   busy_lb_count                                                    :           0  $        0.00 $
> >   busy_lb_balanced                                                 :           0  $        0.00 $
> >   busy_lb_failed                                                   :           0  $        0.00 $
> >   busy_lb_imbalance_load                                           :           0
> >   busy_lb_imbalance_util                                           :           0
> >   busy_lb_imbalance_task                                           :           0
> >   busy_lb_imbalance_misfit                                         :           0
> >   busy_lb_gained                                                   :           0
> >   busy_lb_hot_gained                                               :           0
> >   busy_lb_nobusyq                                                  :           0  $        0.00 $
> >   busy_lb_nobusyg                                                  :           0  $        0.00 $
> >   *busy_lb_success_count                                           :           0
> >   *busy_lb_avg_pulled                                              :        0.00
> > 
> >   ... and so on. Output will show similar data for all the cpus in the
> > system.
> > 
> > Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> > Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> > Tested-by: James Clark <james.clark@linaro.org>
> > Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> > ---
> >  tools/perf/builtin-sched.c | 99 +++++++++++++++++++++++++++++++++++++-
> >  tools/perf/util/header.c   |  3 +-
> >  tools/perf/util/header.h   |  3 ++
> >  3 files changed, 102 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index c6b054b9b12a..8993308439bc 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -4426,6 +4426,103 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
> >  	return err;
> >  }
> >  
> > +static int process_synthesized_event_live(const struct perf_tool *tool __maybe_unused,
> > +					  union perf_event *event,
> > +					  struct perf_sample *sample __maybe_unused,
> > +					  struct machine *machine __maybe_unused)
> > +{
> > +	return perf_sched__process_schedstat(tool, NULL, event);
> > +}
> > +
> > +static int perf_sched__schedstat_live(struct perf_sched *sched,
> > +				      int argc, const char **argv)
> > +{
> > +	struct cpu_domain_map **cd_map = NULL;
> > +	struct target target = {};
> > +	u32 __maybe_unused md;
> > +	struct evlist *evlist;
> > +	u32 nr = 0, sv;
> > +	int reset = 0;
> > +	int err = 0;
> > +
> > +	signal(SIGINT, sighandler);
> > +	signal(SIGCHLD, sighandler);
> > +	signal(SIGTERM, sighandler);
> > +
> > +	evlist = evlist__new();
> > +	if (!evlist)
> > +		return -ENOMEM;
> > +
> > +	/*
> > +	 * `perf sched schedstat` does not support workload profiling (-p pid)
> > +	 * since /proc/schedstat file contains cpu specific data only. Hence, a
> > +	 * profile target is either set of cpus or systemwide, never a process.
> > +	 * Note that, although `-- <workload>` is supported, profile data are
> > +	 * still cpu/systemwide.
> > +	 */
> > +	if (cpu_list)
> > +		target.cpu_list = cpu_list;
> > +	else
> > +		target.system_wide = true;
> > +
> > +	if (argc) {
> > +		err = evlist__prepare_workload(evlist, &target, argv, false, NULL);
> > +		if (err)
> > +			goto out;
> > +	}
> > +
> > +	err = evlist__create_maps(evlist, &target);
> > +	if (err < 0)
> > +		goto out;
> > +
> > +	user_requested_cpus = evlist->core.user_requested_cpus;
> > +
> > +	err = perf_event__synthesize_schedstat(&(sched->tool),
> > +					       process_synthesized_event_live,
> > +					       user_requested_cpus);
> > +	if (err < 0)
> > +		goto out;
> > +
> > +	err = enable_sched_schedstats(&reset);
> > +	if (err < 0)
> > +		goto out;
> > +
> > +	if (argc)
> > +		evlist__start_workload(evlist);
> > +
> > +	/* wait for signal */
> > +	pause();
> > +
> > +	if (reset) {
> > +		err = disable_sched_schedstat();
> > +		if (err < 0)
> > +			goto out;
> > +	}
> > +
> > +	err = perf_event__synthesize_schedstat(&(sched->tool),
> > +					       process_synthesized_event_live,
> > +					       user_requested_cpus);
> > +	if (err)
> > +		goto out;
> > +
> > +	setup_pager();
> > +
> > +	if (list_empty(&cpu_head)) {
> > +		pr_err("Data is not available\n");
> > +		err = -1;
> > +		goto out;
> > +	}
> > +
> > +	nr = cpu__max_present_cpu().cpu;
> > +	cd_map = build_cpu_domain_map(&sv, &md, nr);
> > +	show_schedstat_data(&cpu_head, cd_map);
> > +out:
> 
> With clang on almalinux 10:
> 
> + make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= -C tools/perf O=/tmp/build/perf CC=clang
> make: Entering directory '/git/perf-6.19.0-rc4/tools/perf'
>   GEN     /tmp/build/perf/pmu-events/arch/powerpc/power8/memory.json
> builtin-sched.c:4709:6: error: variable 'sv' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>  4709 |         if (list_empty(&cpu_head)) {
>       |             ^~~~~~~~~~~~~~~~~~~~~
>   GEN     /tmp/build/perf/pmu-events/arch/powerpc/power8/metrics.json
>   GEN     /tmp/build/perf/pmu-events/arch/powerpc/power8/other.json
>   CC      /tmp/build/perf/tests/kmod-path.o
> builtin-sched.c:4719:31: note: uninitialized use occurs here
>   GEN     /tmp/build/perf/pmu-events/arch/powerpc/power8/pipeline.json
>  4719 |         free_cpu_domain_info(cd_map, sv, nr);
>       |                                      ^~
> 

Moving the label does the trick as free_cpu_domain_info() only needs to
be called if build_cpu_domain_map() was called.

- Arnaldo

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 8993308439bc5998..ec9fa29196b24f5a 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4516,8 +4516,8 @@ static int perf_sched__schedstat_live(struct perf_sched *sched,
 	nr = cpu__max_present_cpu().cpu;
 	cd_map = build_cpu_domain_map(&sv, &md, nr);
 	show_schedstat_data(&cpu_head, cd_map);
-out:
 	free_cpu_domain_info(cd_map, sv, nr);
+out:
 	free_schedstat(&cpu_head);
 	evlist__delete(evlist);
 	return err;
