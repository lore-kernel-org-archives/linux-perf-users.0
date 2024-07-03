Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6D41FAA;
	Wed,  3 Jul 2024 02:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719975103; cv=none; b=YwKT3ef9EXY5ZIUi/I1DhX6m4A17o8RFIqokrDXvVjJorzNQsz0V2GLZqmObR2R3H+7lzVZJvFPqtjo7XRq1t4048ONY6yu5QY0PvPxv/baS0bnr1oBj/bAwzv3Q1nwivys85uf8xDaoB2UdjCZlLygGSgO0YiKSUxVabJruDzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719975103; c=relaxed/simple;
	bh=lng4NNQ5ju68/C2l80GS1gkmtl0tqHz0vg5n8om5la8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Weon3o0hJqdYd5KL8nSCqixy2Cm/fzmnTHBCM2Oin5YR5zs3q0kWCu5oHdEZmWqu9CYhi8ZA/hZIzoGIZWsRQkePVdHQA3ObBAnXuWYeSlwtRq5LhpSWsVHBvQSk6e1S7DwZtIY17jdgLIOHrMlGYj5Juu0CL6McnDrgTDxx3kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mnLGPDMV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mnLGPDMV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719975102; x=1751511102;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lng4NNQ5ju68/C2l80GS1gkmtl0tqHz0vg5n8om5la8=;
  b=mnLGPDMVpOasU4HOGvksmgYlCyR2AVQNHO3pxeV0vCvkxhRUvfOw1/av
   6KHLHD5/rUJu6NsZ2u8mjNhJYaAo+xEAvke9XIGbtHW1oGSjzpHzRu0Ns
   /sHZ1E1SLRbPCDdhiLCPTdIUfgA6A65VazxBTJ4VrpD+U7iafJ1gttgux
   t12q3+v6LwMgZJzoscj7qbeG/q6VEWkF0COncEmR+uhpDzGdaIeyWvXlD
   WRcIw8dTf2X/fLR78l5lkfrBzjei9xBPuxtQCVb+rv6HgjuP4r/t33/XH
   9E1d6h+pRuIgGIYWqTEpb19/MXITd0mEQTwtyv4EjuN4sb0S4cWKGmiNx
   g==;
X-CSE-ConnectionGUID: Sg6M/bmhRvalXOGOjGYd9g==
X-CSE-MsgGUID: IDu3bbv1TR6vUSnU0PY6sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17393008"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="17393008"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 19:51:41 -0700
X-CSE-ConnectionGUID: ZaH+ySWVSC6/yOTIF5pbaw==
X-CSE-MsgGUID: 1uvUaHDTTqulPVR5x28RIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="69279956"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.225.1]) ([10.124.225.1])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 19:51:37 -0700
Message-ID: <5edf28db-46f3-431e-820e-4b2575bdb14c@linux.intel.com>
Date: Wed, 3 Jul 2024 10:51:35 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] perf parse-events: Don't move slots event when no
 topdwon metrics event
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yanfei Xu <yanfei.xu@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
References: <20240702224037.343958-1-dapeng1.mi@linux.intel.com>
 <20240702224037.343958-4-dapeng1.mi@linux.intel.com>
 <ea062008-1ae3-4568-8491-7d0d785eb0c2@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <ea062008-1ae3-4568-8491-7d0d785eb0c2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/3/2024 2:03 AM, Liang, Kan wrote:
>
> On 2024-07-02 6:40 p.m., Dapeng Mi wrote:
>> Currently the helper arch_evlist__cmp() would unconditionally move slots
>> event to be the leader event even though there is no topdown metrics
>> event in the group.
>>
>> perf stat -e "{instructions,slots}" -C 0 sleep 1
>> WARNING: events were regrouped to match PMUs
>>
>>  Performance counter stats for 'CPU(s) 0':
>>
>>         27,581,148      slots
>>          8,390,827      instructions
>>
>>        1.045546595 seconds time elapsed
>>
>> This is an overkill. It's not necessary to move slots event as the leader
>> event if there is no topdown metrics event.
>>
>> Thus only regroup events when there are both topdown slots and metrics
>> events in a group.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/perf/arch/x86/util/evlist.c |  6 ++++--
>>  tools/perf/util/evlist.h          |  7 ++++++-
>>  tools/perf/util/parse-events.c    | 35 ++++++++++++++++++-------------
>>  3 files changed, 31 insertions(+), 17 deletions(-)
>>
>> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
>> index 7215c7c7b435..a1e78be6ebd1 100644
>> --- a/tools/perf/arch/x86/util/evlist.c
>> +++ b/tools/perf/arch/x86/util/evlist.c
>> @@ -73,9 +73,11 @@ int arch_evlist__add_default_attrs(struct evlist *evlist,
>>  	return ___evlist__add_default_attrs(evlist, attrs, nr_attrs);
>>  }
>>  
>> -int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
>> +int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs, void *priv)
>>  {
>> -	if (topdown_sys_has_perf_metrics() &&
>> +	struct sort_priv *_priv = priv;
>> +
>> +	if (topdown_sys_has_perf_metrics() && _priv->topdown_metrics_in_group &&
>>  	    (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_group(rhs))) {
>>  		/* Ensure the topdown slots comes first. */
>>  		if (strcasestr(lhs->name, "slots") && !strcasestr(lhs->name, "uops_retired.slots"))
>> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
>> index cb91dc9117a2..14c858dcf5a2 100644
>> --- a/tools/perf/util/evlist.h
>> +++ b/tools/perf/util/evlist.h
>> @@ -89,6 +89,11 @@ struct evsel_str_handler {
>>  	void	   *handler;
>>  };
>>  
>> +struct sort_priv {
>> +	int force_grouped_idx;
>> +	bool topdown_metrics_in_group;
> The topdown metrics should be only available in some Intel platforms. I
> don't think we want to add such platform-specific variable in the
> generic code.
>
> The current code just re-order the events, not re-group. So it doesn't
> impact the result accuracy.
> So the issue is just an annoying WARNING, right?
>
> It seems the issue has been there for more than 1 year. No complaints
> except for one internal test case, which can be easily fixed.
> Considering the complexity of the fix, I guess we may leave it as is.

I was also hesitating on whether posting the patch. Not sure if other tools
depends on the events output order. If not, it's just an annoying WARNING.
But I think there should no other tools depending on it as you said no any
complaints on this.

I would drop this patch in next version.


>
> Thanks,
> Kan
>> +};
>> +
>>  struct evlist *evlist__new(void);
>>  struct evlist *evlist__new_default(void);
>>  struct evlist *evlist__new_dummy(void);
>> @@ -112,7 +117,7 @@ int arch_evlist__add_default_attrs(struct evlist *evlist,
>>  #define evlist__add_default_attrs(evlist, array) \
>>  	arch_evlist__add_default_attrs(evlist, array, ARRAY_SIZE(array))
>>  
>> -int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs);
>> +int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs, void *priv);
>>  
>>  int evlist__add_dummy(struct evlist *evlist);
>>  struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide);
>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>> index 6ed0f9c5581d..a3f7173a7ae2 100644
>> --- a/tools/perf/util/parse-events.c
>> +++ b/tools/perf/util/parse-events.c
>> @@ -1962,19 +1962,21 @@ static int evsel__compute_group_pmu_name(struct evsel *evsel,
>>  	return evsel->group_pmu_name ? 0 : -ENOMEM;
>>  }
>>  
>> -__weak int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
>> +__weak int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs,
>> +			    void *priv __maybe_unused)
>>  {
>>  	/* Order by insertion index. */
>>  	return lhs->core.idx - rhs->core.idx;
>>  }
>>  
>> -static int evlist__cmp(void *_fg_idx, const struct list_head *l, const struct list_head *r)
>> +static int evlist__cmp(void *_sort_priv, const struct list_head *l, const struct list_head *r)
>>  {
>>  	const struct perf_evsel *lhs_core = container_of(l, struct perf_evsel, node);
>>  	const struct evsel *lhs = container_of(lhs_core, struct evsel, core);
>>  	const struct perf_evsel *rhs_core = container_of(r, struct perf_evsel, node);
>>  	const struct evsel *rhs = container_of(rhs_core, struct evsel, core);
>> -	int *force_grouped_idx = _fg_idx;
>> +	struct sort_priv *sort_priv = _sort_priv;
>> +	int force_grouped_idx = sort_priv->force_grouped_idx;
>>  	int lhs_sort_idx, rhs_sort_idx, ret;
>>  	const char *lhs_pmu_name, *rhs_pmu_name;
>>  	bool lhs_has_group, rhs_has_group;
>> @@ -1992,8 +1994,8 @@ static int evlist__cmp(void *_fg_idx, const struct list_head *l, const struct li
>>  		lhs_sort_idx = lhs_core->leader->idx;
>>  	} else {
>>  		lhs_has_group = false;
>> -		lhs_sort_idx = *force_grouped_idx != -1 && arch_evsel__must_be_in_group(lhs)
>> -			? *force_grouped_idx
>> +		lhs_sort_idx = force_grouped_idx != -1 && arch_evsel__must_be_in_group(lhs)
>> +			? force_grouped_idx
>>  			: lhs_core->idx;
>>  	}
>>  	if (rhs_core->leader != rhs_core || rhs_core->nr_members > 1) {
>> @@ -2001,8 +2003,8 @@ static int evlist__cmp(void *_fg_idx, const struct list_head *l, const struct li
>>  		rhs_sort_idx = rhs_core->leader->idx;
>>  	} else {
>>  		rhs_has_group = false;
>> -		rhs_sort_idx = *force_grouped_idx != -1 && arch_evsel__must_be_in_group(rhs)
>> -			? *force_grouped_idx
>> +		rhs_sort_idx = force_grouped_idx != -1 && arch_evsel__must_be_in_group(rhs)
>> +			? force_grouped_idx
>>  			: rhs_core->idx;
>>  	}
>>  
>> @@ -2019,16 +2021,17 @@ static int evlist__cmp(void *_fg_idx, const struct list_head *l, const struct li
>>  	}
>>  
>>  	/* Architecture specific sorting. */
>> -	return arch_evlist__cmp(lhs, rhs);
>> +	return arch_evlist__cmp(lhs, rhs, _sort_priv);
>>  }
>>  
>>  static int parse_events__sort_events_and_fix_groups(struct list_head *list)
>>  {
>> -	int idx = 0, force_grouped_idx = -1;
>>  	struct evsel *pos, *cur_leader = NULL;
>>  	struct perf_evsel *cur_leaders_grp = NULL;
>>  	bool idx_changed = false, cur_leader_force_grouped = false;
>>  	int orig_num_leaders = 0, num_leaders = 0;
>> +	struct sort_priv sort_priv = {-1, false};
>> +	int idx = 0;
>>  	int ret;
>>  
>>  	/*
>> @@ -2053,13 +2056,17 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
>>  		pos->core.idx = idx++;
>>  
>>  		/* Remember an index to sort all forced grouped events together to. */
>> -		if (force_grouped_idx == -1 && pos == pos_leader && pos->core.nr_members < 2 &&
>> -		    arch_evsel__must_be_in_group(pos))
>> -			force_grouped_idx = pos->core.idx;
>> +		if (sort_priv.force_grouped_idx == -1 && pos == pos_leader &&
>> +		    pos->core.nr_members < 2 && arch_evsel__must_be_in_group(pos))
>> +			sort_priv.force_grouped_idx = pos->core.idx;
>> +
>> +		if (!sort_priv.topdown_metrics_in_group &&
>> +		    strcasestr(pos->name, "topdown"))
>> +			sort_priv.topdown_metrics_in_group = true;
>>  	}
>>  
>>  	/* Sort events. */
>> -	list_sort(&force_grouped_idx, list, evlist__cmp);
>> +	list_sort(&sort_priv, list, evlist__cmp);
>>  
>>  	/*
>>  	 * Recompute groups, splitting for PMUs and adding groups for events
>> @@ -2070,7 +2077,7 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
>>  		const struct evsel *pos_leader = evsel__leader(pos);
>>  		const char *pos_pmu_name = pos->group_pmu_name;
>>  		const char *cur_leader_pmu_name;
>> -		bool pos_force_grouped = force_grouped_idx != -1 &&
>> +		bool pos_force_grouped = sort_priv.force_grouped_idx != -1 &&
>>  			arch_evsel__must_be_in_group(pos);
>>  
>>  		/* Reset index and nr_members. */
