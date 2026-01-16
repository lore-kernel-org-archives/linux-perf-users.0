Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6567C2745C;
	Fri, 16 Jan 2026 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582548; cv=none; b=BdQLcYgbozCxjv8P5K/+wjIzHM9A3uphyPT1I4WNX1nh/eh80L+IhRr/1zs959R+qBVRgY7w96CqKKPPU244DJ5JDOfEr4kqET6L8DDNHHLbeBNvNfk0/LDcSamseQHVSKzrq5C6MkzeyOcBwrm/lJmXHiGGUQ/5Gn09KfOd2CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582548; c=relaxed/simple;
	bh=U5bU8uy3QaFXX5fGrfSABXJUkdycUgsBChvWEXs/MjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSMBAwa60M+/Uxka4A1MR59movTL6G7CWO/k16SreXDxCao18vsOrPOJnbjZIypQ/3p3RBicK5z4951SL5Exp38rRvq2zJhuFVkEXTfPHTSZY7P86ULaCfL+hBQmeymi920Q+lUbqWjOFB73saSDuEC6grdXCPW/JULxFeWoBHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZVrdg5dq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZVrdg5dq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768582545; x=1800118545;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U5bU8uy3QaFXX5fGrfSABXJUkdycUgsBChvWEXs/MjM=;
  b=ZVrdg5dqAIlADQxkQCs3UH4z4oviwGQ1uJMLz9rEVQLrqB0W+HP2y09n
   ku2hXg2EReYusgYffedZ5vC1TEiFsnenuVMcOywdJcCIKrNo3jVFfW2wP
   nXiMXWR7v1etdNFPIl7dJ38TSTsvjdjTdKySFYVoxNE3cb79J+FJc3Ohh
   sUOEJrJtwgQiXVOQLeQfuV7P/WIQU08Eg/rasYwGweYMq3kLkrgGZzIQz
   jfelGrzZaYkFZytPgHgRIp0HWnsc5pusPoBK2cQNw7iVoNOqguE0Mj690
   JHfggp/Zck2UAR3CZXgRrB62yflTDKtWgLskWR1F6G7xw4t2V5b8fLgTm
   Q==;
X-CSE-ConnectionGUID: VAf4bgPER6Km7lvociwtjg==
X-CSE-MsgGUID: olcZ9BNZSN6SxTLWLcj49Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="81268608"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="81268608"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 08:55:45 -0800
X-CSE-ConnectionGUID: TCwzQ+lEQKa14nj5j/vJzA==
X-CSE-MsgGUID: qN1g3zWBRoOgw3uLPMoKiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="235978480"
Received: from dnelso3-mobl.amr.corp.intel.com (HELO [10.125.85.28]) ([10.125.85.28])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 08:55:44 -0800
Message-ID: <092c955c-4f27-44ed-9e88-dc721e1d2959@intel.com>
Date: Fri, 16 Jan 2026 08:55:44 -0800
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
 Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>
Cc: lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Thomas Falcon <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260114193825.17973-1-zide.chen@intel.com>
 <cda9ab9b-4581-409f-a9bb-0e8a67ad3530@web.de>
 <32386e0a-09d9-4f13-a5e1-c6f9dd3afdfd@intel.com>
 <25f39aaa-1e72-47ce-92e7-d6b8ecc2750a@web.de>
 <b7c46240-d0b3-472d-87dc-88cdbd8e0b92@intel.com>
 <afc060ac-0cb9-4e2f-8cdc-029ac7679246@web.de>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <afc060ac-0cb9-4e2f-8cdc-029ac7679246@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/15/2026 11:15 PM, Markus Elfring wrote:
>>>>> See also once more:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc5#n94
>>>>>
>>>>> Will another imperative wording approach become helpful for an improved change description?
>>>>
>>>> My apologies — I did try to address the feedback, but I may still be
>>>> missing something.  Could you please point out what specifically could
>>>> be improved?
>>>
>>> I hope that the understanding will improve somehow also for a development
>>> communication requirement like “imperative mood”.
>>
>> For the commit message itself, I’ve tried to improve it as much as I can
>> based on the feedback so far. If there are still specific phrases or
>> wording that should be adjusted, I’d really appreciate it if you could
>> point them out.
> 
> 1. The mentioned source code analysis report is obviously helpful.
> 
> 2. You added a custom explanation accordingly.
> 
> 3. Which text part of your change description does contain “orders to
>    the codebase to change its behaviour”?

OK, I see your point. Yes, it's good to add one sentence to describe
what the patches does. But I guess this patch is simple enough.


>>>>> Is there a need to perform desirable changes by a small patch series?
>>>>>
>>>>> * Specific fix
>>>>> * Related refinements
>>>>
>>>> It seems to me that the changes in this patch are small and closely
>>>> related, so I wondered whether splitting it might be unnecessary.
>>>
>>> I propose to apply a more detailed change granularity.
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc5#n81
>>
>> Thanks for the reference. I considered this a single logical fix, which
>> is why I kept the changes together.
> 
> I find this adjustment approach also “logical” (in principle).
> 
> 
>>>>>> +++ b/arch/x86/events/intel/uncore_discovery.c
>>>>>> @@ -264,6 +264,7 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
>>>>>>  	struct uncore_unit_discovery unit;
>>>>>>  	void __iomem *io_addr;
>>>>>>  	unsigned long size;
>>>>>> +	int ret = 0;
>>>>>>  	int i;
>>>>>
>>>>> Would scope adjustments become helpful for any of these local variables?
>>>>
>>>> As mentioned in my earlier reply, my suggestion was to avoid doing other
>>>> unrelated optimizations in this patch.
>>>
>>> Will development interests grow for related update steps?
>>
>> Are you suggesting including this change in this patch?
> 
> Does anything hinder you to take patch series better into account?


This “optimization” is trivial and does not appear to be related to the
issue this patch is trying to address.

I don’t think this change alone justifies a separate patch, as it would
add review overhead without providing much practical benefit.

-  int i;
-       for (i = 0; i < global.max_units; i++) {
+       for (int i = 0; i < global.max_units; i++) {

Overall, the Intel perf driver largely follows a pre-C99 coding style.
Updating a single instance in isolation does not seem very helpful; if
there is interest, this could be handled as part of a broader,
driver-wide cleanup.

> 
>>                                                         My understanding
>> is that it isn’t directly related to the scope of this patch, so I would
>> prefer not to include it here.
> 
> Can we imagine further patch variations?

Ditto.

> 
>>                                Please let me know if you see it differently.
> 
> This is the case according to another evolving patch review.
> 
> 
>>>> https://lore.kernel.org/all/e7d74d9d-cb45-4f5f-8e44-502dd7c4bcff@intel.com/T/#t
>>>
>>> Re: [PATCH] perf/x86/intel/uncore: Fix iounmap() leak on global_init failure
>>>
>>> Can the timing trigger special considerations?
>>
>> Sorry if I’m missing your point, but it seems to me that there are no
>> special considerations involved here.
> 
> 1. You announced planned changes for an initial patch.
>    https://lore.kernel.org/linux-perf-users/fc565620-a3ef-4a28-bfb8-87bb5ce135f5@intel.com/
> 
> 2. I offered review comments accordingly.
> 
> 3. You published the second patch version.
>    https://lore.kernel.org/linux-perf-users/20260114193825.17973-1-zide.chen@intel.com/
> 
> 4. You replied to the mentioned review approach three minutes later, didn't you?
>    https://lore.kernel.org/linux-perf-users/e7d74d9d-cb45-4f5f-8e44-502dd7c4bcff@intel.com/
> 

Really appreciated for your review!


>>>>                                           Since the patch is already
>>>> refactoring the iounmap() handling, my thinking was that it would be
>>>> reasonable to include it in the same patch.
>>>
>>> I dare to point another opinion out.
>>>
>>> I assume that backporting concerns can influence this detail also a bit more.
>>
>> Thanks for pointing that out. This patch is intended as a quick fix for
>> a change that is still staging in perf/core, so I assume that
>> backporting is unlikely to be needed.
> 
> Will backporting be usually desirable for Linux software components?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/backporting.rst?h=v6.19-rc5#n14
> 
> It happened again that further change possibilities were noticed.
> Thus companion patches can be considered on demand.
> The corresponding change recombination can occasionally become more interesting
> for selected development ideas.


Are you suggesting putting this into a separate patch?
My impression is that the change is simple and closely related, though I
may be missing something. I understand others may see it differently.

@@ -273,21 +274,23 @@ static int __parse_discovery_table(struct
uncore_discovery_domain *domain,

        /* Read Global Discovery State */
        memcpy_fromio(&global, io_addr, sizeof(struct
uncore_global_discovery));
+       iounmap(io_addr);
+
        if (uncore_discovery_invalid_unit(global)) {
                pr_info("Invalid Global Discovery State: 0x%llx 0x%llx
0x%llx\n",
                        global.table1, global.ctl, global.table3);
-               iounmap(io_addr);
                return -EINVAL;
        }
-       iounmap(io_addr);


>>> How do you think about to increase the application of scope-based resource management?
>>
>> That’s an interesting topic, but for this patch I’d like to keep the
>> change minimal and focused.
> 
> This software design technique influences also if we would still like to fiddle
> with goto chains (or not).
> https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/cleanup.h#L12-L17
> 
> Do you see opportunities fur further collateral evolution?

Yes, there are some code cleanup/improvement ideas in mind.

> Regards,
> Markus

