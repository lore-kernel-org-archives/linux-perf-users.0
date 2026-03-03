Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34CD1A683D;
	Tue,  3 Mar 2026 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772577527; cv=none; b=MI8JcRrlRWdQLJ82rcnQXy0EarlSsmd6wmaUIZk9CClFnrWC96LOQQCTxEeggHCrHRevXHHYc+LaJ8NOPheLDRfFrdF5A5slokSP7eUl+yCwXt2vJ4tcx36LwVhwrmv2jtGYtLyLwhfNGFcp+j+t2g4k7fuuSceXt3ktGRWm9q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772577527; c=relaxed/simple;
	bh=2B8H4BnBQxk+9KPCQ26T35inv66oOBR8m6M/hquQDME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvV5lpD8wgmJYKCRz35Vpz3qqkvPIoLjCeys10YNYdG8FIksN4aOxqvee++V3t8S11cY7l4SLYtNEn0mTpi8EX8PLedUljWwap/hjon7xNxhf//UQHvlvUKAZ6IuiBpT16qjJ8tOi45f45wtUBrM5or6b/m+Dzhz56GLF7Bp2uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKa1qehi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKa1qehi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5839C2BC87;
	Tue,  3 Mar 2026 22:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772577527;
	bh=2B8H4BnBQxk+9KPCQ26T35inv66oOBR8m6M/hquQDME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TKa1qehiDEoLO9Z57FRsNHF37QBciiJho0LrPNcHedHI/50sS20OAHf641/QvgYsB
	 pSRvWhz73cRC3qBMayHo0mxQhiN+q04KC71fCobH08J06r1YNXezqXLXTAwDVq/yBL
	 dG7YBLcXkGrDPmMYWrJqAm07495LNua9kmeZkK6g5XCCZAeMr5fptxeVwTnJV6SBv2
	 StOo1R0LG1O1za8hseQ+rr3VIGIH1NLgER86l3JSMd5cqLVKT2qfFgpw7PAUsMQ5du
	 +lUe0ySlMmWiTmICiEhOifdelNoq2fn77/nDLkfj4LAxBS7wr62ZdG5braqCcAC28X
	 p3OSla16yZAMA==
Date: Tue, 3 Mar 2026 14:38:44 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Leo Yan <leo.yan@arm.com>, Tianyou Li <tianyou.li@intel.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Derek Foreman <derek.foreman@collabora.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	tanze <tanze@kylinos.cn>,
	Hrishikesh Suresh <hrishikesh123s@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>, Blake Jones <blakejones@google.com>,
	Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/25] perf sample: Make sure perf_sample__init/exit
 are used
Message-ID: <aadi9Buot21U4dEp@google.com>
References: <20260209174032.4142096-1-irogers@google.com>
 <20260209174032.4142096-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260209174032.4142096-3-irogers@google.com>

On Mon, Feb 09, 2026 at 09:40:09AM -0800, Ian Rogers wrote:
> The deferred stack trace code wasn't using perf_sample__init/exit. Add
> the deferred stack trace clean up to perf_sample__exit which requires
> proper NULL initialization in perf_sample__init. Make the
> perf_sample__exit robust to being called more than once by using
> zfree. Make the error paths in evsel__parse_sample exit the sample.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/builtin-inject.c |  6 +++++-
>  tools/perf/util/evsel.c     | 28 +++++++++++++++++-----------
>  tools/perf/util/sample.c    |  8 ++++++--
>  tools/perf/util/session.c   | 13 +++++++++----
>  4 files changed, 37 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 5b29f4296861..3d2556213599 100644
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
> @@ -1098,12 +1099,15 @@ static int perf_inject__sched_stat(const struct perf_tool *tool,
>  	event_sw = &ent->event[0];
>  	evsel__parse_sample(evsel, event_sw, &sample_sw);
>  
> +	perf_sample__init(&sample_sw, /*all=*/false);

Shouldn't it be called before evsel__parse_sample()?


>  	sample_sw.period = sample->period;
>  	sample_sw.time	 = sample->time;
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
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index f59228c1a39e..34ae388750db 100644
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

It seems this is called before evlist__parse_sample(), do we need to do
it here as well?


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
> @@ -3586,6 +3589,9 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  		return __set_offcpu_sample(data);
>  
>  	return 0;
> +out_efault:
> +	perf_sample__exit(data);
> +	return -EFAULT;
>  }
>  
>  int evsel__parse_sample_timestamp(struct evsel *evsel, union perf_event *event,
> diff --git a/tools/perf/util/sample.c b/tools/perf/util/sample.c
> index 8f82aaf1aab6..4894b990c6ce 100644
> --- a/tools/perf/util/sample.c
> +++ b/tools/perf/util/sample.c
> @@ -21,13 +21,17 @@ void perf_sample__init(struct perf_sample *sample, bool all)
>  	} else {
>  		sample->user_regs = NULL;
>  		sample->intr_regs = NULL;
> +		sample->deferred_callchain = false;
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
> +	if (sample->deferred_callchain)
> +		zfree(&sample->callchain);

Nit: maybe better to set deferred_callchain to false.

Thanks,
Namhyung


>  }
>  
>  struct regs_dump *perf_sample__user_regs(struct perf_sample *sample)
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
> 2.53.0.239.g8d8fc8a987-goog
> 
