Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E3117E44F;
	Mon, 12 Aug 2024 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473429; cv=none; b=ZsR84vTmRvtiyvrfXGpEiqAhsmBK8di6EyhjLpHQgaV2GqL752S+4eW78sCnOL3frDF6ML/BVtzyDYq/mzDPoIu/dQkPlC1L16wxesXv/WpjDVhQ4cD5pkxNN+MCeXClpVry/G9BlduqM5bUnhWzmsoLB1PpZM4mdwWsEczafxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473429; c=relaxed/simple;
	bh=102QsHKwVMn3s9wkJRZFLVyNNMM26EtBvD3T3IXqEdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwwHJIXJnV8xep/IBWKGelj+Wk/QJoYXU8DtX/7N4MBZvvkURZRj+UANt4CMjuuluFcgNp9z2SfjoGEi2jDyDnHCkfXxjXaLAmshGOCzS/DnzXJ98n9Z3Ln+0Aa+jBVwwXVApv0N7w6nTAIpdLV/RaZZxxPZaDhw0yRPFEVetA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFC5uVh+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFC5uVh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723473428; x=1755009428;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=102QsHKwVMn3s9wkJRZFLVyNNMM26EtBvD3T3IXqEdo=;
  b=aFC5uVh+RX68rUXACYz+25/ytoYew379QzMiz2TtSZO3l79c+U4GBgZy
   ybsnNUlCHLzMbjr/v/VqxArR7UbiGMH62HdhM4tSsg3CaC2M0o+0tRyh+
   OCg1lnPd/6Aexm5hf8VAPk6VwstjTsmiawh59trEcRZj2OqH5/BwNgHX2
   adSzF/qdcg8NUwaTWZUGszix5PtxRHTImtqPGkm/xgZzrPIHfez7ssSV9
   a1ScqxBJF256nI3S/R1/Glx7KqA4kQxpAs4o5DwSD+c7GbHJ5L8XW/mWG
   YUuGAxoTDQTSIFIKFhonzbdD9VSQbAslKflDlcxiP179nnscfnM8xy/9e
   g==;
X-CSE-ConnectionGUID: rdmVr2c4R++gCODQSnFDdQ==
X-CSE-MsgGUID: WOQzjHNeQMynoXewc0qcOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21749051"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="21749051"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 07:37:07 -0700
X-CSE-ConnectionGUID: CotyronJSOywVlVTAfLuPw==
X-CSE-MsgGUID: mIq1/KQ3RRGp3VaBpmaTJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="58218847"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 07:37:06 -0700
Received: from [10.212.112.28] (kliang2-mobl1.ccr.corp.intel.com [10.212.112.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 2E35120CFED8;
	Mon, 12 Aug 2024 07:37:05 -0700 (PDT)
Message-ID: <b2d0b461-1fac-431b-82b7-521b35f502c3@linux.intel.com>
Date: Mon, 12 Aug 2024 10:37:04 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 2/5] perf x86/topdown: Correct leader selection with
 sample_read enabled
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
References: <20240712170339.185824-1-dapeng1.mi@linux.intel.com>
 <20240712170339.185824-3-dapeng1.mi@linux.intel.com> <ZroRXXlV-ePkj-On@x1>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZroRXXlV-ePkj-On@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-08-12 9:42 a.m., Arnaldo Carvalho de Melo wrote:
> On Fri, Jul 12, 2024 at 05:03:36PM +0000, Dapeng Mi wrote:
>> Addresses an issue where, in the absence of a topdown metrics event
>> within a sampling group, the slots event was incorrectly bypassed as
>> the sampling leader when sample_read was enabled.
>>
>> perf record -e '{slots,branches}:S' -c 10000 -vv sleep 1
> 
> Kan, can you please take a look at this patch and the others in this
> series?

Sure.

Thanks,
Kan

> 
> Thanks,
> 
> - Arnaldo
>  
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
>> index 49f25d67ed77..857e00cf579f 100644
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
>> @@ -87,11 +88,22 @@ bool arch_is_topdown_metrics(const struct evsel *evsel)
>>   */
>>  bool arch_topdown_sample_read(struct evsel *leader)
>>  {
>> +	struct evsel *evsel;
>> +
>>  	if (!evsel__sys_has_perf_metrics(leader))
>>  		return false;
>>  
>> -	if (arch_is_topdown_slots(leader))
>> -		return true;
>> +	if (!arch_is_topdown_slots(leader))
>> +		return false;
>> +
>> +	/*
>> +	 * If slots event as leader event but no topdown metric events
>> +	 * in group, slots event should still sample as leader.
>> +	 */
>> +	evlist__for_each_entry(leader->evlist, evsel) {
>> +		if (evsel != leader && arch_is_topdown_metrics(evsel))
>> +			return true;
>> +	}
>>  
>>  	return false;
>>  }
>> -- 
>> 2.40.1
> 
