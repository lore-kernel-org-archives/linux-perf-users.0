Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55293F9F46
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783326840; cv=none; b=P5Xj9mgZHMq4kcZf5A5sZHgCyZASufpOwzIWqAAKzKECHAlww/9Y4v18deVGJH3caMOWKT6rkRFVTzRx25pM+AS6rdznFdxn2CwCXFBinkEbuaojOFHWJ78JgIOt/WRZ7kbcbwZ0uhJYlMm0X171aOBPdITGST9L58jxZEaEqrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783326840; c=relaxed/simple;
	bh=qQ3liem5vpA5ZuIqtILAsKAqNrnkXCjL8lMe//qOLXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbOa8QoBZFrPnyvo5vmkTEwobt0Kt0kr3xL1ymFdQVAEmtgI4YiayKRWPxO7ExxvCYvYF6JVCqg12WxTkXa8xxpi9r0d9L7OcyvYVF8+uMYM2TucgJKhqEW7RlXxgX/4udJZ4SzeLGDHbPuksqJ4AmK5KIu/Vg5sCogW5DuqJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gsoFFzq4; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gsoFFzq4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783326830; x=1814862830;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qQ3liem5vpA5ZuIqtILAsKAqNrnkXCjL8lMe//qOLXw=;
  b=gsoFFzq4vYW066RfL7RdsKIr3EhnHzBkNHmXfxaYe7fbSMYwaSMrWwc5
   LYmatgkgTraTJMlHLrXaCjXq7jzDJPkf5a1CYnGOWFmSbPBv3y/atxpbz
   WHK1td2hppGrOeHzlQU+qK0JEesLPfROHQhxyFqoLPYC6ZYdEsWAQGCAu
   mvTkF2b4yQBxMCCuSa3Zr7acVumIH8c5FQ0aPbDwAeEcQ/pgzlt4/BaR0
   24A3oYFumBxCu9ZSMOqixGDYY217SLirzMpMuabGs52J6oX+ARivivuGf
   s5a3B7BTGhZgl9ImarJUdfs+mIg2wxoveE6RQxVg7vioAuGVFAKwxWeUD
   g==;
X-CSE-ConnectionGUID: LSe6XT+rS3+TTZtwUYsRKQ==
X-CSE-MsgGUID: MiKmahJMRni01/BdWNEeVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83934178"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83934178"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 01:33:45 -0700
X-CSE-ConnectionGUID: ZlU4xJcdTdyJM5q4iNTzAg==
X-CSE-MsgGUID: AHhAbgMjT0C+p/miva6WoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="255594779"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 01:33:44 -0700
Message-ID: <afa403c1-2594-49ec-ad12-f1dd1409e29e@linux.intel.com>
Date: Mon, 6 Jul 2026 16:33:41 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 02/24] perf/x86: Move hybrid PMU initialization before
 x86_pmu_starting_cpu()
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-3-dapeng1.mi@linux.intel.com>
 <20260706021852.DE2ED1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260706021852.DE2ED1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/6/2026 10:18 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Preexisting out-of-bounds read in `check_hw_exists()` on hybrid platforms due to an invalid `container_of()` cast on the global static `pmu` struct via the `hybrid()` macro.
> --
>
> commit 8216e613cee4854e16daaa11279146d17bc7f313
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Move hybrid PMU initialization before x86_pmu_starting_cpu()
>
> The current approach initializes hybrid PMU structures immediately before
> registering them. This is risky as it can lead to key fields being
> inadvertently overwritten. This patch mitigates this by moving the
> default hybrid structure initialization before calling
> x86_pmu_starting_cpu().
>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 872d07a5fa80d..0888d3b0923e1 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -2195,8 +2195,20 @@ static int __init init_hw_perf_events(void)
>>  
>>  	pmu.attr_update = x86_pmu.attr_update;
>>  
>> -	if (!is_hybrid())
>> +	if (!is_hybrid()) {
>>  		x86_pmu_show_pmu_cap(NULL);
>> +	} else {
>> +		int i;
>> +
>> +		/*
>> +		 * Init default ops.
>> +		 * Must be called before registering x86_pmu_starting_cpu(),
>> +		 * otherwise some key PMU fields, e.g., capabilities
>> +		 * initialized in x86_pmu_starting_cpu(), would be overwritten.
>> +		 */
>> +		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++)
>> +			x86_pmu.hybrid_pmu[i].pmu = pmu;
>> +	}
> [Severity: High]
> This is a pre-existing issue, but does passing the global pmu struct to
> check_hw_exists() earlier in this function cause an out-of-bounds read on
> hybrid platforms?
>
> In init_hw_perf_events(), check_hw_exists(&pmu, ...) is called after
> perf_is_hybrid is enabled. Inside check_hw_exists(), it iterates over
> fixed counters and calls fixed_counter_disabled():
>
> arch/x86/events/perf_event.h:fixed_counter_disabled() {
>     ...
>     u64 intel_ctrl = hybrid(pmu, intel_ctrl);
>     ...
> }
>
> The hybrid() macro expands to a container_of() cast:
>
>     container_of(_pmu, struct x86_hybrid_pmu, pmu)->_field
>
> Because the pmu passed in is the standalone global struct pmu (not embedded
> within a struct x86_hybrid_pmu), this cast yields an invalid pointer.
>
> Could this read garbage data past the end of the global pmu struct when
> accessing intel_ctrl, potentially causing the BIOS hardware check to act on
> garbage data or trigger a kernel panic if it crosses an unmapped page
> boundary?

Yes, a real issue. It looks unnecessary to run fixed_counter_disabled()
check since intel_ctrl always comes from the the bitwised-or between
cntr_mask64 and fixed_cntr_mask64. Would drop fixed_counter_disabled() and
all calling in a separate patch.

Thanks.


>
