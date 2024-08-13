Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44C72582;
	Tue, 13 Aug 2024 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723534244; cv=none; b=pHANQnPtqb5/UBDgIjIqZV899lF+j3ifzBI+EmxJZsEtrjm5DzR+DyCiy2bwW604umHdZGZH/aPYPxK77MDYCJguc5xY6+xu5tSNtWK4auGp0aHC0AMypcDvNtBH2lz5FBKWdeyJp/KlOgqMNzPIUjxv6bv2ChCeCxxwLG7/tpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723534244; c=relaxed/simple;
	bh=hAQZixzCwYGKYk26E6wIRzn58O+FkXlUjBRcl1zSt7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BW8vCf6eWcFiqsqYaim2Entc3vwYZs1/n1lt1UGpwHu68vYH1r5xcNjOuS+sy777dG3vqxFpV3+4yo2//X+sVJ8JM8X9REikwcPwDDOvHqqkYXfxsRF4/8fIpdnR3aVjBtwRVD3qjZPuyb/W5x3KZD1mhNmreZAqR7o9NuDJ//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHfK14FR; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHfK14FR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723534243; x=1755070243;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hAQZixzCwYGKYk26E6wIRzn58O+FkXlUjBRcl1zSt7o=;
  b=FHfK14FR7ArJ3kf4XPnPfTkGJKex7iUY21QX7Q12QLuoVvO7+IGIWHJE
   Zv54bTnpAbXqX0XkcVi3OW/HO3iUYA0aw7+JVE7cV/KEOxnEIG3rBHtfI
   e6mOqiBncE6JxYQ6/AJ0RYUBIOw7YGS+QC447nseRDYF2SHEDcF+qVf7w
   +ECP8ZFlyAAIQ91OspNo/Em5nEqbDVjW2WIo+UXqPm8i6fJwPTgIu3jIb
   LnOvwBg92AiY251of4GrmdQKO584P0WVI9Pr52flW+JIZS9Bz7O7RSSof
   OgZ3gt/Uo22Age+AaVDT9yrBWbKIZ9cCm/N05uC0SzDajYS5Dznb4MP9L
   A==;
X-CSE-ConnectionGUID: MaXQpgswTPSBVyevIM6tqA==
X-CSE-MsgGUID: c4GE1hxyR8iBynqoYO1cQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="33081609"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="33081609"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 00:30:42 -0700
X-CSE-ConnectionGUID: lPH5BXBIRXqcBqpddxUMog==
X-CSE-MsgGUID: BZSLQ1NsRa6MB7i6CexvgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="62969865"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.225.1]) ([10.124.225.1])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 00:30:39 -0700
Message-ID: <adc34dd8-88bf-4a3e-9939-c2fa0ddb4b65@linux.intel.com>
Date: Tue, 13 Aug 2024 15:30:36 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 3/5] perf x86/topdown: Don't move topdown metric events
 in group
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
References: <20240712170339.185824-1-dapeng1.mi@linux.intel.com>
 <20240712170339.185824-4-dapeng1.mi@linux.intel.com>
 <83cfa057-1791-4aab-ace8-fb0ad5a607b7@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <83cfa057-1791-4aab-ace8-fb0ad5a607b7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/12/2024 11:37 PM, Liang, Kan wrote:
>
> On 2024-07-12 1:03 p.m., Dapeng Mi wrote:
>> when running below perf command, we say error is reported.
>>
>> perf record -e "{slots,instructions,topdown-retiring}:S" -vv -C0 sleep 1
>>
>> ------------------------------------------------------------
>> perf_event_attr:
>>   type                             4 (cpu)
>>   size                             168
>>   config                           0x400 (slots)
>>   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
>>   read_format                      ID|GROUP|LOST
>>   disabled                         1
>>   sample_id_all                    1
>>   exclude_guest                    1
>> ------------------------------------------------------------
>> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>> ------------------------------------------------------------
>> perf_event_attr:
>>   type                             4 (cpu)
>>   size                             168
>>   config                           0x8000 (topdown-retiring)
>>   { sample_period, sample_freq }   4000
>>   sample_type                      IP|TID|TIME|READ|CPU|PERIOD|IDENTIFIER
>>   read_format                      ID|GROUP|LOST
>>   freq                             1
>>   sample_id_all                    1
>>   exclude_guest                    1
>> ------------------------------------------------------------
>> sys_perf_event_open: pid -1  cpu 0  group_fd 5  flags 0x8
>> sys_perf_event_open failed, error -22
>>
>> Error:
>> The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (topdown-retiring).
>>
>> The reason of error is that the events are regrouped and
>> topdown-retiring event is moved to closely after the slots event and
>> topdown-retiring event needs to do the sampling, but Intel PMU driver
>> doesn't support to sample topdown metrics events.
>>
>> For topdown metrics events, it just requires to be in a group which has
>> slots event as leader. It doesn't require topdown metrics event must be
>> closely after slots event. Thus it's a overkill to move topdown metrics
>> event closely after slots event in events regrouping and furtherly cause
>> the above issue.
>>
>> Thus don't move topdown metrics events forward if they are already in a
>> group.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/perf/arch/x86/util/evlist.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
>> index 332e8907f43e..6ae044f21843 100644
>> --- a/tools/perf/arch/x86/util/evlist.c
>> +++ b/tools/perf/arch/x86/util/evlist.c
>> @@ -85,7 +85,12 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
>>  		/* Followed by topdown events. */
>>  		if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
>>  			return -1;
>> -		if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
>> +		/*
>> +		 * Move topdown events forward only when topdown events
>> +		 * are not in same group with previous event.
>> +		 */
> Do you mean this case?
>
> perf stat -e '{slots,branches},topdown-retiring' -C0 sleep 1
> WARNING: events were regrouped to match PMUs
>
>  Performance counter stats for 'CPU(s) 0':
>
>         22,568,316      slots
>            569,904      branches
>          3,805,637      topdown-retiring

Yes, this case can be regrouped.


>
> But if I add one more event before topdown-retiring, it seems break again.
>
> perf stat -e '{slots,branches},cycles,topdown-retiring' -C0 sleep 1
>
>  Performance counter stats for 'CPU(s) 0':
>
>         25,218,108      slots
>            647,598      branches
>          4,345,121      cycles
>    <not supported>      topdown-retiring

Yes, this case can't be supported by original code. I ever tried to support
this format, but it's not easy, it needs to fully change current sort logic.


>
> I'm not asking to support all the above cases. I just try to understand
> which cases you plan to support.
>
> Can you please add some comments or update the document to clearly show
> which format is supported, which format will be automatically adjusted
> by the tool, and which format will be error out?

Yeah, I would list all currently supported regrouping format. BTW, is there
a document to describe the topdown metrics feaeture. If not, I would add
comments here.


>
> We should also need test cases for all the supported formats, not just
> the standard one.

Sure. thanks.


>
> Thanks,
> Kan
>
>> +		if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs) &&
>> +		    lhs->core.leader != rhs->core.leader)
>>  			return 1;
>>  	}
>>  
