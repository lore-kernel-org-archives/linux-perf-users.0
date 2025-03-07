Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E56F1E1DEE;
	Fri,  7 Mar 2025 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341160; cv=none; b=dtqMHSdwg5lFBOdZ0wS44okZc1yo+JVJzFl6wdLPKV6ww8HqZxVXjYrTBtSKIpfwpEo9pyLab0TxK76xGliS1lY78Optz6KE7VSirBrVOZAHa2m6yFGQQqmiSph9D6ToN5xZC7IQL9oJev2DJWHOi7FCxO3mWmyOjDg9wkhXmK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341160; c=relaxed/simple;
	bh=M+281YHHKdHfMn68/HHlu54H0+BomZX22hWoyjy9IxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FsuHPgxFpWq4I8R95sc7jLumWt/u3Fp8m5GW16NsKFvzmIke0rUIa/zCylp56j/hV8+LWJBlE0LuaVVflee18zxhGnZ5f5gfTMd5e8jJTRKSuaR1pvWsj4AHWhyHPQLsojastEiTh2pfGEeJnJUHaRj1frfvKEQQ4/jsyC8Iai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxVt61gh; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxVt61gh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741341160; x=1772877160;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=M+281YHHKdHfMn68/HHlu54H0+BomZX22hWoyjy9IxM=;
  b=cxVt61ghw7EmyNa7/OxxDmG/vs10qqgWJOU08LLeYRo46YCU2AEl4bst
   xUnObek6c/wKtQe0OIiphfuxKK/V3EatPEpi2K2F8Y+YSdSCs//ciTSSE
   2odFVv2svuhDeemWtn390VaEGglDnl7hSwoUL2Ve1LWDzCmanhHZTgx5D
   Yv83UJbhfs/RdB/FHaDRPD5gsVt5LfVp6Tm+dAxvuZVNBtoIXFcsNJvpB
   /IWpZNGM04ixu/IHaKrD9cxq/CUeAm6Y9RdCCo5JUE05ErFVjlbJqbR1j
   Flp1egqeVocwxso/auDk8owSqx3IXxPmCX9B8LckS7Z9h/FxlMSwQXZ6O
   w==;
X-CSE-ConnectionGUID: pOLiiHS4QUScaqxpPOLtcw==
X-CSE-MsgGUID: SUcwpYicRXGNxqFzhvGKBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53373302"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="53373302"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 01:52:39 -0800
X-CSE-ConnectionGUID: G9NIp5EGQKSDY+3n1vsGtw==
X-CSE-MsgGUID: ioNmOyZ8TjqfhY38evX2WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="119020581"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 01:52:35 -0800
Message-ID: <97416612-68a4-47b4-a9b3-c8290c1088ed@linux.intel.com>
Date: Fri, 7 Mar 2025 17:52:32 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] perf parse-events: Corrections to topdown sorting
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>,
 Dominique Martinet <asmadeus@codewreck.org>, Andi Kleen
 <ak@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Falcon <thomas.falcon@intel.com>
References: <20250307023906.1135613-1-irogers@google.com>
 <20250307023906.1135613-3-irogers@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250307023906.1135613-3-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/7/2025 10:39 AM, Ian Rogers wrote:
> In the case of '{instructions,slots},faults,topdown-retiring' the
> first event that must be grouped, slots, is ignored causing the
> topdown-retiring event not to be adjacent to the group it needs to be
> inserted into. Don't ignore the group members when computing the
> force_grouped_index.
>
> Make the force_grouped_index be for the leader of the group it is
> within and always use it first rather than a group leader index so
> that topdown events may be sorted from one group into another.
>
> As the PMU name comparison applies to moving events in the same group
> ensure the name ordering is always respected.
>
> Change the group splitting logic to not group if there are no other
> topdown events and to fix cases where the force group leader wasn't
> being grouped with the other members of its group.
>
> Reported-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Closes: https://lore.kernel.org/lkml/20250224083306.71813-2-dapeng1.mi@linux.intel.com/
> Closes: https://lore.kernel.org/lkml/f7e4f7e8-748c-4ec7-9088-0e844392c11a@linux.intel.com/
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/util/evlist.c |  15 ++--
>  tools/perf/util/parse-events.c    | 145 ++++++++++++++++++++----------
>  2 files changed, 105 insertions(+), 55 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> index 447a734e591c..ed205d1b207d 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -76,12 +76,15 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
>  		 * topdown metrics events are already in same group with slots
>  		 * event, do nothing.
>  		 */
> -		if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs) &&
> -		    lhs->core.leader != rhs->core.leader)
> -			return -1;
> -		if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
> -		    lhs->core.leader != rhs->core.leader)
> -			return 1;
> +		if (lhs->core.leader != rhs->core.leader) {
> +			bool lhs_topdown = arch_is_topdown_metrics(lhs);
> +			bool rhs_topdown = arch_is_topdown_metrics(rhs);
> +
> +			if (lhs_topdown && !rhs_topdown)
> +				return -1;
> +			if (!lhs_topdown && rhs_topdown)
> +				return 1;
> +		}
>  	}
>  
>  	/* Retire latency event should not be group leader*/
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 35e48fe56dfa..5152fd5a6ead 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1980,48 +1980,55 @@ static int evlist__cmp(void *_fg_idx, const struct list_head *l, const struct li
>  	int *force_grouped_idx = _fg_idx;
>  	int lhs_sort_idx, rhs_sort_idx, ret;
>  	const char *lhs_pmu_name, *rhs_pmu_name;
> -	bool lhs_has_group, rhs_has_group;
>  
>  	/*
> -	 * First sort by grouping/leader. Read the leader idx only if the evsel
> -	 * is part of a group, by default ungrouped events will be sorted
> -	 * relative to grouped events based on where the first ungrouped event
> -	 * occurs. If both events don't have a group we want to fall-through to
> -	 * the arch specific sorting, that can reorder and fix things like
> -	 * Intel's topdown events.
> +	 * Get the indexes of the 2 events to sort. If the events are
> +	 * in groups then the leader's index is used otherwise the
> +	 * event's index is used. An index may be forced for events that
> +	 * must be in the same group, namely Intel topdown events.
>  	 */
> -	if (lhs_core->leader != lhs_core || lhs_core->nr_members > 1) {
> -		lhs_has_group = true;
> -		lhs_sort_idx = lhs_core->leader->idx;
> +	if (*force_grouped_idx != -1 && arch_evsel__must_be_in_group(lhs)) {
> +		lhs_sort_idx = *force_grouped_idx;
>  	} else {
> -		lhs_has_group = false;
> -		lhs_sort_idx = *force_grouped_idx != -1 && arch_evsel__must_be_in_group(lhs)
> -			? *force_grouped_idx
> -			: lhs_core->idx;
> -	}
> -	if (rhs_core->leader != rhs_core || rhs_core->nr_members > 1) {
> -		rhs_has_group = true;
> -		rhs_sort_idx = rhs_core->leader->idx;
> +		bool lhs_has_group = lhs_core->leader != lhs_core || lhs_core->nr_members > 1;
> +
> +		lhs_sort_idx = lhs_has_group ? lhs_core->leader->idx : lhs_core->idx;
> +	}
> +	if (*force_grouped_idx != -1 && arch_evsel__must_be_in_group(rhs)) {
> +		rhs_sort_idx = *force_grouped_idx;
>  	} else {
> -		rhs_has_group = false;
> -		rhs_sort_idx = *force_grouped_idx != -1 && arch_evsel__must_be_in_group(rhs)
> -			? *force_grouped_idx
> -			: rhs_core->idx;
> +		bool rhs_has_group = rhs_core->leader != rhs_core || rhs_core->nr_members > 1;
> +
> +		rhs_sort_idx = rhs_has_group ? rhs_core->leader->idx : rhs_core->idx;
>  	}
>  
> +	/* If the indices differ then respect the insertion order. */
>  	if (lhs_sort_idx != rhs_sort_idx)
>  		return lhs_sort_idx - rhs_sort_idx;
>  
> -	/* Group by PMU if there is a group. Groups can't span PMUs. */
> -	if (lhs_has_group && rhs_has_group) {
> -		lhs_pmu_name = lhs->group_pmu_name;
> -		rhs_pmu_name = rhs->group_pmu_name;
> -		ret = strcmp(lhs_pmu_name, rhs_pmu_name);
> -		if (ret)
> -			return ret;
> -	}
> +	/*
> +	 * Ignoring forcing, lhs_sort_idx == rhs_sort_idx so lhs and rhs should
> +	 * be in the same group. Events in the same group need to be ordered by
> +	 * their grouping PMU name as the group will be broken to ensure only
> +	 * events on the same PMU are programmed together.
> +	 *
> +	 * With forcing the lhs_sort_idx == rhs_sort_idx shows that one or both
> +	 * events are being forced to be at force_group_index. If only one event
> +	 * is being forced then the other event is the group leader of the group
> +	 * we're trying to force the event into. Ensure for the force grouped
> +	 * case that the PMU name ordering is also respected.
> +	 */
> +	lhs_pmu_name = lhs->group_pmu_name;
> +	rhs_pmu_name = rhs->group_pmu_name;
> +	ret = strcmp(lhs_pmu_name, rhs_pmu_name);
> +	if (ret)
> +		return ret;
>  
> -	/* Architecture specific sorting. */
> +	/*
> +	 * Architecture specific sorting, by default sort events in the same
> +	 * group with the same PMU by their insertion index. On Intel topdown
> +	 * constraints must be adhered to - slots first, etc.
> +	 */
>  	return arch_evlist__cmp(lhs, rhs);
>  }
>  
> @@ -2030,9 +2037,11 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
>  	int idx = 0, force_grouped_idx = -1;
>  	struct evsel *pos, *cur_leader = NULL;
>  	struct perf_evsel *cur_leaders_grp = NULL;
> -	bool idx_changed = false, cur_leader_force_grouped = false;
> +	bool idx_changed = false;
>  	int orig_num_leaders = 0, num_leaders = 0;
>  	int ret;
> +	struct evsel *force_grouped_leader = NULL;
> +	bool last_event_was_forced_leader = false;
>  
>  	/*
>  	 * Compute index to insert ungrouped events at. Place them where the
> @@ -2055,10 +2064,13 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
>  		 */
>  		pos->core.idx = idx++;
>  
> -		/* Remember an index to sort all forced grouped events together to. */
> -		if (force_grouped_idx == -1 && pos == pos_leader && pos->core.nr_members < 2 &&
> -		    arch_evsel__must_be_in_group(pos))
> -			force_grouped_idx = pos->core.idx;
> +		/*
> +		 * Remember an index to sort all forced grouped events
> +		 * together to. Use the group leader as some events
> +		 * must appear first within the group.
> +		 */
> +		if (force_grouped_idx == -1 && arch_evsel__must_be_in_group(pos))
> +			force_grouped_idx = pos_leader->core.idx;
>  	}
>  
>  	/* Sort events. */
> @@ -2086,31 +2098,66 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
>  		 * Set the group leader respecting the given groupings and that
>  		 * groups can't span PMUs.
>  		 */
> -		if (!cur_leader)
> +		if (!cur_leader) {
>  			cur_leader = pos;
> +			cur_leaders_grp = &pos->core;
> +			if (pos_force_grouped)
> +				force_grouped_leader = pos;
> +		}
>  
>  		cur_leader_pmu_name = cur_leader->group_pmu_name;
> -		if ((cur_leaders_grp != pos->core.leader &&
> -		     (!pos_force_grouped || !cur_leader_force_grouped)) ||
> -		    strcmp(cur_leader_pmu_name, pos_pmu_name)) {
> -			/* Event is for a different group/PMU than last. */
> +		if (strcmp(cur_leader_pmu_name, pos_pmu_name)) {
> +			/* PMU changed so the group/leader must change. */
>  			cur_leader = pos;
> -			/*
> -			 * Remember the leader's group before it is overwritten,
> -			 * so that later events match as being in the same
> -			 * group.
> -			 */
>  			cur_leaders_grp = pos->core.leader;
> +			if (pos_force_grouped && force_grouped_leader == NULL)
> +				force_grouped_leader = pos;
> +		} else if (cur_leaders_grp != pos->core.leader) {
> +			bool split_even_if_last_leader_was_forced = true;
> +
>  			/*
> -			 * Avoid forcing events into groups with events that
> -			 * don't need to be in the group.
> +			 * Event is for a different group. If the last event was
> +			 * the forced group leader then subsequent group events
> +			 * and forced events should be in the same group. If
> +			 * there are no other forced group events then the
> +			 * forced group leader wasn't really being forced into a
> +			 * group, it just set arch_evsel__must_be_in_group, and
> +			 * we don't want the group to split here.
>  			 */
> -			cur_leader_force_grouped = pos_force_grouped;
> +			if (force_grouped_idx != -1 && last_event_was_forced_leader) {
> +				struct evsel *pos2 = pos;
> +				/*
> +				 * Search the whole list as the group leaders
> +				 * aren't currently valid.
> +				 */
> +				list_for_each_entry_continue(pos2, list, core.node) {
> +					if (pos->core.leader == pos2->core.leader &&
> +					    arch_evsel__must_be_in_group(pos2)) {
> +						split_even_if_last_leader_was_forced = false;
> +						break;
> +					}
> +				}
> +			}
> +			if (!last_event_was_forced_leader || split_even_if_last_leader_was_forced) {
> +				if (pos_force_grouped) {
> +					if (force_grouped_leader) {
> +						cur_leader = force_grouped_leader;
> +						cur_leaders_grp = force_grouped_leader->core.leader;
> +					} else {
> +						cur_leader = force_grouped_leader = pos;
> +						cur_leaders_grp = &pos->core;
> +					}
> +				} else {
> +					cur_leader = pos;
> +					cur_leaders_grp = pos->core.leader;
> +				}
> +			}
>  		}
>  		if (pos_leader != cur_leader) {
>  			/* The leader changed so update it. */
>  			evsel__set_leader(pos, cur_leader);
>  		}
> +		last_event_was_forced_leader = (force_grouped_leader == pos);
>  	}
>  	list_for_each_entry(pos, list, core.node) {
>  		struct evsel *pos_leader = evsel__leader(pos);

Perf stat and record tests pass on SPR and ARL.

Tested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


