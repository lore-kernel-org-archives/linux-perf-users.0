Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91602FC00D;
	Fri,  3 Apr 2026 03:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775185851; cv=none; b=psLX/kaIUHTYcfpU4mnOHKKqYzOLJxqxYn61ncSBEdkb50Gjn/e7L1r42LU87WKqZanIl9Ckq3phesCPy9DQdDxgfQhtt7AUijxcIeJXrKcXTxZGRJkrEFUnxhb/Z+l6oRLDU2+Vuu9hGCNgTvrnqHiF5Jt9xPKj6kOrDF7B7CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775185851; c=relaxed/simple;
	bh=1lPA3Xo5HXrsUcecYwhNXQ5SGP0vcJX3MJTbg5bokiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YF/5QqSHGLgSssi4VI/bhck648c4I7i8GVB22+HWvEWHrlkPLFKs72hVtez9DtK1L9J4Q+uBEqaQgadCRfJhlvj03OKK2VC0keUlk1GeEsbs8E2eNLVTAQF771/K7k0MTrto2W2AEHkmidQteYb+4riyeeW9q41Z5YltCRnxnIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePw3elEp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePw3elEp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED348C116C6;
	Fri,  3 Apr 2026 03:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775185851;
	bh=1lPA3Xo5HXrsUcecYwhNXQ5SGP0vcJX3MJTbg5bokiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ePw3elEpUQzGDYBtPP6//JPW5y0JBdwmr1d8RR5zidlU+uR7vM6T6lGug3zcUY0z6
	 bzBnEYJIQ7AgSD7XZ77KK8MT/ckU7Xe8J/MGrykzchdp8vQ6FgQowkykwMZgAmhZR+
	 OCOzVKxnMTAGLFsqp5EtNOUgxlUOw8mWlB3mFau2noWKwzfZMnaCp3R4MJQBcuOtue
	 FJ8qDBpHm1av6Haw1whGnwQz65vnMixl8A+22eqDSIhIZMC2Qa6xNLmGueWw/QN9eh
	 72WdZItQ9jXFpNUSGtUiu/5dsoZ4o2DqCRSg7AVhU9fo0N8mXVGOHKcxBH2k4Ap0Nk
	 zMScZfZEjPATg==
Date: Thu, 2 Apr 2026 20:10:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
	ak@linux.intel.com, alex@ghiti.fr,
	alexander.shishkin@linux.intel.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
	blakejones@google.com, ctshao@google.com,
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com,
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com,
	james.clark@linaro.org, jolsa@kernel.org,
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn,
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn,
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com,
	zhouquan@iscas.ac.cn
Subject: Re: [PATCH v4 02/25] perf sample: Make sure perf_sample__init/exit
 are used
Message-ID: <ac8vuNEJNsVa-Trk@google.com>
References: <20260320080835.724836-1-irogers@google.com>
 <20260320192627.368357-1-irogers@google.com>
 <20260320192627.368357-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320192627.368357-3-irogers@google.com>

On Fri, Mar 20, 2026 at 12:26:04PM -0700, Ian Rogers wrote:
> The deferred stack trace code wasn't using perf_sample__init/exit. Add
> the deferred stack trace clean up to perf_sample__exit which requires
> proper NULL initialization in perf_sample__init. Make the
> perf_sample__exit robust to being called more than once by using
> zfree. Make the error paths in evsel__parse_sample exit the
> sample. Add a merged_callchain boolean to capture that callchain is
> allocated, deferred_callchain doen't suffice for this. Pack the struct
> variables to avoid padding bytes for this.
> 
> Similiarly powerpc_vpadtl_sample wasn't using perf_sample__init/exit,
> use it for consistency and potential issues with uninitialized
> variables.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-inject.c        |  6 +++++-
>  tools/perf/tests/perf-record.c     |  1 +
>  tools/perf/tests/switch-tracking.c |  2 ++
>  tools/perf/util/callchain.c        | 10 ++++++---
>  tools/perf/util/evlist.c           |  5 ++++-
>  tools/perf/util/evsel.c            | 34 ++++++++++++++++++------------
>  tools/perf/util/powerpc-vpadtl.c   | 10 +++++----
>  tools/perf/util/sample.c           | 10 +++++++--
>  tools/perf/util/sample.h           | 17 +++++++++------
>  tools/perf/util/session.c          | 13 ++++++++----
>  10 files changed, 74 insertions(+), 34 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 5b29f4296861..8b9a0a4097af 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -1087,6 +1087,7 @@ static int perf_inject__sched_stat(const struct perf_tool *tool,
>  	struct perf_sample sample_sw;
>  	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
>  	u32 pid = evsel__intval(evsel, sample, "pid");
> +	int ret;
>  
>  	list_for_each_entry(ent, &inject->samples, node) {
>  		if (pid == ent->tid)
> @@ -1103,7 +1104,9 @@ static int perf_inject__sched_stat(const struct perf_tool *tool,
>  	perf_event__synthesize_sample(event_sw, evsel->core.attr.sample_type,
>  				      evsel->core.attr.read_format, &sample_sw);
>  	build_id__mark_dso_hit(tool, event_sw, &sample_sw, evsel, machine);
> -	return perf_event__repipe(tool, event_sw, &sample_sw, machine);
> +	ret = perf_event__repipe(tool, event_sw, &sample_sw, machine);
> +	perf_sample__exit(&sample_sw);
> +	return ret;
>  }
>  #endif
>  
> @@ -1826,6 +1829,7 @@ static int guest_session__inject_events(struct guest_session *gs, u64 timestamp)
>  			return -EINVAL;
>  		}
>  
> +		perf_sample__exit(sample);
>  		gs->fetched = false;

I don't see matching perf_sample__init() in guest_session__fetch().  And
as sashiko reported, there are paths missing perf_sample__exit().

In general, I prefer not having perf_sample__init() in
evsel__parse_sample() since it's already called from the callers and
it'd be easier to match with corresponding __exit() there.

Thanks,
Namhyung

>  
>  		ret = output_bytes(inject, ev, ev->header.size);
> diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
> index efbd9cd60c63..7b881f08906d 100644
> --- a/tools/perf/tests/perf-record.c
> +++ b/tools/perf/tests/perf-record.c
> @@ -297,6 +297,7 @@ static int test__PERF_RECORD(struct test_suite *test __maybe_unused, int subtest
>  				}
>  
>  				perf_mmap__consume(&md->core);
> +				perf_sample__exit(&sample);
>  			}
>  			perf_mmap__read_done(&md->core);
>  		}
> diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
> index 15791fcb76b2..72a8289e846d 100644
> --- a/tools/perf/tests/switch-tracking.c
> +++ b/tools/perf/tests/switch-tracking.c
> @@ -239,11 +239,13 @@ static int add_event(struct evlist *evlist, struct list_head *events,
>  
>  	if (!sample.time) {
>  		pr_debug("event with no time\n");
> +		perf_sample__exit(&sample);
>  		return -1;
>  	}
>  
>  	node->event_time = sample.time;
>  
> +	perf_sample__exit(&sample);
>  	return 0;
>  }
>  
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 8ff0898799ee..19c97137103c 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1854,16 +1854,19 @@ int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
>  	u64 nr_deferred = sample_callchain->callchain->nr;
>  	struct ip_callchain *callchain;
>  
> +	if (sample_orig->merged_callchain) {
> +		/* Already merged. */
> +		return -EINVAL;
> +	}
> +
>  	if (sample_orig->callchain->nr < 2) {
>  		sample_orig->deferred_callchain = false;
>  		return -EINVAL;
>  	}
>  
>  	callchain = calloc(1 + nr_orig + nr_deferred, sizeof(u64));
> -	if (callchain == NULL) {
> -		sample_orig->deferred_callchain = false;
> +	if (callchain == NULL)
>  		return -ENOMEM;
> -	}
>  
>  	callchain->nr = nr_orig + nr_deferred;
>  	/* copy original including PERF_CONTEXT_USER_DEFERRED (but the cookie) */
> @@ -1872,6 +1875,7 @@ int sample__merge_deferred_callchain(struct perf_sample *sample_orig,
>  	memcpy(&callchain->ips[nr_orig], sample_callchain->callchain->ips,
>  	       nr_deferred * sizeof(u64));
>  
> +	sample_orig->merged_callchain = true;
>  	sample_orig->callchain = callchain;
>  	return 0;
>  }
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 591bdf0b3e2a..bdb196425071 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1622,8 +1622,11 @@ int evlist__parse_sample(struct evlist *evlist, union perf_event *event, struct
>  	struct evsel *evsel = evlist__event2evsel(evlist, event);
>  	int ret;
>  
> -	if (!evsel)
> +	if (!evsel) {
> +		/* Ensure the sample is okay for perf_sample__exit. */
> +		perf_sample__init(sample, /*all=*/false);
>  		return -EFAULT;
> +	}
>  	ret = evsel__parse_sample(evsel, event, sample);
>  	if (ret)
>  		return ret;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index f59228c1a39e..59efe460d9bc 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3067,7 +3067,7 @@ static inline bool overflow(const void *endp, u16 max_size, const void *offset,
>  #define OVERFLOW_CHECK(offset, size, max_size)				\
>  	do {								\
>  		if (overflow(endp, (max_size), (offset), (size)))	\
> -			return -EFAULT;					\
> +			goto out_efault;				\
>  	} while (0)
>  
>  #define OVERFLOW_CHECK_u64(offset) \
> @@ -3199,6 +3199,8 @@ static int __set_offcpu_sample(struct perf_sample *data)
>  	data->cgroup = *array;
>  
>  	return 0;
> +out_efault:
> +	return -EFAULT;
>  }
>  
>  int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
> @@ -3217,7 +3219,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  	 */
>  	union u64_swap u;
>  
> -	memset(data, 0, sizeof(*data));
> +	perf_sample__init(data, /*all=*/true);
>  	data->cpu = data->pid = data->tid = -1;
>  	data->stream_id = data->id = data->time = -1ULL;
>  	data->period = evsel->core.attr.sample_period;
> @@ -3231,25 +3233,26 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  
>  		data->callchain = (struct ip_callchain *)&event->callchain_deferred.nr;
>  		if (data->callchain->nr > max_callchain_nr)
> -			return -EFAULT;
> +			goto out_efault;
>  
>  		data->deferred_cookie = event->callchain_deferred.cookie;
>  
>  		if (evsel->core.attr.sample_id_all)
>  			perf_evsel__parse_id_sample(evsel, event, data);
> +
>  		return 0;
>  	}
>  
>  	if (event->header.type != PERF_RECORD_SAMPLE) {
> -		if (!evsel->core.attr.sample_id_all)
> -			return 0;
> -		return perf_evsel__parse_id_sample(evsel, event, data);
> +		if (evsel->core.attr.sample_id_all)
> +			perf_evsel__parse_id_sample(evsel, event, data);
> +		return 0;
>  	}
>  
>  	array = event->sample.array;
>  
>  	if (perf_event__check_size(event, evsel->sample_size))
> -		return -EFAULT;
> +		goto out_efault;
>  
>  	if (type & PERF_SAMPLE_IDENTIFIER) {
>  		data->id = *array;
> @@ -3342,7 +3345,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  					sizeof(struct sample_read_value);
>  
>  			if (data->read.group.nr > max_group_nr)
> -				return -EFAULT;
> +				goto out_efault;
>  
>  			sz = data->read.group.nr * sample_read_value_size(read_format);
>  			OVERFLOW_CHECK(array, sz, max_size);
> @@ -3370,7 +3373,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  		data->callchain = (struct ip_callchain *)array++;
>  		callchain_nr = data->callchain->nr;
>  		if (callchain_nr > max_callchain_nr)
> -			return -EFAULT;
> +			goto out_efault;
>  		sz = callchain_nr * sizeof(u64);
>  		/*
>  		 * Save the cookie for the deferred user callchain.  The last 2
> @@ -3428,7 +3431,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  		data->branch_stack = (struct branch_stack *)array++;
>  
>  		if (data->branch_stack->nr > max_branch_nr)
> -			return -EFAULT;
> +			goto out_efault;
>  
>  		sz = data->branch_stack->nr * sizeof(struct branch_entry);
>  		if (evsel__has_branch_hw_idx(evsel)) {
> @@ -3505,7 +3508,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  			data->user_stack.size = *array++;
>  			if (WARN_ONCE(data->user_stack.size > sz,
>  				      "user stack dump failure\n"))
> -				return -EFAULT;
> +				goto out_efault;
>  		}
>  	}
>  
> @@ -3582,10 +3585,15 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  		array = (void *)array + sz;
>  	}
>  
> -	if (evsel__is_offcpu_event(evsel))
> -		return __set_offcpu_sample(data);
> +	if (evsel__is_offcpu_event(evsel)) {
> +		if (__set_offcpu_sample(data))
> +			goto out_efault;
> +	}
>  
>  	return 0;
> +out_efault:
> +	perf_sample__exit(data);
> +	return -EFAULT;
>  }
>  
>  int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
> diff --git a/tools/perf/util/powerpc-vpadtl.c b/tools/perf/util/powerpc-vpadtl.c
> index d1c3396f182f..993ab16614c7 100644
> --- a/tools/perf/util/powerpc-vpadtl.c
> +++ b/tools/perf/util/powerpc-vpadtl.c
> @@ -182,7 +182,9 @@ static int powerpc_vpadtl_sample(struct powerpc_vpadtl_entry *record,
>  {
>  	struct perf_sample sample;
>  	union perf_event event;
> +	int ret;
>  
> +	perf_sample__init(&sample, /*all=*/true);
>  	sample.ip = be64_to_cpu(record->srr0);
>  	sample.period = 1;
>  	sample.cpu = cpu;
> @@ -198,12 +200,12 @@ static int powerpc_vpadtl_sample(struct powerpc_vpadtl_entry *record,
>  	event.sample.header.misc = sample.cpumode;
>  	event.sample.header.size = sizeof(struct perf_event_header);
>  
> -	if (perf_session__deliver_synth_event(vpa->session, &event, &sample)) {
> +	ret = perf_session__deliver_synth_event(vpa->session, &event, &sample);
> +	if (ret)
>  		pr_debug("Failed to create sample for dtl entry\n");
> -		return -1;
> -	}
>  
> -	return 0;
> +	perf_sample__exit(&sample);
> +	return ret;
>  }
>  
>  static int powerpc_vpadtl_get_buffer(struct powerpc_vpadtl_queue *vpaq)
> diff --git a/tools/perf/util/sample.c b/tools/perf/util/sample.c
> index 8f82aaf1aab6..2a30de4573f6 100644
> --- a/tools/perf/util/sample.c
> +++ b/tools/perf/util/sample.c
> @@ -21,13 +21,19 @@ void perf_sample__init(struct perf_sample *sample, bool all)
>  	} else {
>  		sample->user_regs = NULL;
>  		sample->intr_regs = NULL;
> +		sample->merged_callchain = false;
> +		sample->callchain = NULL;
>  	}
>  }
>  
>  void perf_sample__exit(struct perf_sample *sample)
>  {
> -	free(sample->user_regs);
> -	free(sample->intr_regs);
> +	zfree(&sample->user_regs);
> +	zfree(&sample->intr_regs);
> +	if (sample->merged_callchain) {
> +		zfree(&sample->callchain);
> +		sample->merged_callchain = false;
> +	}
>  }
>  
>  struct regs_dump *perf_sample__user_regs(struct perf_sample *sample)
> diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
> index 8d4ace0e6594..5809c42631e5 100644
> --- a/tools/perf/util/sample.h
> +++ b/tools/perf/util/sample.h
> @@ -155,12 +155,6 @@ struct perf_sample {
>  	 *            intel-pt. The instruction itself is held in insn.
>  	 */
>  	u16 insn_len;
> -	/**
> -	 * @cpumode: The cpumode from struct perf_event_header misc variable
> -	 *           masked with CPUMODE_MASK. Gives user, kernel and hypervisor
> -	 *           information.
> -	 */
> -	u8  cpumode;
>  	/** @misc: The entire struct perf_event_header misc variable. */
>  	u16 misc;
>  	/**
> @@ -174,6 +168,12 @@ struct perf_sample {
>  	 *           powerpc holds p_stage_cyc.
>  	 */
>  	u16 weight3;
> +	/**
> +	 * @cpumode: The cpumode from struct perf_event_header misc variable
> +	 *           masked with CPUMODE_MASK. Gives user, kernel and hypervisor
> +	 *           information.
> +	 */
> +	u8  cpumode;
>  	/**
>  	 * @no_hw_idx: For PERF_SAMPLE_BRANCH_STACK, true when
>  	 *             PERF_SAMPLE_BRANCH_HW_INDEX isn't set.
> @@ -184,6 +184,11 @@ struct perf_sample {
>  	 *                      user callchain marker was encountered.
>  	 */
>  	bool deferred_callchain;
> +	/**
> +	 * @merged_callchain: A synthesized merged callchain that is allocated
> +	 *                    and needs freeing.
> +	 */
> +	bool merged_callchain;
>  	/**
>  	 * @deferred_cookie: Identifier of the deferred callchain in the later
>  	 *                   PERF_RECORD_CALLCHAIN_DEFERRED event.
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 4b465abfa36c..c48e840da7d4 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1367,14 +1367,18 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
>  	list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list) {
>  		struct perf_sample orig_sample;
>  
> +		perf_sample__init(&orig_sample, /*all=*/false);
>  		ret = evlist__parse_sample(evlist, de->event, &orig_sample);
>  		if (ret < 0) {
>  			pr_err("failed to parse original sample\n");
> +			perf_sample__exit(&orig_sample);
>  			break;
>  		}
>  
> -		if (sample->tid != orig_sample.tid)
> +		if (sample->tid != orig_sample.tid) {
> +			perf_sample__exit(&orig_sample);
>  			continue;
> +		}
>  
>  		if (event->callchain_deferred.cookie == orig_sample.deferred_cookie)
>  			sample__merge_deferred_callchain(&orig_sample, sample);
> @@ -1385,9 +1389,7 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
>  		ret = evlist__deliver_sample(evlist, tool, de->event,
>  					     &orig_sample, evsel, machine);
>  
> -		if (orig_sample.deferred_callchain)
> -			free(orig_sample.callchain);
> -
> +		perf_sample__exit(&orig_sample);
>  		list_del(&de->list);
>  		free(de->event);
>  		free(de);
> @@ -1414,9 +1416,11 @@ static int session__flush_deferred_samples(struct perf_session *session,
>  	list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list) {
>  		struct perf_sample sample;
>  
> +		perf_sample__init(&sample, /*all=*/false);
>  		ret = evlist__parse_sample(evlist, de->event, &sample);
>  		if (ret < 0) {
>  			pr_err("failed to parse original sample\n");
> +			perf_sample__exit(&sample);
>  			break;
>  		}
>  
> @@ -1424,6 +1428,7 @@ static int session__flush_deferred_samples(struct perf_session *session,
>  		ret = evlist__deliver_sample(evlist, tool, de->event,
>  					     &sample, evsel, machine);
>  
> +		perf_sample__exit(&sample);
>  		list_del(&de->list);
>  		free(de->event);
>  		free(de);
> -- 
> 2.53.0.959.g497ff81fa9-goog
> 
