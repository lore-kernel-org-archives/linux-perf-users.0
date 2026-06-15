Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFD41E5714
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 01:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781487697; cv=none; b=eXklnaRgSh7JNZzKHVHh7lMxZbV6z9P2o/82Pgh3KUlCoj5W/WvcOWNVh7UC3gLopvjKWrgtWhG5EHmIWqhNo250zfXpt2lyntA5rIIv2ozJcnfefosFM42XukubbtUUgQ/TLIvQtcZK0ugH5JMGWKa47Y3blEenYYvNOhDkeN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781487697; c=relaxed/simple;
	bh=GmQq77REyG2D1HAwc0Q604VBZniGPXt/8w6M8k7U/1U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iZmxeQkIgYiv8AF7zd5sXGHC0SB/1fxSvPjU38caBLQsyBo+n59rjhHYvPlG95IisBV/YBxq/OFSURjF0+UCkpdn2dUwIUvlNI8xIxILRxQwqUlvXm4pbVes3LOeSRgjZmZAIC9X8tw+KzscrYorXueCLsetMURW3qoQPcOnDX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fvJBGHNU; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fvJBGHNU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781487695; x=1813023695;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=GmQq77REyG2D1HAwc0Q604VBZniGPXt/8w6M8k7U/1U=;
  b=fvJBGHNUuNaNf03BI/Iix7QDthgr8ULcoyZm09PeHtTJ3SUK3QD9OYMz
   q9l+qu1DKloiw+XGt1B3kWQOlY57rhEMeY67vCo/U5wdsc6ShUsWpbJSO
   xC5KYxKfjYcWtZN4I8BnfPyRksyPy6HhiFuUPieo+kRJBmd7rJxjhZhcu
   ay5EZdK88cnfgEMvt5xZVjO3EvNS86Ps4wa7rzoihcOdT7ZnVN1IwvGxh
   jE11VMsVzleDZlpNV631nKv1uAcvsh84FEtggaTlYc3im/i9EYOrH4fAl
   xtlm3zvHKma9r1RLIyeX2Hwa/lW9pDw3xVbEFV7G86jvfed/olPAv4vOf
   Q==;
X-CSE-ConnectionGUID: 9LT8WzjKR12Y7YNb5R7dAQ==
X-CSE-MsgGUID: jXqVDq7dT2+aueZ3/JFS9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="85857468"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="85857468"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 18:41:35 -0700
X-CSE-ConnectionGUID: Zfx8QdNUR5SZhOXlD4FU9A==
X-CSE-MsgGUID: mil6r2EWS9qUUDWeMeqWeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="271413085"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 18:41:33 -0700
Message-ID: <3f97834b-92f0-492b-aac0-06b7edf3c1c7@linux.intel.com>
Date: Mon, 15 Jun 2026 09:41:31 +0800
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
 <ac2849f5-bfe9-4532-b2f7-b9dbc3925c00@linux.intel.com>
Content-Language: en-US
In-Reply-To: <ac2849f5-bfe9-4532-b2f7-b9dbc3925c00@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/15/2026 9:15 AM, Mi, Dapeng wrote:
> On 6/10/2026 5:04 PM, Mi, Dapeng wrote:
>> On 6/10/2026 6:58 AM, Chun-Tse Shao wrote:
>>> + Dapeng and Edward
>>>
>>> On Tue, Jun 9, 2026 at 3:02 PM <sashiko-bot@kernel.org> wrote:
>>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>>> - [Medium] Accidental deletion of the UMask field for the BR_INST_RETIRED.COND_TAKEN_FWD PMU event, making it an alias of ALL_BRANCHES.
>>>> --
>>>>
>>>> commit 5c9c0d0a9a04ac6fce773f8ccf00f8df75a3f68d
>>>> Author: Chun-Tse Shao <ctshao@google.com>
>>>>
>>>> perf vendor events intel: Update lunarlake events from 1.22 to 1.25
>>>>
>>>> This commit updates the Lunar Lake PMU events from version 1.22 to 1.25
>>>> based on the upstream intel/perfmon repository.
>>>>
>>>>> diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
>>>>> index d66eafccebbb6..a7467b2f291de 100644
>>>>> --- a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
>>>>> +++ b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
>>>>> @@ -190,7 +190,6 @@
>>>>>          "EventName": "BR_INST_RETIRED.COND_TAKEN_FWD",
>>>>>          "PublicDescription": "Counts taken forward conditional branch instructions retired. Available PDIST counters: 0,1",
>>>>>          "SampleAfterValue": "400009",
>>>>> -        "UMask": "0x102",
>>>> [Severity: Medium]
>>>> Was the UMask field intentionally removed here?
>>>>
>>>> When UMask is missing, it is omitted from the generated event string.
>>>> The kernel PMU driver interprets omitted mask bits as zero, which makes
>>>> EventCode 0xc4 with UMask 0x00 an exact match for the ALL_BRANCHES event.
>>>>
>>>> Does this cause BR_INST_RETIRED.COND_TAKEN_FWD to incorrectly count all
>>>> branches instead of only forward-taken conditional branches, potentially
>>>> corrupting Topdown metrics that rely on this branching ratio?
>>>>
>>>> (This same UMask removal also appears to happen in the parallel Arrow Lake
>>>> update patch within this series).
>>> From perfmon: https://github.com/intel/perfmon/commit/5535a3e8cc14ae8ef58013cf3d8e9480018b911a
>>> It seems like the umask of `BR_INST_RETIRED.COND_TAKEN_FWD` is changed
>>> from 0x02 to 0x00.
>>> Can you confirm if that is correct?
>> I suppose it's correct, but need double check. Thanks.
> Ed confirmed the change is correct. The umask should be 0x00 instead of
> 0x00. Thanks.

Correct the typo. "instead of 0x02". Thanks.


>
>
>>
>>> Thanks,
>>> CT
>>>
>>>>>          "Unit": "cpu_core"
>>>>>      },
>>>> --
>>>> Sashiko AI review · https://sashiko.dev/#/patchset/20260609215046.2391903-1-ctshao@google.com?part=4
