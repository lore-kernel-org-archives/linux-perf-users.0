Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD8734A78E;
	Mon, 27 Apr 2026 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777270415; cv=none; b=tgDN/cTifPlKaErbV/LcTaZtuobFuRgsj66aT7aMIZwQIyJgY9FOhYN+lq0Jw5Y0/95WDHL0fwfkwxFizf5FlH6hqM69P/p929vDiM0Nse6pxjq+iQgkVIpcKBglGoWovUIZRuyjHc+8tUuW0EB98dmsDl5Dh0wSShXQ9OdTKcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777270415; c=relaxed/simple;
	bh=wM6ZV2NwVJW0MbTrc2wrjS4pGhDVvI8TogTGXTLDAAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRnD2MfPuLMY2Zz9XRVo4QgUhLHnwd06BHnbwCiGSFrCCcDgFNiKLTEsvVavZPaMs4ATjkylZoNo8sy+gaq8yFr6lkK35o1Pzu1WmKi0d7Ttb3oR22F8YaCxjcGBXWg3rpK6pLDb9t+O3ModNpfTJJcH/pyQ5gn68MV6JCSflnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qN8pvndh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qN8pvndh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD30C19425;
	Mon, 27 Apr 2026 06:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777270415;
	bh=wM6ZV2NwVJW0MbTrc2wrjS4pGhDVvI8TogTGXTLDAAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qN8pvndhKI8Tt3LpdyJHhg+IEC+rFA7o2PRhk1kC0gHGxQsUwlAOM7iBCh9SDbqWk
	 bwQRpIjY8Mjn6m8xq795Zef+7VKM7o0XqTsj06hna033v/YgkUUKuaEwdPuROOBId+
	 RCrUo3OtvgYQXb4aAMseZOLQM9ucLS/hTSdf3pEomi5W0ShEpZj77Zsc/k4O9TiZzt
	 iGxZvdxx4oR6ElPMVVWfTou+W7gFz3trt5KmQWPBu4I/0e4THSNE8IjFTcPtL2nJFN
	 f2VNrhz6ZwdcKQj2cGHgaxmI1WEXbiQb9BxuE/tuYPXzzE4jy/wPBXV4HhHXY9EXjA
	 htUqRhR/N6ZfQ==
Date: Sun, 26 Apr 2026 23:13:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org,
	leo.yan@linux.dev, tmricht@linux.ibm.com,
	alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH v7 01/59] perf inject: Fix itrace branch stack synthesis
Message-ID: <ae7-jS-TeQ-TUXSF@google.com>
References: <20260425174858.3922152-1-irogers@google.com>
 <20260425224951.174663-1-irogers@google.com>
 <20260425224951.174663-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260425224951.174663-2-irogers@google.com>

Hi Ian,

On Sat, Apr 25, 2026 at 03:48:53PM -0700, Ian Rogers wrote:
> When using "perf inject --itrace=L" to synthesize branch stacks from
> AUX data, several issues caused failures:
> 
> 1. The synthesized samples were delivered without the
>    PERF_SAMPLE_BRANCH_STACK flag if it was not in the original event's
>    sample_type. Fixed by using sample_type | evsel->synth_sample_type
>    in intel_pt_deliver_synth_event.
> 
> 2. The record layout was misaligned because of inconsistent handling
>    of PERF_SAMPLE_BRANCH_HW_INDEX. Fixed by explicitly writing nr and
>    hw_idx in perf_event__synthesize_sample.
> 
> 3. Modifying evsel->core.attr.sample_type early in __cmd_inject caused
>    parse failures for subsequent records in the input file. Fixed by
>    moving this modification to just before writing the header.
> 
> 4. perf_event__repipe_sample was narrowed to only synthesize samples
>    when branch stack injection was requested, and restored the use of
>    perf_inject__cut_auxtrace_sample as a fallback to preserve
>    functionality.

Looks like it does a lot of things in a patch.  I think these are
independent fixes from this series.  How about moving this out to a
separate series?

Thanks,
Namhyung

> 
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> Issues fixed in v2:
> 
> 1. Potential Heap Overflow in perf_event__repipe_sample : Addressed by
>    adding a check that prints an error and returns -EFAULT if the
>    calculated event size exceeds PERF_SAMPLE_MAX_SIZE , as you
>    requested.
> 
> 2. Header vs Payload Mismatch in __cmd_inject : Addressed by narrowing
>    the condition so that HEADER_BRANCH_STACK is only set in the file
>    header if add_last_branch was true.
> 
> 3. NULL Pointer Dereference in intel-pt.c : Addressed by updating the
>    condition in intel_pt_do_synth_pebs_sample to fill sample.
>    branch_stack if it was synthesized, even if not in the original
>    sample_type .
> 
> 4. Unsafe Reads for events lacking HW_INDEX in synthetic-events.c :
>    Addressed by using the perf_sample__branch_entries() macro and
>    checking sample->no_hw_idx .
> 
> 5. Size mismatch in perf_event__sample_event_size : Addressed by
>    passing branch_sample_type to it and conditioning the hw_idx size on
>    PERF_SAMPLE_BRANCH_HW_INDEX .
> ---
>  tools/perf/bench/inject-buildid.c  |  9 ++--
>  tools/perf/builtin-inject.c        | 77 ++++++++++++++++++++++++++++--
>  tools/perf/tests/dlfilter-test.c   |  8 +++-
>  tools/perf/tests/sample-parsing.c  |  5 +-
>  tools/perf/util/arm-spe.c          |  7 ++-
>  tools/perf/util/cs-etm.c           |  6 ++-
>  tools/perf/util/intel-bts.c        |  3 +-
>  tools/perf/util/intel-pt.c         | 13 +++--
>  tools/perf/util/synthetic-events.c | 25 +++++++---
>  tools/perf/util/synthetic-events.h |  6 ++-
>  10 files changed, 129 insertions(+), 30 deletions(-)
> 
> diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
> index aad572a78d7f..bfd2c5ec9488 100644
> --- a/tools/perf/bench/inject-buildid.c
> +++ b/tools/perf/bench/inject-buildid.c
> @@ -228,9 +228,12 @@ static ssize_t synthesize_sample(struct bench_data *data, struct bench_dso *dso,
>  
>  	event.header.type = PERF_RECORD_SAMPLE;
>  	event.header.misc = PERF_RECORD_MISC_USER;
> -	event.header.size = perf_event__sample_event_size(&sample, bench_sample_type, 0);
> -
> -	perf_event__synthesize_sample(&event, bench_sample_type, 0, &sample);
> +	event.header.size = perf_event__sample_event_size(&sample, bench_sample_type,
> +							   /*read_format=*/0,
> +							   /*branch_sample_type=*/0);
> +	perf_event__synthesize_sample(&event, bench_sample_type,
> +				      /*read_format=*/0,
> +				      /*branch_sample_type=*/0, &sample);
>  
>  	return writen(data->input_pipe[1], &event, event.header.size);
>  }
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index f174bc69cec4..88c0ef4f5ff1 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -375,7 +375,59 @@ static int perf_event__repipe_sample(const struct perf_tool *tool,
>  
>  	build_id__mark_dso_hit(tool, event, sample, evsel, machine);
>  
> -	if (inject->itrace_synth_opts.set && sample->aux_sample.size) {
> +	if (inject->itrace_synth_opts.set &&
> +	    (inject->itrace_synth_opts.last_branch ||
> +	     inject->itrace_synth_opts.add_last_branch)) {
> +		union perf_event *event_copy = (void *)inject->event_copy;
> +		struct branch_stack dummy_bs = { .nr = 0 };
> +		int err;
> +		size_t sz;
> +		u64 orig_type = evsel->core.attr.sample_type;
> +		u64 orig_branch_type = evsel->core.attr.branch_sample_type;
> +
> +		if (event_copy == NULL) {
> +			inject->event_copy = malloc(PERF_SAMPLE_MAX_SIZE);
> +			if (!inject->event_copy)
> +				return -ENOMEM;
> +
> +			event_copy = (void *)inject->event_copy;
> +		}
> +
> +		if (!sample->branch_stack)
> +			sample->branch_stack = &dummy_bs;
> +
> +		if (inject->itrace_synth_opts.add_last_branch) {
> +			/* Temporarily add in type bits for synthesis. */
> +			evsel->core.attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
> +			evsel->core.attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
> +			evsel->core.attr.sample_type &= ~PERF_SAMPLE_AUX;
> +		}
> +
> +		sz = perf_event__sample_event_size(sample, evsel->core.attr.sample_type,
> +						   evsel->core.attr.read_format,
> +						   evsel->core.attr.branch_sample_type);
> +
> +		if (sz > PERF_SAMPLE_MAX_SIZE) {
> +			pr_err("Sample size %zu exceeds max size %d\n", sz, PERF_SAMPLE_MAX_SIZE);
> +			return -EFAULT;
> +		}
> +
> +		event_copy->header.type = PERF_RECORD_SAMPLE;
> +		event_copy->header.size = sz;
> +
> +		err = perf_event__synthesize_sample(event_copy, evsel->core.attr.sample_type,
> +						    evsel->core.attr.read_format,
> +						    evsel->core.attr.branch_sample_type, sample);
> +
> +		evsel->core.attr.sample_type = orig_type;
> +		evsel->core.attr.branch_sample_type = orig_branch_type;
> +
> +		if (err) {
> +			pr_err("Failed to synthesize sample\n");
> +			return err;
> +		}
> +		event = event_copy;
> +	} else if (inject->itrace_synth_opts.set && sample->aux_sample.size) {
>  		event = perf_inject__cut_auxtrace_sample(inject, event, sample);
>  		if (IS_ERR(event))
>  			return PTR_ERR(event);
> @@ -464,7 +516,8 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
>  	sample_type &= ~(PERF_SAMPLE_STACK_USER | PERF_SAMPLE_REGS_USER);
>  
>  	perf_event__synthesize_sample(event_copy, sample_type,
> -				      evsel->core.attr.read_format, sample);
> +				      evsel->core.attr.read_format,
> +				      evsel->core.attr.branch_sample_type, sample);
>  	return perf_event__repipe_synth(tool, event_copy);
>  }
>  
> @@ -1100,7 +1153,8 @@ static int perf_inject__sched_stat(const struct perf_tool *tool,
>  	sample_sw.period = sample->period;
>  	sample_sw.time	 = sample->time;
>  	perf_event__synthesize_sample(event_sw, evsel->core.attr.sample_type,
> -				      evsel->core.attr.read_format, &sample_sw);
> +				      evsel->core.attr.read_format,
> +				      evsel->core.attr.branch_sample_type, &sample_sw);
>  	build_id__mark_dso_hit(tool, event_sw, &sample_sw, evsel, machine);
>  	ret = perf_event__repipe(tool, event_sw, &sample_sw, machine);
>  	perf_sample__exit(&sample_sw);
> @@ -2434,12 +2488,25 @@ static int __cmd_inject(struct perf_inject *inject)
>  		 * synthesized hardware events, so clear the feature flag.
>  		 */
>  		if (inject->itrace_synth_opts.set) {
> +			struct evsel *evsel;
> +
>  			perf_header__clear_feat(&session->header,
>  						HEADER_AUXTRACE);
> -			if (inject->itrace_synth_opts.last_branch ||
> -			    inject->itrace_synth_opts.add_last_branch)
> +
> +			evlist__for_each_entry(session->evlist, evsel) {
> +				evsel->core.attr.sample_type &= ~PERF_SAMPLE_AUX;
> +			}
> +
> +			if (inject->itrace_synth_opts.add_last_branch) {
>  				perf_header__set_feat(&session->header,
>  						      HEADER_BRANCH_STACK);
> +
> +				evlist__for_each_entry(session->evlist, evsel) {
> +					evsel->core.attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
> +					evsel->core.attr.branch_sample_type |=
> +						PERF_SAMPLE_BRANCH_HW_INDEX;
> +				}
> +			}
>  		}
>  
>  		/*
> diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-test.c
> index e63790c61d53..204663571943 100644
> --- a/tools/perf/tests/dlfilter-test.c
> +++ b/tools/perf/tests/dlfilter-test.c
> @@ -188,8 +188,12 @@ static int write_sample(struct test_data *td, u64 sample_type, u64 id, pid_t pid
>  
>  	event->header.type = PERF_RECORD_SAMPLE;
>  	event->header.misc = PERF_RECORD_MISC_USER;
> -	event->header.size = perf_event__sample_event_size(&sample, sample_type, 0);
> -	err = perf_event__synthesize_sample(event, sample_type, 0, &sample);
> +	event->header.size = perf_event__sample_event_size(&sample, sample_type,
> +							   /*read_format=*/0,
> +							   /*branch_sample_type=*/0);
> +	err = perf_event__synthesize_sample(event, sample_type,
> +					    /*read_format=*/0,
> +					    /*branch_sample_type=*/0, &sample);
>  	if (err)
>  		return test_result("perf_event__synthesize_sample() failed", TEST_FAIL);
>  
> diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
> index a7327c942ca2..55f0b73ca20e 100644
> --- a/tools/perf/tests/sample-parsing.c
> +++ b/tools/perf/tests/sample-parsing.c
> @@ -310,7 +310,8 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
>  		sample.read.one.lost  = 1;
>  	}
>  
> -	sz = perf_event__sample_event_size(&sample, sample_type, read_format);
> +	sz = perf_event__sample_event_size(&sample, sample_type, read_format,
> +					   evsel.core.attr.branch_sample_type);
>  	bufsz = sz + 4096; /* Add a bit for overrun checking */
>  	event = malloc(bufsz);
>  	if (!event) {
> @@ -324,7 +325,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
>  	event->header.size = sz;
>  
>  	err = perf_event__synthesize_sample(event, sample_type, read_format,
> -					    &sample);
> +					    evsel.core.attr.branch_sample_type, &sample);
>  	if (err) {
>  		pr_debug("%s failed for sample_type %#"PRIx64", error %d\n",
>  			 "perf_event__synthesize_sample", sample_type, err);
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index e5835042acdf..c4ed9f10e731 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -484,8 +484,11 @@ static void arm_spe__prep_branch_stack(struct arm_spe_queue *speq)
>  
>  static int arm_spe__inject_event(union perf_event *event, struct perf_sample *sample, u64 type)
>  {
> -	event->header.size = perf_event__sample_event_size(sample, type, 0);
> -	return perf_event__synthesize_sample(event, type, 0, sample);
> +	event->header.type = PERF_RECORD_SAMPLE;
> +	event->header.size = perf_event__sample_event_size(sample, type, /*read_format=*/0,
> +							   /*branch_sample_type=*/0);
> +	return perf_event__synthesize_sample(event, type, /*read_format=*/0,
> +					     /*branch_sample_type=*/0, sample);
>  }
>  
>  static inline int
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 8a639d2e51a4..1ebc1a6a5e75 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1425,8 +1425,10 @@ static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq,
>  static int cs_etm__inject_event(union perf_event *event,
>  			       struct perf_sample *sample, u64 type)
>  {
> -	event->header.size = perf_event__sample_event_size(sample, type, 0);
> -	return perf_event__synthesize_sample(event, type, 0, sample);
> +	event->header.size = perf_event__sample_event_size(sample, type, /*read_format=*/0,
> +							   /*branch_sample_type=*/0);
> +	return perf_event__synthesize_sample(event, type, /*read_format=*/0,
> +					     /*branch_sample_type=*/0, sample);
>  }
>  
>  
> diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
> index 382255393fb3..0b18ebd13f7c 100644
> --- a/tools/perf/util/intel-bts.c
> +++ b/tools/perf/util/intel-bts.c
> @@ -303,7 +303,8 @@ static int intel_bts_synth_branch_sample(struct intel_bts_queue *btsq,
>  		event.sample.header.size = bts->branches_event_size;
>  		ret = perf_event__synthesize_sample(&event,
>  						    bts->branches_sample_type,
> -						    0, &sample);
> +						    /*read_format=*/0, /*branch_sample_type=*/0,
> +						    &sample);
>  		if (ret)
>  			return ret;
>  	}
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index fc9eec8b54b8..2dce6106c038 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -1731,8 +1731,12 @@ static void intel_pt_prep_b_sample(struct intel_pt *pt,
>  static int intel_pt_inject_event(union perf_event *event,
>  				 struct perf_sample *sample, u64 type)
>  {
> -	event->header.size = perf_event__sample_event_size(sample, type, 0);
> -	return perf_event__synthesize_sample(event, type, 0, sample);
> +	event->header.type = PERF_RECORD_SAMPLE;
> +	event->header.size = perf_event__sample_event_size(sample, type, /*read_format=*/0,
> +							   /*branch_sample_type=*/0);
> +
> +	return perf_event__synthesize_sample(event, type, /*read_format=*/0,
> +					     /*branch_sample_type=*/0, sample);
>  }
>  
>  static inline int intel_pt_opt_inject(struct intel_pt *pt,
> @@ -2486,7 +2490,7 @@ static int intel_pt_do_synth_pebs_sample(struct intel_pt_queue *ptq, struct evse
>  		intel_pt_add_xmm(intr_regs, pos, items, regs_mask);
>  	}
>  
> -	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
> +	if ((sample_type | evsel->synth_sample_type) & PERF_SAMPLE_BRANCH_STACK) {
>  		if (items->mask[INTEL_PT_LBR_0_POS] ||
>  		    items->mask[INTEL_PT_LBR_1_POS] ||
>  		    items->mask[INTEL_PT_LBR_2_POS]) {
> @@ -2557,7 +2561,8 @@ static int intel_pt_do_synth_pebs_sample(struct intel_pt_queue *ptq, struct evse
>  		sample.transaction = txn;
>  	}
>  
> -	ret = intel_pt_deliver_synth_event(pt, event, &sample, sample_type);
> +	ret = intel_pt_deliver_synth_event(pt, event, &sample,
> +					   sample_type | evsel->synth_sample_type);
>  	perf_sample__exit(&sample);
>  	return ret;
>  }
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 85bee747f4cd..2461f25a4d7d 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1455,7 +1455,8 @@ int perf_event__synthesize_stat_round(const struct perf_tool *tool,
>  	return process(tool, (union perf_event *) &event, NULL, machine);
>  }
>  
> -size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type, u64 read_format)
> +size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type, u64 read_format,
> +				     u64 branch_sample_type)
>  {
>  	size_t sz, result = sizeof(struct perf_record_sample);
>  
> @@ -1515,8 +1516,10 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
>  
>  	if (type & PERF_SAMPLE_BRANCH_STACK) {
>  		sz = sample->branch_stack->nr * sizeof(struct branch_entry);
> -		/* nr, hw_idx */
> -		sz += 2 * sizeof(u64);
> +		/* nr */
> +		sz += sizeof(u64);
> +		if (branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX)
> +			sz += sizeof(u64);
>  		result += sz;
>  	}
>  
> @@ -1605,7 +1608,7 @@ static __u64 *copy_read_group_values(__u64 *array, __u64 read_format,
>  }
>  
>  int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_format,
> -				  const struct perf_sample *sample)
> +				  u64 branch_sample_type, const struct perf_sample *sample)
>  {
>  	__u64 *array;
>  	size_t sz;
> @@ -1719,9 +1722,17 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
>  
>  	if (type & PERF_SAMPLE_BRANCH_STACK) {
>  		sz = sample->branch_stack->nr * sizeof(struct branch_entry);
> -		/* nr, hw_idx */
> -		sz += 2 * sizeof(u64);
> -		memcpy(array, sample->branch_stack, sz);
> +
> +		*array++ = sample->branch_stack->nr;
> +
> +		if (branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX) {
> +			if (sample->no_hw_idx)
> +				*array++ = 0;
> +			else
> +				*array++ = sample->branch_stack->hw_idx;
> +		}
> +
> +		memcpy(array, perf_sample__branch_entries((struct perf_sample *)sample), sz);
>  		array = (void *)array + sz;
>  	}
>  
> diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
> index b0edad0c3100..8c7f49f9ccf5 100644
> --- a/tools/perf/util/synthetic-events.h
> +++ b/tools/perf/util/synthetic-events.h
> @@ -81,7 +81,8 @@ int perf_event__synthesize_mmap_events(const struct perf_tool *tool, union perf_
>  int perf_event__synthesize_modules(const struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
>  int perf_event__synthesize_namespaces(const struct perf_tool *tool, union perf_event *event, pid_t pid, pid_t tgid, perf_event__handler_t process, struct machine *machine);
>  int perf_event__synthesize_cgroups(const struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
> -int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_format, const struct perf_sample *sample);
> +int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_format,
> +				  u64 branch_sample_type, const struct perf_sample *sample);
>  int perf_event__synthesize_stat_config(const struct perf_tool *tool, struct perf_stat_config *config, perf_event__handler_t process, struct machine *machine);
>  int perf_event__synthesize_stat_events(struct perf_stat_config *config, const struct perf_tool *tool, struct evlist *evlist, perf_event__handler_t process, bool attrs);
>  int perf_event__synthesize_stat_round(const struct perf_tool *tool, u64 time, u64 type, perf_event__handler_t process, struct machine *machine);
> @@ -97,7 +98,8 @@ void perf_event__synthesize_final_bpf_metadata(struct perf_session *session,
>  
>  int perf_tool__process_synth_event(const struct perf_tool *tool, union perf_event *event, struct machine *machine, perf_event__handler_t process);
>  
> -size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type, u64 read_format);
> +size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
> +				     u64 read_format, u64 branch_sample_type);
>  
>  int __machine__synthesize_threads(struct machine *machine, const struct perf_tool *tool,
>  				  struct target *target, struct perf_thread_map *threads,
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
