Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F1A3B5318
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082284; cv=none; b=f5PW4nnNa6a7an9Zmud2YxD7Q7RzOg62EVLGKVxd2FbR7eStzelbo/KxR2Q87eP/cPuAI29Rg3EM22e/I+xpbjHleue6Vb4S9MJ1CtZo6XLnWze/DTGfzBX0Vc8DU7zYHXZzdGYRiVwJCN24RQJdu0MP1T3j1cBSDeoLBE4Lkmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082284; c=relaxed/simple;
	bh=igN/YCunjni4r2ieLz2L4oJPXp5CqAiw5gcg32sXaS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJo+N2xQHvJQf+J1Mn6L64P4M3RCK16Ih54MsSTr09pL1Wd4QCMeUzQOJdXvl0ufCClQc2RYyG+FFspOwVqIGJC168p9MS7O8lyk1GckWxubOYrqhWSx9h7rCbMo7PPT6VzrUTBMStFn9E4vzoOW7il85rlLUsrgLgqFnJSFipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ginHtPN7; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ginHtPN7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781082282; x=1812618282;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=igN/YCunjni4r2ieLz2L4oJPXp5CqAiw5gcg32sXaS4=;
  b=ginHtPN7ex2QgYNikmgSxRf2XWXcCaLS0FHu0L4xEfcuVQJbgrGjh0kV
   YdMQkyx7svnnzrB7B54UdheWZXE4UzNu5zUjZwdPdcVBOzKErorvnhYUx
   gvTvgDcxF/HrU9753A4iYVvmf2JbEH2OP7oqgz2fWx0dxOD+dsnJ2L4O8
   6eRehc0yBLSgEpr8sl+dAipn0RzjCC1BRuQopB3wvyWk4W4/pAhdn2xgT
   edyl+p9Q9ckTaD3SPfwjBNhLCw/fl8GwSs0NVUQE20d77F7kpDJAWfUkJ
   Dwtg0Q0fINoHmL/Xgckx6Ic3tTtei4bK6SDteQyT8yqE+8KpDvDKK0RXD
   w==;
X-CSE-ConnectionGUID: s4w4I8D2Sg+WBcFfDwG7mQ==
X-CSE-MsgGUID: 08ERqaybRKaH/kTjkfJB6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="80886424"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="80886424"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 02:04:41 -0700
X-CSE-ConnectionGUID: xZh62xRpRuKX0gn5ZdA5Yg==
X-CSE-MsgGUID: rzwUMrGqTwCgkC/7/9xf3w==
X-ExtLoop1: 1
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 02:04:39 -0700
Message-ID: <c0a5f131-db2d-4252-8e88-7336718e95ae@linux.intel.com>
Date: Wed, 10 Jun 2026 17:04:37 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] perf vendor events intel: Update lunarlake events
 from 1.22 to 1.25
To: Chun-Tse Shao <ctshao@google.com>, "Baker, Edward"
 <edward.baker@intel.com>
Cc: linux-perf-users@vger.kernel.org
References: <20260609215046.2391903-5-ctshao@google.com>
 <20260609220242.A7B301F00893@smtp.kernel.org>
 <CAJpZYjXoC=Z10_X_=TQw2Q+O-jrQfV+S-bHThAUoXEoenHpT0w@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAJpZYjXoC=Z10_X_=TQw2Q+O-jrQfV+S-bHThAUoXEoenHpT0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/10/2026 6:58 AM, Chun-Tse Shao wrote:
> + Dapeng and Edward
>
> On Tue, Jun 9, 2026 at 3:02 PM <sashiko-bot@kernel.org> wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Medium] Accidental deletion of the UMask field for the BR_INST_RETIRED.COND_TAKEN_FWD PMU event, making it an alias of ALL_BRANCHES.
>> --
>>
>> commit 5c9c0d0a9a04ac6fce773f8ccf00f8df75a3f68d
>> Author: Chun-Tse Shao <ctshao@google.com>
>>
>> perf vendor events intel: Update lunarlake events from 1.22 to 1.25
>>
>> This commit updates the Lunar Lake PMU events from version 1.22 to 1.25
>> based on the upstream intel/perfmon repository.
>>
>>> diff --git a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
>>> index d66eafccebbb6..a7467b2f291de 100644
>>> --- a/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
>>> +++ b/tools/perf/pmu-events/arch/x86/lunarlake/pipeline.json
>>> @@ -190,7 +190,6 @@
>>>          "EventName": "BR_INST_RETIRED.COND_TAKEN_FWD",
>>>          "PublicDescription": "Counts taken forward conditional branch instructions retired. Available PDIST counters: 0,1",
>>>          "SampleAfterValue": "400009",
>>> -        "UMask": "0x102",
>> [Severity: Medium]
>> Was the UMask field intentionally removed here?
>>
>> When UMask is missing, it is omitted from the generated event string.
>> The kernel PMU driver interprets omitted mask bits as zero, which makes
>> EventCode 0xc4 with UMask 0x00 an exact match for the ALL_BRANCHES event.
>>
>> Does this cause BR_INST_RETIRED.COND_TAKEN_FWD to incorrectly count all
>> branches instead of only forward-taken conditional branches, potentially
>> corrupting Topdown metrics that rely on this branching ratio?
>>
>> (This same UMask removal also appears to happen in the parallel Arrow Lake
>> update patch within this series).
> From perfmon: https://github.com/intel/perfmon/commit/5535a3e8cc14ae8ef58013cf3d8e9480018b911a
> It seems like the umask of `BR_INST_RETIRED.COND_TAKEN_FWD` is changed
> from 0x02 to 0x00.
> Can you confirm if that is correct?

I suppose it's correct, but need double check. Thanks.


>
> Thanks,
> CT
>
>>>          "Unit": "cpu_core"
>>>      },
>> --
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260609215046.2391903-1-ctshao@google.com?part=4
