Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7799C23DE;
	Mon, 13 Jan 2025 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736756129; cv=none; b=eF5kfA2Kpzw8VQCWJgMoer4COu4thbC+WDzJWbTs6yzvPqqe/KbVRMcJibrQzyer6RfmWv3GZVLw/bUCunSuIR6Q5vWDVHm5Zr/k7SXjiNCB/Ue0zlVc4JjkEl5I/32tBfgkJg4AR0zUrR2Jq+C1yXY6Cr42PSFGw+nipwuILjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736756129; c=relaxed/simple;
	bh=YsY/tgYmhVSOXgcKsftN3k40h8z/EkYIRpQJIIkD/3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fBnEl3Bg8J2+c/lpq/co22NPtFXpPy1/6+THy3nxYcHNn212b5dfHi2GtVKSenqYQYsjSIY7eu6G6wVsWCMjtry7poF9gplizqhbZRpbNzc420dqOZ+JmEdf+bQ7WRujRqf8gkKg6Fo6hfayUBVYfn5RoSrlceW73nQq38mpaxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EnhmkwYb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EnhmkwYb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736756127; x=1768292127;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YsY/tgYmhVSOXgcKsftN3k40h8z/EkYIRpQJIIkD/3I=;
  b=EnhmkwYbGA+y/5i5wYi5QMvMXF8Ftqg7N3gpK9MrIIbKkHd5qaGRkDqj
   87HLhIfFH38G4Rl07uzpIUmF2+QHCuxM76jmLlvZCrXkPlsuU06R6ptHJ
   6X1Bhe1Dm2pOjrrvAvJQ+73R86P44HeZtUKyTaZ2A5p4x7k/t1q4bHTff
   m4aT8Yx+yUKZTLmsyD89pvGMv6xv85DxA2SwqeJh4BKGoBUJF6kq7Zpee
   NpgUqzYn7W2bAqk4RbOe/V9mbJA0T30Jcs2VLNIFY1eiAHkcxQoeHK0Gp
   ycF9W9ygQRMOkwFbrBeDclMo7+CmGOO1SrmleNjkFESoRusf4cKG23WYy
   A==;
X-CSE-ConnectionGUID: lhE/3sfLSGyZoRqbEH5N+A==
X-CSE-MsgGUID: 9CctfNBvRlGGqNoEViUrGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="37022935"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="37022935"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:15:26 -0800
X-CSE-ConnectionGUID: dVrya6aXS8eZz+aKA155Nw==
X-CSE-MsgGUID: SCHyj2PKSn2pRwaj0PVOwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108462588"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.16.163])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:15:22 -0800
Message-ID: <c29a4cdc-9419-4f1e-92bc-a75c3b10e37d@intel.com>
Date: Mon, 13 Jan 2025 10:15:16 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf intel-pt: don't zero the whole perf_sample
To: Tavian Barnes <tavianator@tavianator.com>,
 linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Andrew Kreimer
 <algonell@gmail.com>, linux-kernel@vger.kernel.org
References: <d841b97b3ad2ca8bcab07e4293375fb7c32dfce7.1736618095.git.tavianator@tavianator.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <d841b97b3ad2ca8bcab07e4293375fb7c32dfce7.1736618095.git.tavianator@tavianator.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/01/25 19:56, Tavian Barnes wrote:
> C designated initializers like
> 
>     struct perf_sample sample = { .ip = 0, };
> 
> set every unmentioned field of the struct to zero.  But since
> sizeof(struct perf_sample) == 1384, this takes a long time.
> 
> struct perf_sample does not need to be fully initialized, and even

Yes it does need to be fully initialized.  Leaving members
uninitialized in the hope that they never get used adds to
code complexity e.g. how do you know they never are used,
or future members never will be used.

> .ip = 0 is unnecessary because intel_pt_prep_*_sample() will initialize
> it.  Skipping the initialization saves about 2.5% of the execution time
> when running
> 
>     $ perf script --itrace=i0
> 
> Signed-off-by: Tavian Barnes <tavianator@tavianator.com>
> ---
>  tools/perf/util/intel-pt.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 30be6dfe09eb..c829398c5bb9 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -1764,7 +1764,7 @@ static int intel_pt_synth_branch_sample(struct intel_pt_queue *ptq)
>  {
>  	struct intel_pt *pt = ptq->pt;
>  	union perf_event *event = ptq->event_buf;
> -	struct perf_sample sample = { .ip = 0, };
> +	struct perf_sample sample;
>  	struct dummy_branch_stack {
>  		u64			nr;
>  		u64			hw_idx;
> @@ -1835,7 +1835,7 @@ static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
>  {
>  	struct intel_pt *pt = ptq->pt;
>  	union perf_event *event = ptq->event_buf;
> -	struct perf_sample sample = { .ip = 0, };
> +	struct perf_sample sample;
>  
>  	if (intel_pt_skip_event(pt))
>  		return 0;
> @@ -1867,7 +1867,7 @@ static int intel_pt_synth_cycle_sample(struct intel_pt_queue *ptq)
>  {
>  	struct intel_pt *pt = ptq->pt;
>  	union perf_event *event = ptq->event_buf;
> -	struct perf_sample sample = { .ip = 0, };
> +	struct perf_sample sample;
>  	u64 period = 0;
>  
>  	if (ptq->sample_ipc)
> @@ -1894,7 +1894,7 @@ static int intel_pt_synth_transaction_sample(struct intel_pt_queue *ptq)
>  {
>  	struct intel_pt *pt = ptq->pt;
>  	union perf_event *event = ptq->event_buf;
> -	struct perf_sample sample = { .ip = 0, };
> +	struct perf_sample sample;
>  
>  	if (intel_pt_skip_event(pt))
>  		return 0;
> @@ -1927,7 +1927,7 @@ static int intel_pt_synth_ptwrite_sample(struct intel_pt_queue *ptq)
>  {
>  	struct intel_pt *pt = ptq->pt;
>  	union perf_event *event = ptq->event_buf;
> -	struct perf_sample sample = { .ip = 0, };
> +	struct perf_sample sample;
>  	struct perf_synth_intel_ptwrite raw;
>  
>  	if (intel_pt_skip_event(pt))
> @@ -1953,7 +1953,7 @@ static int intel_pt_synth_cbr_sample(struct intel_pt_queue *ptq)
>  {
>  	struct intel_pt *pt = ptq->pt;
>  	union perf_event *event = ptq->event_buf;
> -	struct perf_sample sample = { .ip = 0, };
> +	struct perf_sample sample;
>  	struct perf_synth_intel_cbr raw;
>  	u32 flags;
>  
> @@ -1983,7 +1983,7 @@ static int intel_pt_synth_psb_sample(struct intel_pt_queue *ptq)
>  {
>  	struct intel_pt *pt = ptq->pt;
>  	union perf_event *event = ptq->event_buf;
> -	struct perf_sample sample = { .ip = 0, };
> +	struct perf_sample sample;
>  	struct perf_synth_intel_psb raw;
>  
>  	if (intel_pt_skip_event(pt))
> @@ -2009,7 +2009,7 @@ static int intel_pt_synth_mwait_sample(struct intel_pt_queue *ptq)
>  {
>  	struct intel_pt *pt = ptq->pt;
>  	union perf_event *event = ptq->event_buf;
> -	struct perf_sample sample = { .ip = 0, };
> +	struct perf_sample sample;
>  	struct perf_synth_intel_mwait raw;
>  
>  	if (intel_pt_skip_event(pt))
> @@ -2034,7 +2034,7 @@ static int intel_pt_synth_pwre_sample(struct intel_pt_queue *ptq)
>  {
>  	struct intel_pt *pt = ptq->pt;
>  	union perf_event *event = ptq->event_buf;
> -	struct perf_sample sample = { .ip = 0, };
> +	struct perf_sample sample;
>  	struct perf_synth_intel_pwre raw;
>  
>  	if (intel_pt_skip_event(pt))
> @@ -2059,7 +2059,7 @@ static int intel_pt_synth_exstop_sample(struct intel_pt_queue *ptq)
>  {
>  	struct intel_pt *pt = ptq->pt;
>  	union perf_event *event = ptq->event_buf;
> -	struct perf_sample sample = { .ip = 0, };
> +	struct perf_sample sample;
>  	struct perf_synth_intel_exstop raw;
>  
>  	if (intel_pt_skip_event(pt))
> @@ -2084,7 +2084,7 @@ static int intel_pt_synth_pwrx_sample(struct intel_pt_queue *ptq)
>  {
>  	struct intel_pt *pt = ptq->pt;
>  	union perf_event *event = ptq->event_buf;
> -	struct perf_sample sample = { .ip = 0, };
> +	struct perf_sample sample;
>  	struct perf_synth_intel_pwrx raw;
>  
>  	if (intel_pt_skip_event(pt))
> @@ -2235,7 +2235,7 @@ static void intel_pt_add_lbrs(struct branch_stack *br_stack,
>  static int intel_pt_do_synth_pebs_sample(struct intel_pt_queue *ptq, struct evsel *evsel, u64 id)
>  {
>  	const struct intel_pt_blk_items *items = &ptq->state->items;
> -	struct perf_sample sample = { .ip = 0, };
> +	struct perf_sample sample;
>  	union perf_event *event = ptq->event_buf;
>  	struct intel_pt *pt = ptq->pt;
>  	u64 sample_type = evsel->core.attr.sample_type;
> @@ -2407,7 +2407,7 @@ static int intel_pt_synth_events_sample(struct intel_pt_queue *ptq)
>  {
>  	struct intel_pt *pt = ptq->pt;
>  	union perf_event *event = ptq->event_buf;
> -	struct perf_sample sample = { .ip = 0, };
> +	struct perf_sample sample;
>  	struct {
>  		struct perf_synth_intel_evt cfe;
>  		struct perf_synth_intel_evd evd[INTEL_PT_MAX_EVDS];
> @@ -2446,7 +2446,7 @@ static int intel_pt_synth_iflag_chg_sample(struct intel_pt_queue *ptq)
>  {
>  	struct intel_pt *pt = ptq->pt;
>  	union perf_event *event = ptq->event_buf;
> -	struct perf_sample sample = { .ip = 0, };
> +	struct perf_sample sample;
>  	struct perf_synth_intel_iflag_chg raw;
>  
>  	if (intel_pt_skip_event(pt))

