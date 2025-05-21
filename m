Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35C20FA97;
	Wed, 21 May 2025 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842129; cv=none; b=gwKIRsXcNaJ4MBN1ggAKGqXq/lFe/kWVYHQ2xIJ6wB2MU1PUDLUayxJAM/94vJo+pXqhWt62zYpF3TSIvvJdWBMtYe2uxeRnRr0dDPAmLPrMhsOMKW5wzIA0VWjwdaWBi7PddZIR5awZ9EAjZZpGGGrFblyj5j1D7YdtHkW/YhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842129; c=relaxed/simple;
	bh=j4e9Qrdtw4z7zim9wizUAZ1R5kNNmyKIM+RSXDB3yho=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ai8jHck5dgSd5ryBuDTC0GkSlcSTMEAGxflJacJDxz0sEq/ji03ZaZyF7WlOWJoxDmfroznL1Lj2Qcr+kk7Ii6ymN6X4n73IZ2VV8BMAuDDcVxZCrKUPDRVIwJKwIFIJGz4uU2C8mMyz0jP8GDd1vVsOij2OkwHGMs49Og3njmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IudMREEB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IudMREEB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747842128; x=1779378128;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=j4e9Qrdtw4z7zim9wizUAZ1R5kNNmyKIM+RSXDB3yho=;
  b=IudMREEBnN9aTX3ViW2nSKZWgbE6yr1wVbJk7T5QEFHph/ENk4T0O8rs
   urcX20JyuoLLj+nHRKZSzJ+qMlONxW2qOZPDzVdSGa+BfCOLe5a34aqdq
   QnB12sQ0g5s7380fxwUCDNGedcPXUU/I0l6J0MBiWd0TCkju+eUYgPRN4
   s72qGiV/Z+kvxS5NYF2UlanFbC9bJTWp+Te04ranIXbeEGm3q/nxAC6Pk
   +CWMSIS5+sn+WkXS1ZFQaFt/OFRrpYrLfF+WjuQJQXI+bjr5+7wXGu4Sw
   mQszEKeaNpLeTdaYV63K24+hADECkkx1JzypE2al6lvWyPaxi7mvbTGp7
   w==;
X-CSE-ConnectionGUID: vdCFejm5Qtevf3CK94E8Qw==
X-CSE-MsgGUID: E+5sTMB3TQulAq3yG+9xvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="48946056"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="48946056"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 08:42:05 -0700
X-CSE-ConnectionGUID: Fk/GwzLhScGxcFICq+YCUg==
X-CSE-MsgGUID: 4QhCtQLOQwyzkA2G52qK2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="140647730"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 08:42:04 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 8671320B5736;
	Wed, 21 May 2025 08:42:15 -0700 (PDT)
Message-ID: <14a4c1e3-11e1-43d2-933b-10d4b2c155a1@linux.intel.com>
Date: Wed, 21 May 2025 11:42:00 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] perf sample: Remove arch notion of sample parsing
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>,
 Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>,
 Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
 Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming
 <matt@readmodwrite.com>, Chun-Tse Shao <ctshao@google.com>,
 Ben Gainey <ben.gainey@arm.com>, Song Liu <song@kernel.org>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20250521135500.677508-1-irogers@google.com>
 <20250521135500.677508-2-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250521135500.677508-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-21 9:54 a.m., Ian Rogers wrote:
> By definition arch sample parsing and synthesis will inhibit certain
> kinds of cross-platform record then analysis (report, script,
> etc.). Remove arch_perf_parse_sample_weight and
> arch_perf_synthesize_sample_weight replacing with a common
> implementation. Combine perf_sample p_stage_cyc and retire_lat to
> capture the differing uses regardless of compiled for architecture.
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
> index ddacef881af2..7e61ddfa66b8 100644
> --- a/tools/perf/util/dlfilter.c
> +++ b/tools/perf/util/dlfilter.c
> @@ -526,7 +526,7 @@ int dlfilter__do_filter_event(struct dlfilter *d,
>  	ASSIGN(period);
>  	ASSIGN(weight);
>  	ASSIGN(ins_lat);
> -	ASSIGN(p_stage_cyc);
> +	d_sample.p_stage_cyc = sample->p_stage_cyc_or_retire_lat;

Can you please move it out of the ASSIGN() area? Maybe right after
d_sample.size  = sizeof(d_sample);.
It looks strange to insert a non-macro assignment here.


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
> index d55482f094bf..097ab98bb81a 100644
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
> +	if (type & PERF_SAMPLE_WEIGHT) {
> +		data->weight = weight.full;
> +	} else {
> +		data->weight = weight.var1_dw;
> +		data->ins_lat = weight.var2_w;
> +		data->p_stage_cyc_or_retire_lat = weight.var3_w;
> +	}
>  }
>  

It works for X86, but I'm not sure other ARCHs.
Since the PERF_SAMPLE_WEIGHT_STRUCT is newly added type, should it be
safer to do the below?
	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
		data->weight = weight.var1_dw;
		data->ins_lat = weight.var2_w;
		data->p_stage_cyc_or_retire_lat = weight.var3_w;
	} else
		data->weight = weight.full;

The default behavior is always data->weight = weight.full; unless an
ARCH apply the new type PERF_SAMPLE_WEIGHT_STRUCT.

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

It works for X86, but powerpc seems have a different behavior. The
p_stage_cyc is missed here. Not sure if it intends.

Thanks,
Kan

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

