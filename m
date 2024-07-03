Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF2E522F;
	Wed,  3 Jul 2024 02:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719974784; cv=none; b=MlbYQNSRAOK1Xow8hEJVhztzioCagcCyHymQX+AZxGWkSJ/iBJlX2As4f36smgdrUl6GW4NnF80F+cKtKiHHjpolZudxuqulf/MfPkpe+yR+4t7xDeefHv9p1RWhq68NNGAkWvTg2V7Ts2cemVdk8i4V8GtbP7X/QFJavBK8eec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719974784; c=relaxed/simple;
	bh=HlBx1gRF97fkG+5OJH0WLfFyY+EZd8AUjrhOyXD9IHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0rdro+C+jRiX8m0ItI8rls7rIZceYfT/jJa9bTSDhd8lIgLPVel3gfgLaXcm7cIKnb/RqNP7nr6hTsWNnt+zpOL5O4KWthBsBbVSvNTOUTvwKM2WgEANR5Q+dsZhOBkoDgq3y1y/4gpecZU1Ypn2XvSmghBQdjfMDUJpgFSGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SeeO0IUu; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SeeO0IUu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719974782; x=1751510782;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HlBx1gRF97fkG+5OJH0WLfFyY+EZd8AUjrhOyXD9IHU=;
  b=SeeO0IUuF3q/Jr1n1pWX+5lZmUu8rw8ammJBhJNNxCHR5reF+UqOL7/3
   7Pb0nfHPUkpNbrFj+A5K2tsLpypIyYcOdXdqQUPNHy8AsWwBBjcwMxmEd
   IPU279k3YsSVwIQFHU4WC+W5SP8GnAAhkq+BgF1VzdfnOMA5y+GVGI6HI
   8Uv7jOI1bt8TpPkrv1H10i3g9XlmzveIG4LFLNhm3DDc+rEA4bcT5yryN
   Etm/E0kw83/epLU4p49uNDtDYA/laBszMSDluk4RvQjxEWUmx0RfkE6rY
   0gTDtx5FlPAlMJn6QlSRcPT7795NQPmgSDqxGAHhABQ9ytfp8wC1KftCN
   Q==;
X-CSE-ConnectionGUID: /krxXrNdRE+m2djhTf8oBA==
X-CSE-MsgGUID: h0mH8gJZQGyveLWSGThoNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="20085091"
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="20085091"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 19:46:21 -0700
X-CSE-ConnectionGUID: ikPRfOyQQ3yLwz1UcfQKjQ==
X-CSE-MsgGUID: fgek1npPSHuNlfeeOekFdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,180,1716274800"; 
   d="scan'208";a="45881129"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.225.1]) ([10.124.225.1])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 19:46:18 -0700
Message-ID: <5223c6bb-a05b-4a8c-a625-2011db190631@linux.intel.com>
Date: Wed, 3 Jul 2024 10:46:15 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] perf topdown: Correct leader selection with
 sample_read enabled
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yanfei Xu <yanfei.xu@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
References: <20240702224037.343958-1-dapeng1.mi@linux.intel.com>
 <20240702224037.343958-2-dapeng1.mi@linux.intel.com>
 <d9c26690-5147-4a4a-815b-fb5d46d043c6@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <d9c26690-5147-4a4a-815b-fb5d46d043c6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/3/2024 12:05 AM, Liang, Kan wrote:
>
> On 2024-07-02 6:40 p.m., Dapeng Mi wrote:
>> Addresses an issue where, in the absence of a topdown metrics event
>> within a sampling group, the slots event was incorrectly bypassed as
>> the sampling leader when sample_read was enabled.
>>
>> perf record -e '{slots,branches}:S' -c 10000 -vv sleep 1
>>
>> In this case, the slots event should be sampled as leader but the
>> branches event is sampled in fact like the verbose output shows.
>>
>> perf_event_attr:
>>   type                             4 (cpu)
>>   size                             168
>>   config                           0x400 (slots)
>>   sample_type                      IP|TID|TIME|READ|CPU|IDENTIFIER
>>   read_format                      ID|GROUP|LOST
>>   disabled                         1
>>   sample_id_all                    1
>>   exclude_guest                    1
>> ------------------------------------------------------------
>> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>> ------------------------------------------------------------
>> perf_event_attr:
>>   type                             0 (PERF_TYPE_HARDWARE)
>>   size                             168
>>   config                           0x4 (PERF_COUNT_HW_BRANCH_INSTRUCTIONS)
>>   { sample_period, sample_freq }   10000
>>   sample_type                      IP|TID|TIME|READ|CPU|IDENTIFIER
>>   read_format                      ID|GROUP|LOST
>>   sample_id_all                    1
>>   exclude_guest                    1
>>
>> The sample period of slots event instead of branches event is reset to
>> 0.
>>
>> This fix ensures the slots event remains the leader under these
>> conditions.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/perf/arch/x86/util/topdown.c | 16 ++++++++++++++--
>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
>> index 3f9a267d4501..5d7b78eb7516 100644
>> --- a/tools/perf/arch/x86/util/topdown.c
>> +++ b/tools/perf/arch/x86/util/topdown.c
>> @@ -1,6 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  #include "api/fs/fs.h"
>>  #include "util/evsel.h"
>> +#include "util/evlist.h"
>>  #include "util/pmu.h"
>>  #include "util/pmus.h"
>>  #include "util/topdown.h"
>> @@ -41,11 +42,22 @@ bool topdown_sys_has_perf_metrics(void)
>>   */
>>  bool arch_topdown_sample_read(struct evsel *leader)
>>  {
>> +	struct evsel *event;
>> +
>>  	if (!evsel__sys_has_perf_metrics(leader))
>>  		return false;
>>  
>> -	if (leader->core.attr.config == TOPDOWN_SLOTS)
>> -		return true;
>> +	if (leader->core.attr.config != TOPDOWN_SLOTS)
>> +		return false;
>> +
>> +	/*
>> +	 * If slots event as leader event but no topdown metric events in group,
>> +	 * slots event should still sample as leader.
>> +	 */
>> +	evlist__for_each_entry(leader->evlist, event) {
>> +		if (event != leader && strcasestr(event->name, "topdown"))
> User may uses the RAW format. It may not be good enough to just check
> the event name.
>
> I recall you have a complete support for this in the previous patch. Why
> drop it?


Oh, I ignored the RAW format case. Yes, there is a complete comparison in
previous patch, but I originally thought it's over-complicated, so I just
simplified it (refer other helpers to compare the name).  If we need to
consider the RAW format, it may be not correct for the comparisons in the
helpers arch_evsel__must_be_in_group() and arch_evlist__cmp() as well.

If we want to fix the issue thoroughly, we may have to expose two helpers
which check if an event is topdown slots or metrics event and use these two
helpers to replace current name comparison.

>
> Thanks,
> Kan
>
>> +			return true;
>> +	}
>>  
>>  	return false;
>>  }
