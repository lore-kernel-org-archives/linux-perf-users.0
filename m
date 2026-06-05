Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2963D4128
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 03:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780630985; cv=none; b=P2xAjeeWK9a/78CqtfxA40zhHuv+oWoh3Nyxofghhk8K7suj/Kjl34gTpLF1NrLzI+fAV+uhi6oFXY+ZRonnv3ScHzcIkqlgB7eh55oKgQZEejuQisnkf6HDpGy2M+0tneRuIo6rvMYkS6AJoGDwXK5Xtu7eTeFm5uqA0D1p61w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780630985; c=relaxed/simple;
	bh=OjDcggc+MRX8BCYBkodLwtWzE6eUOjAlCr9aEl5m9Ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgAt17H7loaj0writQl0AQnOQptqNoXGqENnhej+1nyCadVBwvfbTFzn82pPA9Uk+wq+PPrLpzVgZi4mgpRJx6XPgpxRY2ArHK5r67LpDoZzrLpcbo4sGU47sNL3vfuIGxauyW2OxtJbU7nRo9x8J2LM049hGLPFcfEBS68Ag7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GM3mIF/L; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GM3mIF/L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780630982; x=1812166982;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OjDcggc+MRX8BCYBkodLwtWzE6eUOjAlCr9aEl5m9Ac=;
  b=GM3mIF/LWUAXvQ/Eef1Mg3hhJjwcQB6oCWn4AHsKAHmzLKcKbRrbZvsc
   Uuvc3MsMl6/BCpUYwr/MDQhbqG5EsJfzSF/KAF6tbWzu0mw97wSUBsz+S
   loOHqcO87IQKTSoQxTGKUJm18VYdWlhObDQZReteQ9K1kZgrhK72Vj1YS
   Jvd9uk+RncXLJln/H8URXu3WkOIVXpz3o0kYUWyIwWrjJiMlH/hArbUAL
   BGjGmw/B+/cRT+2cP7WEdk75Abl0nauiIv1Ky7wwFBIsPdxqLYkG9AfZL
   I2iLGFJEn5yDIQLGfgjf5rWbfHlZefxBwkwybqHEmRbRQZspOYTGlLarg
   A==;
X-CSE-ConnectionGUID: U1a8+fiCQW25NFIF/KNB2A==
X-CSE-MsgGUID: zkrVuhkTRUWu4UgumR/rvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="106907730"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="106907730"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 20:43:01 -0700
X-CSE-ConnectionGUID: CrRkhbMeRE2qGHMpxDDv+Q==
X-CSE-MsgGUID: PektKz8eTi+zN6fkzp2DLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="241743290"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 20:43:01 -0700
Message-ID: <7540cfd9-153b-49d7-a5f9-26f83f17f7b1@linux.intel.com>
Date: Fri, 5 Jun 2026 11:42:58 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] perf/core: Fix kernel register info leak via hardware
 skid
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260605011136.2043393-9-dapeng1.mi@linux.intel.com>
 <20260605013848.317911F00893@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260605013848.317911F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/5/2026 9:38 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] Valid hardware-captured user-space register samples from precise events (e.g., Intel PEBS) are incorrectly dropped as sensitive kernel data when the PMU interrupt (PMI) skids into kernel mode.
>
> Pre-existing issues:
> - [High] Hardware PMI skid still leaks kernel IPs and callchains to unprivileged users when exclude_kernel=1.
> --
>
> commit 8a7df272a8b8797c3525f28de5158f11f610df4d
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/core: Fix kernel register info leak via hardware skid
>     
> This patch addresses a security vulnerability where hardware skid can
> cause a PMI to trigger in kernel space, leaking kernel register data
> to user space via PERF_SAMPLE_REGS_INTR. It fixes this by dropping
> sampled register data if the event has exclude_kernel set but the CPU
> is in kernel mode.
>     
> Link: https://lore.kernel.org/all/20260529085613.CCAFB1F00893@smtp.kernel.org/
>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 7935d5663944e..b7326bc3acd00 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -7800,10 +7800,21 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
>>  }
>>  
>>  static void perf_sample_regs_intr(struct perf_regs *regs_intr,
>> -				  struct pt_regs *regs)
>> +				  struct pt_regs *regs,
>> +				  bool exclude_kernel)
>>  {
>> -	regs_intr->regs = regs;
>> -	regs_intr->abi  = perf_reg_abi(current);
>> +	/*
>> +	 * Hardware skid can lead to PMI is delivered after
>> +	 * the CPU has already entered kernel mode. In that case,
>> +	 * user-space sampling must not expose kernel register state.
>> +	 */
>> +	if (exclude_kernel && !user_mode(regs)) {
> [Severity: High]
> Will this incorrectly drop valid hardware-captured user-space register
> samples from precise events like Intel PEBS?
>
> For precise events, the PMU driver populates a temporary pt_regs
> with exact user-space registers captured by the hardware. Because PEBS
> does not capture segment registers, the driver copies them from the
> delayed PMI interrupt context:
>
> arch/x86/events/intel/ds.c:setup_pebs_fixed_sample_data() {
>     *regs = *iregs;
>     ...
> }
>
> If the PMI skids and is delivered after the CPU enters kernel space,
> iregs->cs reflects kernel mode, causing user_mode(regs) to evaluate
> to false. This would result in these safe, hardware-captured user
> registers being zeroed out here, which seems like it might break
> unprivileged precise profiling.

Yes, it's true. But since PEBS has no way to sample CS register and the
value of CS register can only come from the data of PMI. It seems no better
way except dropping all these register data from PEBS records. 


>
>> +		regs_intr->abi = PERF_SAMPLE_REGS_ABI_NONE;
>> +		regs_intr->regs = NULL;
>> +	} else {
>> +		regs_intr->regs = regs;
>> +		regs_intr->abi = perf_reg_abi(current);
>> +	}
>>  }
> [ ... ]
>
>> @@ -8694,7 +8705,8 @@ void perf_prepare_sample(struct perf_sample_data *data,
>>  		/* regs dump ABI info */
>>  		int size = sizeof(u64);
>>  
>> -		perf_sample_regs_intr(&data->regs_intr, regs);
>> +		perf_sample_regs_intr(&data->regs_intr, regs,
>> +				      event->attr.exclude_kernel);
> [Severity: High]
> This is a pre-existing issue, but does the hardware PMI skid still leak
> kernel IPs and callchains to unprivileged users when exclude_kernel=1?
>
> While this patch correctly zeroes out the register state to prevent
> leaking the full CPU register context, it appears the same privilege
> boundaries are not applied to PERF_SAMPLE_IP and PERF_SAMPLE_CALLCHAIN.
>
> In perf_prepare_sample(), the kernel IP is unconditionally extracted
> from regs if the PMI skid caught the CPU in kernel mode:
>
> kernel/events/core.c:perf_prepare_sample() {
>     if (filtered_sample_type & PERF_SAMPLE_IP) {
>         data->ip = perf_instruction_pointer(event, regs);
>         ...
>     }
> }
>
> Similarly, unprivileged users can set exclude_kernel=1 and leave
> exclude_callchain_kernel=0. On a skid, !user_mode(regs) evaluates to
> true, causing perf_callchain() to unwind and expose the kernel stack
> trace.
>
> Could this allow a deterministic KASLR bypass, and should it be
> addressed alongside the register clearing?

Hmm, make sense. Need extra changes to prevent these 2 leakages.

Thanks.


>
>>  
>>  		if (data->regs_intr.regs) {
>>  			u64 mask = event->attr.sample_regs_intr;
