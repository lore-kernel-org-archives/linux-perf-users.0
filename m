Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848F91DE4F3;
	Tue, 11 Mar 2025 00:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741653929; cv=none; b=nLj8wf3XA/lDf53MTaSbpCAqg7OCdhX2UOq7mSQZuIsTXIWhVXB2ZGHdzAo2NaIYhlduizN0V/MT0nxaLXWxl2Sxq9YM+5QY6ftDUtRe7/9oMXgbymbfrNdmIUKdwFO4v7qvupuv6BmWqiuQT8u7DA3hbVakekD3+XNLURJidUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741653929; c=relaxed/simple;
	bh=8fysGV/DETVS5cSCbvfDu7bU+efp3MuujNHDeLv2eAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bf2n6xnToHGSV1ZaYySZyYLdjZJhp6iTlh4jPWbuhwAtsbdv2BEyB0HI67L+V5UPvpIKrsV/EWcTjI9vQL0gMbA2YRgiPOny99Qa0TZCDNoFGPpzFYI0q3mYi39uIvr2o0VWQEKsJLrokTih8cVxpoESlCcXq1DSb5kQjjPTrO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ibqyUgKc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ibqyUgKc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741653927; x=1773189927;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8fysGV/DETVS5cSCbvfDu7bU+efp3MuujNHDeLv2eAw=;
  b=ibqyUgKcu5PLOwpJtY6jsIfkh+Rv48il7vAx38cCHnlFOCKGwNjxCVPY
   aPnWSo7iJUxs+2qN/3Yo1HfoqIM4kKhUaLlyLfIFzA148N6l6+9Bm2thk
   YqL5Ttzkw1tmy/FqRcw76JDbbBMENgHTOaFFf5Fbq/BBg+tzuMywErCSy
   TF1icPE1pPn5XOtLpbjNRbibIb8MekTQt2htWcibYojiSgLrnVvvOKz7r
   trpLFdLNhW6XsJf/Do0HTWiVa0+xekgfi/X/20R43FHZxxf8iR3j6tMpL
   5Yr1NnCNEHE+Qq6yVohdrdzUxL+ICY7eeD2tlehtChQ11sLlsbPy2TUcv
   A==;
X-CSE-ConnectionGUID: 5vCUVMnYSIu5bNUKmB65BA==
X-CSE-MsgGUID: IGXKZZo+RcupRvzKfOUi+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="52883315"
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="52883315"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 17:45:27 -0700
X-CSE-ConnectionGUID: mt3H7reTTmaYNYls5N1LKw==
X-CSE-MsgGUID: 760FJxwAQo2PqCD7Nol5sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="119995364"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 17:45:22 -0700
Message-ID: <ba8dedbc-9a5f-4038-ad51-2b20baa6af65@linux.intel.com>
Date: Tue, 11 Mar 2025 08:45:20 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] perf x86 evlist: Update comments on topdown
 regrouping
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>,
 Dominique Martinet <asmadeus@codewreck.org>, Andi Kleen
 <ak@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Falcon <thomas.falcon@intel.com>
References: <20250307023906.1135613-1-irogers@google.com>
 <20250307023906.1135613-4-irogers@google.com> <Z89Y5pUchAaJj4PY@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <Z89Y5pUchAaJj4PY@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/11/2025 5:25 AM, Namhyung Kim wrote:
> Hello,
>
> On Thu, Mar 06, 2025 at 06:39:05PM -0800, Ian Rogers wrote:
>> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> Update to remove comments about groupings not working and with the:
>> ```
>> perf stat -e "{instructions,slots},{cycles,topdown-retiring}"
>> ```
>> case that now works.
>>
>> Signed-off-by: Ian Rogers <irogers@google.com>
> Dapeng, can I get your Signed-off-by here?
>
> Thanks,
> Namhyung
>
>> ---
>>  tools/perf/arch/x86/util/evlist.c | 27 ++++++---------------------
>>  1 file changed, 6 insertions(+), 21 deletions(-)
>>
>> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
>> index ed205d1b207d..7905a28d7734 100644
>> --- a/tools/perf/arch/x86/util/evlist.c
>> +++ b/tools/perf/arch/x86/util/evlist.c
>> @@ -39,28 +39,13 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
>>  	 *         26,319,024      slots
>>  	 *          2,427,791      instructions
>>  	 *          2,683,508      topdown-retiring
>> -	 *
>> -	 * If slots event and topdown metrics events are not in same group, the
>> -	 * topdown metrics events must be first event after the slots event group,
>> -	 * otherwise topdown metrics events can't be regrouped correctly, e.g.
>> -	 *
>> -	 * a. perf stat -e "{instructions,slots},cycles,topdown-retiring" -C0 sleep 1
>> -	 *    WARNING: events were regrouped to match PMUs
>> -	 *     Performance counter stats for 'CPU(s) 0':
>> -	 *         17,923,134      slots
>> -	 *          2,154,855      instructions
>> -	 *          3,015,058      cycles
>> -	 *    <not supported>      topdown-retiring
>> -	 *
>> -	 * If slots event and topdown metrics events are in two groups, the group which
>> -	 * has topdown metrics events must contain only the topdown metrics event,
>> -	 * otherwise topdown metrics event can't be regrouped correctly as well, e.g.
>> -	 *
>> -	 * a. perf stat -e "{instructions,slots},{topdown-retiring,cycles}" -C0 sleep 1
>> +	 * e. slots event and metrics event are in a group and not adjacent

Yes, here is my SoB.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

BTW, It seems there is a typo and missed the "not" word. It should be 
"slots event and metrics event are not in a group and not adjacent"

Thanks.


>> +	 *    perf stat -e "{instructions,slots},cycles,topdown-retiring" -C0 sleep 1
>>  	 *    WARNING: events were regrouped to match PMUs
>> -	 *    Error:
>> -	 *    The sys_perf_event_open() syscall returned with 22 (Invalid argument) for
>> -	 *    event (topdown-retiring)
>> +	 *         68,433,522      slots
>> +	 *          8,856,102      topdown-retiring
>> +	 *          7,791,494      instructions
>> +	 *         11,469,513      cycles
>>  	 */
>>  	if (topdown_sys_has_perf_metrics() &&
>>  	    (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_group(rhs))) {
>> -- 
>> 2.49.0.rc0.332.g42c0ae87b1-goog
>>
