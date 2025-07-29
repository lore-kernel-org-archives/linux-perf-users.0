Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610672673B9;
	Tue, 29 Jul 2025 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781020; cv=none; b=Whb8GvNZv5yNVWIShDi3Qjykv5zILXfL6HE1yQTWuEEyXhZ0mFMylgXZm8ahIjobocepkumLpLwWaRqTI/rqwtSnskAOfMb079hhnfqJCLYYFghL+UMTnCeSrAs7CVLp2OWP/pe9aCK2Z5da/Ezr3rKXpq80H/Zcb1IdltLl4xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781020; c=relaxed/simple;
	bh=kBrxVm2sOKsediQJYDDB5wk7S0hagRKEn+9PQekDd+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgN/wxU5zGC9Aee+t9qz7PrmOSDMIzy3vQEhvVP0UpYvlLpAYrz703SsorNHEEXnI+yshZwmn9DUIUcxHXybNbB6PVHIrBibB7SneCw8i6AHvzYJ/RGaOhLZecufWniuPJmLfol5QdOOFSe3oRn4Ptac5ZE1rXJknHEfdxzFea8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9xyRZeU; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9xyRZeU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753781018; x=1785317018;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kBrxVm2sOKsediQJYDDB5wk7S0hagRKEn+9PQekDd+U=;
  b=h9xyRZeUnXzo0YgIT8tuOUHPdAsrpEigq+QHi2QnkG+xRvIGzo0fGEba
   D4WFcY/KvZKm3cQNrSfoCXMTZNY5UPvO850LoJdmdF4wwBud6h5Xn4mCK
   X9rkneK0MSJoRWi7ld3elOg8nwdI2jEaasVBw5CzaPlNyHG9z3n+2TwxN
   wiDPkUYdCBjxdrL4TRkY4YHKnx6mwA4k+Kq0FSQGbB/rabRZKpODPXRTT
   v2LOpNHPdamklyNvOENaGtbKotcQU6wC2bwYaWuEXkbrUtqq7cSm+QEPE
   1tJU7GtboQap+efy/lEjbNRS75AGCQoO9GMf3WEZp2/2xVu1PCXKGqGzV
   Q==;
X-CSE-ConnectionGUID: PkY9Js+qQU+qKPZDCfH11w==
X-CSE-MsgGUID: 2DLso0lVTWqL3q0iVeXI7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="43649354"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="43649354"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 02:23:38 -0700
X-CSE-ConnectionGUID: +kMwkbTOR/+vSDJ2f816ZA==
X-CSE-MsgGUID: GxINhn5dQRO5letcuTCI2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="167954486"
Received: from zhengwen-mobl3.ccr.corp.intel.com (HELO [10.124.240.106]) ([10.124.240.106])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 02:23:34 -0700
Message-ID: <db7043a4-f815-4178-8d81-2da1dda6236e@linux.intel.com>
Date: Tue, 29 Jul 2025 17:23:32 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [perf] fuzzer triggers "BUG: kernel NULL pointer dereference"
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <5baea1f7-6edd-d6fa-27ce-04eddb7e5199@maine.edu>
 <fdcdd5a7-76b5-6c52-63dc-95fadddf7772@maine.edu>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <fdcdd5a7-76b5-6c52-63dc-95fadddf7772@maine.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Vince,

Could you please provide more information about this issue?  Like HW
information, how long can the issue be produced and whether the issue can
be seen in latest kernel (6.16)? Thanks.

--

Dapeng Mi

On 7/22/2025 5:17 AM, Vince Weaver wrote:
> I'm still tracking this fuzzer issue.  The fuzzer can reliably trigger the 
> crash but only 32000 syscalls deep into a run and I am having a lot of 
> trouble trying to gather a trace/testcase that can generate it.
>
> I was hoping the recent
> 	[PATCH] perf/x86: Check if cpuc->events[*] pointer exists before accessing it
> patch might fix things as the symptoms were vaguely similar but that 
> particular patch does not fix the problem.
>
> Vince
>
> On Tue, 8 Jul 2025, Vince Weaver wrote:
>
>> Hello
>>
>> the perf_fuzzer can reliably trigger this on a 6.16-rc2 kernel.  It 
>> doesn't look obviously perf related but since the perf_fuzzer triggered it 
>> I thought I'd report it as a perf issue first.  I can work on a smaller 
>> test case but that might take a bit especially as the machine locks up 
>> super hard and requires being unplugged after it's triggered.
>>
>> let me know if there's any other info I can provide.  The dump below is 
>> transcribed from a screenshot as I still haven't figured out a way to get 
>> a serial console on this Raptorlake system.
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000008
>> #PF: supervisor read access in kernel mode
>> #PF: error_code(0x0000) - not-present page
>> PGD 0 P4D 0
>> Oops: Oops: 0000 [#1] SMP NOPTI
>> CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Not tainted 6.16.0-rc2+ #8 PREEMPT (voluntary)
>> Hardware name: Dell Inc. Precision 3660/0VJ7G2
>> RIP: 0010:rb_insert_color+0x18/0x130
>> Code: 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 8b 07
>> RSP: 0018:ffffb5e5c01e3df8 EFLAGS: 00010046
>> RAX: ffff93f1927f8168 .....
>> ...
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 000000000000008 CR3: 00000000596824001 CR4: 000000000000f72ef0
>> DR0: 00000000a000001 ....
>> PKRU: 55555554
>> Call Trace:
>>  <TASK>
>>  timerqueue_add+0x66/0xb0
>>  hrtimer_start_range_ns+0x102/0x420
>>  ? next_zone+0x42/0x70
>>  tick_nohz_stop_tick+0xce/0x230
>>  tick_nohz_idle_stop_tick+0x70/0xd0
>>  do_idle+0x1d3/240
>>  cpu_startup_entry+0x29/0x30
>>  start_secondary+0x119/0x140
>>  common_startup_64+0x13e/0x141
>>  </TASK>
>>
>>
>>
