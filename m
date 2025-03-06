Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB441191F75;
	Thu,  6 Mar 2025 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252631; cv=none; b=uiIrNs94fPOzPGiFM3b/HFwOn+UQFIETduqgJVdkoxy9hQVkaCLuxSZEHFid8QvX9kJM3OVJmDAOkE0TRIXNEboDHs7QAQcl3XAXOtgv0nehD8IMsPCFLyVTLpIYyE9Kh9zrbgnL9e7mfqgmALEQl1mTp72ISLe4iSRnAMLxRgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252631; c=relaxed/simple;
	bh=L4guu4Rw9BOlx45UtJ9X9aI1R9albEDQKJIfSSYX9ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OqwbQEaWIiK7+hjvZoEjel/Kjp9d446pU4hzcVAWf0kHHPCtfSGPq25qxRWtkOh7/F44/U/+rOb8kXUHhmizYFUaBEBdvwFn3/pZbyJ1cKJOn//elFQC/mkZ1jKSEZ+ChAJ8dse3pX4xq2bsf9LuPX2nUc/UHE07THDd/JEZG4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gtOWEM7Y; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtOWEM7Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741252630; x=1772788630;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=L4guu4Rw9BOlx45UtJ9X9aI1R9albEDQKJIfSSYX9ew=;
  b=gtOWEM7Y+ODlknHf5UEzS48WeSyR5wWO4RIw0qCFzNZWuuEbXXBu4HBF
   VxZFX/YmyuM/a5JwYJWh1ln2/3yMr6BEm4EUdGzmXoBFYI8ZTYdNFHzAH
   VKKmZeh334PaPBR8Iw16xpLk2VSBHpAwvEqs/BhfOPvxJbLuwhhAAQHz2
   bxTykX+bALuuG/2oXaSPUWC4QtkwCcmo+uFBsxSSY4TXTNjaS6XkYx71s
   MksXcA5fbKJOaKCcRcwcJNUsp+wLBWKDuGCLseSY13fkyhsV4tld6myWC
   6dOSs6A4WrGJrebU13xY1+4mR0zKdUx37zk3JgbJ1BdIAJDIdvEHdgoFT
   w==;
X-CSE-ConnectionGUID: 6veJgdoNS0+6S/f9SRTj2A==
X-CSE-MsgGUID: 3h5us3KDS72GZdAwc5FMRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52898944"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="52898944"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 01:17:09 -0800
X-CSE-ConnectionGUID: lnvnKZEbS0umBtAIGAstgQ==
X-CSE-MsgGUID: feyTeJUPTtewBVFfAdxzSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="123910546"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 01:17:05 -0800
Message-ID: <f7e4f7e8-748c-4ec7-9088-0e844392c11a@linux.intel.com>
Date: Thu, 6 Mar 2025 17:17:01 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] perf parse-events: Corrections to topdown sorting
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>,
 Dominique Martinet <asmadeus@codewreck.org>, Andi Kleen
 <ak@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Falcon <thomas.falcon@intel.com>
References: <20250305083735.393333-1-irogers@google.com>
 <20250305083735.393333-2-irogers@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250305083735.393333-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/5/2025 4:37 PM, Ian Rogers wrote:
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
> Reported-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Closes: https://lore.kernel.org/lkml/20250224083306.71813-2-dapeng1.mi@linux.intel.com/
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.c | 54 ++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 26 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 35e48fe56dfa..cf32abc496e9 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1983,31 +1983,30 @@ static int evlist__cmp(void *_fg_idx, const struct list_head *l, const struct li
>  	bool lhs_has_group, rhs_has_group;
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
> +	 * event's index is used. Events in the same group will be
> +	 * sorted by PMU name. An index may be forced for events that
> +	 * must be in the same group, namely Intel topdown events.
> +	 * When everything is identical arch specific sorting is used,
> +	 * that can reorder and fix things like Intel's topdown
> +	 * events.
>  	 */
> -	if (lhs_core->leader != lhs_core || lhs_core->nr_members > 1) {
> -		lhs_has_group = true;
> +	lhs_has_group = lhs_core->leader != lhs_core || lhs_core->nr_members > 1;
> +	if (*force_grouped_idx != -1 && arch_evsel__must_be_in_group(lhs))
> +		lhs_sort_idx = *force_grouped_idx;
> +	else if (lhs_has_group)
>  		lhs_sort_idx = lhs_core->leader->idx;
> -	} else {
> -		lhs_has_group = false;
> -		lhs_sort_idx = *force_grouped_idx != -1 && arch_evsel__must_be_in_group(lhs)
> -			? *force_grouped_idx
> -			: lhs_core->idx;
> -	}
> -	if (rhs_core->leader != rhs_core || rhs_core->nr_members > 1) {
> -		rhs_has_group = true;
> +	else
> +		lhs_sort_idx = lhs_core->idx;
> +	rhs_has_group = rhs_core->leader != rhs_core || rhs_core->nr_members > 1;
> +
> +	if (*force_grouped_idx != -1 && arch_evsel__must_be_in_group(rhs))
> +		rhs_sort_idx = *force_grouped_idx;
> +	else if (rhs_has_group)
>  		rhs_sort_idx = rhs_core->leader->idx;
> -	} else {
> -		rhs_has_group = false;
> -		rhs_sort_idx = *force_grouped_idx != -1 && arch_evsel__must_be_in_group(rhs)
> -			? *force_grouped_idx
> -			: rhs_core->idx;
> -	}
> +	else
> +		rhs_sort_idx = rhs_core->idx;
>  
>  	if (lhs_sort_idx != rhs_sort_idx)
>  		return lhs_sort_idx - rhs_sort_idx;
> @@ -2055,10 +2054,13 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
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

Hi Ian,

With this fix,  this topdown metrics sequence
"{instructions,slots},faults,topdown-retiring" indeed works on non-hybrid
platform, like SPR, but it still fails on hybrid platform.

Here is the result on Intel LNL platform.

./perf stat -e "{instructions,slots},faults,topdown-retiring" true
WARNING: events were regrouped to match PMUs

 Performance counter stats for 'true':

   *<not supported> *     cpu_core/topdown-retiring/u
           146,710      instructions:u
     <not counted>     
cpu_core/slots/u                                                        (0.00%)
     <not counted>     
instructions:u                                                          (0.00%)
                49      faults:u
           195,855      cpu_atom/topdown-retiring/u

       0.001367139 seconds time elapsed

       0.001402000 seconds user
       0.000000000 seconds sys

the "cpu_core/topdown-retiring/" event is incorrectly moved to the head and
becomes the group leader.

To thoroughly fix this issue on hybrid platform, we need an extra below
change.

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 91c2b2e2c6bd..1f7772d4db6e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2006,7 +2006,7 @@ static int evlist__cmp(void *_fg_idx, const struct
list_head *l, const struct li
                return lhs_sort_idx - rhs_sort_idx;

        /* Group by PMU if there is a group. Groups can't span PMUs. */
-       if (lhs_has_group && rhs_has_group) {
+       if (lhs_has_group || rhs_has_group) {
                lhs_pmu_name = lhs->group_pmu_name;
                rhs_pmu_name = rhs->group_pmu_name;
                ret = strcmp(lhs_pmu_name, rhs_pmu_name);

Besides, since we support this new topdown events sequence regroup, the
comments and tests are need to be updated accordingly.

diff --git a/tools/perf/arch/x86/util/evlist.c
b/tools/perf/arch/x86/util/evlist.c
index 447a734e591c..8d7a7c4acd4b 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -39,28 +39,21 @@ int arch_evlist__cmp(const struct evsel *lhs, const
struct evsel *rhs)
         *         26,319,024      slots
         *          2,427,791      instructions
         *          2,683,508      topdown-retiring
-        *
-        * If slots event and topdown metrics events are not in same group, the
-        * topdown metrics events must be first event after the slots event
group,
-        * otherwise topdown metrics events can't be regrouped correctly, e.g.
-        *
-        * a. perf stat -e "{instructions,slots},cycles,topdown-retiring"
-C0 sleep 1
+        * e. slots event and metrics event are in a group and not adjacent
+        *    perf stat -e "{instructions,slots},cycles,topdown-retiring"
-C0 sleep 1
         *    WARNING: events were regrouped to match PMUs
-        *     Performance counter stats for 'CPU(s) 0':
-        *         17,923,134      slots
-        *          2,154,855      instructions
-        *          3,015,058      cycles
-        *    <not supported>      topdown-retiring
-        *
-        * If slots event and topdown metrics events are in two groups, the
group which
-        * has topdown metrics events must contain only the topdown metrics
event,
-        * otherwise topdown metrics event can't be regrouped correctly as
well, e.g.
-        *
-        * a. perf stat -e "{instructions,slots},{topdown-retiring,cycles}"
-C0 sleep 1
+        *    Performance counter stats for 'true':
+        *         78,452,058      slots
+        *         10,767,929      topdown-retiring
+        *          9,438,226      instructions
+        *         13,080,988      cycles
+        * f. slots event and metrics event are in two groups and not adjacent
+        *    perf stat -e "{instructions,slots},{cycles,topdown-retiring}"
-C0 sleep 1
         *    WARNING: events were regrouped to match PMUs
-        *    Error:
-        *    The sys_perf_event_open() syscall returned with 22 (Invalid
argument) for
-        *    event (topdown-retiring)
+        *         68,433,522      slots
+        *          8,856,102      topdown-retiring
+        *          7,791,494      instructions
+        *         11,469,513      cycles
         */
        if (topdown_sys_has_perf_metrics() &&
            (arch_evsel__must_be_in_group(lhs) ||
arch_evsel__must_be_in_group(rhs))) {
diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 68323d636fb7..a1b847c16f07 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -97,6 +97,18 @@ test_topdown_groups() {
     err=1
     return
   fi
+  if perf stat -e '{instructions,slots},cycles,topdown-retiring' true 2>&1
| grep -E -q "<not supported>"
+  then
+    echo "Topdown event group test [Failed non-adjacent topdown metrics
group not move into slots group]"
+    err=1
+    return
+  fi
+  if perf stat -e '{instructions,slots},{cycles,topdown-retiring}' true
2>&1 | grep -E -q "<not supported>"
+  then
+    echo "Topdown event group test [Failed non-adjacent topdown metrics
group not merge into slots group]"
+    err=1
+    return
+  fi
   if perf stat -e '{instructions,r400,r8000}' true 2>&1 | grep -E -q "<not
supported>"
   then
     echo "Topdown event group test [Failed raw format slots not reordered
first]"

Thanks,

Dapeng Mi


