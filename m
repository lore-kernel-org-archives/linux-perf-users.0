Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4631A388382
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 02:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784686175; cv=none; b=l5cK89qcrMfGlpZnGa4f1o9PwiuSiRSeC0KZOoCyCEhK3S9sfvkwSq7qyu2JiiB7ifK80LhT9Yuv6yTzAiEOVhzvr2m+5G0sAqQ8MfXtgJfko6PKN9RN/+XZJX0z9XqMkQR6s3HikjlGnlx1xynJ32sekyuFZ7QEhy7NlCyU8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784686175; c=relaxed/simple;
	bh=LLNiHbsRSmGaFUXTf4GzPSNNjfAep51VoVThIqKDPKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bpp1pHk0GPoTytyib1EK67Gsi9x6naCVJvWtcY6G3dCpYeSgxlsEiPa/WWkTQvQzkTvZvFY8EwHIzdwYxZysNcydQKHTQ+VWbQ2/12jGDV94BGtRP4N5gqpzYocCotlwMTHOnzNQDgh13aUMhBX6/0Lw/eJtch5t33GF7Ukv08E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQi2yVhz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQi2yVhz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784686170; x=1816222170;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LLNiHbsRSmGaFUXTf4GzPSNNjfAep51VoVThIqKDPKc=;
  b=SQi2yVhzP5HKSkVhsaJ3a7vRp4s/MyeFLzNOuyghVP7qP8PLuOBqjsHX
   MdGDlva6EVJhDaIiPNIY/FP3BVJU1KOxsXe6LKTuiRxqrxYM776/MXtEC
   5denfBxU2tmy5909LeSd8qCP07JPejJCN0WMD9GJCZUS6Bhd8p8ijRHAu
   8Kl/2kSSG86Lx872oQowZcHoTstuaUJIN3Eel+/xvX5oGroGYpO4rtthi
   IGZrYMS+OjKwUAiSLzBCKkK+UsVnuxKUNLkr1KkSz94zr16CdZfUb2pnR
   gDFtvThHcNkc6lucVbmCQJVuAZZFLCoE91roRJdRz8vtpvm7J8og5h5uh
   w==;
X-CSE-ConnectionGUID: vqmG5enfQhmCpadotEuE1w==
X-CSE-MsgGUID: ZDmH/+C5T9mWhKHUCEoCfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="85349330"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="85349330"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 19:09:29 -0700
X-CSE-ConnectionGUID: tl7FqKpNRl6AJASoFqfDzQ==
X-CSE-MsgGUID: eHGa7awtS8izrFm46LheYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="261506557"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 19:09:28 -0700
Message-ID: <78906af1-06b6-49af-97d3-ad3e99f0aefe@linux.intel.com>
Date: Wed, 22 Jul 2026 10:09:26 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v10 05/10] perf regs: Support x86 eGPRs/SSP sampling
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260721072707.3787848-1-dapeng1.mi@linux.intel.com>
 <20260721072707.3787848-6-dapeng1.mi@linux.intel.com>
 <20260721075209.EC4A41F00A3D@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260721075209.EC4A41F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/21/2026 3:52 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Hardcoded 32-byte SIMD header skip in `__evsel__parse_sample` corrupts parsing of future `perf.data` files containing actual SIMD data payloads.
> - [High] `perf_event__synthesize_sample` fails to write the SIMD register header, leading to uninitialized memory leaks and corruption of synthesized events.
> - [High] Silently substituting requested eGPRs with legacy XMM registers on non-hardware events.
> --
>
> --- Patch [5]: [Patch v10 05/10] perf regs: Support x86 eGPRs/SSP sampling ---
> commit 8930556b90beb6ec5b6f4e43ddaf5145e6dda06d
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf regs: Support x86 eGPRs/SSP sampling
>
> This commit adds support for sampling x86 extended GP registers (R16-R31)
> and the shadow stack pointer (SSP) register. It reclaims the original XMM
> registers space in the sampling masks to represent eGPRs and SSP when SIMD
> sampling is supported, distinguishing them with a new abi flag.
>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index a5b0687a3a79f..da0ad06446091 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
> [ ... ]
>
>> @@ -1661,12 +1664,16 @@ void evsel__config(struct evsel *evsel, const struct record_opts *opts,
>>  	if (opts->sample_intr_regs && !evsel->no_aux_samples &&
>>  	    !evsel__is_dummy_event(evsel)) {
>>  		attr->sample_regs_intr = opts->sample_intr_regs;
>> +		attr->sample_simd_regs_enabled = evsel__is_hardware_event(evsel) ?
>> +				!!opts->sample_simd_regs_enabled : 0;
> [Severity: High]
> Does clearing the sample_simd_regs_enabled flag for non-hardware events
> cause the kernel to misinterpret the bits as legacy XMM requests?
>
> If a user requests sampling of eGPRs on a software event, this flag is
> forcibly cleared, but the opts->sample_intr_regs bitmask is preserved.
> Because eGPR definitions alias legacy XMM definitions, wouldn't the kernel
> see the bits set alongside sample_simd_regs_enabled = 0 and dump legacy XMM
> data instead?
>
> The tool might then read it back without the SIMD ABI flag and print it as
> XMM, silently losing the user's intent to capture eGPRs. Should the
> aliasing eGPR bits be masked out from the sample_regs mask when clearing
> the SIMD flag?

All software events can only sample these legacy GPRs and can't support
these new added advanced registers regardless of SIMD or APX eGPRs. So the
issue can't really occur.


>
>>  		evsel__set_sample_bit(evsel, REGS_INTR);
>>  	}
>>  
>>  	if (opts->sample_user_regs && !evsel->no_aux_samples &&
>>  	    !evsel__is_dummy_event(evsel)) {
>>  		attr->sample_regs_user |= opts->sample_user_regs;
>> +		attr->sample_simd_regs_enabled = evsel__is_hardware_event(evsel) ?
>> +				!!opts->sample_simd_regs_enabled : 0;
> [Severity: High]
> This seems to have the same aliasing issue as above where eGPR requests on
> non-hardware events will be silently interpreted as legacy XMM registers.

Ditto.


>
>>  		evsel__set_sample_bit(evsel, REGS_USER);
>>  	}
> [ ... ]
>
>> @@ -3679,6 +3686,13 @@ int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>>  			regs->mask = mask;
>>  			regs->regs = (u64 *)array;
>>  			array = (void *)array + sz;
>> +
>> +			if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
>> +				/* Skip SIMD-regs header. */
>> +				sz = 4 * sizeof(u64);
>> +				OVERFLOW_CHECK(array, sz, max_size);
>> +				array = (void *)array + sz;
>> +			}
>>  		}
>>  	}
> [Severity: High]
> Will this hardcoded 32-byte header skip corrupt parsing for files containing
> actual SIMD data payloads?
>
> The parser unconditionally skips exactly 4 u64s for the SIMD header, but it
> doesn't dynamically compute and skip the variable-length SIMD payload that
> might follow it in future files. This would misalign the array pointer for
> subsequent fields like STACK_USER, causing garbage reads and triggering
> OVERFLOW_CHECK aborts.

The extra SIMD registers payload would be parsed in subsequent patch 07/10
"perf regs: Enable dumping of SIMD registers".


>
> [ ... ]
>
>> @@ -3736,6 +3750,13 @@ int __evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>>  			regs->mask = mask;
>>  			regs->regs = (u64 *)array;
>>  			array = (void *)array + sz;
>> +
>> +			if (regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
>> +				/* Skip SIMD-regs header. */
>> +				sz = 4 * sizeof(u64);
>> +				OVERFLOW_CHECK(array, sz, max_size);
>> +				array = (void *)array + sz;
>> +			}
>>  		}
>>  	}
> [Severity: High]
> This appears to have the same issue with skipping the SIMD header without
> handling the variable-length payload.
>
>> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
>> index b75f9dcf4dbfe..503a239b0b10f 100644
>> --- a/tools/perf/util/synthetic-events.c
>> +++ b/tools/perf/util/synthetic-events.c
>> @@ -1527,6 +1527,8 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
>>  		if (sample->user_regs && sample->user_regs->abi) {
>>  			result += sizeof(u64);
>>  			sz = hweight64(sample->user_regs->mask) * sizeof(u64);
>> +			if (sample->user_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
>> +				sz += 4 * sizeof(u64);
> [Severity: High]
> Does perf_event__synthesize_sample() also need to be updated to write these
> 32 bytes?
>
> Since perf_event__sample_event_size() allocates 32 extra bytes for the SIMD
> header here, if perf_event__synthesize_sample() doesn't write them,
> subsequent fields could be written 32 bytes early.
>
> When the malformed event is parsed by __evsel__parse_sample(), the parser
> will skip 32 bytes after the registers, completely missing the early-written
> subsequent fields and corrupting the stream. The final 32 bytes of the event
> buffer would remain uninitialized heap memory, leaking information when
> emitted.

Ditto.


>>  			result += sz;
>>  		} else {
>>  			result += sizeof(u64);
>> @@ -1555,6 +1557,8 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
>>  		if (sample->intr_regs && sample->intr_regs->abi) {
>>  			result += sizeof(u64);
>>  			sz = hweight64(sample->intr_regs->mask) * sizeof(u64);
>> +			if (sample->intr_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
>> +				sz += 4 * sizeof(u64);
> [Severity: High]
> This appears to have the same issue as above, where the allocated SIMD
> header bytes might not be written by perf_event__synthesize_sample().

Ditto. 

Thanks.


>
>>  			result += sz;
>>  		} else {
>>  			result += sizeof(u64);
