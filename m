Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1B0322A;
	Mon,  9 Feb 2026 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770597827; cv=none; b=Tm6Fvlus2TYEdZ80v6Ebj4j+RkJAINkFtzMwAi5/Lqvh2YWtSA31rc8aVwn1aX639h8GEtKWEBrup2GW3Xk+jAObOSKf1YNMnQzyFAsRh8m3WWrwOUelCs1rYqo9Cy3d6nb1jwKlthANpM9Co9lXV1S7AoH4rdUnqDR9NgpUqpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770597827; c=relaxed/simple;
	bh=Knh75R6IU27zVgZCp4Zv9rhWs8Rl8/LvTD6YeInAQDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBVSwOWy4utOHo0SO8Akjm4AXvYkPkYGkHVet6KDnW3OdHgcwJGC2tEtQucoYvjqKjkQ0vK5aqcq/fKQUw0qStmfyRSB9poOZ7w+dTXe6VF6SkKFyvnOMyMA5Ul9/r7Ae1cB/XZoRwEPwNW+Vn4LvhqB5sirpsBLvEPsGskC4jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YR44luxC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YR44luxC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770597828; x=1802133828;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Knh75R6IU27zVgZCp4Zv9rhWs8Rl8/LvTD6YeInAQDk=;
  b=YR44luxCGK5nQSC/MNM8REy5SlpeydLdKQ61kdPR6aSUVrsWMfQrdyTw
   O/DXTlYjEwHGiw3gBTVvj+3sh7nS4uZm++LkC/EEexDrw2qDSe6og4iNy
   a8vFsULWqCRg8obhPOJK7jQKTPiWh60W1uWPSZZlykFlmTTdEEDaUYA4u
   XB0q8qmBqgwJ2E1YJIk3NE55C9Jfm45JiB2QEYRJ5UmxNmVUiRctWaXBO
   1gaNW70jH1aVFBHeQG8rrJmmJbUztTTW63TJlnpd3ZJdvA1Tf034PU2vF
   jZazhuwZpob/5sLwUBj9x1fxAKnq3U77PKbhNl9AHw4y1DA0ij30C5NaE
   A==;
X-CSE-ConnectionGUID: KvHR067HTOC54w7JuOLvbw==
X-CSE-MsgGUID: jpk75PjFSSi5O6zLmjJAjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="75328368"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="75328368"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 16:43:47 -0800
X-CSE-ConnectionGUID: XOsCEXYYRv6OwFklH+Z8lQ==
X-CSE-MsgGUID: eLbYrrrWQ4WCe72WrENc3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="211225336"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 16:43:43 -0800
Message-ID: <d3f95dcc-4b55-4110-86be-a79f68fab7b9@linux.intel.com>
Date: Mon, 9 Feb 2026 08:43:41 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] perf callchain lbr: Make the leaf IP that of the
 sample
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Andi Kleen <ak@linux.intel.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 =?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Weilin Wang <weilin.wang@intel.com>
References: <20260205205622.530825-1-irogers@google.com>
 <764406ae-c604-410c-9205-7f3343a4bd8f@linux.intel.com> <aYZYrxyg7MTepxKQ@x1>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aYZYrxyg7MTepxKQ@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/7/2026 5:10 AM, Arnaldo Carvalho de Melo wrote:
> On Fri, Feb 06, 2026 at 09:44:04AM +0800, Mi, Dapeng wrote:
>> On 2/6/2026 4:56 AM, Ian Rogers wrote:
>>> The current IP of a leaf function when reported from a perf record
>>> with "--call-graph lbr" is the "to" field of the LBR branch stack
>>> record. The sample for the event being recorded may be further into
>>> the function and there may be inlining information associated with
>>> it. Rather than use the branch stack "to" field in this case switch to
>>> the callchain appending the sample->ip and thereby allowing the inline
>>> information to show.
>>>
>>> Before this change:
>>> ```
>>> $ perf record --call-graph lbr perf test -w inlineloop
>>> ...
>>> $ perf script --fields +srcline
>>> ...
>>> perf-inlineloop  467586  4649.344493:     950905 cpu_core/cycles/P:
>>>            55dfda2829c0 parent+0x0 (perf)
>>>  inlineloop.c:31
>>>            55dfda282a96 inlineloop+0x86 (perf)
>>>  inlineloop.c:47
>>>            55dfda236420 run_workload+0x59 (perf)
>>>  builtin-test.c:715
>>>            55dfda236b03 cmd_test+0x413 (perf)
>>>  builtin-test.c:825
>>> ...
>>> ```
>>>
>>> After this change:
>>> ```
>>> $ perf record --call-graph lbr perf test -w inlineloop
>>> ...
>>> $ perf script --fields +srcline
>>> ...
>>> perf-inlineloop  529703 11878.680815:     950905 cpu_core/cycles/P:
>>>             555ce86be9e6 leaf+0x26
>>>   inlineloop.c:20 (inlined)
>>>             555ce86be9e6 middle+0x26
>>>   inlineloop.c:27 (inlined)
>>>             555ce86be9e6 parent+0x26 (perf)
>>>   inlineloop.c:32
>>>             555ce86bea96 inlineloop+0x86 (perf)
>>>   inlineloop.c:47
>>>             555ce8672420 run_workload+0x59 (perf)
>>>   builtin-test.c:715
>>>             555ce8672b03 cmd_test+0x413 (perf)
>>>   builtin-test.c:825
>>> ...
>>> ```
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  tools/perf/util/machine.c | 20 ++++++++++++++++----
>>>  1 file changed, 16 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
>>> index 5b0f5a48ffd4..e76f8c86e62a 100644
>>> --- a/tools/perf/util/machine.c
>>> +++ b/tools/perf/util/machine.c
>>> @@ -2423,8 +2423,14 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
>>>  	}
>>>  
>>>  	if (callee) {
>>> -		/* Add LBR ip from first entries.to */
>>> -		ip = entries[0].to;
>>> +		/*
>>> +		 * Set the (first) leaf function's IP to sample->ip (the
>>> +		 * location of the sample) but if not recorded use entries.to
>>> +		 */
>>> +		if (sample->ip)
>>> +			ip = sample->ip;
>>> +		else
>>> +			ip = entries[0].to;
>>>  		flags = &entries[0].flags;
>>>  		*branch_from = entries[0].from;
>>>  		err = add_callchain_ip(thread, cursor, parent,
>>> @@ -2477,8 +2483,14 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
>>>  	}
>>>  
>>>  	if (lbr_nr > 0) {
>>> -		/* Add LBR ip from first entries.to */
>>> -		ip = entries[0].to;
>>> +		/*
>>> +		 * Set the (first) leaf function's IP to sample->ip (the
>>> +		 * location of the sample) but if not recorded use entries.to
>>> +		 */
>>> +		if (sample->ip)
>>> +			ip = sample->ip;
>>> +		else
>>> +			ip = entries[0].to;
>>>  		flags = &entries[0].flags;
>>>  		*branch_from = entries[0].from;
>>>  		err = add_callchain_ip(thread, cursor, parent,
>> LGTM. Thanks.
> Next time please express that with an Acked-by, that way b4 will collect
> it.
>
> I'm adding it this time:
>
> Acked-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> ok?

Yeah. Thanks.


>
> - Arnaldo
>
>
