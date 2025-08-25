Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436B51F0E3E;
	Mon, 25 Aug 2025 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756083265; cv=none; b=GMw/vTz3zD4Z/9Tv+Cc8wsMY/+RVT/zcJBC3Z0rk9ardpWmgS86n7BWCvTiITshrhKRv7LRX85AJoLfvA3SrCeoK6HjpqRRFYQ2Mbl+X9XH9+bhxZCub4kYB7/MKOb3U+YRYL6cpl+bT7q5PHXa94Hs3eGS8joTs1CdNZZrzxTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756083265; c=relaxed/simple;
	bh=rBgdmYUqFckpELcLrAlCCv8k/vTr+gfXp1Bn30Bh+1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ody6ckCTxHzD80716Ybeyqwf+p4aUnixRVaZhoeEh7iXtiJvJYpfP5YVQIXXQQiglN1nPkehu7y79cZM1T1MsfoTnuAAjGOVvqEu0aJfZFk615wEdYYvYqAlhMn40YkPvLPg0MN3DdZ8Ms4ovm+AoS5GsLmRBFwLSgnKnugK8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2JT388m; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2JT388m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756083263; x=1787619263;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rBgdmYUqFckpELcLrAlCCv8k/vTr+gfXp1Bn30Bh+1k=;
  b=G2JT388mQrGBNYaVzRIHmAr8zuBQ0nHRf18f+uwhE4MQsciht/gC15FW
   qx+LaQ0WUv2N3+CVgbsPRRsXjaopcJpkyMSCJhSUiIVjXP/P0mxTjfCZZ
   9jwcE2FEnzU0I7oVbss0bgdW3kSfpWJyxtT+o19W/Mkxqast+pvs1ZsGR
   HQqHn3lGheARWCJAN/uq6QsUnhsuOMnWpw1ld7RGJr9wp6CSr5WH+DrTJ
   JMBuzW4BtoIQRbTVjx8D8z1w3FQgYOsPyqD0KPstOHae45dNf/NHIGAgm
   KtYQycr9FMs88yM+o+fOSDf90E2JVjdBSoxCS446Y6ULfG0gdRqk523eq
   w==;
X-CSE-ConnectionGUID: b2v9enp9QOCvWzDpunX3SA==
X-CSE-MsgGUID: 2n3NnEsfTBWYbHFWvqD4XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="62106855"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62106855"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 17:54:22 -0700
X-CSE-ConnectionGUID: GADeNY6gRAuWWgBdzBbpmQ==
X-CSE-MsgGUID: 298aOxcJTB+FIF3oxAbi0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="200103187"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.233.125]) ([10.124.233.125])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2025 17:54:19 -0700
Message-ID: <03e30fdd-0624-4fa0-a187-cd870e5d3694@linux.intel.com>
Date: Mon, 25 Aug 2025 08:54:16 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools topdown: Fix incorrect topdown slots regroup
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20250822082233.1850417-1-dapeng1.mi@linux.intel.com>
 <CAP-5=fW6N+eE0KTyV7F4wm=KBwk46QbXjwwG9POtZxEDhbRqRQ@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fW6N+eE0KTyV7F4wm=KBwk46QbXjwwG9POtZxEDhbRqRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/23/2025 1:35 AM, Ian Rogers wrote:
> On Fri, Aug 22, 2025 at 1:23 AM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>> When running the command "perf stat -e "slots,slots" -C0 sleep 1", we
>> see below error.
>>
>> perf stat -e "slots,slots" -C0 sleep 1
>> WARNING: events were regrouped to match PMUs
>>  Performance counter stats for 'CPU(s) 0':
>>      <not counted>      slots
>>    <not supported>      slots
>>
>>      1.002265769 seconds time elapsed
>>
>> The topdown slots events are not correctly counted. The root cause is
>> that perf tools incorrectly regroup these 2 slots events into a group.
>> If there are only topdown slots events but no topdown metrics events,
>> the regroup should not be done since topdown slots event can only be
>> programed on fixed counter 3 and multiple slots events can only be
>> multiplexed to run on fixed counter 3, but grouping them blocks
>> multiplexing.
>>
>> So avoid to regroup topdown slots events if there is no topdown metrics
>> events.
>>
>> With this change, above command can be run successfully.
>>
>> perf stat -e "slots,slots" -C0 sleep 1
>>  Performance counter stats for 'CPU(s) 0':
>>        103,973,791      slots
>>        106,488,170      slots
>>
>>        1.003517284 seconds time elapsed
>>
>> Besides, run perf stats/record test on SPR and PTL, both passed.
>>
>> Reported-by: Xudong Hao <xudong.hao@intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> I don't think we should do this and if we were to do it we shouldn't
> do it in the common code. The perf metrics requiring a slots event is
> a massive mess that never seems to end. What should we do with:
> ```
> $ perf stat -e "topdown-fe-bound,topdown-fe-bound" true
>
> Performance counter stats for 'true':
>
>     <not counted>      slots
>     <not counted>      topdown-fe-bound
>   <not supported>      topdown-fe-bound
>
>       0.000960472 seconds time elapsed
>
>       0.001060000 seconds user
>       0.000000000 seconds sys
>
>
> Some events weren't counted. Try disabling the NMI watchdog:
>        echo 0 > /proc/sys/kernel/nmi_watchdog
>        perf stat ...
>        echo 1 > /proc/sys/kernel/nmi_watchdog
> ```
>
> We've injected the slots event but the repeated topdown-fe-bound
> causes the group to fail in a similar way. Why is repeating slots a
> case we care about more?
> Were we to say, okay slots is more special than the other perf metric
> events then I'd prefer arch_evsel__must_be_in_group to return false
> for the slots event when there are no other perf metric events in the
> evlist. But then what do you do if the slots event is in a different
> group like:
> ```
> $ perf stat -e "slots,{slots,topdown-fe-bound}" true
> ```
> It is pretty easy to teach the code to deduplicate events, but then
> again, what about the group behavior?
> It is not clear to me we can ever clean up all the mess that the perf
> metric events on p-cores create and I'm in favor of having the code be
> no more complex than it needs to be, so I'm not sure we should be
> solving this problem.

Ian, thanks for reviewing. Yeah, I agree what you said "topdown events are
a massive mess", we could never solve all issues. But it's annoying for
users that it reports "not counted" instead of an error. Is it possible
that we take a step back and don't try to resolve this issue and just
report an error (maybe plus a message) to warn users that multiple same
topdown events are not allowed? Thanks. 


>
> Thanks,
> Ian
>
>> ---
>>  tools/perf/arch/x86/util/topdown.h |  2 --
>>  tools/perf/util/evsel.c            | 10 ++++++++++
>>  tools/perf/util/evsel.h            |  2 ++
>>  tools/perf/util/parse-events.c     | 11 +++++++++++
>>  4 files changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/arch/x86/util/topdown.h b/tools/perf/arch/x86/util/topdown.h
>> index 69035565e649..6a917b2066f7 100644
>> --- a/tools/perf/arch/x86/util/topdown.h
>> +++ b/tools/perf/arch/x86/util/topdown.h
>> @@ -8,8 +8,6 @@ struct evsel;
>>  struct list_head;
>>
>>  bool topdown_sys_has_perf_metrics(void);
>> -bool arch_is_topdown_slots(const struct evsel *evsel);
>> -bool arch_is_topdown_metrics(const struct evsel *evsel);
>>  int topdown_insert_slots_event(struct list_head *list, int idx, struct evsel *metric_event);
>>
>>  #endif
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index d264c143b592..6aaae1ac026e 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -3965,6 +3965,16 @@ int evsel__source_count(const struct evsel *evsel)
>>         return count;
>>  }
>>
>> +bool __weak arch_is_topdown_slots(const struct evsel *evsel __maybe_unused)
>> +{
>> +       return false;
>> +}
>> +
>> +bool __weak arch_is_topdown_metrics(const struct evsel *evsel __maybe_unused)
>> +{
>> +       return false;
>> +}
>> +
>>  bool __weak arch_evsel__must_be_in_group(const struct evsel *evsel __maybe_unused)
>>  {
>>         return false;
>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
>> index 5797a02e5d6a..33f8aab675a9 100644
>> --- a/tools/perf/util/evsel.h
>> +++ b/tools/perf/util/evsel.h
>> @@ -556,6 +556,8 @@ void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
>>  int evsel__source_count(const struct evsel *evsel);
>>  void evsel__remove_from_group(struct evsel *evsel, struct evsel *leader);
>>
>> +bool arch_is_topdown_slots(const struct evsel *evsel);
>> +bool arch_is_topdown_metrics(const struct evsel *evsel);
>>  bool arch_evsel__must_be_in_group(const struct evsel *evsel);
>>
>>  bool evsel__set_needs_uniquify(struct evsel *counter, const struct perf_stat_config *config);
>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>> index 8282ddf68b98..bd09fc47ea90 100644
>> --- a/tools/perf/util/parse-events.c
>> +++ b/tools/perf/util/parse-events.c
>> @@ -2127,6 +2127,8 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
>>         int ret;
>>         struct evsel *force_grouped_leader = NULL;
>>         bool last_event_was_forced_leader = false;
>> +       bool has_slots = false;
>> +       bool has_metrics = false;
>>
>>         /* On x86 topdown metrics events require a slots event. */
>>         ret = arch_evlist__add_required_events(list);
>> @@ -2147,6 +2149,11 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
>>                 if (pos == pos_leader)
>>                         orig_num_leaders++;
>>
>> +               if (!has_slots)
>> +                       has_slots = arch_is_topdown_slots(pos);
>> +               if (!has_metrics)
>> +                       has_metrics = arch_is_topdown_metrics(pos);
>> +
>>                 /*
>>                  * Ensure indexes are sequential, in particular for multiple
>>                  * event lists being merged. The indexes are used to detect when
>> @@ -2163,6 +2170,10 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
>>                         force_grouped_idx = pos_leader->core.idx;
>>         }
>>
>> +       /* Don't regroup if there are only topdown slots events. */
>> +       if (force_grouped_idx != -1 && has_slots && !has_metrics)
>> +               force_grouped_idx = -1;
>> +
>>         /* Sort events. */
>>         list_sort(&force_grouped_idx, list, evlist__cmp);
>>
>>
>> base-commit: 6235ce77749f45cac27f630337e2fdf04e8a6c73
>> --
>> 2.34.1
>>
