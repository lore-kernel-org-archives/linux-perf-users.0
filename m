Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833B23CF73;
	Wed,  3 Jul 2024 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014647; cv=none; b=dZATCGo3l4fDWfU1PCni+KkpjpDLCXcjZqzej6/g/RBtxGNq7iWl7zV1bRICQ0Nj6oANWg7SuF6/ECr89PE9B+2LXSezll5zJ5IhnyAVsnWWzYZan3c7bXSJHyb2G2mbhANBt4RLoUkfnfiNuj40ciGxCy91Ti3MKoA0fiEEvLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014647; c=relaxed/simple;
	bh=rZw/x5DNDmlgq/YRxFmk4A1MkbVCzgR5o46weJUGkB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEE4BOfDfMs2n6Mcrei/fuJjBVqBeYAXPoHpavZ78ychYWO86Vp1eQ4Zt9J6VrxO9CfIFbLCnzrkqFhK1YqwZSBILF5ZDCDA/kFc77xANRUrayjg/aHIrh5dW7HXWUyKoDb32fMBqshiHEh4LWp0uCAK8Pas28htAJcU6EZ8qX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XLHTD7SP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XLHTD7SP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720014645; x=1751550645;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rZw/x5DNDmlgq/YRxFmk4A1MkbVCzgR5o46weJUGkB0=;
  b=XLHTD7SPrJUm0URnoGNQptovd8/S42KM4oGhkhFoGK13NlI62LLJVYzl
   UQi6i1Zu8myYetrd1PwLauRXa7xJo3XRSsgcOmkFUxyUiFaUnIOP1SiH1
   RKhdcF1lGVnx7m8O2oTyWe8ordKH4HFdVycSwe9ai2UV+Rnn3eCcV0ziT
   SC6wK6Ljc4jqd3916E4dGi49iwmnnqxbaqmM9Sij+//KqNUMYT5BoHSA1
   thaHEikOIfGHZ1slQv5ZxYxSs/82vn/mXkrJCCLDH7NFwiqh7/9a1AjGn
   iZXup1rCjfI2jef5+k0bk/vRfdh/GKUwJrvAxnlHYR0st/OSyZVc3x/W1
   g==;
X-CSE-ConnectionGUID: lzDxt+VVTHa55YAvsQQwDg==
X-CSE-MsgGUID: lUIQQwBkT8SlRMasc0RCew==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="39761677"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="39761677"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 06:50:45 -0700
X-CSE-ConnectionGUID: m82/40P5QFmdWB6TJmB5xg==
X-CSE-MsgGUID: CVkFQwDISqmVo7nByYeJaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="51109870"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 06:50:45 -0700
Received: from [10.209.189.42] (kliang2-mobl1.ccr.corp.intel.com [10.209.189.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 5A939201A797;
	Wed,  3 Jul 2024 06:50:43 -0700 (PDT)
Message-ID: <8b511e2b-defa-491e-af06-2de85377ba97@linux.intel.com>
Date: Wed, 3 Jul 2024 09:50:42 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] perf topdown: Correct leader selection with
 sample_read enabled
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
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
 <5223c6bb-a05b-4a8c-a625-2011db190631@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <5223c6bb-a05b-4a8c-a625-2011db190631@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-07-02 10:46 p.m., Mi, Dapeng wrote:
> 
> On 7/3/2024 12:05 AM, Liang, Kan wrote:
>>
>> On 2024-07-02 6:40 p.m., Dapeng Mi wrote:
>>> Addresses an issue where, in the absence of a topdown metrics event
>>> within a sampling group, the slots event was incorrectly bypassed as
>>> the sampling leader when sample_read was enabled.
>>>
>>> perf record -e '{slots,branches}:S' -c 10000 -vv sleep 1
>>>
>>> In this case, the slots event should be sampled as leader but the
>>> branches event is sampled in fact like the verbose output shows.
>>>
>>> perf_event_attr:
>>>   type                             4 (cpu)
>>>   size                             168
>>>   config                           0x400 (slots)
>>>   sample_type                      IP|TID|TIME|READ|CPU|IDENTIFIER
>>>   read_format                      ID|GROUP|LOST
>>>   disabled                         1
>>>   sample_id_all                    1
>>>   exclude_guest                    1
>>> ------------------------------------------------------------
>>> sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>>> ------------------------------------------------------------
>>> perf_event_attr:
>>>   type                             0 (PERF_TYPE_HARDWARE)
>>>   size                             168
>>>   config                           0x4 (PERF_COUNT_HW_BRANCH_INSTRUCTIONS)
>>>   { sample_period, sample_freq }   10000
>>>   sample_type                      IP|TID|TIME|READ|CPU|IDENTIFIER
>>>   read_format                      ID|GROUP|LOST
>>>   sample_id_all                    1
>>>   exclude_guest                    1
>>>
>>> The sample period of slots event instead of branches event is reset to
>>> 0.
>>>
>>> This fix ensures the slots event remains the leader under these
>>> conditions.
>>>
>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>> ---
>>>  tools/perf/arch/x86/util/topdown.c | 16 ++++++++++++++--
>>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
>>> index 3f9a267d4501..5d7b78eb7516 100644
>>> --- a/tools/perf/arch/x86/util/topdown.c
>>> +++ b/tools/perf/arch/x86/util/topdown.c
>>> @@ -1,6 +1,7 @@
>>>  // SPDX-License-Identifier: GPL-2.0
>>>  #include "api/fs/fs.h"
>>>  #include "util/evsel.h"
>>> +#include "util/evlist.h"
>>>  #include "util/pmu.h"
>>>  #include "util/pmus.h"
>>>  #include "util/topdown.h"
>>> @@ -41,11 +42,22 @@ bool topdown_sys_has_perf_metrics(void)
>>>   */
>>>  bool arch_topdown_sample_read(struct evsel *leader)
>>>  {
>>> +	struct evsel *event;
>>> +
>>>  	if (!evsel__sys_has_perf_metrics(leader))
>>>  		return false;
>>>  
>>> -	if (leader->core.attr.config == TOPDOWN_SLOTS)
>>> -		return true;
>>> +	if (leader->core.attr.config != TOPDOWN_SLOTS)
>>> +		return false;
>>> +
>>> +	/*
>>> +	 * If slots event as leader event but no topdown metric events in group,
>>> +	 * slots event should still sample as leader.
>>> +	 */
>>> +	evlist__for_each_entry(leader->evlist, event) {
>>> +		if (event != leader && strcasestr(event->name, "topdown"))
>> User may uses the RAW format. It may not be good enough to just check
>> the event name.
>>
>> I recall you have a complete support for this in the previous patch. Why
>> drop it?
> 
> 
> Oh, I ignored the RAW format case. Yes, there is a complete comparison in
> previous patch, but I originally thought it's over-complicated, so I just
> simplified it (refer other helpers to compare the name).  If we need to
> consider the RAW format, it may be not correct for the comparisons in the
> helpers arch_evsel__must_be_in_group() and arch_evlist__cmp() as well.
>

Right, those need to be fixed as well.

> If we want to fix the issue thoroughly, we may have to expose two helpers
> which check if an event is topdown slots or metrics event and use these two
> helpers to replace current name comparison.

Yes, you may have to add an extra patch to introduce the two helper
functions and replace the existing function.

Thanks,
Kan
> 
>>
>> Thanks,
>> Kan
>>
>>> +			return true;
>>> +	}
>>>  
>>>  	return false;
>>>  }
