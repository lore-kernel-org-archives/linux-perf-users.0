Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7709B28468B;
	Thu, 24 Apr 2025 17:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745514501; cv=none; b=YBFx8pOr629e01o2XSIWxzw2qSo9/bVFnjPZP/XjbbTQ/RZn9+oWwHvUSO4w906wGvDAJBmXjYS/+xJ0LRM4IEuIv7pVT70Wi7DPh+jWJBDv2yJY3qqj8aNdVCp0HDMvqT7mulkh2lIuGI+i8h2T+0Q0R7ztnAx5Im4xOplnJsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745514501; c=relaxed/simple;
	bh=Aua7mFb35cAODT1KQWumEW/D3FGry1i9W+uCgHVB7mQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I8gwm/cP4mhYC22AhkrOwPmWqDvnE9c/48j7mLHnrRxQecP3GNi/terS8AV7NRUVRtMCfYXxKS6dS6plHM2F74qF8DiFcoINY8VvKu6BOJ+ypbnqC5K5c7nrvngyMaFsI866KTt78tdlAPeYjUbTObaqZZY84Qzhbb0c+myxLIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eWChJjfz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eWChJjfz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745514500; x=1777050500;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Aua7mFb35cAODT1KQWumEW/D3FGry1i9W+uCgHVB7mQ=;
  b=eWChJjfzkntx5aNhGIHRHQ5SpxmQlCH3pL98eccpbhLvXUsLw88nnnxd
   To8nVzj7+9jK1ulUAtcRqFtB62m3feKtgPgulAMF5P6t/TkNHc2e7/mYF
   qFxcY/vE7mTGuseKr1Wb1dTVlZmK7/qb1h9mfaVgfnbqZip0T5lO9u40l
   pLFgcZ0hnaqEjQ5nNp6BuiiY2bcE6LuN2CrhY+YAW75r/m8TWNaK33eXA
   LIS27EwI6POWJmcfIE/U9K7z0Chw2YzKePtFUVxZbMFnsgfORpc3jUNe4
   vqgQzvzRpqkARsp3XjOaJYZlrv0qh8I8sp8XaQJI00ooIHYlYZz4y5L5K
   w==;
X-CSE-ConnectionGUID: z1vrj4EXRm2S6I/yQ0hHLA==
X-CSE-MsgGUID: BB+lDNSlTTefjqicGbnEdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="57809582"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="57809582"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 10:08:17 -0700
X-CSE-ConnectionGUID: 0hUj5O7+TaCht2uSvGMjKA==
X-CSE-MsgGUID: 64deZ4BxSfGtUVeufLULTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="133199286"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 10:08:18 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id E0DC420B5736;
	Thu, 24 Apr 2025 10:08:13 -0700 (PDT)
Message-ID: <e85c1a65-fa55-457f-82d9-c25f6a4deb49@linux.intel.com>
Date: Thu, 24 Apr 2025 13:08:12 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86: Fix open counting event error
To: Ingo Molnar <mingo@kernel.org>, Luo Gengkun <luogengkun@huaweicloud.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ravi.bangoria@amd.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250423064724.3716211-1-luogengkun@huaweicloud.com>
 <aApkwfEUCJcc9PXn@gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <aApkwfEUCJcc9PXn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-04-24 12:20 p.m., Ingo Molnar wrote:
> 
> * Luo Gengkun <luogengkun@huaweicloud.com> wrote:
> 
>> Perf doesn't work at perf stat for hardware events:
>>
>>  $perf stat -- sleep 1
>>  Performance counter stats for 'sleep 1':
>>              16.44 msec task-clock                       #    0.016 CPUs utilized
>>                  2      context-switches                 #  121.691 /sec
>>                  0      cpu-migrations                   #    0.000 /sec
>>                 54      page-faults                      #    3.286 K/sec
>>    <not supported>	cycles
>>    <not supported>	instructions
>>    <not supported>	branches
>>    <not supported>	branch-misses
>>
>> The reason is that the check in x86_pmu_hw_config for sampling event is
>> unexpectedly applied to the counting event.
>>
>> Fixes: 88ec7eedbbd2 ("perf/x86: Fix low freqency setting issue")
>> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
>> ---
>>  arch/x86/events/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 6866cc5acb0b..3a4f031d2f44 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -629,7 +629,7 @@ int x86_pmu_hw_config(struct perf_event *event)
>>  	if (event->attr.type == event->pmu->type)
>>  		event->hw.config |= x86_pmu_get_event_config(event);
>>  
>> -	if (!event->attr.freq && x86_pmu.limit_period) {
>> +	if (is_sampling_event(event) && !event->attr.freq && x86_pmu.limit_period) {
> 
> Hm, so how come it works here, on an affected x86 system:
> 
> $ perf stat -- sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>               0.64 msec task-clock:u                     #    0.001 CPUs utilized             
>                  0      context-switches:u               #    0.000 /sec                      
>                  0      cpu-migrations:u                 #    0.000 /sec                      
>                 73      page-faults:u                    #  114.063 K/sec                     
>            325,849      instructions:u                   #    0.56  insn per cycle            
>                                                   #    0.88  stalled cycles per insn   
>            580,323      cycles:u                         #    0.907 GHz                       
>            286,348      stalled-cycles-frontend:u        #   49.34% frontend cycles idle      
>             72,623      branches:u                       #  113.474 M/sec                     
>              4,713      branch-misses:u                  #    6.49% of all branches           
> 
> 
> ?

It doesn't affect all X86 platforms. It should only impact the platforms
with limit_period used for the non-pebs events. For Intel platforms, it
should only impact some older platforms, e.g., HSW, BDW and NHM.

For other platforms, the x86_pmu.limit_period is invoked. But the left
is not updated. So it still equals to event->attr.sample_period.
It doesn't error out.

	if (!event->attr.freq && x86_pmu.limit_period) {
		s64 left = event->attr.sample_period;
		x86_pmu.limit_period(event, &left);
		if (left > event->attr.sample_period)
			return -EINVAL;
	}

Thanks,
Kan

