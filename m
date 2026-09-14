Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA7731ED93
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 03:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789356236; cv=none; b=BZBwz2teCYXOHT28CHuFvo3eJQ+O5tNO/MFg4zgZxlLE49a5flPwQAt0S7S75nl0xWlBXzeOuMf6Vc/KFTg7M45o8Fs8BdfaDEbvQ+rSbiW5/q+EHKvls7QSFIbwm3+WqTn7XEZ7TAfmVgsVtELX0nFV7JoPy8yyu2Ja1QF2cMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789356236; c=relaxed/simple;
	bh=PJWRpZ6R7Caez2tyA1fHosu6VMV3NMzU5S7qJ024Imw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMGOvLoOR5ieBEpziav/UVsbCUZ6VKC0G+DkmYNMlJocn3DWymywNOLGZ8TvEBWv4WC0dEmSEIwHaqPOfoitJ0k/bzHGZTF/yG8kSMmd2Y3hjL2p3KmFuE2exTreipiIyQE787v+bfLa1E8+kc/jxkoz7ao3rn/NlUVTq7r02DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dmn4KYI2; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dmn4KYI2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789356229; x=1820892229;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PJWRpZ6R7Caez2tyA1fHosu6VMV3NMzU5S7qJ024Imw=;
  b=Dmn4KYI2Z2vG5EzeDcFKe7n8nZ+w+3K7A1NhQAduaHx0vRRttJHjFkcE
   dQ95pWkGNClGxwaN3HGOOo8ZCeanmWb52UzG/o0qmw2IDsRU71dTC31le
   yA0+dxANSEgcEC4nphbehYF0J+GATP7Pf3APr9EjJwYJq/kDhJTQo8huS
   BdbPKoal8QDTtstSDcUkFo4SJB9CMXUHI/ZU2ifufEUksFqKtbKhDKabb
   xq+CCE6rInLXPJ8eRJt0cfHyZFTwwoVHUnpzEgbXPdPRTwG9GBsEjurQE
   4hyKhzNo23i1BkDMJoDaDnScylRU9FYnqQje78BGyppesnI6/rNUhvDpJ
   Q==;
X-CSE-ConnectionGUID: gZOSgyM/Q3CPK9WkfD1IbA==
X-CSE-MsgGUID: fvW980U9SXG27pxFRQfFWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="93579745"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="93579745"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 20:23:45 -0700
X-CSE-ConnectionGUID: 0QlTuGIgQwWWu2rMeAXkhA==
X-CSE-MsgGUID: tei1ZRo+Q6m6oz3OajZaeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="297534191"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 20:23:44 -0700
Message-ID: <c16e173c-d3de-42e4-99e0-184eed096eac@linux.intel.com>
Date: Mon, 14 Sep 2026 11:23:41 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v11 04/10] perf headers: Sync perf_event.h/perf_regs.h
 with the kernel headers
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
 <20260914014049.2061519-5-dapeng1.mi@linux.intel.com>
 <20260914020145.4DEE91F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260914020145.4DEE91F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/14/2026 10:01 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Sample parser in ASLR tool fails to consume the new SIMD register payload when PERF_SAMPLE_REGS_ABI_SIMD is set, leading to stream desynchronization.
> - [Low] perf_event_attr__fprintf() prints the newly added SIMD fields out of struct layout order.
> --
>
> commit 2a8ebff44960ffb0cedfa7b327d5de5cc826d750
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf headers: Sync perf_event.h/perf_regs.h with the kernel headers
>
> Sync the UAPI header changes of supporting SIMD/eGPRs/SSP sampling into
> corresponding tools UAPI headers. Additionally, support the newly introduced
> perf_event_attr fields in the perf_event_attr__fprintf and
> perf_event__attr_swap() helpers.
>
>> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
>> index fd10aa8d697f2..c49fc76292f79 100644
>> --- a/tools/include/uapi/linux/perf_event.h
>> +++ b/tools/include/uapi/linux/perf_event.h
> [ ... ]
>
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
>>  	 *
> [Severity: High]
> Does this new ABI payload cause stream desynchronization in
> tools/perf/util/aslr.c?
>
> When PERF_SAMPLE_REGS_ABI_SIMD is set, aslr_tool__process_sample() fails to 
> advance the payload pointer over the extended SIMD struct:
>
> tools/perf/util/aslr.c:aslr_tool__process_sample() {
> 	...
> 	if (orig_sample_type & PERF_SAMPLE_REGS_USER) {
> 		u64 abi;
>
> 		if (CHECK_BOUNDS(1, 0)) {
> 			ret = -EFAULT;
> 			goto out_put;
> 		}
> 		abi = in_array[i++];
> 		if (abi != PERF_SAMPLE_REGS_ABI_NONE) {
> 			u64 nr = hweight64(orig_regs_user);
>
> 			if (nr > max_i - i) {
> 				ret = -EFAULT;
> 				goto out_put;
> 			}
> 			i += nr;
> 		}
> 	}
> 	...
> }
>
> It appears the function skips standard registers by adding
> hweight64(orig_regs_user) to the parser index, but misses parsing or skipping
> the dynamically sized SIMD payload that follows. Can this leave unparsed
> SIMD data in the stream, potentially corrupting subsequent fields?
>
> A similar regression is present in the PERF_SAMPLE_REGS_INTR handling within
> the same function.
>
> Note that while other parsers like evsel.c were fixed in subsequent patches,
> aslr.c appears to remain broken at the end of the series.

oh, yes. Since this patch series is close to merge, I would submit an
independent patch to fix the miss.


>
> [ ... ]
>
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
>> +		PRINT_ATTRf(sample_simd_pred_reg_user, p_hex);
>> +		PRINT_ATTRf(sample_simd_vec_reg_qwords, p_unsigned);
>> +		PRINT_ATTRf(sample_simd_vec_reg_intr, p_hex);
>> +		PRINT_ATTRf(sample_simd_vec_reg_user, p_hex);
>> +	}
> [Severity: Low]
> Does this print the newly added SIMD fields out of struct layout order?
>
> The UAPI struct definition in tools/include/uapi/linux/perf_event.h places
> sample_simd_vec_reg_qwords before sample_simd_pred_reg_intr:
>
> tools/include/uapi/linux/perf_event.h:struct perf_event_attr {
> 	...
> 	__u16	sample_simd_regs_enabled;
> 	__u16	sample_simd_pred_reg_qwords;
> 	__u16	sample_simd_vec_reg_qwords;
> 	__u16	__reserved_4;
>
> 	__u32	sample_simd_pred_reg_intr;
> 	__u32	sample_simd_pred_reg_user;
> 	...
> }
>
> However, the fprintf code above prints sample_simd_vec_reg_qwords after both
> sample_simd_pred_reg_intr and sample_simd_pred_reg_user. Could this cause
> minor confusion when debugging raw perf_event_attr fields?

There is no strict requirement on the print order. The reason that adjusts
the print order is to make the fields belonging same class printed close
together and convenient for users reading.

Thanks.


>
