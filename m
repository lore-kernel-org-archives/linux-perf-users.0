Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE4317C21B;
	Wed, 21 May 2025 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747859222; cv=none; b=YvkvwkiTAdYo8pD4Bkjm5JyX4e56bHSYdg6fuNdWghRCpBHFrVpfKdjDdRLbpXOoWMHrzG/usja+QZbDbhc0s5HNKHqhEttadJZeE/hGqf0c1TrYTe4zt0H8GRTYUiTyazaWKYDUJp6Pm7M3GmDWeBzlZBRTuGG0+Iu+tJkDjoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747859222; c=relaxed/simple;
	bh=e2agM3DyI+8XYfPZ1u5AZzD8453tvWuWbMJUyImWCpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fo/ridBbFOA3NCxXxxj0UImtUG2RzJOgb1qGkGHiVy73qB6zFePBkbRmygtk4Xynx5uiXx6CiuxmnYRlJn+ig42Sa+I2z3VAI3dSJNjPFlKFr63bBHxiYqvJTG9v37yeJAhmyi0B/5XrttH+oW5PThNAveb0RDLUsJYL2v4pm2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqWv6w7m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqWv6w7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65974C4CEE4;
	Wed, 21 May 2025 20:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747859221;
	bh=e2agM3DyI+8XYfPZ1u5AZzD8453tvWuWbMJUyImWCpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hqWv6w7mQV6HGPpBGCWe4jHK46/tAWYKYwcdsGnxyxjAd/My0c7OXysjiuS/KALHR
	 9RUhh6ylnP5/gqSkeDvlMzQ2t2clQCj+vtGsqbITmsmOh6QHM4c8E8c/hXiRYIaUfc
	 LxhOZEOt1Yj1xiPAhLtfGcxrCKf1vXijLiq6oKFlU3zG/P64dcXbG1bJuNjhNsja9k
	 pcJHdgfpR0doBeTltih9JVjRLEEWhn+f1rOZlIuwf1gGJNi5xBkSr78kn8lDT3a1Dc
	 aPKVvor/ygMNQfx5wW8oE3q3cJHSfR5NN4H14ACAk3rYw5NCGkFpNzN1liT7KI1P2U
	 Pri0D4rXAbRlQ==
Date: Wed, 21 May 2025 13:26:58 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>,
	Yujie Liu <yujie.liu@intel.com>,
	Graham Woodward <graham.woodward@arm.com>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Matt Fleming <matt@readmodwrite.com>,
	Chun-Tse Shao <ctshao@google.com>, Ben Gainey <ben.gainey@arm.com>,
	Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/3] perf sample: Remove arch notion of sample parsing
Message-ID: <aC43Et06tyrBOrsT@google.com>
References: <20250521165317.713463-1-irogers@google.com>
 <20250521165317.713463-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250521165317.713463-2-irogers@google.com>

On Wed, May 21, 2025 at 09:53:15AM -0700, Ian Rogers wrote:
> By definition arch sample parsing and synthesis will inhibit certain
> kinds of cross-platform record then analysis (report, script,
> etc.). Remove arch_perf_parse_sample_weight and
> arch_perf_synthesize_sample_weight replacing with a common
> implementation. Combine perf_sample p_stage_cyc and retire_lat to
> capture the differing uses regardless of compiled for architecture.

Can you please do this without renaming?  It can be a separate patch but
I think we can just leave it.

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/powerpc/util/event.c       | 26 ---------------------
>  tools/perf/arch/x86/tests/sample-parsing.c |  4 ++--
>  tools/perf/arch/x86/util/event.c           | 27 ----------------------
>  tools/perf/builtin-script.c                |  2 +-
>  tools/perf/util/dlfilter.c                 |  2 +-
>  tools/perf/util/event.h                    |  2 --
>  tools/perf/util/evsel.c                    | 17 ++++++++++----
>  tools/perf/util/hist.c                     |  4 ++--
>  tools/perf/util/hist.h                     |  2 +-
>  tools/perf/util/intel-tpebs.c              |  4 ++--
>  tools/perf/util/sample.h                   |  5 +---
>  tools/perf/util/session.c                  |  2 +-
>  tools/perf/util/sort.c                     |  6 ++---
>  tools/perf/util/synthetic-events.c         | 10 ++++++--
>  14 files changed, 34 insertions(+), 79 deletions(-)
> 
> diff --git a/tools/perf/arch/powerpc/util/event.c b/tools/perf/arch/powerpc/util/event.c
> index 77d8cc2b5691..024ac8b54c33 100644
> --- a/tools/perf/arch/powerpc/util/event.c
> +++ b/tools/perf/arch/powerpc/util/event.c
> @@ -11,32 +11,6 @@
>  #include "../../../util/debug.h"
>  #include "../../../util/sample.h"
>  
> -void arch_perf_parse_sample_weight(struct perf_sample *data,
> -				   const __u64 *array, u64 type)
> -{
> -	union perf_sample_weight weight;
> -
> -	weight.full = *array;
> -	if (type & PERF_SAMPLE_WEIGHT)
> -		data->weight = weight.full;
> -	else {
> -		data->weight = weight.var1_dw;
> -		data->ins_lat = weight.var2_w;
> -		data->p_stage_cyc = weight.var3_w;
> -	}
> -}
> -
> -void arch_perf_synthesize_sample_weight(const struct perf_sample *data,
> -					__u64 *array, u64 type)
> -{
> -	*array = data->weight;
> -
> -	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
> -		*array &= 0xffffffff;
> -		*array |= ((u64)data->ins_lat << 32);
> -	}
> -}
> -
>  const char *arch_perf_header_entry(const char *se_header)
>  {
>  	if (!strcmp(se_header, "Local INSTR Latency"))
> diff --git a/tools/perf/arch/x86/tests/sample-parsing.c b/tools/perf/arch/x86/tests/sample-parsing.c
> index a061e8619267..95d8f7f1d2fb 100644
> --- a/tools/perf/arch/x86/tests/sample-parsing.c
> +++ b/tools/perf/arch/x86/tests/sample-parsing.c
> @@ -29,7 +29,7 @@ static bool samples_same(const struct perf_sample *s1,
>  {
>  	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
>  		COMP(ins_lat);
> -		COMP(retire_lat);
> +		COMP(p_stage_cyc_or_retire_lat);
>  	}
>  
>  	return true;
> @@ -50,7 +50,7 @@ static int do_test(u64 sample_type)
>  	struct perf_sample sample = {
>  		.weight		= 101,
>  		.ins_lat        = 102,
> -		.retire_lat     = 103,
> +		.p_stage_cyc_or_retire_lat = 103,
>  	};
>  	struct perf_sample sample_out;
>  	size_t i, sz, bufsz;
> diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
> index a0400707180c..576c1c36046c 100644
> --- a/tools/perf/arch/x86/util/event.c
> +++ b/tools/perf/arch/x86/util/event.c
> @@ -92,33 +92,6 @@ int perf_event__synthesize_extra_kmaps(const struct perf_tool *tool,
>  
>  #endif
>  
> -void arch_perf_parse_sample_weight(struct perf_sample *data,
> -				   const __u64 *array, u64 type)
> -{
> -	union perf_sample_weight weight;
> -
> -	weight.full = *array;
> -	if (type & PERF_SAMPLE_WEIGHT)
> -		data->weight = weight.full;
> -	else {
> -		data->weight = weight.var1_dw;
> -		data->ins_lat = weight.var2_w;
> -		data->retire_lat = weight.var3_w;
> -	}
> -}
> -
> -void arch_perf_synthesize_sample_weight(const struct perf_sample *data,
> -					__u64 *array, u64 type)
> -{
> -	*array = data->weight;
> -
> -	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
> -		*array &= 0xffffffff;
> -		*array |= ((u64)data->ins_lat << 32);
> -		*array |= ((u64)data->retire_lat << 48);
> -	}
> -}
> -
>  const char *arch_perf_header_entry(const char *se_header)
>  {
>  	if (!strcmp(se_header, "Local Pipeline Stage Cycle"))
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 6c3bf74dd78c..c02c435e0f0b 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2251,7 +2251,7 @@ static void process_event(struct perf_script *script,
>  		fprintf(fp, "%16" PRIu16, sample->ins_lat);
>  
>  	if (PRINT_FIELD(RETIRE_LAT))
> -		fprintf(fp, "%16" PRIu16, sample->retire_lat);
> +		fprintf(fp, "%16" PRIu16, sample->p_stage_cyc_or_retire_lat);
>  
>  	if (PRINT_FIELD(CGROUP)) {
>  		const char *cgrp_name;
> diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
> index ddacef881af2..d5fd6d34a17c 100644
> --- a/tools/perf/util/dlfilter.c
> +++ b/tools/perf/util/dlfilter.c
> @@ -513,6 +513,7 @@ int dlfilter__do_filter_event(struct dlfilter *d,
>  	d->d_addr_al   = &d_addr_al;
>  
>  	d_sample.size  = sizeof(d_sample);
> +	d_sample.p_stage_cyc = sample->p_stage_cyc_or_retire_lat;
>  	d_ip_al.size   = 0; /* To indicate d_ip_al is not initialized */
>  	d_addr_al.size = 0; /* To indicate d_addr_al is not initialized */
>  
> @@ -526,7 +527,6 @@ int dlfilter__do_filter_event(struct dlfilter *d,
>  	ASSIGN(period);
>  	ASSIGN(weight);
>  	ASSIGN(ins_lat);
> -	ASSIGN(p_stage_cyc);
>  	ASSIGN(transaction);
>  	ASSIGN(insn_cnt);
>  	ASSIGN(cyc_cnt);
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index 664bf39567ce..119bce37f4fd 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -390,8 +390,6 @@ extern unsigned int proc_map_timeout;
>  #define PAGE_SIZE_NAME_LEN	32
>  char *get_page_size_name(u64 size, char *str);
>  
> -void arch_perf_parse_sample_weight(struct perf_sample *data, const __u64 *array, u64 type);
> -void arch_perf_synthesize_sample_weight(const struct perf_sample *data, __u64 *array, u64 type);
>  const char *arch_perf_header_entry(const char *se_header);
>  int arch_support_sort_key(const char *sort_key);
>  
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d55482f094bf..27de167855ee 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2846,11 +2846,18 @@ perf_event__check_size(union perf_event *event, unsigned int sample_size)
>  	return 0;
>  }
>  
> -void __weak arch_perf_parse_sample_weight(struct perf_sample *data,
> -					  const __u64 *array,
> -					  u64 type __maybe_unused)
> +static void perf_parse_sample_weight(struct perf_sample *data, const __u64 *array, u64 type)
>  {
> -	data->weight = *array;
> +	union perf_sample_weight weight;
> +
> +	weight.full = *array;
> +	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
> +		data->weight = weight.var1_dw;
> +		data->ins_lat = weight.var2_w;
> +		data->p_stage_cyc_or_retire_lat = weight.var3_w;
> +	} else {
> +		data->weight = weight.full;
> +	}
>  }
>  
>  u64 evsel__bitfield_swap_branch_flags(u64 value)
> @@ -3236,7 +3243,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  
>  	if (type & PERF_SAMPLE_WEIGHT_TYPE) {
>  		OVERFLOW_CHECK_u64(array);
> -		arch_perf_parse_sample_weight(data, array, type);
> +		perf_parse_sample_weight(data, array, type);
>  		array++;
>  	}
>  
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index afc6855327ab..ae9803dca0b1 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -829,7 +829,7 @@ __hists__add_entry(struct hists *hists,
>  			.period	= sample->period,
>  			.weight1 = sample->weight,
>  			.weight2 = sample->ins_lat,
> -			.weight3 = sample->p_stage_cyc,
> +			.weight3 = sample->p_stage_cyc_or_retire_lat,
>  			.latency = al->latency,
>  		},
>  		.parent = sym_parent,
> @@ -846,7 +846,7 @@ __hists__add_entry(struct hists *hists,
>  		.time = hist_time(sample->time),
>  		.weight = sample->weight,
>  		.ins_lat = sample->ins_lat,
> -		.p_stage_cyc = sample->p_stage_cyc,
> +		.p_stage_cyc_or_retire_lat = sample->p_stage_cyc_or_retire_lat,
>  		.simd_flags = sample->simd_flags,
>  	}, *he = hists__findnew_entry(hists, &entry, al, sample_self);
>  
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index c64254088fc7..67033bdabcf4 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -255,7 +255,7 @@ struct hist_entry {
>  	u64			code_page_size;
>  	u64			weight;
>  	u64			ins_lat;
> -	u64			p_stage_cyc;
> +	u64			p_stage_cyc_or_retire_lat;
>  	s32			socket;
>  	s32			cpu;
>  	int			parallelism;
> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> index 4ad4bc118ea5..ec2f3ecf1e1c 100644
> --- a/tools/perf/util/intel-tpebs.c
> +++ b/tools/perf/util/intel-tpebs.c
> @@ -202,8 +202,8 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  	 * latency value will be used. Save the number of samples and the sum of
>  	 * retire latency value for each event.
>  	 */
> -	t->last = sample->retire_lat;
> -	update_stats(&t->stats, sample->retire_lat);
> +	t->last = sample->p_stage_cyc_or_retire_lat;
> +	update_stats(&t->stats, sample->p_stage_cyc_or_retire_lat);
>  	mutex_unlock(tpebs_mtx_get());
>  	return 0;
>  }
> diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
> index 0e96240052e9..3330d18fb5fd 100644
> --- a/tools/perf/util/sample.h
> +++ b/tools/perf/util/sample.h
> @@ -104,10 +104,7 @@ struct perf_sample {
>  	u8  cpumode;
>  	u16 misc;
>  	u16 ins_lat;
> -	union {
> -		u16 p_stage_cyc;
> -		u16 retire_lat;
> -	};
> +	u16 p_stage_cyc_or_retire_lat;
>  	bool no_hw_idx;		/* No hw_idx collected in branch_stack */
>  	char insn[MAX_INSN];
>  	void *raw_data;
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index a320672c264e..451bc24ccfba 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1094,7 +1094,7 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
>  		printf("... weight: %" PRIu64 "", sample->weight);
>  			if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
>  				printf(",0x%"PRIx16"", sample->ins_lat);
> -				printf(",0x%"PRIx16"", sample->p_stage_cyc);
> +				printf(",0x%"PRIx16"", sample->p_stage_cyc_or_retire_lat);
>  			}
>  		printf("\n");
>  	}
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index 45e654653960..dda4ef0b5a73 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -1879,21 +1879,21 @@ struct sort_entry sort_global_ins_lat = {
>  static int64_t
>  sort__p_stage_cyc_cmp(struct hist_entry *left, struct hist_entry *right)
>  {
> -	return left->p_stage_cyc - right->p_stage_cyc;
> +	return left->p_stage_cyc_or_retire_lat - right->p_stage_cyc_or_retire_lat;
>  }
>  
>  static int hist_entry__global_p_stage_cyc_snprintf(struct hist_entry *he, char *bf,
>  					size_t size, unsigned int width)
>  {
>  	return repsep_snprintf(bf, size, "%-*u", width,
> -			he->p_stage_cyc * he->stat.nr_events);
> +			he->p_stage_cyc_or_retire_lat * he->stat.nr_events);
>  }
>  
>  
>  static int hist_entry__p_stage_cyc_snprintf(struct hist_entry *he, char *bf,
>  					size_t size, unsigned int width)
>  {
> -	return repsep_snprintf(bf, size, "%-*u", width, he->p_stage_cyc);
> +	return repsep_snprintf(bf, size, "%-*u", width, he->p_stage_cyc_or_retire_lat);
>  }
>  
>  struct sort_entry sort_local_p_stage_cyc = {
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 2fc4d0537840..449a41900fc4 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1567,10 +1567,16 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
>  	return result;
>  }
>  
> -void __weak arch_perf_synthesize_sample_weight(const struct perf_sample *data,
> +static void perf_synthesize_sample_weight(const struct perf_sample *data,
>  					       __u64 *array, u64 type __maybe_unused)
>  {
>  	*array = data->weight;
> +
> +	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
> +		*array &= 0xffffffff;
> +		*array |= ((u64)data->ins_lat << 32);
> +		*array |= ((u64)data->p_stage_cyc_or_retire_lat << 48);
> +	}
>  }
>  
>  static __u64 *copy_read_group_values(__u64 *array, __u64 read_format,
> @@ -1730,7 +1736,7 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
>  	}
>  
>  	if (type & PERF_SAMPLE_WEIGHT_TYPE) {
> -		arch_perf_synthesize_sample_weight(sample, array, type);
> +		perf_synthesize_sample_weight(sample, array, type);
>  		array++;
>  	}
>  
> -- 
> 2.49.0.1143.g0be31eac6b-goog
> 
