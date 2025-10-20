Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9571533987;
	Mon, 20 Oct 2025 03:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760929240; cv=none; b=pFoUkHdBp66JfwqnDiG7ldUWqEB0D7ajE/ZzyJZ6jh2D2cm7wGuiXh/fU0hTxft66nXqmbOFmsGPumBatm/L/ljxyhfbiSVqNYiZpZv1epJaQgWdm9YmoF66V8wOR7Mo+3FNPQ1oTAdIAekmDt94/h9dA59eTy/IB1MuNTx+ya8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760929240; c=relaxed/simple;
	bh=+nIhC2zKkfNtfe6nkQ4e2tFpfBvzUXgK2DHwB/MiGv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fOfbYDrWmrip1hKm3qucgjcrCFQEuvhfYHTDuTewlqTUAfG2YI2beW0e0ePSZXPBUOTJtlEigry1Hi3aORdkvLVFmm7bYHb4YzzGW8TGNnh2Kj2GcRbKcrbLtcVCtGJJ4RtVtNM/s+VgoPOnv3KEF5ddvz9BoaHuwL8dTwoaZL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftRHrTDV; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftRHrTDV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760929238; x=1792465238;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=+nIhC2zKkfNtfe6nkQ4e2tFpfBvzUXgK2DHwB/MiGv0=;
  b=ftRHrTDVWiELbanLtz+XoG9leNBYDEmb16/RpISb1QrenhqlOLn3eMjX
   0RD+skKDGOhH6CgUKSOCojpINsQvtreQwyO+f4YTEAA1CN9hrqc8zg1CG
   AFVJlvsjOX3MPpvvoYn6pg9a7Lss7KTPWEHPcApTc8ydkw0SNjVlYD6LG
   5inWJH4hTcnhgYyc9IwouiraLUyxpr+3gZhdheOA6dvmGimvCV66jyRjA
   uexJBIE1qTd/UjN13l1u1G+WbH5oUvRtuGME3nBGz5g4lxE94uhTnRhPF
   k9zBMQbTjfWoTuxLgdB5u2nksWOvXAT/7x/fuZt5fOFK9+SNQIvXN+53u
   w==;
X-CSE-ConnectionGUID: HME6l/fGTe+e/sv8Hmrwkg==
X-CSE-MsgGUID: 5pSvx6qYStClwwzu4inO7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="62748004"
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="62748004"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 20:00:34 -0700
X-CSE-ConnectionGUID: A/8Q+EhtR4WAxmFR9buTVQ==
X-CSE-MsgGUID: /mDlHRkxSiyymjE4BZwBOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,241,1754982000"; 
   d="scan'208";a="182778010"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.233.173]) ([10.124.233.173])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 20:00:31 -0700
Message-ID: <86dc089a-1a0d-48e5-9aaa-5ae0ddf22a7c@linux.intel.com>
Date: Mon, 20 Oct 2025 11:00:28 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf parse-events: Make X modifier more respectful of
 groups
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251017230357.15663-1-irogers@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251017230357.15663-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/18/2025 7:03 AM, Ian Rogers wrote:
> Events with an X modifier were reordered within a group, for example
> slots was made the leader in:
> ```
> $ perf record -e '{cpu/mem-stores/ppu,cpu/slots/uX}' -- sleep 1
> ```
>
> Fix by making `dont_regroup` evsels always use their index for
> sorting. Make the cur_leader, when fixing the groups, be that of
> `dont_regroup` evsel so that the `dont_regroup` evsel doesn't become a
> leader.
>
> On a tigerlake this patch corrects this and meets expectations in:
> ```
> $ perf stat -e '{cpu/mem-stores/,cpu/slots/uX}' -a -- sleep 0.1
>
>  Performance counter stats for 'system wide':
>
>         83,458,652      cpu/mem-stores/
>      2,720,854,880      cpu/slots/uX
>
>        0.103780587 seconds time elapsed
>
> $ perf stat -e 'slots,slots:X' -a -- sleep 0.1
>
>  Performance counter stats for 'system wide':
>
>        732,042,247      slots                (48.96%)
>        643,288,155      slots:X              (51.04%)
>
>        0.102731018 seconds time elapsed
> ```
>
> Closes: https://lore.kernel.org/lkml/18f20d38-070c-4e17-bc90-cf7102e1e53d@linux.intel.com/
> Fixes: 035c17893082 ("perf parse-events: Add 'X' modifier to exclude an event from being regrouped")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 3aec86aebdc6..0c0dc20b1c13 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1973,14 +1973,18 @@ static int evlist__cmp(void *_fg_idx, const struct list_head *l, const struct li
>  	 * event's index is used. An index may be forced for events that
>  	 * must be in the same group, namely Intel topdown events.
>  	 */
> -	if (*force_grouped_idx != -1 && arch_evsel__must_be_in_group(lhs)) {
> +	if (lhs->dont_regroup) {
> +		lhs_sort_idx = lhs_core->idx;
> +	} else if (*force_grouped_idx != -1 && arch_evsel__must_be_in_group(lhs)) {
>  		lhs_sort_idx = *force_grouped_idx;
>  	} else {
>  		bool lhs_has_group = lhs_core->leader != lhs_core || lhs_core->nr_members > 1;
>  
>  		lhs_sort_idx = lhs_has_group ? lhs_core->leader->idx : lhs_core->idx;
>  	}
> -	if (*force_grouped_idx != -1 && arch_evsel__must_be_in_group(rhs)) {
> +	if (rhs->dont_regroup) {
> +		rhs_sort_idx = rhs_core->idx;
> +	} else if (*force_grouped_idx != -1 && arch_evsel__must_be_in_group(rhs)) {
>  		rhs_sort_idx = *force_grouped_idx;
>  	} else {
>  		bool rhs_has_group = rhs_core->leader != rhs_core || rhs_core->nr_members > 1;
> @@ -2078,10 +2082,10 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
>  	 */
>  	idx = 0;
>  	list_for_each_entry(pos, list, core.node) {
> -		const struct evsel *pos_leader = evsel__leader(pos);
> +		struct evsel *pos_leader = evsel__leader(pos);
>  		const char *pos_pmu_name = pos->group_pmu_name;
>  		const char *cur_leader_pmu_name;
> -		bool pos_force_grouped = force_grouped_idx != -1 &&
> +		bool pos_force_grouped = force_grouped_idx != -1 && !pos->dont_regroup &&
>  			arch_evsel__must_be_in_group(pos);
>  
>  		/* Reset index and nr_members. */
> @@ -2095,8 +2099,8 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
>  		 * groups can't span PMUs.
>  		 */
>  		if (!cur_leader || pos->dont_regroup) {
> -			cur_leader = pos;
> -			cur_leaders_grp = &pos->core;
> +			cur_leader = pos->dont_regroup ? pos_leader : pos;
> +			cur_leaders_grp = &cur_leader->core;
>  			if (pos_force_grouped)
>  				force_grouped_leader = pos;
>  		}

LGTM. Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Thanks for fixing this issue so quickly.


