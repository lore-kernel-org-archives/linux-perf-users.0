Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A472E8B9B;
	Tue,  4 Nov 2025 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762283447; cv=none; b=aRZmdEzNnMurG0V0hkXQZ+4fz576x+B2nf3AXS/+3oLtz7/0ZxgjXFw5EbmvwLPztmFC0NXfOLiANjjU+5ComYu8S63AKhJr+xS9CCUyb198/6guMNw9EbkOH5mG4bnOlrzOqhsX/aXEtJKSXnsGuHNdyrG3X2n7x66piWhEJJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762283447; c=relaxed/simple;
	bh=i/4SqAH0KYJye1+6FqYbaz7wY23xJqDxa7bHI3C3YLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+CtGVWgDjvAWYcSh2vzwYUZxgUQ3AVreNGonz0VagYi7N91F4JA182yuUhJxq/HXQ5us499GB2dPENvzshf/td4Kjtny2qYb9PifmPqgRhA8NTMLnMu6PH6AY0HmoB8U+NsuFHUsDK3EZJBgdVS/ukqSuY9+1ZvzMRQl6eGI5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ADTO5o2a; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ADTO5o2a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762283445; x=1793819445;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i/4SqAH0KYJye1+6FqYbaz7wY23xJqDxa7bHI3C3YLU=;
  b=ADTO5o2aazh5jXniyQYojh2CxW3LvlOVa/dhlr4fG295HtR0U/JwsOKu
   WdQoQ+fIJfXYKCHv1YYCiLbOLXZhXElojtyvGE8c4E6rc+fBNb0go6eaD
   So1Ky5bwohJkXxASyiuYAidHzLFn5ytIEf6eElrm8KTG/ynIWOY3GTsu9
   FVjN5WCbco7CDDG+AAj8/lDgA2iCZiS2xNlh6CqLOATKwu5pJK580gLJj
   K4gLJmtAhFUrkODtjJGg1qL/kV40RXBz6hG2LxCPiFeDoiCwK8xmiwXvV
   Wmy98aJw8Bd01jBgUl9UvwkO6ZU9z7jMWgXui3ZQSA7xDb5+zUgSNzufX
   g==;
X-CSE-ConnectionGUID: XBFaFsxqTFKn5TswqBaXKg==
X-CSE-MsgGUID: lObf0Wm5RLKz9dlcszqejQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="68249245"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="68249245"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 11:10:45 -0800
X-CSE-ConnectionGUID: NamD3PwoSZWDxApe+l8fmA==
X-CSE-MsgGUID: PYrQTQwpQLmUgj/keoxkqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="192325491"
Received: from unknown (HELO [10.241.241.65]) ([10.241.241.65])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 11:10:44 -0800
Message-ID: <652bf158-ba9e-4a97-b4c3-3a7f7e39fe85@intel.com>
Date: Tue, 4 Nov 2025 11:10:44 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf tools: Refactor precise_ip fallback logic
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Ingo Molnar <mingo@redhat.com>,
 Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 thomas.falcon@intel.com, dapeng1.mi@linux.intel.com, xudong.hao@intel.com
References: <20251022220802.1335131-1-zide.chen@intel.com>
 <aPrktlANBHFtV52B@google.com>
 <576a7d2b-0a82-4738-8b86-507e4d841524@intel.com>
 <aP1ucJiJYBavTHV7@google.com>
 <e10d671a-eb89-4e06-a1eb-e2f12ee41d70@intel.com>
 <aQl3qfyTdAb68l1l@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <aQl3qfyTdAb68l1l@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/3/2025 7:48 PM, Namhyung Kim wrote:
> Hello,
> 
> Sorry for the delay.
> 
> On Mon, Oct 27, 2025 at 11:56:52AM -0700, Chen, Zide wrote:
>>
>>
>> On 10/25/2025 5:42 PM, Namhyung Kim wrote:
>>> On Fri, Oct 24, 2025 at 11:03:17AM -0700, Chen, Zide wrote:
>>>>
>>>>
>>>> On 10/23/2025 7:30 PM, Namhyung Kim wrote:
>>>>> Hello,
>>>>>
>>>>> On Wed, Oct 22, 2025 at 03:08:02PM -0700, Zide Chen wrote:
>>>>>> Commit c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
>>>>>> unconditionally called the precise_ip fallback and moved it after the
>>>>>> missing-feature checks so that it could handle EINVAL as well.
>>>>>>
>>>>>> However, this introduced an issue: after disabling missing features,
>>>>>> the event could fail to open, which makes the subsequent precise_ip
>>>>>> fallback useless since it will always fail.
>>>>>>
>>>>>> For example, run the following command on Intel SPR:
>>>>>>
>>>>>> $ perf record -e '{cpu/mem-loads-aux/S,cpu/mem-loads,ldlat=3/PS}' -- ls
>>>>>>
>>>>>> Opening the event "cpu/mem-loads,ldlat=3/PS" returns EINVAL when
>>>>>> precise_ip == 3. It then sets attr.inherit = false, which triggers a
>>>>>
>>>>> I'm curious about this part.  Why the kernel set 'inherit = false'?  IOW
>>>>> how did the leader event (mem-loads-aux) succeed with inherit = true
>>>>> then?
>>>>
>>>> Initially, the inherit = true for both the group leader
>>>> (cpu/mem-loads-aux/S) and the event in question (cpu/mem-loads,ldlat=3/PS).
>>>>
>>>> When the second event fails with EINVAL, the current logic calls
>>>> evsel__detect_missing_features() first. Since this is a PERF_SAMPLE_READ
>>>> event, the inherit attribute falls back to false, according to the
>>>> fallback order implemented in evsel__detect_missing_features().
>>>
>>> Right, that means the kernel doesn't support PERF_SAMPLE_READ with
>>> inherit = true.  How did the first event succeed to open then?
>>
>> The perf tool sets PERF_SAMPLE_TID for Inherit + PERF_SAMPLE_READ
>> events, as implemented in commit 90035d3cd876 ("tools/perf: Allow
>> inherit + PERF_SAMPLE_READ when opening event").
>>
>> Meanwhile, commit 7e8b255650fc ("perf: Support PERF_SAMPLE_READ with
>> inherit") rejects a perf event if has_inherit_and_sample_read(attr) is
>> true and PERF_SAMPLE_TID is not set in attr->sample_type.
>>
>> Therefore, the first event succeeded, while the one opened in
>> evsel__detect_missing_features() which doesn't have PERF_SAMPLE_TID failed.
> 
> Why does the first succeed and the second fail?  Don't they have the
> same SAMPLE_READ and SAMPLE_TID + inherit flags?

Sorry, my previous reply wasn’t entirely accurate. The first event
(cpu/mem-loads-aux/S) succeeds because it’s not a precise event
(precise_ip == 0).

The second event fails with -EINVAL because, on some platforms, events
with precise_ip = 3 must be scheduled on fixed counter 0, and it fails
if it happens that this counter is unavailable.

In the current code, the first fallback attempt (inherit = 0) also fails
because the inherit attribute differs from that of the group leader
(first event).


>>
>>>>
>>>>>
>>>>>> kernel check failure since it doesn't match the group leader's inherit
>>>>>> attribute. As a result, it continues to fail even after precise_ip is
>>>>>> reduced.
>>>>>>
>>>>>> By moving the precise_ip fallback earlier, this issue is resolved, as
>>>>>> well as the kernel test robot report mentioned in commit
>>>>>> c33aea446bf555ab.
>>>>>>
>>>>>> No negative side effects are expected, because the precise_ip level is
>>>>>> restored by evsel__precise_ip_fallback() if the fallback does not help.
>>>>>
>>>>> I'm not sure.. some events may need a different (i.e. lower) precise
>>>>> level than the max.  I think checking the missing feature later will
>>>>> use the max precise level always.
>>>>
>>>> Yes, but seems the basic idea of the event open fallback logic is to
>>>> check whether it's lucky enough to open the event by falling back one
>>>> single attribute, not multiple attributes.
>>>>
>>>> evsel__precise_ip_fallback() can restore the precise_ip level after a
>>>> failed attempt, while evsel__detect_missing_features() cannot recover
>>>> the event attributes from its failed try.
>>>
>>> I think precise_ip_fallback() is just a trial and error for each possible
>>> value.  While detect_missing_features() checks what the current kernel
>>> supports.  Trying different precise_ip values with unsupported attributes
>>> doesn't make sense.
>>
>> When it returns -EINVAL, the cause could be an unsupported precise_ip or
>> something else. We could either end up with "trying different precise_ip
>> values with unsupported attributes", or "trying attributes with
>> unsupported precise_ip".
>>
>> The perf tool’s fallback logic is a “best effort” mechanism to fix only
>> one issue, not multiple ones. So, IMO, we should place
>> evsel__detect_missing_features() as the last fallback attempt, since it
>> does not restore the event attributes after a failed try.
> 
> The missing feature check is about the global kernel behavior so there's
> no point to try if we know the kernel won't support those features.
> While precise fallback is per-PMU (and per-event?) behavior so it'd be
> natural to try that after removing must-fail attributes from the missing
> feature tests.

But someone may argue that since presise_ip is per-event and it's less
intrusive, why not try it first?

If we want to keep this principle, we need to ensure that detect missing
features does not incorrectly remove valid features, and there’s no need
to restore the removed features.

After commit 3b193a57baf1 (“perf tools: Detect missing kernel features
properly”), it no longer checks attributes based on the previously
failed evsel. Instead, it checks against a dummy event. This  makes it
difficult to correctly detect features with complex dependencies — for
example, group events involves PERF_SAMPLE_READ, PERF_SAMPLE_TID, and
inherit.

Another argument is what if the original evsel fails because of multiple
invalid attributes? Seems it's hard to trust the missing feature
detection to find out "must-fail" attributes.

> 
> Thanks,
> Namhyung
> 
>>>>
>>>> Therefore, falling back precise_ip first maintains the intended
>>>> “one-by-one” fallback logic. If it’s placed later, it may combine two
>>>> fallbacks, which can cause failures like the example above.  Of course,
>>>> in theory, there might be cases where an event can be opened if both
>>>> precise_ip and another feature are relaxed together, but I haven’t
>>>> exhaustively checked whether such cases actually exist.
>>>>
>>>>> Thanks,
>>>>> Namhyung
>>>>>
>>>>>>
>>>>>> This also aligns with commit 2b70702917337a8d ("perf tools: Remove
>>>>>> evsel__handle_error_quirks()").
>>>>>>
>>>>>> Fixes: af954f76eea56453 ("perf tools: Check fallback error and order")
>>>>>> Fixes: c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
>>>>>> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>>>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>>>>> ---
>>>>>>  tools/perf/util/evsel.c | 6 +++---
>>>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>>>>> index ca74514c8707..6ce32533a213 100644
>>>>>> --- a/tools/perf/util/evsel.c
>>>>>> +++ b/tools/perf/util/evsel.c
>>>>>> @@ -2714,12 +2714,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>>>>>>  	if (err == -EMFILE && rlimit__increase_nofile(&set_rlimit))
>>>>>>  		goto retry_open;
>>>>>>  
>>>>>> +	if (evsel__precise_ip_fallback(evsel))
>>>>>> +		goto retry_open;
>>>>>> +
>>>>>>  	if (err == -EINVAL && evsel__detect_missing_features(evsel, cpu))
>>>>>>  		goto fallback_missing_features;
>>>>>>  
>>>>>> -	if (evsel__precise_ip_fallback(evsel))
>>>>>> -		goto retry_open;
>>>>>> -
>>>>>>  out_close:
>>>>>>  	if (err)
>>>>>>  		threads->err_thread = thread;
>>>>>> -- 
>>>>>> 2.51.0
>>>>>>
>>>>
>>

