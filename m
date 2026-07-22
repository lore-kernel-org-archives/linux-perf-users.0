Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D5D3290C2
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 02:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784687504; cv=none; b=iu2O2eOpNHcIPzkpuooW3ynTs0LWDI+fiDJve03vUTRCah8ICPE4QDgo/sahlao2BBQGDUD6H85Tyj9wyc3ZPDIYlI7rE0gCHuTVdPGcBiMXLDRhqDnaTNLXTrEWyaRm3wXASO3DjwHcHYsoD0SeufLtzem2cjCgx1MfLaE0nvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784687504; c=relaxed/simple;
	bh=M8lQPv8gpdSPqFjCZjz7ULFUtLhUL1yLFBgaTPaGuqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icLSdYqVGdJJA0OdlOoeIrwNdYIN9aOo0YT3rfqo40b1cGFKOfOEkK4u038a/8tmJ19TWVvEs7hYevyorGZ5knMNMvSU9UQFnlDwp3cyvwb/WF8PuuKKS3qlxvKKMNXdL081IVQDohOSWvAmM/sGk4RS6T81q7+TVMspNnpr9Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZqB0f9K; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZqB0f9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784687503; x=1816223503;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M8lQPv8gpdSPqFjCZjz7ULFUtLhUL1yLFBgaTPaGuqM=;
  b=QZqB0f9KJJ8AANkQx7BbyUHlz8FxX+jI5HFrXNMNDTFhTH9iytPlwsL2
   Amg8UVN1t4gcNj7eJ1fT5vDzuL+Jo8K71Mnxclc0zomF1sv9JnRM5m7mI
   lhz5XPrxkc0g2+YZUYBdBx5VLrep8vcnBO/1mD6ess6yEa1WRbSv0U57j
   R6AI8rGepGB0C1/zkcJ88xlPGTK+nYcw4YDSYsDJ72NLD/PRpWOkjIN2b
   MKvqssTQutgd7TyD6oVceWD3dMFwglwzcvDweK03nZLcl7jOnerDccGsa
   po5s+dTingSf2EgjjM7CWz0MUFVYl3EEMl21d9DWZqfyWWS1r+/UNHsbN
   Q==;
X-CSE-ConnectionGUID: nInkDsIsR4K0gj++4PYDGg==
X-CSE-MsgGUID: 1hvWHUecSPWu+DW2wEG8ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="102724030"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="102724030"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 19:31:42 -0700
X-CSE-ConnectionGUID: ccwVl8IHQpCdoH4xkTT0ng==
X-CSE-MsgGUID: m+53JrmvRGecTghUZgNSrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="256163099"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 19:31:41 -0700
Message-ID: <9add8e60-04bd-484b-a92b-979515512f6e@linux.intel.com>
Date: Wed, 22 Jul 2026 10:31:38 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v10 06/10] perf regs: Support x86 SIMD registers sampling
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260721072707.3787848-1-dapeng1.mi@linux.intel.com>
 <20260721072707.3787848-7-dapeng1.mi@linux.intel.com>
 <20260721075012.961481F00A3D@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260721075012.961481F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/21/2026 3:50 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] The sample parser fails to skip the SIMD register data payload, corrupting subsequent sample fields.
> - [Medium] Silently synchronizing SIMD register masks between intr and user modes bypasses architectural capability checks.
> - [Medium] Bypassing hardware event check for SIMD register sampling enables it for unsupported software events.
> --
>
> --- Patch [6]: [Patch v10 06/10] perf regs: Support x86 SIMD registers sampling ---
> commit 511dc4506d241eccda5990483afe081741ffbdb5
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf regs: Support x86 SIMD registers sampling
>
> This commit adds support for the SIMD register sampling format on x86 platforms.
> It introduces functions to retrieve register class masks, names, and lengths for 
> both interrupt and user registers, and updates command-line parsing to handle
> groups like XMM, YMM, ZMM, and OPMASK.
>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index da0ad06446091..52249316709d7 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
> [ ... ]
>> @@ -1669,6 +1670,16 @@ void evsel__config(struct evsel *evsel, const struct record_opts *opts,
>>  		evsel__set_sample_bit(evsel, REGS_INTR);
>>  	}
>>  
>> +	if ((opts->sample_intr_vec_regs || opts->sample_intr_pred_regs) &&
>> +	    !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
>> +		attr->sample_simd_regs_enabled = !!opts->sample_simd_regs_enabled;
> [Severity: Medium]
> When SIMD registers are enabled here, should there be a check to verify it is a
> hardware event?
>
> For regular registers, this is guarded with evsel__is_hardware_event(evsel),
> but here it seems to unconditionally enable SIMD registers for software events.
> Could this cause the kernel to reject the event with -EINVAL?

No, sample_simd_regs_enabled must be set for SIMD register sampling.
Software event can't sample these SIMD/eGPRs registers, the event creation
would fail if it wants to sample these SIMD/eGPRs registers.


>
>> +		attr->sample_simd_vec_reg_intr = opts->sample_intr_vec_regs;
>> +		attr->sample_simd_vec_reg_qwords = opts->sample_vec_reg_qwords;
>> +		attr->sample_simd_pred_reg_intr = opts->sample_intr_pred_regs;
>> +		attr->sample_simd_pred_reg_qwords = opts->sample_pred_reg_qwords;
>> +		evsel__set_sample_bit(evsel, REGS_INTR);
>> +	}
> [Severity: High]
> If SIMD sampling is enabled, does the parser in __evsel__parse_sample() properly
> skip the SIMD data payload?
>
> It appears that __evsel__parse_sample() only skips the 4 header elements but
> misses the variable-length SIMD data array that follows:
>
> __evsel__parse_sample() {
>     ...
>     if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
>         /* Skip SIMD-regs header. */
>         sz = 4 * sizeof(u64);
>         OVERFLOW_CHECK(array, sz, max_size);
>         array = (void *)array + sz;
>     }
>     ...
> }
>
> Will this leave the array pointer pointing at register data instead of the next
> field (like PERF_SAMPLE_STACK_USER), potentially corrupting subsequent fields
> and failing to parse the event?

Similarly, __evsel__parse_sample() would be extended to support these SIMD
registers in subsequent patch 07/10 "perf regs: Enable dumping of SIMD
registers".


>
>> +
>>  	if (opts->sample_user_regs && !evsel->no_aux_samples &&
>>  	    !evsel__is_dummy_event(evsel)) {
>>  		attr->sample_regs_user |= opts->sample_user_regs;
>> @@ -1677,6 +1688,16 @@ void evsel__config(struct evsel *evsel, const struct record_opts *opts,
>>  		evsel__set_sample_bit(evsel, REGS_USER);
>>  	}
>>  
>> +	if ((opts->sample_user_vec_regs || opts->sample_user_pred_regs) &&
>> +	    !evsel->no_aux_samples && !evsel__is_dummy_event(evsel)) {
>> +		attr->sample_simd_regs_enabled = !!opts->sample_simd_regs_enabled;
>> +		attr->sample_simd_vec_reg_user = opts->sample_user_vec_regs;
>> +		attr->sample_simd_vec_reg_qwords = opts->sample_vec_reg_qwords;
>> +		attr->sample_simd_pred_reg_user = opts->sample_user_pred_regs;
>> +		attr->sample_simd_pred_reg_qwords = opts->sample_pred_reg_qwords;
>> +		evsel__set_sample_bit(evsel, REGS_USER);
>> +	}
>> +
>>  	if (target__has_cpu(&opts->target) || opts->sample_cpu)
>>  		evsel__set_sample_bit(evsel, CPU);
>>  
>> diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
>> index 70a1cc90b2c13..709fcfb077a2b 100644
>> --- a/tools/perf/util/parse-regs-options.c
>> +++ b/tools/perf/util/parse-regs-options.c
> [ ... ]
>> @@ -53,26 +106,116 @@ name_to_perf_reg_mask(const char *to_match, uint64_t mask, int abi)
>>  	return reg_mask;
>>  }
>>  
>> +static bool
>> +name_to_simd_reg_mask(struct record_opts *opts, const char *to_match,
>> +		      uint64_t mask, bool intr, bool pred)
>> +{
> [ ... ]
>> +		/*
>> +		 * sample_intr_pred_regs and sample_user_pred_regs share
>> +		 * sample_pred_reg_qwords. If both are set, keep their bitmaps identical.
>> +		 */
>> +		if (opts->sample_intr_pred_regs && opts->sample_user_pred_regs) {
>> +			uint64_t max_pred_regs = MAX(opts->sample_intr_pred_regs,
>> +						     opts->sample_user_pred_regs);
>> +
>> +			opts->sample_intr_pred_regs = max_pred_regs;
>> +			opts->sample_user_pred_regs = max_pred_regs;
>> +		}
>> +	} else {
>> +		opts->sample_vec_reg_qwords =
>> +			MAX(qwords, opts->sample_vec_reg_qwords);
> [ ... ]
>> +		/*
>> +		 * sample_intr_vec_regs and sample_user_vec_regs share
>> +		 * sample_vec_reg_qwords. If both are set, keep their bitmaps identical.
>> +		 */
>> +		if (opts->sample_intr_vec_regs && opts->sample_user_vec_regs) {
>> +			uint64_t max_vec_regs = MAX(opts->sample_intr_vec_regs,
>> +						    opts->sample_user_vec_regs);
>> +
>> +			opts->sample_intr_vec_regs = max_vec_regs;
>> +			opts->sample_user_vec_regs = max_vec_regs;
>> +		}
>> +	}
> [Severity: Medium]
> Does synchronizing the SIMD register masks between intr and user modes bypass
> architectural capability checks?
>
> If a user specifies different sets for INTR and USER mode SIMD registers
> (e.g., -I XMM --user-regs ZMM), forcing both masks to the maximum might
> violate the capability check retrieved by
> perf_intr_simd_reg_class_bitmap_qwords().
>
> Will this cause perf record to pass an unsupported register bitmask and fail
> with -EINVAL from the kernel?

No, currently perf/x86 code would validate if the full-register sampling is
required. If not, the event creation would fail. Since sample_intr_vec_regs
and sample_user_vec_regs share sample_vec_reg_qwords, it won't really
violate perf_intr_simd_reg_class_bitmap_qwords(). 

Thanks.


>
