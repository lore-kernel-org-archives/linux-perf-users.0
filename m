Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEF01AA1E0;
	Mon, 12 May 2025 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747063995; cv=none; b=m+2w4j5vPTTer2CZS/QtNj2259ebJg42LeP0p8BGS1yGYx/Boq3yO915wPbMR5pgsX20SLw50gCABmWdM3GeYYewvld1snf5hGHqreEtaFk84TRM2BmMvIMi3VT1LJ7iJW5Ko188eItxtFDkTDUy55sGkxJaKHxsDD/iqTGgkLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747063995; c=relaxed/simple;
	bh=pIYrF35g0YFgMKyqsoLG3Y+QCBxkN9FIc5AxIEnJjVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdaYh4R3F2MFXwt5mnXL5eMsiOOVswmtxn0VPwDS9r1Dng79jpGO4ibsoWgBZa+SEI8X1/7NI7eIfa3NjhucnivPGpU3lc0JsKZGNvG/EGopEecZomI+3RJE8oAcriEonigSu9QkPPjGuBZupSMMGtakqwcd8ddziah8YGBulss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLD7szOA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLD7szOA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747063994; x=1778599994;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pIYrF35g0YFgMKyqsoLG3Y+QCBxkN9FIc5AxIEnJjVc=;
  b=aLD7szOA62nlqTvrmeCtfGdCTd26BpTDr7HVnWpTH8YEHYfIc2LO9xCO
   wSyUFyWZ4E4t6w4RaIgUlLoCzlT3K7ho93mOblH4FhWQZtOi2AxHCd6tq
   QzHxFdRfHhZgdUzagcFxVEC+ApPDe8O3IIUr4+cZCjH2kCTYWnYAUdL/V
   eKP7uXCU1zXSLqRFBSiT7fCjDX9d3cA9EOYtOjGMyjegGjnMz7tvzg5hC
   ENDNs25ZsqApcRy3sEwTTId4jerhtZLSW5FrMF5ZzMz+1JJk0qPFO5OG/
   9b1T/+KZ/n6jLtGkLxAsbBnRutu+52Acp2m+GflhdejBVgLGR8GU5fKPj
   w==;
X-CSE-ConnectionGUID: CGHlGrtwR4+Lz+NTrVdnvw==
X-CSE-MsgGUID: EZpxbp2lRyKwL0pWyprucA==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48736459"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="48736459"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 08:33:13 -0700
X-CSE-ConnectionGUID: ynjvagt8QLGLVl/rVIrGfg==
X-CSE-MsgGUID: RRShvq/HSauIYhzvA3byNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="137871877"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 08:33:12 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 06A6920B5736;
	Mon, 12 May 2025 08:33:50 -0700 (PDT)
Message-ID: <a3282de2-bc5a-444b-b58b-2dc99c420266@linux.intel.com>
Date: Mon, 12 May 2025 11:33:10 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf intel-pt: Fix PEBS-via-PT data_src
To: Adrian Hunter <adrian.hunter@intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20250512093932.79854-1-adrian.hunter@intel.com>
 <20250512093932.79854-2-adrian.hunter@intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250512093932.79854-2-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-12 5:39 a.m., Adrian Hunter wrote:
> The Fixes commit did not add support for decoding PEBS-via-PT data_src.
> Fix by adding support.
> 
> PEBS-via-PT is a feature of some E-core processors, starting with
> processors based on Tremont microarchitecture. Because the kernel only
> supports Intel PT features that are on all processors, there is no support
> for PEBS-via-PT on hybrids.
> 
> Currently that leaves processors based on Tremont, Gracemont and Crestmont,
> however there are no events on Tremont that produce data_src information,
> and for Gracemont and Crestmont there are only:
> 
> 	mem-loads	event=0xd0,umask=0x5,ldlat=3
> 	mem-stores	event=0xd0,umask=0x6
> 
> Affected processors include Alder Lake N (Gracemont), Sierra Forest
> (Crestmont) and Grand Ridge (Crestmont).
>

I think they are the only processors which need to be patched. For the
future platforms, the PEBS-via-PT should be gone. The kernel data_source
functions have been there for a while. I think it's OK to copy & paste
and without worrying about the sync for future platforms.

The patch looks good to me.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> Example:
> 
>  # perf record -d -e intel_pt/branch=0/ -e mem-loads/aux-output/pp uname
> 
>  Before:
> 
>   # perf.before script --itrace=o -Fdata_src
>             0 |OP No|LVL N/A|SNP N/A|TLB N/A|LCK No|BLK  N/A
>             0 |OP No|LVL N/A|SNP N/A|TLB N/A|LCK No|BLK  N/A
> 
>  After:
> 
>   # perf script --itrace=o -Fdata_src
>   10268100142 |OP LOAD|LVL L1 hit|SNP None|TLB L1 or L2 hit|LCK No|BLK  N/A
>   10450100442 |OP LOAD|LVL L2 hit|SNP None|TLB L2 miss|LCK No|BLK  N/A
> 
> Fixes: 975846eddf907 ("perf intel-pt: Add memory information to synthesized PEBS sample")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/intel-pt.c | 205 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 202 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 4e8a9b172fbc..9b1011fe4826 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -127,6 +127,7 @@ struct intel_pt {
>  
>  	bool single_pebs;
>  	bool sample_pebs;
> +	int pebs_data_src_fmt;
>  	struct evsel *pebs_evsel;
>  
>  	u64 evt_sample_type;
> @@ -175,6 +176,7 @@ enum switch_state {
>  struct intel_pt_pebs_event {
>  	struct evsel *evsel;
>  	u64 id;
> +	int data_src_fmt;
>  };
>  
>  struct intel_pt_queue {
> @@ -2272,7 +2274,146 @@ static void intel_pt_add_lbrs(struct branch_stack *br_stack,
>  	}
>  }
>  
> -static int intel_pt_do_synth_pebs_sample(struct intel_pt_queue *ptq, struct evsel *evsel, u64 id)
> +#define P(a, b) PERF_MEM_S(a, b)
> +#define OP_LH (P(OP, LOAD) | P(LVL, HIT))
> +#define LEVEL(x) P(LVLNUM, x)
> +#define REM P(REMOTE, REMOTE)
> +#define SNOOP_NONE_MISS (P(SNOOP, NONE) | P(SNOOP, MISS))
> +
> +#define PERF_PEBS_DATA_SOURCE_GRT_MAX	0x10
> +#define PERF_PEBS_DATA_SOURCE_GRT_MASK	(PERF_PEBS_DATA_SOURCE_GRT_MAX - 1)
> +
> +/* Based on kernel __intel_pmu_pebs_data_source_grt() and pebs_data_source */
> +static const u64 pebs_data_source_grt[PERF_PEBS_DATA_SOURCE_GRT_MAX] = {
> +	P(OP, LOAD) | P(LVL, MISS) | LEVEL(L3) | P(SNOOP, NA),         /* L3 miss|SNP N/A */
> +	OP_LH | P(LVL, L1)  | LEVEL(L1)  | P(SNOOP, NONE),             /* L1 hit|SNP None */
> +	OP_LH | P(LVL, LFB) | LEVEL(LFB) | P(SNOOP, NONE),             /* LFB/MAB hit|SNP None */
> +	OP_LH | P(LVL, L2)  | LEVEL(L2)  | P(SNOOP, NONE),             /* L2 hit|SNP None */
> +	OP_LH | P(LVL, L3)  | LEVEL(L3)  | P(SNOOP, NONE),             /* L3 hit|SNP None */
> +	OP_LH | P(LVL, L3)  | LEVEL(L3)  | P(SNOOP, HIT),              /* L3 hit|SNP Hit */
> +	OP_LH | P(LVL, L3)  | LEVEL(L3)  | P(SNOOP, HITM),             /* L3 hit|SNP HitM */
> +	OP_LH | P(LVL, L3)  | LEVEL(L3)  | P(SNOOP, HITM),             /* L3 hit|SNP HitM */
> +	OP_LH | P(LVL, L3)  | LEVEL(L3)  | P(SNOOPX, FWD),             /* L3 hit|SNP Fwd */
> +	OP_LH | P(LVL, REM_CCE1) | REM | LEVEL(L3) | P(SNOOP, HITM),   /* Remote L3 hit|SNP HitM */
> +	OP_LH | P(LVL, LOC_RAM)  | LEVEL(RAM) | P(SNOOP, HIT),         /* RAM hit|SNP Hit */
> +	OP_LH | P(LVL, REM_RAM1) | REM | LEVEL(L3) | P(SNOOP, HIT),    /* Remote L3 hit|SNP Hit */
> +	OP_LH | P(LVL, LOC_RAM)  | LEVEL(RAM) | SNOOP_NONE_MISS,       /* RAM hit|SNP None or Miss */
> +	OP_LH | P(LVL, REM_RAM1) | LEVEL(RAM) | REM | SNOOP_NONE_MISS, /* Remote RAM hit|SNP None or Miss */
> +	OP_LH | P(LVL, IO)  | LEVEL(NA) | P(SNOOP, NONE),              /* I/O hit|SNP None */
> +	OP_LH | P(LVL, UNC) | LEVEL(NA) | P(SNOOP, NONE),              /* Uncached hit|SNP None */
> +};
> +
> +/* Based on kernel __intel_pmu_pebs_data_source_cmt() and pebs_data_source */
> +static const u64 pebs_data_source_cmt[PERF_PEBS_DATA_SOURCE_GRT_MAX] = {
> +	P(OP, LOAD) | P(LVL, MISS) | LEVEL(L3) | P(SNOOP, NA),       /* L3 miss|SNP N/A */
> +	OP_LH | P(LVL, L1)  | LEVEL(L1)  | P(SNOOP, NONE),           /* L1 hit|SNP None */
> +	OP_LH | P(LVL, LFB) | LEVEL(LFB) | P(SNOOP, NONE),           /* LFB/MAB hit|SNP None */
> +	OP_LH | P(LVL, L2)  | LEVEL(L2)  | P(SNOOP, NONE),           /* L2 hit|SNP None */
> +	OP_LH | P(LVL, L3)  | LEVEL(L3)  | P(SNOOP, NONE),           /* L3 hit|SNP None */
> +	OP_LH | P(LVL, L3)  | LEVEL(L3)  | P(SNOOP, MISS),           /* L3 hit|SNP Hit */
> +	OP_LH | P(LVL, L3)  | LEVEL(L3)  | P(SNOOP, HIT),            /* L3 hit|SNP HitM */
> +	OP_LH | P(LVL, L3)  | LEVEL(L3)  | P(SNOOPX, FWD),           /* L3 hit|SNP HitM */
> +	OP_LH | P(LVL, L3)  | LEVEL(L3)  | P(SNOOP, HITM),           /* L3 hit|SNP Fwd */
> +	OP_LH | P(LVL, REM_CCE1) | REM | LEVEL(L3) | P(SNOOP, HITM), /* Remote L3 hit|SNP HitM */
> +	OP_LH | P(LVL, LOC_RAM)  | LEVEL(RAM) | P(SNOOP, NONE),      /* RAM hit|SNP Hit */
> +	OP_LH | LEVEL(RAM) | REM | P(SNOOP, NONE),                   /* Remote L3 hit|SNP Hit */
> +	OP_LH | LEVEL(RAM) | REM | P(SNOOPX, FWD),                   /* RAM hit|SNP None or Miss */
> +	OP_LH | LEVEL(RAM) | REM | P(SNOOP, HITM),                   /* Remote RAM hit|SNP None or Miss */
> +	OP_LH | P(LVL, IO)  | LEVEL(NA) | P(SNOOP, NONE),            /* I/O hit|SNP None */
> +	OP_LH | P(LVL, UNC) | LEVEL(NA) | P(SNOOP, NONE),            /* Uncached hit|SNP None */
> +};
> +
> +/* Based on kernel pebs_set_tlb_lock() */
> +static inline void pebs_set_tlb_lock(u64 *val, bool tlb, bool lock)
> +{
> +	/*
> +	 * TLB access
> +	 * 0 = did not miss 2nd level TLB
> +	 * 1 = missed 2nd level TLB
> +	 */
> +	if (tlb)
> +		*val |= P(TLB, MISS) | P(TLB, L2);
> +	else
> +		*val |= P(TLB, HIT) | P(TLB, L1) | P(TLB, L2);
> +
> +	/* locked prefix */
> +	if (lock)
> +		*val |= P(LOCK, LOCKED);
> +}
> +
> +/* Based on kernel __grt_latency_data() */
> +static u64 intel_pt_grt_latency_data(u8 dse, bool tlb, bool lock, bool blk,
> +				     const u64 *pebs_data_source)
> +{
> +	u64 val;
> +
> +	dse &= PERF_PEBS_DATA_SOURCE_GRT_MASK;
> +	val = pebs_data_source[dse];
> +
> +	pebs_set_tlb_lock(&val, tlb, lock);
> +
> +	if (blk)
> +		val |= P(BLK, DATA);
> +	else
> +		val |= P(BLK, NA);
> +
> +	return val;
> +}
> +
> +/* Default value for data source */
> +#define PERF_MEM_NA (PERF_MEM_S(OP, NA)    |\
> +		     PERF_MEM_S(LVL, NA)   |\
> +		     PERF_MEM_S(SNOOP, NA) |\
> +		     PERF_MEM_S(LOCK, NA)  |\
> +		     PERF_MEM_S(TLB, NA)   |\
> +		     PERF_MEM_S(LVLNUM, NA))
> +
> +enum DATA_SRC_FORMAT {
> +	DATA_SRC_FORMAT_ERR  = -1,
> +	DATA_SRC_FORMAT_NA   =  0,
> +	DATA_SRC_FORMAT_GRT  =  1,
> +	DATA_SRC_FORMAT_CMT  =  2,
> +};
> +
> +/* Based on kernel grt_latency_data() and cmt_latency_data */
> +static u64 intel_pt_get_data_src(u64 mem_aux_info, int data_src_fmt)
> +{
> +	switch (data_src_fmt) {
> +	case DATA_SRC_FORMAT_GRT: {
> +		union {
> +			u64 val;
> +			struct {
> +				unsigned int dse:4;
> +				unsigned int locked:1;
> +				unsigned int stlb_miss:1;
> +				unsigned int fwd_blk:1;
> +				unsigned int reserved:25;
> +			};
> +		} x = {.val = mem_aux_info};
> +		return intel_pt_grt_latency_data(x.dse, x.stlb_miss, x.locked, x.fwd_blk,
> +						 pebs_data_source_grt);
> +	}
> +	case DATA_SRC_FORMAT_CMT: {
> +		union {
> +			u64 val;
> +			struct {
> +				unsigned int dse:5;
> +				unsigned int locked:1;
> +				unsigned int stlb_miss:1;
> +				unsigned int fwd_blk:1;
> +				unsigned int reserved:24;
> +			};
> +		} x = {.val = mem_aux_info};
> +		return intel_pt_grt_latency_data(x.dse, x.stlb_miss, x.locked, x.fwd_blk,
> +						 pebs_data_source_cmt);
> +	}
> +	default:
> +		return PERF_MEM_NA;
> +	}
> +}
> +
> +static int intel_pt_do_synth_pebs_sample(struct intel_pt_queue *ptq, struct evsel *evsel,
> +					 u64 id, int data_src_fmt)
>  {
>  	const struct intel_pt_blk_items *items = &ptq->state->items;
>  	struct perf_sample sample;
> @@ -2393,6 +2534,18 @@ static int intel_pt_do_synth_pebs_sample(struct intel_pt_queue *ptq, struct evse
>  		}
>  	}
>  
> +	if (sample_type & PERF_SAMPLE_DATA_SRC) {
> +		if (items->has_mem_aux_info && data_src_fmt) {
> +			if (data_src_fmt < 0) {
> +				pr_err("Intel PT missing data_src info\n");
> +				return -1;
> +			}
> +			sample.data_src = intel_pt_get_data_src(items->mem_aux_info, data_src_fmt);
> +		} else {
> +			sample.data_src = PERF_MEM_NA;
> +		}
> +	}
> +
>  	if (sample_type & PERF_SAMPLE_TRANSACTION && items->has_tsx_aux_info) {
>  		u64 ax = items->has_rax ? items->rax : 0;
>  		/* Refer kernel's intel_hsw_transaction() */
> @@ -2413,9 +2566,10 @@ static int intel_pt_synth_single_pebs_sample(struct intel_pt_queue *ptq)
>  {
>  	struct intel_pt *pt = ptq->pt;
>  	struct evsel *evsel = pt->pebs_evsel;
> +	int data_src_fmt = pt->pebs_data_src_fmt;
>  	u64 id = evsel->core.id[0];
>  
> -	return intel_pt_do_synth_pebs_sample(ptq, evsel, id);
> +	return intel_pt_do_synth_pebs_sample(ptq, evsel, id, data_src_fmt);
>  }
>  
>  static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
> @@ -2440,7 +2594,7 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
>  				       hw_id);
>  			return intel_pt_synth_single_pebs_sample(ptq);
>  		}
> -		err = intel_pt_do_synth_pebs_sample(ptq, pe->evsel, pe->id);
> +		err = intel_pt_do_synth_pebs_sample(ptq, pe->evsel, pe->id, pe->data_src_fmt);
>  		if (err)
>  			return err;
>  	}
> @@ -3407,6 +3561,49 @@ static int intel_pt_process_itrace_start(struct intel_pt *pt,
>  					event->itrace_start.tid);
>  }
>  
> +/*
> + * Events with data_src are identified by L1_Hit_Indication
> + * refer https://github.com/intel/perfmon
> + */
> +static int intel_pt_data_src_fmt(struct intel_pt *pt, struct evsel *evsel)
> +{
> +	struct perf_env *env = pt->machine->env;
> +	int fmt = DATA_SRC_FORMAT_NA;
> +
> +	if (!env->cpuid)
> +		return DATA_SRC_FORMAT_ERR;
> +
> +	/*
> +	 * PEBS-via-PT is only supported on E-core non-hybrid. Of those only
> +	 * Gracemont and Crestmont have data_src. Check for:
> +	 *	Alderlake N   (Gracemont)
> +	 *	Sierra Forest (Crestmont)
> +	 *	Grand Ridge   (Crestmont)
> +	 */
> +
> +	if (!strncmp(env->cpuid, "GenuineIntel,6,190,", 19))
> +		fmt = DATA_SRC_FORMAT_GRT;
> +
> +	if (!strncmp(env->cpuid, "GenuineIntel,6,175,", 19) ||
> +	    !strncmp(env->cpuid, "GenuineIntel,6,182,", 19))
> +		fmt = DATA_SRC_FORMAT_CMT;
> +
> +	if (fmt == DATA_SRC_FORMAT_NA)
> +		return fmt;
> +
> +	/*
> +	 * Only data_src events are:
> +	 *	mem-loads	event=0xd0,umask=0x5
> +	 *	mem-stores	event=0xd0,umask=0x6
> +	 */
> +	if (evsel->core.attr.type == PERF_TYPE_RAW &&
> +	    ((evsel->core.attr.config & 0xffff) == 0x5d0 ||
> +	     (evsel->core.attr.config & 0xffff) == 0x6d0))
> +		return fmt;
> +
> +	return DATA_SRC_FORMAT_NA;
> +}
> +
>  static int intel_pt_process_aux_output_hw_id(struct intel_pt *pt,
>  					     union perf_event *event,
>  					     struct perf_sample *sample)
> @@ -3427,6 +3624,7 @@ static int intel_pt_process_aux_output_hw_id(struct intel_pt *pt,
>  
>  	ptq->pebs[hw_id].evsel = evsel;
>  	ptq->pebs[hw_id].id = sample->id;
> +	ptq->pebs[hw_id].data_src_fmt = intel_pt_data_src_fmt(pt, evsel);
>  
>  	return 0;
>  }
> @@ -3976,6 +4174,7 @@ static void intel_pt_setup_pebs_events(struct intel_pt *pt)
>  			}
>  			pt->single_pebs = true;
>  			pt->sample_pebs = true;
> +			pt->pebs_data_src_fmt = intel_pt_data_src_fmt(pt, evsel);
>  			pt->pebs_evsel = evsel;
>  		}
>  	}

