Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147BF388371
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998304; cv=none; b=m5Z8B+/dDSnXmJtjLYMG6Mw2SilaJ/Ke1Sh95pikUAYw9x+rO899YGhje2uPp/lJwtbFyEycWMvagWIymCvYc/kLpxG/UymBO7aVLFngP4LyyEfs3zurbqrAQ8LhFF+Sw9JQWFGiJCiGByYlH08a4ANElSz5HrX51MDI7Fcpv1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998304; c=relaxed/simple;
	bh=2e/98ak0HzhbJaWL2iU3ZiIi1r8v4w0EtBGb52kVwrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=de/dy76DyZkWuDvhKM854svCO9utM+MrsI6YuVWdD/+HD8El/dsKV1PduNx/nvLPwnMT3AOTvLjzQOHVY92srrmyc7vNgVWVITMwG/az/mGFl6WRxfCfVRDBweQKGHCf0Z6Adn1u4YcVUvwXSyzDqq8w01dAf46YvRiSR1gCxxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HHXr5Ysy; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHXr5Ysy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780998303; x=1812534303;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2e/98ak0HzhbJaWL2iU3ZiIi1r8v4w0EtBGb52kVwrU=;
  b=HHXr5YsymAIisN9H/UEubjACiuK+arMMLV4Go9XmMfKPwxwSpMiKA7X6
   yxJBFggW9NbsbQdrvsoAIRUZOfyO4CWUyL9fky2PGa77D5fm7PGWYb/4M
   jIimtCL0EKPtySvqKlVdDKubi1S8k/LkfjHiQOWM7GK1R++P+wQ+j+2ns
   lXIvpbSLVJ5/ipkiM8eUcjmIR0oRQMP0s77HQj/aSVCKMH32eYmQYiO0p
   +5wbGg2eGr1fxzDolXax+1lbk0Qy0QVkJJSvjxM0ps3+7pfq8gk6Aj9bF
   TL9QMINBXzlrZ4S6VEi1ZKW5hBWOpAfBmCV73eDDCSyLRStjfAXFbEdT3
   g==;
X-CSE-ConnectionGUID: EWEidoGITQiEWJ0MC7WCjQ==
X-CSE-MsgGUID: R6hNzihjQ4+2klscg4praQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81865015"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81865015"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 02:45:03 -0700
X-CSE-ConnectionGUID: UPjpJR/mT32PO94+Hk2vLQ==
X-CSE-MsgGUID: xqKnMDo3S16AMbZRsQtrTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="241647985"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 02:45:02 -0700
Message-ID: <786b589e-f31f-4617-8394-dccf0bb11121@linux.intel.com>
Date: Tue, 9 Jun 2026 17:44:59 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 6/9] perf/x86/intel: Validate return value of
 intel_pmu_init_hybrid()
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260609050222.2458129-7-dapeng1.mi@linux.intel.com>
 <20260609052508.455E11F00893@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260609052508.455E11F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/9/2026 1:25 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Unnecessary error handling logic for memory allocation failure in early boot (__init) function
> --
>
> commit 3dd0c7770a2df131c0ee92d24ad34bc579754b8e
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Validate return value of intel_pmu_init_hybrid()
>
> This commit adds checks for the return value of intel_pmu_init_hybrid()
> to prevent accessing the uninitialized x86_pmu.hybrid_pmu[] array on
> allocation failure. It also introduces an error path to free the created
> task_ctx_cache kmem cache if this failure occurs.
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 532a089e16762..57b1a4bd3facf 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
> [ ... ]
>
>> @@ -8540,7 +8541,9 @@ __init int intel_pmu_init(void)
>>  		 *
>>  		 * Initialize the common PerfMon capabilities here.
>>  		 */
>> -		intel_pmu_init_hybrid(hybrid_big_small);
>> +		ret = intel_pmu_init_hybrid(hybrid_big_small);
>> +		if (ret < 0)
>> +			goto err;
> [ ... ]
>
>> @@ -8886,6 +8901,10 @@ __init int intel_pmu_init(void)
>>  	intel_aux_output_init();
>>  
>>  	return 0;
>> +
>> +err:
>> +	kmem_cache_destroy(x86_get_pmu(smp_processor_id())->task_ctx_cache);
>> +	return ret;
>>  }
> [Severity: Low]
> Is this cleanup logic necessary for an __init function? 
>
> Memory allocation failures during early boot generally mean the system cannot
> boot anyway. Functions executed only at this stage typically do not need to
> handle memory allocation failures gracefully, making this kind of error
> handling and cleanup logic effectively dead code.

IMO, even it's in early boot, it's better not to trigger an invalid memory
access error which could cause misleading. 
Thanks.


>
