Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F0C30FF21;
	Thu, 22 Jan 2026 00:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769043261; cv=none; b=tLqdTyPC1NXvOQhSJM+L3AeBSO201jdbyGj8SSiG/KlFUar6k0RULN+do1ktBiIxf29kQkdTzkJjtY0gSLtfrGi0KybzgA/aFkcmoAjIUoPkv287o1MXga07O1fWEa7xfbvEtOgGXTssZY+t0tC5NSf4hPEkbCE3BJtFUx9m+so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769043261; c=relaxed/simple;
	bh=L5Ya50Ajdy86v6DKEtidwIV8uBPJQFlNTl2aPPROjYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gS0uN0mb57D99Y7qJHLQKvg7grPgJG4qDsO6ERfPJ4pViFnrb7cU2v9tBZdTWb0mz0Hv3TJWJgy6YvEmH5IZdmkQPh9V8Ttvo8YNufGpyJ6QA3UzKIH6CecFuIVGmPbVyIdoqAER4Ypmw1wz7RrzE3H1uKiSu/O0FZl2M5cgiBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+zMp07y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+zMp07y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E39C4CEF1;
	Thu, 22 Jan 2026 00:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769043260;
	bh=L5Ya50Ajdy86v6DKEtidwIV8uBPJQFlNTl2aPPROjYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b+zMp07ysMrcGK8iKewBPw7XJygS/KR90a0FI8h7H7K4vSLkSzkT19uZhZGlI58DS
	 NNmexS2k8iyZ7qLs4hJSzjyfpxD9UsmDe1nCKTxHwjEeOu1cfaHHisXDfyZS1RmpSH
	 JUYOYAU6euCxxahFFS9697+cCiZyK30QhtE7qxVpgMd+Y+LAf9RTQ9Fik70nYa2sea
	 tr7XbruriADXxyF13KxFYuiMKNjXm3CoJxHmTk5k0CjZkj450QghTyUQ/Zx2P8ZdfB
	 UuilKdir8X3IoxHfSa8HQCNdbt5Y3xnTDZLrmT8ukXjMxFEhPxnilrfkq8sHNHYlea
	 2zH12cg+e9HXQ==
Date: Wed, 21 Jan 2026 21:54:16 -0300
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
Message-ID: <aXF1OECUByl0kgCF@x1>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
 <20260119175833.340369-8-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119175833.340369-8-swapnil.sapkal@amd.com>

On Mon, Jan 19, 2026 at 05:58:29PM +0000, Swapnil Sapkal wrote:
> The live mode works similar to simple `perf stat` command, by profiling
> the target and printing results on the terminal as soon as the target
> finishes.
> 
> Example usage:
> 
>   # perf sched stats -- true
>   Description
>   ----------------------------------------------------------------------------------------------------
>   DESC                          -> Description of the field
>   COUNT                         -> Value of the field
>   PCT_CHANGE                    -> Percent change with corresponding base value
>   AVG_JIFFIES                   -> Avg time in jiffies between two consecutive occurrence of event
>   ----------------------------------------------------------------------------------------------------
> 
>   Time elapsed (in jiffies)                                        :           1
>   ----------------------------------------------------------------------------------------------------
>   CPU: <ALL CPUS SUMMARY>
>   ----------------------------------------------------------------------------------------------------
>   DESC                                                                     COUNT   PCT_CHANGE
>   ----------------------------------------------------------------------------------------------------
>   yld_count                                                        :           0
>   array_exp                                                        :           0
>   sched_count                                                      :           0
>   sched_goidle                                                     :           0  (     0.00% )
>   ttwu_count                                                       :           0
>   ttwu_local                                                       :           0  (     0.00% )
>   rq_cpu_time                                                      :       27875
>   run_delay                                                        :           0  (     0.00% )
>   pcount                                                           :           0
>   ----------------------------------------------------------------------------------------------------
>   CPU: <ALL CPUS SUMMARY> | DOMAIN: SMT
>   ----------------------------------------------------------------------------------------------------
>   DESC                                                                     COUNT    AVG_JIFFIES
>   ----------------------------------------- <Category busy> ------------------------------------------
>   busy_lb_count                                                    :           0  $        0.00 $
>   busy_lb_balanced                                                 :           0  $        0.00 $
>   busy_lb_failed                                                   :           0  $        0.00 $
>   busy_lb_imbalance_load                                           :           0
>   busy_lb_imbalance_util                                           :           0
>   busy_lb_imbalance_task                                           :           0
>   busy_lb_imbalance_misfit                                         :           0
>   busy_lb_gained                                                   :           0
>   busy_lb_hot_gained                                               :           0
>   busy_lb_nobusyq                                                  :           0  $        0.00 $
>   busy_lb_nobusyg                                                  :           0  $        0.00 $
>   *busy_lb_success_count                                           :           0
>   *busy_lb_avg_pulled                                              :        0.00
> 
>   ... and so on. Output will show similar data for all the cpus in the
> system.
> 
> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Tested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> ---
>  tools/perf/builtin-sched.c | 99 +++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/header.c   |  3 +-
>  tools/perf/util/header.h   |  3 ++
>  3 files changed, 102 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index c6b054b9b12a..8993308439bc 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -4426,6 +4426,103 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
>  	return err;
>  }
>  
> +static int process_synthesized_event_live(const struct perf_tool *tool __maybe_unused,
> +					  union perf_event *event,
> +					  struct perf_sample *sample __maybe_unused,
> +					  struct machine *machine __maybe_unused)
> +{
> +	return perf_sched__process_schedstat(tool, NULL, event);
> +}
> +
> +static int perf_sched__schedstat_live(struct perf_sched *sched,
> +				      int argc, const char **argv)
> +{
> +	struct cpu_domain_map **cd_map = NULL;
> +	struct target target = {};
> +	u32 __maybe_unused md;
> +	struct evlist *evlist;
> +	u32 nr = 0, sv;
> +	int reset = 0;
> +	int err = 0;
> +
> +	signal(SIGINT, sighandler);
> +	signal(SIGCHLD, sighandler);
> +	signal(SIGTERM, sighandler);
> +
> +	evlist = evlist__new();
> +	if (!evlist)
> +		return -ENOMEM;
> +
> +	/*
> +	 * `perf sched schedstat` does not support workload profiling (-p pid)
> +	 * since /proc/schedstat file contains cpu specific data only. Hence, a
> +	 * profile target is either set of cpus or systemwide, never a process.
> +	 * Note that, although `-- <workload>` is supported, profile data are
> +	 * still cpu/systemwide.
> +	 */
> +	if (cpu_list)
> +		target.cpu_list = cpu_list;
> +	else
> +		target.system_wide = true;
> +
> +	if (argc) {
> +		err = evlist__prepare_workload(evlist, &target, argv, false, NULL);
> +		if (err)
> +			goto out;
> +	}
> +
> +	err = evlist__create_maps(evlist, &target);
> +	if (err < 0)
> +		goto out;
> +
> +	user_requested_cpus = evlist->core.user_requested_cpus;
> +
> +	err = perf_event__synthesize_schedstat(&(sched->tool),
> +					       process_synthesized_event_live,
> +					       user_requested_cpus);
> +	if (err < 0)
> +		goto out;
> +
> +	err = enable_sched_schedstats(&reset);
> +	if (err < 0)
> +		goto out;
> +
> +	if (argc)
> +		evlist__start_workload(evlist);
> +
> +	/* wait for signal */
> +	pause();
> +
> +	if (reset) {
> +		err = disable_sched_schedstat();
> +		if (err < 0)
> +			goto out;
> +	}
> +
> +	err = perf_event__synthesize_schedstat(&(sched->tool),
> +					       process_synthesized_event_live,
> +					       user_requested_cpus);
> +	if (err)
> +		goto out;
> +
> +	setup_pager();
> +
> +	if (list_empty(&cpu_head)) {
> +		pr_err("Data is not available\n");
> +		err = -1;
> +		goto out;
> +	}
> +
> +	nr = cpu__max_present_cpu().cpu;
> +	cd_map = build_cpu_domain_map(&sv, &md, nr);
> +	show_schedstat_data(&cpu_head, cd_map);
> +out:

With clang on almalinux 10:

+ make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= -C tools/perf O=/tmp/build/perf CC=clang
make: Entering directory '/git/perf-6.19.0-rc4/tools/perf'
  GEN     /tmp/build/perf/pmu-events/arch/powerpc/power8/memory.json
builtin-sched.c:4709:6: error: variable 'sv' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
 4709 |         if (list_empty(&cpu_head)) {
      |             ^~~~~~~~~~~~~~~~~~~~~
  GEN     /tmp/build/perf/pmu-events/arch/powerpc/power8/metrics.json
  GEN     /tmp/build/perf/pmu-events/arch/powerpc/power8/other.json
  CC      /tmp/build/perf/tests/kmod-path.o
builtin-sched.c:4719:31: note: uninitialized use occurs here
  GEN     /tmp/build/perf/pmu-events/arch/powerpc/power8/pipeline.json
 4719 |         free_cpu_domain_info(cd_map, sv, nr);
      |                                      ^~

But then it doesn't build on 32-bit arches with:

    20.64 almalinux:9-i386              : FAIL gcc version 11.4.1 20231218 (Red Hat 11.4.1-3) (GCC)
          |                             ^~~
    /tmp/build/perf/libperf/include/perf/schedstat-v15.h:4:1: note: in expansion of macro ‘CPU_FIELD’
        4 | CPU_FIELD(__u32, yld_count, "sched_yield() count",
          | ^~~~~~~~~
    In file included from util/event.c:3:
    /usr/include/inttypes.h:105:41: note: format string is defined here
      105 | # define PRIu64         __PRI64_PREFIX "u"
    util/event.c:583:29: error: format ‘%llu’ expects argument of type ‘long long unsigned int’, but argument 3 has type ‘long unsigned int’ [-Werror=format=]
      583 |         size += fprintf(fp, "%" PRIu64 " ", (unsigned long)cs->_ver._name)
          |                             ^~~
    /tmp/build/perf/libperf/include/perf/schedstat-v15.h:6:1: note: in expansion of macro ‘CPU_FIELD’
        6 | CPU_FIELD(__u32, array_exp, "Legacy counter can be ignored",
          | ^~~~~~~~~
    In file included from util/event.c:3:
    /usr/include/inttypes.h:105:41: note: format string is defined here
      105 | # define PRIu64         __PRI64_PREFIX "u"
    util/event.c:583:29: error: format ‘%llu’ expects argument of type ‘long long unsigned int’, but argument 3 has type ‘long unsigned int’ [-Werror=format=]
      583 |         size += fprintf(fp, "%" PRIu64 " ", (unsigned long)cs->_ver._name)
          |                             ^~~
    /tmp/build/perf/libperf/include/perf/schedstat-v15.h:8:1: note: in expansion of macro ‘CPU_FIELD’
        8 | CPU_FIELD(__u32, sched_count, "schedule() called",


So continuing to test build up to:

⬢ [acme@toolbx perf-tools-next]$ git log --oneline -5
139b45df27c05531 (HEAD -> perf-tools-next) perf sched stats: Add schedstat v17 support
e092c5d4541da7f0 perf sched stats: Add schedstat v16 support
e659d5e11000b7ff perf sched stats: Add record and rawdump support
900884770020691c perf header: Support CPU DOMAIN relation info
a02829a0e6c65b12 tools/lib: Add list_is_first()
⬢ [acme@toolbx perf-tools-next]$

- Arnaldo

> +	free_cpu_domain_info(cd_map, sv, nr);
> +	free_schedstat(&cpu_head);
> +	evlist__delete(evlist);
> +	return err;
> +}
> +
>  static bool schedstat_events_exposed(void)
>  {
>  	/*
> @@ -4751,7 +4848,7 @@ int cmd_sched(int argc, const char **argv)
>  						     stats_usage, 0);
>  			return perf_sched__schedstat_report(&sched);
>  		}
> -		usage_with_options(stats_usage, stats_options);
> +		return perf_sched__schedstat_live(&sched, argc, argv);
>  	} else {
>  		usage_with_options(sched_usage, sched_options);
>  	}
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 673d53bb2a2c..9a15dd4b7640 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1614,8 +1614,7 @@ static int write_pmu_caps(struct feat_fd *ff,
>  	return 0;
>  }
>  
> -static struct cpu_domain_map **build_cpu_domain_map(u32 *schedstat_version, u32 *max_sched_domains,
> -						    u32 nr)
> +struct cpu_domain_map **build_cpu_domain_map(u32 *schedstat_version, u32 *max_sched_domains, u32 nr)
>  {
>  	struct domain_info *domain_info;
>  	struct cpu_domain_map **cd_map;
> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> index c62f3275a80f..36cc74e2d14d 100644
> --- a/tools/perf/util/header.h
> +++ b/tools/perf/util/header.h
> @@ -211,4 +211,7 @@ char *get_cpuid_str(struct perf_cpu cpu);
>  char *get_cpuid_allow_env_override(struct perf_cpu cpu);
>  
>  int strcmp_cpuid_str(const char *s1, const char *s2);
> +
> +struct cpu_domain_map **build_cpu_domain_map(u32 *schedstat_version, u32 *max_sched_domains,
> +					     u32 nr);
>  #endif /* __PERF_HEADER_H */
> -- 
> 2.43.0
