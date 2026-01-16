Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297C3188735;
	Fri, 16 Jan 2026 00:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768525066; cv=none; b=ijk316FDRT3IyOVaWodt+WV1bhNUvUYLtG4fXPQv+0DGHmpa1go/NvlxM0dQ5vL8rshn8YsIqQa2ZhXpscgfju9B6gRUu1m3jagvJkGiASv3zKYldiGqLJdCd7uxIUdcL3H+7FiZS3V2ai/KrhUk/48W3F6hW2Khosahbpq33tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768525066; c=relaxed/simple;
	bh=o18sfMWvdqNr3iCqBoEY7pxCrYnJNFXFiIPWrTz8X+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHtxvo2fuSH556yx/xewiOJ3QXMI5oxr4TRoa86s3J0sDWX4KChWxtV5cg2OwcrZpCPtRB8pjk2uahe/vHe8LG1E76ApT2VV3u2CB9xUZfs2VbH3ZrjGWsybzlb9wZnGMDafiGXYur+FOnrPQ05ZlGsLNAIRGyqvPE5VDO4Budg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eoVHoLRK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eoVHoLRK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768525065; x=1800061065;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o18sfMWvdqNr3iCqBoEY7pxCrYnJNFXFiIPWrTz8X+o=;
  b=eoVHoLRKeFop150vkevHQKkRzxJKPUVQmNo5GIwHunv8YL2mF+GcSCti
   Bgb2I39FR1xmvuFnYUpaAU6Z6Fp+EEHsQgXizNnueLuoGd1Avnj0brLMY
   npRUF4QEJOYxpY4RuynJ0pUrlNe17AitxAGRXnmevWwfh6UZ3TlFm9ngl
   HkDvvnl+tMVnY5ryQ5WV9RHjx8Drdqtn3yvpFfSLwGtE2Xly2JFPijxxn
   N5W9+vEyE3G/ZoawwtuGsrQNVDzwVaD2tFz+omBiufwuOu1KtPR0AFDwh
   HjUavDJtPdfa/4BM7A0PVzh/57N1EnEXFylBWLQGZ7WsuxibURvfpttdv
   g==;
X-CSE-ConnectionGUID: 1LF29uthSKa+jzi7NUKI7Q==
X-CSE-MsgGUID: lxM4Bx3ISmaBjej9ajaNBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69891214"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69891214"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 16:57:45 -0800
X-CSE-ConnectionGUID: +OOYUsVhRkGmQk5zQEbmrw==
X-CSE-MsgGUID: TXy1g6FBQCmr1GrarK+L4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="209245072"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 16:57:40 -0800
Message-ID: <ef00d1ec-9b0e-4204-b1dd-885245db35fa@linux.intel.com>
Date: Fri, 16 Jan 2026 08:57:37 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V2] perf/x86/intel/uncore: Fix iounmap() leak on global_init
 failure
To: "Chen, Zide" <zide.chen@intel.com>, Markus Elfring
 <Markus.Elfring@web.de>, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Stephane Eranian <eranian@google.com>
Cc: lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Thomas Falcon <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260114193825.17973-1-zide.chen@intel.com>
 <cda9ab9b-4581-409f-a9bb-0e8a67ad3530@web.de>
 <32386e0a-09d9-4f13-a5e1-c6f9dd3afdfd@intel.com>
 <25f39aaa-1e72-47ce-92e7-d6b8ecc2750a@web.de>
 <b7c46240-d0b3-472d-87dc-88cdbd8e0b92@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <b7c46240-d0b3-472d-87dc-88cdbd8e0b92@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/16/2026 5:03 AM, Chen, Zide wrote:
>
> On 1/15/2026 1:01 AM, Markus Elfring wrote:
>>>> See also once more:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc5#n94
>>>>
>>>> Will another imperative wording approach become helpful for an improved change description?
>>> My apologies — I did try to address the feedback, but I may still be
>>> missing something.  Could you please point out what specifically could
>>> be improved?
>> I hope that the understanding will improve somehow also for a development
>> communication requirement like “imperative mood”.
> For the commit message itself, I’ve tried to improve it as much as I can
> based on the feedback so far. If there are still specific phrases or
> wording that should be adjusted, I’d really appreciate it if you could
> point them out.
>>>> …
>>>>> ---
>>>>>  arch/x86/events/intel/uncore_discovery.c | 15 ++++++++++-----
>>>> …
>>>>
>>>> Some contributors would appreciate patch version descriptions.
>>>> https://lore.kernel.org/all/?q=%22This+looks+like+a+new+version+of+a+previously+submitted+patch%22
>> …
>>> Yes, that was the intention for v2.
>>>
>>> V2:
>>> - As suggested by Markus, add an `out` label and use goto-based error
>>>   handling to reduce duplicated iounmap() code.
>> We are still trying to discuss the corresponding identifier selection,
>> aren't we?
>>
>>
>>> - Add the original warning from the kernel test robot to the commit message.
>> It is possible then to identify presented information in the way
>> that it is probably coming from coccicheck.
> It was indeed from the kernel test robot report. I’m not familiar with
> the Intel kernel test robot internals, and I’m not sure whether it
> invokes coccicheck.
>
>>> - Trivial rewording of the commit message.
>>>
>>>> Is there a need to perform desirable changes by a small patch series?
>>>>
>>>> * Specific fix
>>>> * Related refinements
>>> It seems to me that the changes in this patch are small and closely
>>> related, so I wondered whether splitting it might be unnecessary.
>> I propose to apply a more detailed change granularity.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc5#n81
> Thanks for the reference. I considered this a single logical fix, which
> is why I kept the changes together.
>
>
>>>>> +++ b/arch/x86/events/intel/uncore_discovery.c
>>>>> @@ -264,6 +264,7 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
>>>>>  	struct uncore_unit_discovery unit;
>>>>>  	void __iomem *io_addr;
>>>>>  	unsigned long size;
>>>>> +	int ret = 0;
>>>>>  	int i;
>>>> Would scope adjustments become helpful for any of these local variables?
>>> As mentioned in my earlier reply, my suggestion was to avoid doing other
>>> unrelated optimizations in this patch.
>> Will development interests grow for related update steps?
> Are you suggesting including this change in this patch? My understanding
> is that it isn’t directly related to the scope of this patch, so I would
> prefer not to include it here. Please let me know if you see it differently.
>
> diff --git a/arch/x86/events/intel/uncore_discovery.c
> b/arch/x86/events/intel/uncore_discovery.c
> index efd1fc99a908..8ab8f778285a 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
> @@ -265,7 +265,6 @@ static int __parse_discovery_table(struct
> uncore_discovery_domain *domain,
>         void __iomem *io_addr;
>         unsigned long size;
>         int ret = 0;
> -       int i;
>
>         size = UNCORE_DISCOVERY_GLOBAL_MAP_SIZE;
>         io_addr = ioremap(addr, size);
> @@ -293,7 +292,7 @@ static int __parse_discovery_table(struct
> uncore_discovery_domain *domain,
>         }
>
>         /* Parsing Unit Discovery State */
> -       for (i = 0; i < global.max_units; i++) {
> +       for (int i = 0; i < global.max_units; i++) {
>                 memcpy_fromio(&unit, io_addr + (i + 1) * (global.stride
> * 8),
>                               sizeof(struct uncore_unit_discovery));
>
>
>
>>> https://lore.kernel.org/all/e7d74d9d-cb45-4f5f-8e44-502dd7c4bcff@intel.com/T/#t
>> Re: [PATCH] perf/x86/intel/uncore: Fix iounmap() leak on global_init failure
>>
>> Can the timing trigger special considerations?
> Sorry if I’m missing your point, but it seems to me that there are no
> special considerations involved here.
>
>
>>>>> @@ -273,21 +274,23 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
>>>>>  
>>>>>  	/* Read Global Discovery State */
>>>>>  	memcpy_fromio(&global, io_addr, sizeof(struct uncore_global_discovery));
>>>>> +	iounmap(io_addr);
>>>>> +
>>>>>  	if (uncore_discovery_invalid_unit(global)) {
>>>> …
>>>>>  	}
>>>>> -	iounmap(io_addr);
>>>> Can this modification part be interpreted as an optimisation?
>>> Yes, this is technically an optimization.
>> Thanks that we can come to the same conclusion on this aspect.
>>
>>
>>>                                           Since the patch is already
>>> refactoring the iounmap() handling, my thinking was that it would be
>>> reasonable to include it in the same patch.
>> I dare to point another opinion out.
>>
>> I assume that backporting concerns can influence this detail also a bit more.
> Thanks for pointing that out. This patch is intended as a quick fix for
> a change that is still staging in perf/core, so I assume that
> backporting is unlikely to be needed.

Agree.

IMO, we'd better keep this patch is simple and focused and then it can be
reviewed and merged into perf/core tree quickly. So we can avoid to cause
the subsequent backporting work. 

About the further optimization, we can have an independent patchset to do
it. :)

Thanks.


>
>>>> …
>>>>> -	if (domain->global_init && domain->global_init(global.ctl))
>>>>> -		return -ENODEV;
>>>>> +	if (domain->global_init && domain->global_init(global.ctl)) {
>>>>> +		ret = -ENODEV;
>>>>> +		goto out;
>>>>> +	}
>>>> …
>>>>>  	*parsed = true;
>>>>> +
>>>>> +out:
>>>> Would an other label be a bit clearer here?
>>> I’d suggest keeping the label name out for style consistency, as
>>> mentioned in my earlier reply.
>>>
>>> https://lore.kernel.org/all/e7d74d9d-cb45-4f5f-8e44-502dd7c4bcff@intel.com/T/#t
>>>
>>>> unmap_io:
>>>>
>>>>>  	iounmap(io_addr);
>>>>> -	return 0;
>>>>> +	return ret;
>>>>>  }
>>>> …
>> By the way:
>> How do you think about to increase the application of scope-based resource management?
> That’s an interesting topic, but for this patch I’d like to keep the
> change minimal and focused.
>
>> Regards,
>> Markus
