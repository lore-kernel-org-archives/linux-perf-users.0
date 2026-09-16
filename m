Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FAA4DAFAC
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 21:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593328; cv=none; b=L7p6ceGvGQvcIAeT8+fer1wkyH5O4B1kL3NvpS77+I4qut40TEBas7VFX9nTQ2XWSOL73e2rhLvIeTTwK+Yr6O1wSD1eCTSyk/6wEGbM7j2/uOCaVLCJm6XN5EMCpAsmkpQEc7mmVQPKXBvABUevgbKPRtfRoKFm9f1uO7076Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593328; c=relaxed/simple;
	bh=ZveIGnDwjvuPPZmz6qrmGim1y8f4JTpGuoUhjmB387U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSjJcIqiz3mZAlSkYeO8blrhU8V05hoeQExL1dy9i2GWTgLm8eeMErTD7PeyMUZfI6G5DY46G/x4BboxINTyvHcTBgamUNu50IQYh7AkYJv1WxUECm2DOT/EMyEDyWaFOJkdFCK6IgxscG4F56GqQKeybsf4KNzaQg2FDo9UypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LWDDONFA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LWDDONFA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789593316; x=1821129316;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZveIGnDwjvuPPZmz6qrmGim1y8f4JTpGuoUhjmB387U=;
  b=LWDDONFA7JYP+zl9QSvyPAMFGdh7sMJ/zDffQcxFpXN3T0eRkfEB18yi
   Dm4wsFqpKhfNdSWt3Vj+y7tdWX9nt6itlaxOuF7u2aSw1V/SxteRQyyrN
   +AM4twcmyhsnNPCVAcRU/cyokze9ntW/USeto1VEY2d79Tgq0cYvCyXH0
   dm5ZFsQBZKYcDnm1lXHgjU9ustavVBLkS+C2ispgHKFHzCU7XtK3c/Fk2
   o/AWjIwRHv1hnVYcofOi95DXUt3aup6PawcKxP/md6MdK13DwoxlE6AVS
   IWU3ZQBpOeZkIJnPj2B3nHiRc+uuKaIJlgsrot7+8/RTU6zNSAPGSmDXP
   w==;
X-CSE-ConnectionGUID: sbPvERhTQ2Gm1RJGFgYfsA==
X-CSE-MsgGUID: xtoVyiXKStKc6vom7ATV4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89916913"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89916913"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 14:15:12 -0700
X-CSE-ConnectionGUID: VasEWHiSSVmPk+kd3fSvEw==
X-CSE-MsgGUID: kYTxUuEMTJ2HfxYg+BcB4g==
X-ExtLoop1: 1
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 14:15:11 -0700
Message-ID: <9e86d9e4-7aee-4c1b-8812-94aecb2a2cea@intel.com>
Date: Wed, 16 Sep 2026 16:15:10 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf topdown: Don't require config1==0 for a slots event
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260916202740.257376-1-zide.chen@intel.com>
 <20260916204416.80E761F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260916204416.80E761F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/16/2026 3:44 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] perf: missing explicit <stdio.h> and <string.h> inclusions
> --
> 
> commit 197eea3115a0d065dc53e6f96ad2fd38fdb9bc99
> Author: Zide Chen <zide.chen@intel.com>
> 
> perf topdown: Don't require config1==0 for a slots event
> 
> This commit modifies the topdown slots architecture check to no longer require
> config1 == 0, fixing an issue where explicit slots events were duplicated in
> scheduling. It also adds a new test to verify that an explicit metrics_clear
> slots event doesn't trigger extra injections.
> 
>> diff --git a/tools/perf/arch/x86/tests/topdown.c b/tools/perf/arch/x86/tests/topdown.c
>> index 2b6f47ce49324..b1ce9f83db00e 100644
>> --- a/tools/perf/arch/x86/tests/topdown.c
>> +++ b/tools/perf/arch/x86/tests/topdown.c
> [ ... ]
>> @@ -229,10 +229,38 @@ static int test__x86_topdown_slots_injection(struct test_suite *test __maybe_unu
>>  	return TEST_OK;
>>  }
>>  
>> +/*
>> + * An explicit "slots,metrics_clear=1" event is still the slots event and
>> + * must not cause an extra slots event to be injected into the group.
>> + */
>> +static int test__x86_topdown_metrics_clear(struct test_suite *test __maybe_unused,
>> +					   int subtest __maybe_unused)
>> +{
>> +	struct perf_pmu *pmu;
>> +	char event_str[128];
>> +	int ret;
>> +
>> +	if (!topdown_sys_has_perf_metrics())
>> +		return TEST_OK;
>> +
>> +	pmu = perf_pmus__find_by_type(PERF_TYPE_RAW);
>> +	if (!pmu || !perf_pmu__has_format(pmu, "metrics_clear"))
>> +		return TEST_OK;
>> +
>> +	snprintf(event_str, sizeof(event_str),
>> +		 "{%s/slots,metrics_clear=1/,%s/topdown-retiring/}",
>> +		 pmu->name, pmu->name);
> 
> [Severity: Low]
> Does this new function test__x86_topdown_metrics_clear() need explicit header
> inclusions for musl compatibility?
> 
> This code relies on an implicit declaration of <stdio.h> for snprintf().
> Missing POSIX headers can cause build failures when compiling the perf tool
> with strict libc implementations like musl instead of glibc.
> 
> Should <stdio.h> (and potentially <string.h>) be explicitly included at the top
> of this file to prevent musl compilation failures?

Not needed. tools/perf/util/pmu.h, along with debug.h (which is also
included), explicitly pulls in <stdio.h>.

Additionally, this file already contains other calls to snprintf(). If
the required header dependency were missing, those existing uses would
already fail to build.
