Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E7D37B023
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 05:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789362878; cv=none; b=ht3T+fwDRd/PuZBsPywZ9h77BJmslq9l4L4mGV1JHuuNhFDiUhvWBGUq1UhKBb/jVH2yiBcUJSq76cVHblvemLhZEWtdF7etqsMoo/Q6rRn82FcFg5lEpNwDRnCq0CO6nvdTvZGZq7aVNysxdeXcdLr8OqwsyR4z9AIGRq8lOfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789362878; c=relaxed/simple;
	bh=3jXYj3xt57Z7JUSzwjWpbq2Ui80ZtbZvEGLnMZQ3nFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dF05RWKo7OYRiqMaxbnLvXZPLFrMxcXhKZBbNVRMeq+pxNQ+nVwhNUDlmPNGA14tMkQLgG6WNXuSeTkrWCVyN99y4K1zrr69btzhs7ybV4Bc0vtiDHjjiLPVlcxMOTOcqUtRw2XRIhP55cOdQHeJMaEVlqIJZmk28+loSSsUco8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGf+JGID; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGf+JGID"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789362875; x=1820898875;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3jXYj3xt57Z7JUSzwjWpbq2Ui80ZtbZvEGLnMZQ3nFY=;
  b=BGf+JGIDekQ+BKNP4mJCjax+yu0JswLwTQ08uP+CDL2l5IXpvlSCclUe
   e3JsS/gDPv2vdr9+G0tQK3oSgQSP20CtWO61v3/MSrUHiyWJtNtPglqHW
   Llf4FM4a6PH5FTiiLupHCXGt5+stAe7qv607Q3Nf4HmDMUHhd8/Xur7fo
   W9iszsOZ7qwsvCjTBMFZ1kVWHl//nUrrkVnvADt97f9PkyM3ZJORZjSzM
   LNp9yMURWIM7XehVtC5EVAKBhpoJJ7xNhi22DS+X7u6I0Ot0q96VCppD2
   aUvEzV+vKTxmGdTqR/yUQlBx1kwjQvVwhIfTiuPky7OrwIIX9e0eab8r1
   w==;
X-CSE-ConnectionGUID: OhTzd/Y2Rbuc76ifOvcThQ==
X-CSE-MsgGUID: ReaD4gIvQR2vMidrEbS+rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="220191"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="220191"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 22:14:34 -0700
X-CSE-ConnectionGUID: vu5eCxf6SzyzaoC1f7DnzA==
X-CSE-MsgGUID: rCWxuQjqQdWmJSFlTZnNfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="310813398"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 22:14:33 -0700
Message-ID: <e63045a3-5bb6-493a-85c1-b9f174b0e745@linux.intel.com>
Date: Mon, 14 Sep 2026 13:14:30 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v11 06/10] perf regs: Support x86 SIMD registers sampling
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
 <20260914014049.2061519-7-dapeng1.mi@linux.intel.com>
 <20260914020302.DDAB01F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260914020302.DDAB01F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/14/2026 10:03 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Missing `evsel__is_non_software_event()` check for SIMD register sampling allows software events to request SIMD registers, causing `sys_perf_event_open()` to fail.
> - [High] XMM registers are silently dropped from the default `-I` and `-U` register capture sets on modern kernels.
> - [Low] Missing explicit inclusion of POSIX headers (`<unistd.h>`, `<strings.h>`) and inclusion of an unused non-standard header (`<sys/param.h>`).
> --
>
> commit 09156b6b89ab2ab1deab99c4296be004bb60e327
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf regs: Support x86 SIMD registers sampling
>
> This commit adds support for the newly introduced SIMD register sampling
> format on x86 platforms. It introduces helpers to retrieve SIMD register
> classes and modifies the configuration logic to handle SIMD registers for
> interrupt and user sampling.
>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index e9a0400af6dae..a62cb63ad3371 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -31,6 +31,7 @@
>>  #include <sys/resource.h>
>>  #include <sys/syscall.h>
>>  #include <sys/types.h>
>> +#include <sys/param.h>
> [Severity: Low]
> Does this file require <sys/param.h>? It looks like this is a non-standard
> header that might be unnecessarily included here without being used, which
> could cause issues on strict POSIX/musl systems.
>
> [ ... ]
>
>> @@ -1672,6 +1673,16 @@ void evsel__config(struct evsel *evsel, const struct record_opts *opts,
>>  		evsel__set_sample_bit(evsel, REGS_INTR);
>>  	}
>>  
>> +	if ((opts->sample_intr_vec_regs || opts->sample_intr_pred_regs) &&
>> +	    !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
>> +		attr->sample_simd_regs_enabled = !!opts->sample_simd_regs_enabled;
>> +		attr->sample_simd_vec_reg_intr = opts->sample_intr_vec_regs;
> [Severity: High]
> Should this block be guarded by evsel__is_non_software_event(evsel)?
>
> If a user runs perf record with mixed hardware and software events
> (e.g., perf record -e cycles,cpu-clock --intr-regs=XMM0), the opts
> structure is shared.
>
> It seems this unconditionally applies SIMD sampling to software events,
> which could cause sys_perf_event_open() to abort with -EINVAL.

It's intended. The sample_simd_regs_enabled assignment is not needed to
guard by evsel__is_non_software_event(). Software event, like cpu-clock,
can't sample these SIMD registers, the kernel would reject the such event
creation.


>
>> +		attr->sample_simd_vec_reg_qwords = opts->sample_vec_reg_qwords;
>> +		attr->sample_simd_pred_reg_intr = opts->sample_intr_pred_regs;
>> +		attr->sample_simd_pred_reg_qwords = opts->sample_pred_reg_qwords;
>> +		evsel__set_sample_bit(evsel, REGS_INTR);
>> +	}
>> +
>>  	if (opts->sample_user_regs && !evsel->no_aux_samples &&
>>  	    !evsel__is_dummy_event(evsel)) {
>>  		attr->sample_regs_user |= opts->sample_user_regs;
>> @@ -1681,6 +1692,16 @@ void evsel__config(struct evsel *evsel, const struct record_opts *opts,
>>  		evsel__set_sample_bit(evsel, REGS_USER);
>>  	}
>>  
>> +	if ((opts->sample_user_vec_regs || opts->sample_user_pred_regs) &&
>> +	    !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
>> +		attr->sample_simd_regs_enabled = !!opts->sample_simd_regs_enabled;
>> +		attr->sample_simd_vec_reg_user = opts->sample_user_vec_regs;
> [Severity: High]
> Similar to the intr block above, this user registers block appears to be
> missing the evsel__is_non_software_event() check.
>
> This could lead to the same -EINVAL failure for mixed software events.

Ditto.


>
> [ ... ]
>
>> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
>> --- a/tools/perf/util/parse-regs-options.c
>> +++ b/tools/perf/util/parse-regs-options.c
>> @@ -106,6 +106,116 @@ name_to_gp_reg_mask(const char *to_match, uint64_t mask, int abi)
>>  
>> +static bool
>> +name_to_simd_reg_mask(struct record_opts *opts, const char *to_match,
>> +		      uint64_t mask, bool intr, bool pred)
>> +{
> [ ... ]
>> +		if (!strcasecmp(to_match, name)) {
> [Severity: Low]
> Does this file need to include <strings.h>? 
>
> The strcasecmp() function is mandated by POSIX to be in <strings.h>.
> Without explicitly including it at the top of the file, this could break
> compilation on musl-based libc systems.
>
> [ ... ]
>
>> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_x86.c b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
>> --- a/tools/perf/util/perf-regs-arch/perf_regs_x86.c
>> +++ b/tools/perf/util/perf-regs-arch/perf_regs_x86.c
>> @@ -300,8 +301,14 @@ uint64_t __perf_reg_mask_x86(bool intr, int *abi)
>>  	if (mask != PERF_REGS_MASK) {
>>  		*abi |= PERF_SAMPLE_REGS_ABI_SIMD;
>>  	} else {
>> -		mask |= __arch__reg_mask(sample_type, PERF_REG_EXTENDED_MASK,
>> -					 false);
>> +		/*
>> +		 * Use the SIMD sampling interface for XMM registers
>> +		 * when available.
>> +		 */
>> +		if (!__support_simd_sampling(intr)) {
>> +			mask |= __arch__reg_mask(sample_type,
>> +						 PERF_REG_EXTENDED_MASK, false);
>> +		}
>>  	}
>>  
>>  	return mask;
> [Severity: High]
> Does this unintentionally drop XMM registers from default captures when SIMD
> sampling is supported?
>
> When a user runs perf record -I with no specific arguments, __parse_regs()
> in parse-regs-options.c uses the default mask:
>
>     /* str may be NULL in case no arg is passed to -I */
>     if (!str) {
>         *mode = mask;
>         if (abi & PERF_SAMPLE_REGS_ABI_SIMD)
>             opts->sample_simd_regs_enabled = 1;
>         return 0;
>     }
>
> Because __perf_reg_mask_x86() skips adding PERF_REG_EXTENDED_MASK to
> mask when SIMD is available, and __parse_regs() doesn't dynamically
> populate opts->sample_intr_vec_regs with the XMM bits when str == NULL,
> it looks like XMM registers are completely omitted from the capture.

Yes, it's intended, too. Currently the legacy sample_regs_{user|intr} based
XMM sampling is deprecated. All SIMD register sampling uses the new interface.


>
> [ ... ]
>
>> +static bool
>> +__support_simd_reg_class(uint64_t sample_type, uint16_t qwords,
>> +			 uint64_t mask, bool pred)
>> +{
> [ ... ]
>> +	fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
>> +	if (fd != -1) {
>> +		close(fd);
> [Severity: Low]
> Does this use of close() require an explicit include of <unistd.h> at the
> top of perf_regs_x86.c?
>
> Code relying on implicit header inclusions can break compilation on strict
> musl-based libc systems.

Not sure if it's necessary, but anyway it can be fixed later.
Thanks.


>
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
