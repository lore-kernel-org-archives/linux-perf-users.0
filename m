Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF9317A31C
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 01:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781486162; cv=none; b=hDfh6zy+yEBnWgvE8rrRqcIyEtCeZF5hXb3lOlQKouj80WFA8zsVJrZ2yuWhMYPFFWu0ryBJvLTCIxpDM29/exDe4yw5Qm+V7xQq8tyCe+hoq80ujxZJvp9d5H6S16r0a+XawPo+Iq0aJR2nVC3pMKISLexiR+fA8xijK5IPsts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781486162; c=relaxed/simple;
	bh=2rzc2ZONiC7l0r9cGqvkP3EkcFTvoUL332G1Vc2tMM0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HP5FfrozI6l2LM7skrbIHHWmZSN4M7zY4NF/k0ubLOO9HCdjQgQ+MCof6vIQ6thmXU4swxc4ieenH0+w0XCWKXLaGk9yD6H1AvhvoQDjBaiDqNPcD6YgA6SLwITybVyzflsa4MtG4ulVG+Z6u4UcAJ3wQ+3wBBsGE2efzqUzIeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jz3SZN/2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jz3SZN/2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781486160; x=1813022160;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=2rzc2ZONiC7l0r9cGqvkP3EkcFTvoUL332G1Vc2tMM0=;
  b=jz3SZN/2tMRA8cwCY+rGeDFOQPbgspLW26vvln9nVvZTL8/bomWzTxe/
   Euibq/3d87EFAA+sY/yOE9ROKj7x2+NVMeWooEmErRWmgn7nDqPk54Rwb
   jgGFcCCtsx9XG/1QCwWrBoziRZkg4IBP7V9u5Nk2GR222MgM/Rr6HppDZ
   zf624s98IQDgfoG9zPOLvySwnF/Bf/FUBXdO2DjBSpcrZARMCrJT18/Mj
   edb0eSxhJpRnzZVVj7i3cSTQlOyVVsuSrNnV6ynU/EdOjHhlmsbG5/CMA
   P1aFnVb3ON96ZrVZazMtfsamVNuLoUYbCa6HSshnlSylIbai+QnIS8Upb
   g==;
X-CSE-ConnectionGUID: 3DEBfNjATOCH9cnV7jibnQ==
X-CSE-MsgGUID: M+lWvpnnSFOwNpyoJ+10Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="81963187"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="81963187"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 18:16:00 -0700
X-CSE-ConnectionGUID: gLNC6KeKQvOzDaP2zecUuA==
X-CSE-MsgGUID: nteyLqvDSSyBL9Sy4z5VYg==
X-ExtLoop1: 1
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 18:15:59 -0700
Message-ID: <ac2849f5-bfe9-4532-b2f7-b9dbc3925c00@linux.intel.com>
Date: Mon, 15 Jun 2026 09:15:57 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] perf vendor events intel: Update lunarlake events
 from 1.22 to 1.25
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
To: Chun-Tse Shao <ctshao@google.com>, "Baker, Edward"
 <edward.baker@intel.com>
Cc: linux-perf-users@vger.kernel.org
References: <20260609215046.2391903-5-ctshao@google.com>
 <20260609220242.A7B301F00893@smtp.kernel.org>
 <CAJpZYjXoC=Z10_X_=TQw2Q+O-jrQfV+S-bHThAUoXEoenHpT0w@mail.gmail.com>
 <c0a5f131-db2d-4252-8e88-7336718e95ae@linux.intel.com>
Content-Language: en-US
In-Reply-To: <c0a5f131-db2d-4252-8e88-7336718e95ae@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/10/2026 5:04 PM, Mi, Dapeng wrote:
> On 6/10/2026 6:58 AM, Chun-Tse Shao wrote:
>> + Dapeng and Edward
>>
>> On Tue, Jun 9, 2026 at 3:02 PM <sashiko-bot@kernel.org> wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>> - [Medium] Accidental deletion of the UMask field for the BR_INST_RETIRED.COND_TAKEN_FWD PMU event, making it an alias of ALL_BRANCHES.
>>> --
>>>
>>> commit 5c9c0d0a9a04ac6fce773f8ccf00f8df75a3f68d
>>> Author: Chun-Tse Shao <ctshao@google.com>
>>>
>>> perf vendor events intel: Update lunarlake events from 1.22 to 1.25
>>>
>>> This commit updates the Lunar Lake PMU events from version 1.22 to 1.25
>>> based on the upstream intel/perfmon repository.
>>>
>>>> diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
>>>> index d66eafccebbb6..a7467b2f291de 100644
>>>> --- a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
>>>> +++ b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
>>>> @@ -190,7 +190,6 @@
>>>>          "EventName": "BR_INST_RETIRED.COND_TAKEN_FWD",
>>>>          "PublicDescription": "Counts taken forward conditional branch instructions retired. Available PDIST counters: 0,1",
>>>>          "SampleAfterValue": "400009",
>>>> -        "UMask": "0x102",
>>> [Severity: Medium]
>>> Was the UMask field intentionally removed here?
>>>
>>> When UMask is missing, it is omitted from the generated event string.
>>> The kernel PMU driver interprets omitted mask bits as zero, which makes
>>> EventCode 0xc4 with UMask 0x00 an exact match for the ALL_BRANCHES event.
>>>
>>> Does this cause BR_INST_RETIRED.COND_TAKEN_FWD to incorrectly count all
>>> branches instead of only forward-taken conditional branches, potentially
>>> corrupting Topdown metrics that rely on this branching ratio?
>>>
>>> (This same UMask removal also appears to happen in the parallel Arrow Lake
>>> update patch within this series).
>> From perfmon: https://github.com/intel/perfmon/commit/5535a3e8cc14ae8ef58013cf3d8e9480018b911a
>> It seems like the umask of `BR_INST_RETIRED.COND_TAKEN_FWD` is changed
>> from 0x02 to 0x00.
>> Can you confirm if that is correct?
> I suppose it's correct, but need double check. Thanks.

Ed confirmed the change is correct. The umask should be 0x00 instead of
0x00. Thanks.


>
>
>> Thanks,
>> CT
>>
>>>>          "Unit": "cpu_core"
>>>>      },
>>> --
>>> Sashiko AI review · https://sashiko.dev/#/patchset/20260609215046.2391903-1-ctshao@google.com?part=4
