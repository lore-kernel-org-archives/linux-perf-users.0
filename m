Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4154F272E54;
	Thu,  5 Jun 2025 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131489; cv=none; b=Mpl2uOiTuJbO2Zsjg7o26C/zoVyvpnF086teEg2NRciQbQzuV6jHu2k48JovAaD4KFGlnXHx64tenpWBowH0cnXgoCOeJ28Zq6MVMjZKwgoCnTZCwe/1bWTpmcq0LcSFm+0DQkUOb9DOVfW5mtzyGyi1oBpqIrFRKKevXJ62VOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131489; c=relaxed/simple;
	bh=yAV1qmK+GD0TtFCwzR+lZZRLe8ffoaN7xhVT0oGq4Og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dW4VUKYBiBgqMus/nQ9j2EDmCSJrSVTI1UzPV6mkMp7E3uqaL8kP8w4Gj7I4RXX6XlsXYv5EKbO9fw3VUPOcpX86W46FrNEO6LcNQQHrQ0uYMNxGMIWeCkthJh53uotLZgzKNbcLfbKdCc3dQNVsTN8LvAUtTPxPzYn/C10SD84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CxIuH5PN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CxIuH5PN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749131488; x=1780667488;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yAV1qmK+GD0TtFCwzR+lZZRLe8ffoaN7xhVT0oGq4Og=;
  b=CxIuH5PNgYHb9x48bRO35oenvhCIKm3iwgfLWTvlwqiFNmEPCMyTs0f0
   tafhaYywKxDGS6/+rc8GviEFuE/xgKDje5Srg6wSsm20u4W9BMs9fCpBs
   ga256pJkbn3PfPRjLnt2j+H+Ht8GbqEH9gpth5pphDcjbZ0cpTvtRgxVs
   UW8xNTssm6xT4k+IkQ1bYbcF+EBIIyNunF45NU2sdn/TvQdM1G+R7+3uE
   1IiHXcn4hg2HZWP/6Fr5pH7IFBGc86AwENmmOzRUOXktAUdf5lBmRqq0L
   v8z92Dcx2litjoGWP7JNQVvBBX37VeECICRmp60Pf2eCDfgQvvwY4grja
   Q==;
X-CSE-ConnectionGUID: /XE7QyUqSsinz2eFqzaHdQ==
X-CSE-MsgGUID: edBYGxpuSy21tWdcFWBJog==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="62607354"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="62607354"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 06:51:28 -0700
X-CSE-ConnectionGUID: RGgWUE6UTwuS67os1UEwPA==
X-CSE-MsgGUID: KygK6xT1S9CXI8J+gpPULA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="146474689"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 06:51:27 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4936120B5736;
	Thu,  5 Jun 2025 06:51:25 -0700 (PDT)
Message-ID: <1f97aa2e-c488-4800-ac7b-e7351f2a30ea@linux.intel.com>
Date: Thu, 5 Jun 2025 09:51:24 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] perf: Fix the throttle error of some clock events
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 irogers@google.com, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, eranian@google.com, ctshao@google.com,
 tmricht@linux.ibm.com, Leo Yan <leo.yan@arm.com>,
 Aishwarya TCV <aishwarya.tcv@arm.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>
References: <20250604171554.3909897-1-kan.liang@linux.intel.com>
 <aEE7ug56bPS_ZJUQ@gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <aEE7ug56bPS_ZJUQ@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-06-05 2:39 a.m., Ingo Molnar wrote:
> 
> * kan.liang@linux.intel.com <kan.liang@linux.intel.com> wrote:
> 
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Both ARM and IBM CI reports RCU stall, which can be reproduced by the
>> below perf command.
>>   perf record -a -e cpu-clock -- sleep 2
>>
>> The issue is introduced by the generic throttle patch set, which
>> unconditionally invoke the event_stop() when throttle is triggered.
>>
>> The cpu-clock and task-clock are two special SW events, which rely on
>> the hrtimer. The throttle is invoked in the hrtimer handler. The
>> event_stop()->hrtimer_cancel() waits for the handler to finish, which is
>> a deadlock. Instead of invoking the stop(), the HRTIMER_NORESTART should
>> be used to stop the timer.
>>
>> There may be two ways to fix it.
>> - Introduce a PMU flag to track the case. Avoid the event_stop in
>>   perf_event_throttle() if the flag is detected.
>>   It has been implemented in the
>>   https://lore.kernel.org/lkml/20250528175832.2999139-1-kan.liang@linux.intel.com/
>>   The new flag was thought to be an overkill for the issue.
>> - Add a check in the event_stop. Return immediately if the throttle is
>>   invoked in the hrtimer handler. Rely on the existing HRTIMER_NORESTART
>>   method to stop the timer.
>>
>> The latter is implemented here.
>>
>> Move event->hw.interrupts = MAX_INTERRUPTS before the stop(). It makes
>> the order the same as perf_event_unthrottle(). Except the patch, no one
>> checks the hw.interrupts in the stop(). There is no impact from the
>> order change.
>>
>> Reported-by: Leo Yan <leo.yan@arm.com>
>> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
>> Closes: https://lore.kernel.org/lkml/20250527161656.GJ2566836@e132581.arm.com/
>> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Closes: https://lore.kernel.org/lkml/djxlh5fx326gcenwrr52ry3pk4wxmugu4jccdjysza7tlc5fef@ktp4rffawgcw/
>> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>> Closes: https://lore.kernel.org/lkml/8e8f51d8-af64-4d9e-934b-c0ee9f131293@linux.ibm.com/
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Any idea which commit introduced this bug?
> 
> Was it:
> 
>   9734e25fbf5a perf: Fix the throttle logic for a group
>  

Yes.
Since it is still in the tip.git, I'm not sure if the commit ID is valid
for the Fixes tag. so I didn't mention the commit ID in the log.

Thanks,
Kan

> plus the followup driver updates?
> > Thanks,
> 
> 	Ingo

