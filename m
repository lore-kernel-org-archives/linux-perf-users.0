Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2E92A1BF
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 01:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781485438; cv=none; b=jZCgwJC4LansZ8/1WjzzxTxfxYcyjV59ujnHA9MnYm6rVAQ7i4SOc9x7aRE6HHeN4/c6lq5ymM/ZwdXVBZiBi5Rf03lZV1BsFmWmL/KA+ix7A8bkVGDhAJ/6cYkw1Tmt9HUCQiNV8lZl2XSg6tYPSv2yV+xkGjnbe+KkwSuWQ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781485438; c=relaxed/simple;
	bh=DR/L8HHzsjDZoYbL5JLkFdjYRiubFEyUj9I42NWcfu4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=klHELLDyC46yhLvUpnLsHyfoNHdOt+3xm3Fuj0PNMUYQl8dMl5LuM2TzbBd11dJLTXnIMUjlDHXmMgwiIZlCYyaeWGBvCaoK+ZsrkjHCZzvOiCkk4akijL7MDLLcs/Ej76v9+FPpr4rgC9uofUegwhkFb0cAaAIx5z4EKX/xI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AxURwcQ1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AxURwcQ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781485437; x=1813021437;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=DR/L8HHzsjDZoYbL5JLkFdjYRiubFEyUj9I42NWcfu4=;
  b=AxURwcQ1V2UflNPRwQlhSEbyEKdL9KhsEm+UIv7A6kKj8A4IW4QMAKne
   BMT811NVGqjhkHFQLlTDhBgOP24IdNa5OCZh0djM8jeYBsvp6kMlBrO7R
   IQTxpmg9s4LH2u8VwH/Iw35QovyOSzwSTxPaOqVUBR4JZSnXNJz1N/0ZW
   lNgmkTPt6DkMhZ6nq9e1O5SEFNGqEK/MW7Gywc8PEwKABE2D/u4PbXBZp
   CCcLbBs8gy6VLTd+lbxda+VOTGuBXHfDCbPRgvFy/8B2cHuaMXyLw5phH
   waSHvBghbiAZbN4tC1Cmy2XIykPscMKCAs5eipV90LiBpdML1oh2F5a0y
   Q==;
X-CSE-ConnectionGUID: xc2oayaNQRyJW2rxVTXfhA==
X-CSE-MsgGUID: 5fMJ0IbjTTKjpUykKQ7+0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="82205442"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="82205442"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 18:03:57 -0700
X-CSE-ConnectionGUID: jFvVISBCTd2kXG/p1Bsonw==
X-CSE-MsgGUID: Ft8ColuRQE+Vfr8ccQdFVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="247361191"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 18:03:56 -0700
Message-ID: <15ba38bf-b264-4fc8-8d78-92aeb2d5cce6@linux.intel.com>
Date: Mon, 15 Jun 2026 09:03:52 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 3/8] perf/x86/intel: Fallback to sw branch type
 decoding if no hw decoding
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260612090114.3188886-4-dapeng1.mi@linux.intel.com>
 <20260612092141.8AE911F000E9@smtp.kernel.org>
 <af0e50c4-8ea3-4f10-a2c0-5e3a0427107a@linux.intel.com>
Content-Language: en-US
In-Reply-To: <af0e50c4-8ea3-4f10-a2c0-5e3a0427107a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/15/2026 9:00 AM, Mi, Dapeng wrote:
> On 6/12/2026 5:21 PM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [High] The patch introduces a severe performance regression in NMI context on Arch LBR CPUs that lack hardware branch-type decoding by unintentionally forcing software disassembly on all recorded branches.
>> --
>>
>> commit 4686077e19d211c998cc542c03a674a17408e8d7
>> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> perf/x86/intel: Fallback to sw branch type decoding if no hw decoding
>>
>> This commit updates the arch-LBR filtering logic to fallback to software
>> branch-type decoding if hardware decoding is not supported. It replaces
>> the X86_FEATURE_ARCH_LBR CPU feature check with the x86_lbr_type static
>> branch to properly handle arch-LBR configurations that lack branch-type
>> information.
>>
>>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>>> index 72f2adcda7c68..e2657f791e507 100644
>>> --- a/arch/x86/events/intel/lbr.c
>>> +++ b/arch/x86/events/intel/lbr.c
>>> @@ -1231,7 +1231,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>>>  		 * Doesn't support OTHER_BRANCH decoding for now.
>>>  		 * OTHER_BRANCH branch type still rely on software decoding.
>>>  		 */
>>> -		if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
>>> +		if (static_branch_likely(&x86_lbr_type) &&
>>>  		    type <= ARCH_LBR_BR_TYPE_KNOWN_MAX) {
>>>  			to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
>>>  			type = arch_lbr_br_type_map[type] | to_plm;
>> [Severity: High]
>> Does this introduce a performance regression in NMI context on arch-LBR CPUs
>> that lack hardware branch-type decoding?
>>
>> Currently, intel_pmu_setup_hw_lbr_filter() unconditionally sets
>> X86_BR_TYPE_SAVE for arch-LBR CPUs:
>>
>> arch/x86/events/intel/lbr.c:intel_pmu_setup_hw_lbr_filter() {
>>     ...
>>     reg->reg |= X86_BR_TYPE_SAVE;
>>     ...
>> }
>>
>> Because X86_BR_TYPE_SAVE is forcibly set in br_sel, the fast-path early
>> return at the start of intel_pmu_lbr_filter() is bypassed even if the user
>> only requested basic branch recording without branch types.
>>
>> With this patch, if x86_lbr_type is false, the loop falls through to the
>> else block and calls branch_type() for every LBR entry. This causes
>> expensive software instruction decoding to unconditionally execute for all
>> LBR records on every PMU interrupt.
>>
>> Should intel_pmu_setup_hw_lbr_filter() be updated to only force-enable
>> X86_BR_TYPE_SAVE if static_branch_likely(&x86_lbr_type) is true?
> AMD guys have known the issue, they would post the fix separately. Thanks.

Please ignore this comment, it should be the comment for next patch. Thanks.


>
>
>
