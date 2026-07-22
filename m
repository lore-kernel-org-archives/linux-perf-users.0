Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBAB256C8B
	for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784683631; cv=none; b=kwztzusNaSU+5t4rTr1KMKdpHGpdcjojzdkL1KMx1duhtoofV9qTRQNYxXhXCLy/WvpyeF9nx1011pGJ/2yf3PayNTd1XATEAQuL8Hugd+OUl53HV/Ej2HYz8oI2/0t72GiyUAqRedYUTJ25DugnvNHr5lGVW9FO6dmpjyk6qlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784683631; c=relaxed/simple;
	bh=gnQgyX0r1GcSeiY0aBJEpNUSEJ1oYybGpeb54r/Uljk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjUlyw5qkNQM0Jy7OQS+y0o5Fy6vA0RUpwdN6FEqO+LASFQIGSclnLATs+RfQa7QUXCtqKhyOEl1e+7ymvWSMeiE4IM+7DrlW7JrUh1Z+2Yosi6u9i4h5t/TN8T6VCEC4MLixO3XhUDTLtFMigRQ/zvlfBc5atGcIBTopwwKKpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aQofllP/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aQofllP/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784683629; x=1816219629;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gnQgyX0r1GcSeiY0aBJEpNUSEJ1oYybGpeb54r/Uljk=;
  b=aQofllP/BA/ZxCfMNetADbv0zvqVNYDx6klkV4fUdl4lQFe+Bo1gpyQU
   T4h/4JE2NTs8N8aOjxlnbb/QuneufjprjnqE0EkSLmKWFG6yKF0X3+1RD
   ZLlk54mCV//HQqN8D3qiVuhe1/+rhgOjVWy/LWLPQ5pXYS+Lzct90+oEm
   YxtAbH+NcpugrWiT5UpU+i656ThGn9D+VAQ/42hI13ljrVxEWhbBJBims
   UG2pPCohjN60SuGv6QyEak3B5aHUttIbVAnqx+5oipeCg28b7fyWH1zXm
   Gon46Bis+DKwy2K4GDVDQkf2lxC0eU9N7BIYgPwRc3VKplFG5vMR8f+i0
   w==;
X-CSE-ConnectionGUID: 58exaKoCQl+WFs5HcjZnpw==
X-CSE-MsgGUID: nap0vz1/SBi1zFoL2IoLKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="96441491"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="96441491"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 18:27:09 -0700
X-CSE-ConnectionGUID: iQB8M1TeR32BpPypUYTV8w==
X-CSE-MsgGUID: C0yOEp0nRj6RuKqwCBxQrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="261723100"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 18:27:08 -0700
Message-ID: <1a77a18e-5739-48bd-aba0-551d61a72dbf@linux.intel.com>
Date: Wed, 22 Jul 2026 09:27:05 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v10 04/10] perf headers: Sync perf_event.h/perf_regs.h
 with the kernel headers
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260721072707.3787848-1-dapeng1.mi@linux.intel.com>
 <20260721072707.3787848-5-dapeng1.mi@linux.intel.com>
 <20260721074759.467B11F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260721074759.467B11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/21/2026 3:47 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] evsel__parse_sample() fails to parse or skip the newly appended SIMD payload, corrupting subsequent sample field parsing.
> - [Medium] The condition to print the new SIMD attribute fields in `perf_event_attr__fprintf()` uses the offset of the last field instead of the first field, hiding valid intermediate fields.
> - [Medium] regs_dump_abi() incorrectly reports 'unknown' for all samples with SIMD registers enabled.
> --
>
> --- Patch [4]: [Patch v10 04/10] perf headers: Sync perf_event.h/perf_regs.h with the kernel headers ---
> commit 8b5325e2c0e1de39cce1b1704639159d2e039a47
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf headers: Sync perf_event.h/perf_regs.h with the kernel headers
>
> This commit syncs UAPI header changes supporting SIMD/eGPRs/SSP sampling
> into the corresponding tools UAPI headers. It also updates the print
> and swap helpers to support the newly introduced perf_event_attr fields.
>
>> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
>> index fd10aa8d697f2..c49fc76292f79 100644
>> --- a/tools/include/uapi/linux/perf_event.h
>> +++ b/tools/include/uapi/linux/perf_event.h
> [ ... ]
>> @@ -314,8 +314,9 @@ enum {
>>   */
>>  enum perf_sample_regs_abi {
>>  	PERF_SAMPLE_REGS_ABI_NONE		= 0,
>> -	PERF_SAMPLE_REGS_ABI_32			= 1,
>> -	PERF_SAMPLE_REGS_ABI_64			= 2,
>> +	PERF_SAMPLE_REGS_ABI_32			= (1 << 0),
>> +	PERF_SAMPLE_REGS_ABI_64			= (1 << 1),
>> +	PERF_SAMPLE_REGS_ABI_SIMD		= (1 << 2),
>>  };
> [Severity: Medium]
> By changing the ABI values to bitwise flags, will this break the existing
> regs_dump_abi() in tools/perf/util/session.c?
>
> When the PERF_SAMPLE_REGS_ABI_SIMD bit is set, the combined mask is at
> least 4. This triggers the fallback in regs_dump_abi():
>
> static inline const char *regs_dump_abi(struct regs_dump *d)
> {
> 	if (d->abi > PERF_SAMPLE_REGS_ABI_64)
> 		return "unknown";
>
> 	return regs_abi[d->abi];
> }
>
> Should this logic be updated to handle the new bitmasks so valid SIMD
> samples aren't displayed as unknown?

regs_dump_abi() is extended to support these new ABI flags in the patch
05/10 "perf regs: Support x86 eGPRs/SSP sampling".


> [ ... ]
>> @@ -1020,7 +1045,15 @@ enum perf_event_type {
>>  	 *      } && PERF_SAMPLE_BRANCH_STACK
>>  	 *
>>  	 *	{ u64			abi; # enum perf_sample_regs_abi
>> -	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_USER
>> +	 *	  u64			regs[weight(mask)];
>> +	 *	  struct {
>> +	 *		u64 nr_vectors;		# 0 ... weight(sample_simd_vec_reg_user)
>> +	 *		u64 vector_qwords;	# 0 ... sample_simd_vec_reg_qwords
>> +	 *		u64 nr_pred;		# 0 ... weight(sample_simd_pred_reg_user)
>> +	 *		u64 pred_qwords;	# 0 ... sample_simd_pred_reg_qwords
>> +	 *		u64 data[nr_vectors * vector_qwords + nr_pred * pred_qwords];
>> +	 *	  } && (abi & PERF_SAMPLE_REGS_ABI_SIMD)
>> +	 *	} && PERF_SAMPLE_REGS_USER
> [Severity: High]
> Does evsel__parse_sample() need to be updated to parse or skip this
> newly appended SIMD payload?
>
> Looking at tools/perf/util/evsel.c:__evsel__parse_sample(), it currently
> only advances the array pointer by the basic register mask weight:
>
> 		if (regs->abi) {
> 			u64 mask = evsel->core.attr.sample_regs_user;
>
> 			sz = hweight64(mask) * sizeof(u64);
> 			OVERFLOW_CHECK(array, sz, max_size);
> 			regs->mask = mask;
> 			regs->regs = (u64 *)array;
> 			array = (void *)array + sz;
> 		}
>
> If the array pointer isn't advanced past the new SIMD data, will the
> parser misinterpret the SIMD payload as subsequent sample fields and
> result in parsing errors?

Similarly, __evsel__parse_sample() is extended to support these new SIMD
fields in subsequent patch "perf regs: Enable dumping of SIMD registers". 


> [ ... ]
>> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
>> index cc817294ad3d6..2e8be9a357dce 100644
>> --- a/tools/perf/util/perf_event_attr_fprintf.c
>> +++ b/tools/perf/util/perf_event_attr_fprintf.c
>> @@ -407,8 +407,17 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
>>  	}
>>  	if (attr_size >= offsetof(struct perf_event_attr, config4))
>>  		PRINT_ATTRf(config3, p_hex);
>> -	if (attr_size > offsetof(struct perf_event_attr, config4))
>> +	if (attr_size >= offsetof(struct perf_event_attr, sample_simd_regs_enabled))
>>  		PRINT_ATTRf(config4, p_hex);
>> +	if (attr_size > offsetof(struct perf_event_attr, sample_simd_vec_reg_user)) {
>> +		PRINT_ATTRf(sample_simd_regs_enabled, p_unsigned);
>> +		PRINT_ATTRf(sample_simd_pred_reg_qwords, p_unsigned);
>> +		PRINT_ATTRf(sample_simd_pred_reg_intr, p_hex);
> [Severity: Medium]
> Is this conditional too restrictive for the intermediate SIMD fields?
>
> If the tools encounter an attr_size that encompasses some of the new SIMD
> fields (like sample_simd_regs_enabled) but is strictly less than the offset
> of sample_simd_vec_reg_user, it evaluates to false. Will this inadvertently
> skip printing those intermediate fields even though they are present in the
> struct?

That would never happen since all these SIMD fields are always introduced
together. Thanks.


