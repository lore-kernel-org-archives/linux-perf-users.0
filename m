Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96778376;
	Sat, 15 Mar 2025 04:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742013972; cv=none; b=cP6GGo5CnVj5uKxpM3Ce62KBuO/elWC+51loYJlWYB041l6McJYkdQBKGbHWm6HYCWVLRZ90s37tluYi4K6J2QABCOMSi+EMlKcf56wVRsto6MKuhc9rEaJp8UrGdmcl1zcZCOIoLBKe3iz2VIGo3UagdTv6dq8CzCQeM2bNZHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742013972; c=relaxed/simple;
	bh=z7iP+K9DJHedpsOd1jCC4SkqUlvgguw3DEY82hCkWnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkPLG/LQpv6IbeZNOimx2yzzY8kdbVWqIiNHpcCO7V8SxBfTER4NiTq1K+ktAG8Dv3QJlVZk84WRvmf37bv/e5BtMx+ooW1POsaOeNM7G8s/kBHGPUZIbpfcruypTlyXSbPsmEEUaOnDmILe4eZir4w1PcG0hQKPQEtzNkfEthI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gb7aXj55; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gb7aXj55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFDAC4CEE5;
	Sat, 15 Mar 2025 04:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742013972;
	bh=z7iP+K9DJHedpsOd1jCC4SkqUlvgguw3DEY82hCkWnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gb7aXj558TTdn9u9OF2IVpgaGT35NT8njJa0Hql6PShFxp/8FBijw2lSGOjCRMOFm
	 /QGH5nFrb3/5Kp6CIqqvlm2Y0357BwZ/9TZLwxXIeQzy2seAA45AUIhV9g/YArfNoF
	 auLs3naJw/O4jqYwY+wlk512e2iySnpmACCxJD1TxLi1ygqXvMYj/Edic96uLAdTpK
	 g77PupOoh0KN0NfwT73yZdHxzXj3psJluLohTX16zTxczxElLvWBx4IGDBeorKMlma
	 daLiyfZNcGeig9Noj0T5SKGx1rLdLn4PKbpQFhCDCKvKAnsAw4WTNz8Tab9iltzaMp
	 LBNmbH0RmuRXg==
Date: Fri, 14 Mar 2025 21:46:09 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	irogers@google.com, james.clark@arm.com, ravi.bangoria@amd.com,
	yu.c.chen@intel.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	rostedt@goodmis.org, vincent.guittot@linaro.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	gautham.shenoy@amd.com, kprateek.nayak@amd.com,
	juri.lelli@redhat.com, yangjihong@bytedance.com, void@manifault.com,
	tj@kernel.org, sshegde@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, santosh.shukla@amd.com,
	ananth.narayan@amd.com, sandipan.das@amd.com,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v3 5/8] perf sched stats: Add support for live mode
Message-ID: <Z9UGEaypiEbOuhHv@google.com>
References: <20250311120230.61774-1-swapnil.sapkal@amd.com>
 <20250311120230.61774-6-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250311120230.61774-6-swapnil.sapkal@amd.com>

On Tue, Mar 11, 2025 at 12:02:27PM +0000, Swapnil Sapkal wrote:
> The live mode works similar to simple `perf stat` command, by profiling
> the target and printing results on the terminal as soon as the target
> finishes.
> 
> Example usage:
> 
>   # perf sched stats -- sleep 10
> 
> Co-developed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> Tested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> ---
>  tools/perf/builtin-sched.c | 87 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 86 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index e2e7dbc4f0aa..9813e25b54b8 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -4364,6 +4364,91 @@ static int perf_sched__schedstat_report(struct perf_sched *sched)
>  	return err;
>  }
>  
> +static int process_synthesized_event_live(const struct perf_tool *tool __maybe_unused,
> +					  union perf_event *event,
> +					  struct perf_sample *sample __maybe_unused,
> +					  struct machine *machine __maybe_unused)
> +{
> +	return perf_sched__process_schedstat(NULL, event);
> +}
> +
> +static int perf_sched__schedstat_live(struct perf_sched *sched,
> +				      int argc, const char **argv)
> +{
> +	struct evlist *evlist;
> +	struct target *target;
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
> +	target = zalloc(sizeof(struct target));

As I said, you can put it on stack.


> +	if (cpu_list)
> +		target->cpu_list = cpu_list;
> +	else
> +		target->system_wide = true;
> +
> +	if (argc) {
> +		err = evlist__prepare_workload(evlist, target, argv, false, NULL);
> +		if (err)
> +			goto out_target;
> +	}
> +
> +	if (cpu_list) {
> +		user_requested_cpus = perf_cpu_map__new(cpu_list);
> +		if (!user_requested_cpus)
> +			goto out_target;
> +	}

How about this instead?

	evlist__create_maps(evlist, target);

> +
> +	err = perf_event__synthesize_schedstat(&(sched->tool),
> +					       process_synthesized_event_live,
> +					       user_requested_cpus);
> +	if (err < 0)
> +		goto out_target;
> +
> +	err = enable_sched_schedstats(&reset);
> +	if (err < 0)
> +		goto out_target;
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
> +			goto out_target;
> +	}
> +
> +	err = perf_event__synthesize_schedstat(&(sched->tool),
> +					       process_synthesized_event_live,
> +					       user_requested_cpus);
> +	if (err)
> +		goto out_target;
> +
> +	setup_pager();
> +	show_schedstat_data(cpu_head);
> +	free_schedstat(cpu_head);
> +out_target:
> +	free(target);

	evlist__delete(evlist);

and unless you use evlist__create_maps().

	perf_cpu_map__put(user_requested_cpus);

Thanks,
Namhyung


> +	return err;
> +}
> +
>  static bool schedstat_events_exposed(void)
>  {
>  	/*
> @@ -4686,7 +4771,7 @@ int cmd_sched(int argc, const char **argv)
>  						     stats_usage, 0);
>  			return perf_sched__schedstat_report(&sched);
>  		}
> -		usage_with_options(stats_usage, stats_options);
> +		return perf_sched__schedstat_live(&sched, argc, argv);
>  	} else {
>  		usage_with_options(sched_usage, sched_options);
>  	}
> -- 
> 2.43.0
> 
