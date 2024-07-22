Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C84816EB44;
	Mon, 22 Jul 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721663996; cv=none; b=mHo/e3iV0Yvpev1M4+vxa3I7vSwk5lRNdPGoMV0IlT/+zYDJOB/llc3ArTHow4x7OePnNztEPtdWfGWVuq2R1pw7u0BdJU97LyQPIY6WBrxA5JOgYhIcI07A/8P1Fhav4mEH5s/RxuGy0nz1qJpCWta0/U7tLIVdUNF2La79OZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721663996; c=relaxed/simple;
	bh=nUgCygFc78VrkghKhjaJzXj8pZRWehGzELrz5XopRSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XVMGNtKnMRg7FnpmGmIFQgQmfMWsucNpKAnpnoGMvU32vL52j9H4ZDwFenesc1t7p/xaf/JRQV/9vhreLdOHOHcwOkH+LB0/po9qCuDWdZ+7s09vTiFkZE2tlFBcTTf+uQi77LdnkVRZF57v3Bt7w/cRPmnrQmuyNerqw3XxnkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3RkvjKZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3RkvjKZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721663994; x=1753199994;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=nUgCygFc78VrkghKhjaJzXj8pZRWehGzELrz5XopRSk=;
  b=M3RkvjKZLj5wHO89/cY90/u/8BJ75bDGO3cQw5Ga+ZE8NL1SyqcazXG8
   YPXN8roSUPsdT3PN7XsGrkCBTa23SUNCytnpvT4KKEe5zU9U3YkiFJXD6
   EwVdL/nYGuKCknx+v/guAAHaIBeKOR2gsEFQw3HJPkEjIpZ77qKnbe1wl
   VUNqTh7Ahrl/aV1s403LZ0oxuuJZ7aS33Y27oCyo94Dysb8f1Rsdc7cuq
   L5w+IzmT4FLM4yU8uk5mh2/ymD5XssNr773nwyiUiql/00tcFgYTCnEW6
   vxsjwK1LAoSiXHEe6DQbrJ9BdQCmlU0c+VatRtZHAC6fjP5kz8YtuA1zO
   Q==;
X-CSE-ConnectionGUID: jvTYRS0vSTaUcQo2ZdYIqA==
X-CSE-MsgGUID: ox/cTyWFRX+6ujbOj8t3oQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="44665733"
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="44665733"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 08:59:54 -0700
X-CSE-ConnectionGUID: +N2Ol+KqQ/KE/35ZNVG4kA==
X-CSE-MsgGUID: L8pt9t2zRvKaXl2hd6Yj6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="51931537"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 08:59:47 -0700
Message-ID: <1cb6fdfc-0405-4bfb-acd4-ed3b24744c8b@intel.com>
Date: Mon, 22 Jul 2024 18:59:42 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] perf auxtrace: Iterate all AUX events when finish
 reading
To: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240721202113.380750-1-leo.yan@arm.com>
 <20240721202113.380750-5-leo.yan@arm.com>
 <9f08c5cb-fb4b-4994-9128-0484aa6c06d7@intel.com>
 <9f301b09-e040-456c-9bd3-6d5e96ebc8f4@arm.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <9f301b09-e040-456c-9bd3-6d5e96ebc8f4@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/07/24 18:09, Leo Yan wrote:
> On 7/22/24 12:13, Adrian Hunter wrote:
> 
> [...]
> 
>> On 21/07/24 23:21, Leo Yan wrote:
>>> When finished to read AUX trace data from mmaped buffer, based on the
>>> AUX buffer index the core layer needs to search the corresponding PMU
>>> event and re-enable it to continue tracing.
>>>
>>> However, current code only searches the first AUX event. It misses to
>>> search other enabled AUX events, thus, it returns failure if the buffer
>>> index does not belong to the first AUX event.
>>>
>>> This patch extends the auxtrace_record__read_finish() function to
>>> search for every enabled AUX events, so all the mmaped buffer indexes
>>> can be covered.
>>>
>>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>>> ---
>>>   tools/perf/util/auxtrace.c | 15 +++++++++++----
>>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
>>> index e2f317063eec..95be330d7e10 100644
>>> --- a/tools/perf/util/auxtrace.c
>>> +++ b/tools/perf/util/auxtrace.c
>>> @@ -670,18 +670,25 @@ static int evlist__enable_event_idx(struct evlist *evlist, struct evsel *evsel,
>>>   int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
>>>   {
>>>        struct evsel *evsel;
>>> +     int ret = -EINVAL;
>>>
>>>        if (!itr->evlist || !itr->pmu)
>>>                return -EINVAL;
>>>
>>>        evlist__for_each_entry(itr->evlist, evsel) {
>>> -             if (evsel->core.attr.type == itr->pmu->type) {
>>> +             if (evsel__is_aux_event(evsel)) {
>>
>> If the type is the same, then there is no need to
>> change the logic here?
> 
> No, the type is not same for AUX events. Every event has its own type
> value, this is likely related to recent refactoring.
> 
> As a result, 'itr->pmu' only maintains the first registered AUX event,
> comparing to it the tool will find _only_ one AUX event. This is why here
> changes to use the evsel__is_aux_event() to detect AUX event.
> 
>> Otherwise, maybe that should be a separate patch
> 
> Could you explain what is a separate patch for?

No need.

> 
> After this change, the field 'itr->pmu' will be redundant (at least this
> is the case for Arm SPE). I am preparing a refactoring patches for cleaning up
> and see if can totally remove the field 'itr->pmu' (if all AUX events
> have no issue.

For this function, 'itr->pmu' could be removed in this patch
since it is not used anymore.

> 
>>
>>>                        if (evsel->disabled)
>>> -                             return 0;
>>> -                     return evlist__enable_event_idx(itr->evlist, evsel, idx);
>>> +                             continue;
>>> +                     ret = evlist__enable_event_idx(itr->evlist, evsel, idx);
>>> +                     if (ret >= 0)
>>
>> Should this be:
>>
>>                          if (ret < 0)
> 
> Here the logic is to iterate all AUX events, even if an AUX event fails to
> find the buffer index, it will continue to next AUX event.
> 
> So it directly bails out for success (as we have found the matched AUX
> event and enabled it). For the failure cause, it will continue for checking
> next event - until all events have been checked and no event is matched
> for buffer index, the failure will be handled at the end of the function.

Thanks for the explanation. Could probably use a small comment.

> 
> Thanks,
> Leo
> 
>>
>>> +                             return ret;
>>
>> And will need a common error path for the pr_err() below.
>>
>>>                }
>>>        }
>>> -     return -EINVAL;
>>> +
>>> +     if (ret < 0)
>>> +             pr_err("Failed to event enable event (idx=%d): %d\n", idx, ret);
>>> +
>>> +     return ret;
>>>   }
>>>
>>>   /*
>>

