Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D0D3655CF
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 09:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305794; cv=none; b=V1OMZBq2rSxt9TjamrWv6Xaf2wD/tHbwDw+utA6eXzvd00RUNplXsHqZBxji5sJ6Ln1T5uDAbLHZmf7HklLfKVT+5zke1mZFFPJPFjchj5PMtDBFUUPkLaLpGMiSH09K/NgoWNdLHKv70LVt2HIukPBieCtWUWLusEvREHg+JB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305794; c=relaxed/simple;
	bh=7ML+xJwDrsTcAMzvsZToRw7e+V7wJtpIh9bpUP0tSjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FR6RCSbKHXOx4nHKLCkwoQBidG/Z+aceHCDlgM8XItC87x9EzvZo9yScWbi/LwKdg9s1xNsmfyExBy0cviHd9N34+I0uCZv4krmj3s5mGohR5f1z1zb97bFaGJx+HzRwahvqCEV+IlrXmngLBmgj1VfueyaeZn9wPPg0HS/Imio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQsWWHyX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQsWWHyX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780305793; x=1811841793;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7ML+xJwDrsTcAMzvsZToRw7e+V7wJtpIh9bpUP0tSjQ=;
  b=FQsWWHyX9AVg5ASZVi5Fsw0M3mNf3YWTJ38sLIt9ZbszwnrPWxnwGoa8
   qp4kMn2wUWkmtfg2vnsnEju7kznu8oL1Y6H1V9PEN6Xb/MJbffuNQwsYM
   et5HKfWSwRP5fvXbcEVdu0hU/Ddd5Ag9XNsuX1xYeSLzTfctI/NVlgQ72
   rgql3WET+cbx6GpcQaYuIrNCbUxWUvil0Ak7Hco6cakc7KBjm5wF82vD/
   az8caZOJhrDMi9zUtt7WWgHZrBlRQaZU3ssV42pV9d7RgszRbYqVYb0XH
   9WfijxIv7XNO6ZNyzXHva6pasKY/hFw4KfmC+YDvADKl4bp5ldu1dJBLH
   A==;
X-CSE-ConnectionGUID: T2ucl/O+QE6L8logLw5ZBg==
X-CSE-MsgGUID: JFT78tJKRoeuA1QQgvYW4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="68594666"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="68594666"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:23:12 -0700
X-CSE-ConnectionGUID: CIlJ8gWqR5+E6yZwnMSREQ==
X-CSE-MsgGUID: rGoOS7bKQgq9l5XaEsvr4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="239340103"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:23:11 -0700
Message-ID: <249c9bdd-68e7-4779-9cca-7fa48739df83@linux.intel.com>
Date: Mon, 1 Jun 2026 17:23:09 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 22/23] perf/x86: Activate back-to-back NMI detection
 for arch-PEBS induced NMIs
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260529075645.580362-23-dapeng1.mi@linux.intel.com>
 <20260529093443.D23531F00898@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260529093443.D23531F00898@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/29/2026 5:34 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Using the `BIT()` macro for shifts >= 32 on 32-bit architectures causes undefined behavior, defeating the back-to-back NMI detection for fixed counters.
> --
>
> commit 67718335973298488df3db65888b9d78109347ad
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Activate back-to-back NMI detection for arch-PEBS induced NMIs
>
> This commit modifies the PEBS handlers to return the count of actually processed
> events. This activates back-to-back NMI detection in the PMI handler, avoiding
> the "suspicious NMI" warning that occurs when multiple back-to-back NMIs are
> triggered by PEBS events.
>
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index 8a653edce392a..e0d3076277026 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
> [ ... ]
>> @@ -3198,6 +3201,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>>  		if ((counts[bit] == 0) && (error[bit] == 0))
>>  			continue;
>>  
>> +		events_bitmap |= BIT(bit);
>>  		event = cpuc->events[bit];
> [Severity: Medium]
> Will this shift cause undefined behavior on 32-bit architectures?
>
> Since bit can be greater than or equal to 32 for fixed counters (where
> INTEL_PMC_IDX_FIXED is 32), using the BIT() macro on 32-bit x86 kernels
> results in a shift by 32 or more bits on an unsigned long, which is undefined
> behavior in C.
>
> In practice, this typically results in a modulo shift that aliases fixed
> counters to general-purpose counters, causing hweight64(events_bitmap) to
> under-report the number of unique events handled. 
>
> This could defeat the back-to-back NMI detection and fail to suppress the
> "suspicious NMI" warning for fixed counters on 32-bit systems.
>
> Should this use BIT_ULL(bit) instead?

Yes, BIT_ULL() is better. Would fix it in next version.


>
