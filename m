Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE944C61;
	Tue, 13 Aug 2024 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723579572; cv=none; b=nNj8mEluJNL6ccCxFoN3Xtd/Q1Be73lLyo1PydeTVFJV4Yi6UYszWABjyYqpUQWbz0mfLuV3xqCo6gawks9Fc8yQsaXaWm/clXG94MK4+NNp+wuNe9E0ZXMyd/cQW7iD42GU96WIGMrYmCwlQa5UM+tqKK0Q3dmp/Y0KpW24cAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723579572; c=relaxed/simple;
	bh=54vHcE4NSp0HZdHFv1znwaX2jlb0ZcZWWvDg02d3Tv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPIRq5xfNiLZp/OwX0Z9A/LBEUIsS5sRipPXDPf8zbHlyTUgv/O96mCGF4P+89EazUSEJ311eIH0y5G/ybbwihIpwQMwaoFG+Y4qVuRFGosfBG2RmzOT3iayBG32DmZb/k1V2FM/Obaq0e27uDxYsjltY67SA0oRpXqyuunXkDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PSCYpLlD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PSCYpLlD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723579570; x=1755115570;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=54vHcE4NSp0HZdHFv1znwaX2jlb0ZcZWWvDg02d3Tv0=;
  b=PSCYpLlD0e9Wr5b2Q7nos5aFeaVzRBXEV6PSAT3fA0isLmxUps8AXnKI
   QvxOhrJMi1xqns3JFy9y7J7iX8K6bKluez9XKNmCZqQSSLV5ZjITQRSGo
   FKNWTffumXD3Oa6tTMClp8/1MXLz+uxt4nB45fN5ZR5v4CwE318VH88MH
   quox1x8s6seG5zjg4NksEKalyk955c2efi+ScfWUWi6shX1YKgT81D1nB
   yWICv4IQO9wSB1GP57LsM5e+3e++RNuCU3JKKcHlxFTkPRGnrLTVHbBmo
   lAhgTC3wMwl9jGwJFZ82LUqH13D89Qd84W3HwhZzZAnVZI0MvZPQUcY9o
   A==;
X-CSE-ConnectionGUID: XV4LlxTZTBm1r6eI0ciJtg==
X-CSE-MsgGUID: 1kVffGZTSmClFgdsOQ4KPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25530595"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="25530595"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 13:06:09 -0700
X-CSE-ConnectionGUID: Z7uGyN09QjWg1oF8aIlKfw==
X-CSE-MsgGUID: ZqNnll1oRsiTr0h+r/Gk4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="89593604"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 13:06:08 -0700
Received: from [10.212.113.57] (kliang2-mobl1.ccr.corp.intel.com [10.212.113.57])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 0CE3120CFED6;
	Tue, 13 Aug 2024 13:06:06 -0700 (PDT)
Message-ID: <aedabebd-dad1-4b2b-93d7-e2d9884bdaf7@linux.intel.com>
Date: Tue, 13 Aug 2024 16:06:05 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 1/9] perf report: Fix --total-cycles --stdio output
 error
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, irogers@google.com, peterz@infradead.org,
 mingo@kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, adrian.hunter@intel.com,
 ak@linux.intel.com, eranian@google.com
References: <20240813160208.2493643-1-kan.liang@linux.intel.com>
 <20240813160208.2493643-2-kan.liang@linux.intel.com> <ZrupfUSZwem-hCZm@x1>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZrupfUSZwem-hCZm@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-08-13 2:44 p.m., Arnaldo Carvalho de Melo wrote:
> On Tue, Aug 13, 2024 at 09:02:00AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> The --total-cycles may output wrong information with the --stdio.
> 
> Hey, I tried --total-cycles with --group but that didn't work, do you
> think that would make sense?

The current implementation doesn't handle the symbol_conf.event_group
for the tui mode.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/builtin-report.c#n543

I will send a separate patch to fix it and make it consistent.

Thanks,
Kan

> 
> Anyway, all applied, now testing and reviewing the changes,
> 
> thanks!
> 
> - Arnaldo
>  
>> For example,
>>   perf record -e "{cycles,instructions}",cache-misses -b sleep 1
>>   perf report --total-cycles --stdio
>>
>> The total cycles output of {cycles,instructions} and cache-misses are
>> almost the same.
>>
>>  # Samples: 938  of events 'anon group { cycles, instructions }'
>>  # Event count (approx.): 938
>>  #
>>  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles
>>  # ...............  ..............  ...........  ..........
>>   ..................................................>
>>  #
>>            11.19%            2.6K        0.10%          21
>>                           [perf_iterate_ctx+48 -> >
>>             5.79%            1.4K        0.45%          97
>>             [__intel_pmu_enable_all.constprop.0+80 -> __intel_>
>>             5.11%            1.2K        0.33%          71
>>                              [native_write_msr+0 ->>
>>
>>  # Samples: 293  of event 'cache-misses'
>>  # Event count (approx.): 293
>>  #
>>  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles
>>                                                   [>
>>  # ...............  ..............  ...........  ..........
>>    ..................................................>
>>  #
>>            11.19%            2.6K        0.13%          21
>>                           [perf_iterate_ctx+48 -> >
>>             5.79%            1.4K        0.59%          97
>> [__intel_pmu_enable_all.constprop.0+80 -> __intel_>
>>             5.11%            1.2K        0.43%          71
>>                              [native_write_msr+0 ->>
>>
>> With the symbol_conf.event_group, the perf report should only report the
>> block information of the leader event in a group.
>> However, the current implementation retrieves the next event's block
>> information, rather than the next group leader's block information.
>>
>> Make sure the index is updated even if the event is skipped.
>>
>> With the patch,
>>
>>  # Samples: 293  of event 'cache-misses'
>>  # Event count (approx.): 293
>>  #
>>  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles
>>                                                   [>
>>  # ...............  ..............  ...........  ..........
>>    ..................................................>
>>  #
>>            37.98%            9.0K        4.05%         299
>>    [perf_event_addr_filters_exec+0 -> perf_event_a>
>>            11.19%            2.6K        0.28%          21
>>                           [perf_iterate_ctx+48 -> >
>>             5.79%            1.4K        1.32%          97
>> [__intel_pmu_enable_all.constprop.0+80 -> __intel_>
>>
>> Fixes: 6f7164fa231a ("perf report: Sort by sampled cycles percent per block for stdio")
>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  tools/perf/builtin-report.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
>> index dfb47fa85e5c..04b9a5c1bc7e 100644
>> --- a/tools/perf/builtin-report.c
>> +++ b/tools/perf/builtin-report.c
>> @@ -565,6 +565,7 @@ static int evlist__tty_browse_hists(struct evlist *evlist, struct report *rep, c
>>  		struct hists *hists = evsel__hists(pos);
>>  		const char *evname = evsel__name(pos);
>>  
>> +		i++;
>>  		if (symbol_conf.event_group && !evsel__is_group_leader(pos))
>>  			continue;
>>  
>> @@ -574,7 +575,7 @@ static int evlist__tty_browse_hists(struct evlist *evlist, struct report *rep, c
>>  		hists__fprintf_nr_sample_events(hists, rep, evname, stdout);
>>  
>>  		if (rep->total_cycles_mode) {
>> -			report__browse_block_hists(&rep->block_reports[i++].hist,
>> +			report__browse_block_hists(&rep->block_reports[i - 1].hist,
>>  						   rep->min_percent, pos, NULL);
>>  			continue;
>>  		}
>> -- 
>> 2.38.1
> 
