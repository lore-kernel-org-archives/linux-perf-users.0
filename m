Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D19C19D8AC
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781485248; cv=none; b=qsw6ibfLsuPEA/mGHgCZU7z+ybJ60vxyVxjt1IrFLx/01cZCius/waLj3kQCpfm2xclBKklELsAJEpSF0jr1QPKmO+0SPeO4vPbOiTZiXnVhNnT8Rgdf+2ldPtLYfDcl1YaR2a/IMNlmou/uCwk6OWVRJ4Hc5YY2GYxenUjO0y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781485248; c=relaxed/simple;
	bh=rWxPCDds9oMjmAUd3jfsXjPnyhJleuj+hSQYMHDXvRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fsRDKao1OX2e+QOaUI+jQlSCogs2224QK1jGyzlGXSrFOJ+LOqM2qg1tdSuGERv7coR+s904WgjO1exRLBkjXrLHlulyRuOsIAiTSk22yR0b7RpCs5levFJY5ZTjhLYzhcZDxaPs1629IfZrZ1eY0k3Ci+axXaKwO0WFnE4ww3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j+qCqlKX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j+qCqlKX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781485248; x=1813021248;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rWxPCDds9oMjmAUd3jfsXjPnyhJleuj+hSQYMHDXvRs=;
  b=j+qCqlKXejdhnYgOl6yimh3329vhP6ODc7M6vo30+nmaUnvJB11bff1W
   FGtrlxnz8n3jBXRS+fYZWW7rE3tddcePQ9mysnyedMG4qk4sY/rAJu8g4
   gBZX0AYemOpWASwJRV5yxQ5XhqqRp4min5JE8KYJP9YmiApiekfaORcBA
   ueFSGT3EJ3kC5JMZuwOJgue5tu1P62txk3jPh6hd1le0bWazHWd6LGRs1
   7EByX6UltK4QcA5w0pepfausWyczodpHoYEWwcMVzwhaza3hJEM1JQRhd
   s3ZpE54TR9grjZvOiX7SwcCjvea0TqitnBE4alpcRh1a0+cIzaZP3/Lc/
   g==;
X-CSE-ConnectionGUID: JmRk6by+RymdirFtuDwSxg==
X-CSE-MsgGUID: TMCrdJgdQDC/00qJo3BesQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="93339283"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="93339283"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 18:00:47 -0700
X-CSE-ConnectionGUID: mlHl2EkRT9aQ7FJp4LK5SQ==
X-CSE-MsgGUID: 1EbsAqbES/qjC4Bz9ZTR2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; 
   d="scan'208";a="244418614"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2026 18:00:46 -0700
Message-ID: <af0e50c4-8ea3-4f10-a2c0-5e3a0427107a@linux.intel.com>
Date: Mon, 15 Jun 2026 09:00:43 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 3/8] perf/x86/intel: Fallback to sw branch type
 decoding if no hw decoding
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260612090114.3188886-4-dapeng1.mi@linux.intel.com>
 <20260612092141.8AE911F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260612092141.8AE911F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/12/2026 5:21 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The patch introduces a severe performance regression in NMI context on Arch LBR CPUs that lack hardware branch-type decoding by unintentionally forcing software disassembly on all recorded branches.
> --
>
> commit 4686077e19d211c998cc542c03a674a17408e8d7
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Fallback to sw branch type decoding if no hw decoding
>
> This commit updates the arch-LBR filtering logic to fallback to software
> branch-type decoding if hardware decoding is not supported. It replaces
> the X86_FEATURE_ARCH_LBR CPU feature check with the x86_lbr_type static
> branch to properly handle arch-LBR configurations that lack branch-type
> information.
>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index 72f2adcda7c68..e2657f791e507 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -1231,7 +1231,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
>>  		 * Doesn't support OTHER_BRANCH decoding for now.
>>  		 * OTHER_BRANCH branch type still rely on software decoding.
>>  		 */
>> -		if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
>> +		if (static_branch_likely(&x86_lbr_type) &&
>>  		    type <= ARCH_LBR_BR_TYPE_KNOWN_MAX) {
>>  			to_plm = kernel_ip(to) ? X86_BR_KERNEL : X86_BR_USER;
>>  			type = arch_lbr_br_type_map[type] | to_plm;
> [Severity: High]
> Does this introduce a performance regression in NMI context on arch-LBR CPUs
> that lack hardware branch-type decoding?
>
> Currently, intel_pmu_setup_hw_lbr_filter() unconditionally sets
> X86_BR_TYPE_SAVE for arch-LBR CPUs:
>
> arch/x86/events/intel/lbr.c:intel_pmu_setup_hw_lbr_filter() {
>     ...
>     reg->reg |= X86_BR_TYPE_SAVE;
>     ...
> }
>
> Because X86_BR_TYPE_SAVE is forcibly set in br_sel, the fast-path early
> return at the start of intel_pmu_lbr_filter() is bypassed even if the user
> only requested basic branch recording without branch types.
>
> With this patch, if x86_lbr_type is false, the loop falls through to the
> else block and calls branch_type() for every LBR entry. This causes
> expensive software instruction decoding to unconditionally execute for all
> LBR records on every PMU interrupt.
>
> Should intel_pmu_setup_hw_lbr_filter() be updated to only force-enable
> X86_BR_TYPE_SAVE if static_branch_likely(&x86_lbr_type) is true?

AMD guys have known the issue, they would post the fix separately. Thanks.


