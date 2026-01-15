Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085A330AD0C;
	Thu, 15 Jan 2026 21:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768510984; cv=none; b=cW+mEZI8ytKlLlXGnicCOvgJrE9KTrWHsIl8YMrsc7J9HQpjQvcfHyTDHZM4VKSQK2GlhDZ9OjBL+uPxAzvnl9QBXjNFDkIfuPsmfaRNetNuK7Wkw8iJuZVaHyGeFMOrs0oPMIj9JoCTlIatap8YIqeEtQuQPBkpPpbS/ratjcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768510984; c=relaxed/simple;
	bh=sQmUIyHjf6/5MV5Mi+fJO40spykbutFC+hyyezTBqbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6DpFGp7nen2f519zhgqlpMPFwh+U9Q11U/o1ZkTMIESvibg4Pt/wqBEfWdRV8C4OtYJQ2RjQEp0q3d5tRI0XaGm8+VpBu4OBzhU9XBuSTdYHkv3+vqsUhDLcGx6Gh+/Pxhl1dMFheDuc8d7hjtshLnJcK2skjRmTTzMeVgF2WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6ObX7P7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6ObX7P7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768510983; x=1800046983;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sQmUIyHjf6/5MV5Mi+fJO40spykbutFC+hyyezTBqbM=;
  b=Z6ObX7P7AWE+cYv3U1+WnCfVHq7reGXEL25phv/FEjrRDAeeL8uGCdPy
   +dzmOJoQRMVGZTcuamwu96esyn1dRTEV1LNMUcOafLul9BSqqAsYlhpop
   5UBNn+qzsJl+fWG8rLPYT+rg07113T2op9RpnOShlbCAjExupeHt8kWQN
   o1oyRVVsh/MN5fWySIWWeWvEvsizyWaxIUPc66b5LwK2cO0yCnVE6Pc+/
   HIAy52aVJlMGCjzPZ+T2EWPtane3GKLlXV+fBEo3+5EfIYArC5+BlyrUA
   Gz7o9mmWgNTgts3ClNzTzOQvkD/U8i9S87jHAQAzNI1aOjAFme+Al5TFH
   w==;
X-CSE-ConnectionGUID: cePzX6j3TFGDAPXRLIDWrg==
X-CSE-MsgGUID: aUBzlg+xStCqVaAQ44SH2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="73458623"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="73458623"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 13:03:02 -0800
X-CSE-ConnectionGUID: nDuTqCgpTz6bKnlzRRNLaQ==
X-CSE-MsgGUID: 6oBwrsiVRomIRJ1EwDXaaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="204844179"
Received: from unknown (HELO [10.241.241.114]) ([10.241.241.114])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 13:03:03 -0800
Message-ID: <b7c46240-d0b3-472d-87dc-88cdbd8e0b92@intel.com>
Date: Thu, 15 Jan 2026 13:03:02 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V2] perf/x86/intel/uncore: Fix iounmap() leak on global_init
 failure
To: Markus Elfring <Markus.Elfring@web.de>, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Stephane Eranian
 <eranian@google.com>, "Chen, Zide" <zide.chen@intel.com>
Cc: lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Thomas Falcon <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260114193825.17973-1-zide.chen@intel.com>
 <cda9ab9b-4581-409f-a9bb-0e8a67ad3530@web.de>
 <32386e0a-09d9-4f13-a5e1-c6f9dd3afdfd@intel.com>
 <25f39aaa-1e72-47ce-92e7-d6b8ecc2750a@web.de>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <25f39aaa-1e72-47ce-92e7-d6b8ecc2750a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/15/2026 1:01 AM, Markus Elfring wrote:
>>> See also once more:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc5#n94
>>>
>>> Will another imperative wording approach become helpful for an improved change description?
>>
>> My apologies — I did try to address the feedback, but I may still be
>> missing something.  Could you please point out what specifically could
>> be improved?
> 
> I hope that the understanding will improve somehow also for a development
> communication requirement like “imperative mood”.

For the commit message itself, I’ve tried to improve it as much as I can
based on the feedback so far. If there are still specific phrases or
wording that should be adjusted, I’d really appreciate it if you could
point them out.
>>> …
>>>> ---
>>>>  arch/x86/events/intel/uncore_discovery.c | 15 ++++++++++-----
>>> …
>>>
>>> Some contributors would appreciate patch version descriptions.
>>> https://lore.kernel.org/all/?q=%22This+looks+like+a+new+version+of+a+previously+submitted+patch%22
> …
>> Yes, that was the intention for v2.
>>
>> V2:
>> - As suggested by Markus, add an `out` label and use goto-based error
>>   handling to reduce duplicated iounmap() code.
> 
> We are still trying to discuss the corresponding identifier selection,
> aren't we?
> 
> 
>> - Add the original warning from the kernel test robot to the commit message.
> 
> It is possible then to identify presented information in the way
> that it is probably coming from coccicheck.
It was indeed from the kernel test robot report. I’m not familiar with
the Intel kernel test robot internals, and I’m not sure whether it
invokes coccicheck.

>> - Trivial rewording of the commit message.
>>
>>>
>>> Is there a need to perform desirable changes by a small patch series?
>>>
>>> * Specific fix
>>> * Related refinements
>>
>> It seems to me that the changes in this patch are small and closely
>> related, so I wondered whether splitting it might be unnecessary.
> 
> I propose to apply a more detailed change granularity.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc5#n81

Thanks for the reference. I considered this a single logical fix, which
is why I kept the changes together.


>>>> +++ b/arch/x86/events/intel/uncore_discovery.c
>>>> @@ -264,6 +264,7 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
>>>>  	struct uncore_unit_discovery unit;
>>>>  	void __iomem *io_addr;
>>>>  	unsigned long size;
>>>> +	int ret = 0;
>>>>  	int i;
>>>
>>> Would scope adjustments become helpful for any of these local variables?
>>
>> As mentioned in my earlier reply, my suggestion was to avoid doing other
>> unrelated optimizations in this patch.
> 
> Will development interests grow for related update steps?

Are you suggesting including this change in this patch? My understanding
is that it isn’t directly related to the scope of this patch, so I would
prefer not to include it here. Please let me know if you see it differently.

diff --git a/arch/x86/events/intel/uncore_discovery.c
b/arch/x86/events/intel/uncore_discovery.c
index efd1fc99a908..8ab8f778285a 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -265,7 +265,6 @@ static int __parse_discovery_table(struct
uncore_discovery_domain *domain,
        void __iomem *io_addr;
        unsigned long size;
        int ret = 0;
-       int i;

        size = UNCORE_DISCOVERY_GLOBAL_MAP_SIZE;
        io_addr = ioremap(addr, size);
@@ -293,7 +292,7 @@ static int __parse_discovery_table(struct
uncore_discovery_domain *domain,
        }

        /* Parsing Unit Discovery State */
-       for (i = 0; i < global.max_units; i++) {
+       for (int i = 0; i < global.max_units; i++) {
                memcpy_fromio(&unit, io_addr + (i + 1) * (global.stride
* 8),
                              sizeof(struct uncore_unit_discovery));



>> https://lore.kernel.org/all/e7d74d9d-cb45-4f5f-8e44-502dd7c4bcff@intel.com/T/#t
> 
> Re: [PATCH] perf/x86/intel/uncore: Fix iounmap() leak on global_init failure
> 
> Can the timing trigger special considerations?

Sorry if I’m missing your point, but it seems to me that there are no
special considerations involved here.


>>>> @@ -273,21 +274,23 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
>>>>  
>>>>  	/* Read Global Discovery State */
>>>>  	memcpy_fromio(&global, io_addr, sizeof(struct uncore_global_discovery));
>>>> +	iounmap(io_addr);
>>>> +
>>>>  	if (uncore_discovery_invalid_unit(global)) {
>>> …
>>>>  	}
>>>> -	iounmap(io_addr);
>>>
>>> Can this modification part be interpreted as an optimisation?
>>
>> Yes, this is technically an optimization.
> 
> Thanks that we can come to the same conclusion on this aspect.
> 
> 
>>                                           Since the patch is already
>> refactoring the iounmap() handling, my thinking was that it would be
>> reasonable to include it in the same patch.
> 
> I dare to point another opinion out.
> 
> I assume that backporting concerns can influence this detail also a bit more.

Thanks for pointing that out. This patch is intended as a quick fix for
a change that is still staging in perf/core, so I assume that
backporting is unlikely to be needed.

>>> …
>>>> -	if (domain->global_init && domain->global_init(global.ctl))
>>>> -		return -ENODEV;
>>>> +	if (domain->global_init && domain->global_init(global.ctl)) {
>>>> +		ret = -ENODEV;
>>>> +		goto out;
>>>> +	}
>>> …
>>>>  	*parsed = true;
>>>> +
>>>> +out:
>>>
>>> Would an other label be a bit clearer here?
>>
>> I’d suggest keeping the label name out for style consistency, as
>> mentioned in my earlier reply.
>>
>> https://lore.kernel.org/all/e7d74d9d-cb45-4f5f-8e44-502dd7c4bcff@intel.com/T/#t
>>
>>>
>>> unmap_io:
>>>
>>>>  	iounmap(io_addr);
>>>> -	return 0;
>>>> +	return ret;
>>>>  }
>>> …
> 
> By the way:
> How do you think about to increase the application of scope-based resource management?

That’s an interesting topic, but for this patch I’d like to keep the
change minimal and focused.

> Regards,
> Markus

