Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D103B3AC0F3
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 01:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783473237; cv=none; b=kqXm5xV7gzKsBQAoHgp4Lmp4n0hAF7+9tzIFXPNIJC9xj5KFUoNbmQ20QgMEnC2P8yZY0fgxmPQTSt6YtiOayEwLr/4VHQOifTHjTLdNbcPcC4QlAgNrh/xKMkhg9/p5oLRymyFtIqcAnc6gKffrFVywjdBybputiB/OznSmOWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783473237; c=relaxed/simple;
	bh=o3BNBAr+EbQXF4PwScM6kNTmPr1SBLLVV2GnegWMlOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2iZscZwxderJoUXKRTJ0/aPm7ZOfQ1sjKHVL9+35CxxH93n9r2OJMyVOWJkD/zhBDqVXuzKDPpzeAPhX7FnlBB5XkL6vg6b+d2CBWFJlIYqFx8ZmnnPjtNi39zXrDmS5UaZOYQ37irskjCnmofNhCuVRfN1VqGZzgl/PQDucWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uw0HySDT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uw0HySDT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783473235; x=1815009235;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o3BNBAr+EbQXF4PwScM6kNTmPr1SBLLVV2GnegWMlOo=;
  b=Uw0HySDT0BdnrT+58URzV9MI5uT46hyHceAZT9VW3y4A2646zw+uofKZ
   wyoGoYYzm9mWkazX5sofXRNxXPmqrnUpvyoANlQPzLb8a6vWyZ/CRwEIA
   gTKdA8pNTSr3Ql0ri1FOdTpGyqpwJQue7SqIK4dCjRkJT0PKQ5SVwAaAe
   eKFjUQJGiblF1ThG4r4tnEcp/wgiI5h2lTmk/vNUNkscsELXgulcPu6rH
   DCP7zCV8OSzGbKX2Ix2JjqLGmVrUtV5iIJ3szNK3vWGhi0dum6cLA2Jvv
   NADKVJsP/SSP5e3j2vi0CCqvnT3A643wHJFD+UkncfV8JhtaMHOPkzFqR
   Q==;
X-CSE-ConnectionGUID: N6lJ7xslTzyoIulKwED1UA==
X-CSE-MsgGUID: 7A0CXstUQkeJ3htKtGxMiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84188258"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84188258"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 18:13:55 -0700
X-CSE-ConnectionGUID: ZABfYRbxSqm37uHIY49PBQ==
X-CSE-MsgGUID: DjNC7vcTQVShPkhE08dPvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="292331724"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 18:13:54 -0700
Message-ID: <b27063e8-b230-40e0-a5ae-a902612e8845@linux.intel.com>
Date: Wed, 8 Jul 2026 09:13:51 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 13/24] perf: Add sampling support for SIMD registers
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-14-dapeng1.mi@linux.intel.com>
 <20260706023436.5DFDD1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260706023436.5DFDD1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/6/2026 10:34 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [Medium] Uninitialized, flag-gated syscall parameters are unconditionally passed to and evaluated by the validation function `perf_simd_reg_validate()`, breaking trust boundaries.
>
> Pre-existing issues:
> - [High] The dynamic size added by PERF_SAMPLE_REGS_INTR (and exacerbated by SIMD registers) bypasses the size capping applied during PERF_SAMPLE_STACK_USER, leading to a U16_MAX integer overflow and ring buffer corruption.
> --
>
> commit 8a8cf6dc3b640f823c8a7990b8c46e78cd38719e
> Author: Kan Liang <kan.liang@linux.intel.com>
>
> perf: Add sampling support for SIMD registers
>
> This commit introduces support for sampling SIMD registers during profiling
> by adding new attribute fields to the perf_event_attr structure. It provides
> a new output format and the PERF_SAMPLE_REGS_ABI_SIMD ABI to represent the
> number and width of these registers based on user configuration.
>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 0239864029bec..ce93c23b3a33f 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -8773,6 +8877,10 @@ void perf_prepare_sample(struct perf_sample_data *data,
>>  			u64 mask = event->attr.sample_regs_intr;
>>  
>>  			size += hweight64(mask) * sizeof(u64);
>> +			if (event_has_simd_regs(event)) {
>> +				size += perf_update_xregs_size(event, true);
>> +				data->regs_intr.abi |= PERF_SAMPLE_REGS_ABI_SIMD;
>> +			}
>>  		}
>>  
>>  		data->dyn_size += size;
> [Severity: High]
> This is a pre-existing issue, but does adding this new SIMD register size
> cause a buffer overrun by overflowing data->dyn_size past USHRT_MAX?
>
> Earlier in perf_prepare_sample(), when PERF_SAMPLE_STACK_USER is processed,
> perf_sample_ustack_size() caps the stack dump size so that the total dynamic
> size precisely reaches USHRT_MAX. 
>
> Since PERF_SAMPLE_REGS_INTR is unconditionally processed after
> PERF_SAMPLE_STACK_USER, adding its size (which can now be significantly
> larger with SIMD registers) to data->dyn_size will exceed 65535 bytes.
>
> Could this truncate the 16-bit header size and cause perf_output_sample()
> to write far more data than was allocated in the ring buffer?

The function perf_simd_reg_validate() would check if SIMD register size
exceeds USHRT_MAX. If so, the event creation would fail before sampling.


>
>> [ ... ]
>> @@ -13694,6 +13809,16 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
>>  		ret = perf_reg_validate(attr->sample_regs_user);
>>  		if (ret)
>>  			return ret;
>> +		ret = perf_simd_reg_validate(attr->sample_type,
>> +					     attr->sample_simd_regs_enabled,
>> +					     attr->sample_simd_vec_reg_qwords,
>> +					     attr->sample_simd_vec_reg_intr,
>> +					     attr->sample_simd_vec_reg_user,
>> +					     attr->sample_simd_pred_reg_qwords,
>> +					     attr->sample_simd_pred_reg_intr,
>> +					     attr->sample_simd_pred_reg_user);
>> +		if (ret)
>> +			return ret;
>>  	}
> [Severity: Medium]
> Could this pass uninitialized syscall parameters to the validation logic?
>
> When PERF_SAMPLE_REGS_USER is set but PERF_SAMPLE_REGS_INTR is not, the user
> is not required to initialize the sample_simd_vec_reg_intr or
> sample_simd_pred_reg_intr fields. 
>
> If perf_simd_reg_validate() evaluates these uninitialized fields:
>
> arch/x86/kernel/perf_regs.c:perf_simd_reg_validate() {
>     if (!vec_mask_intr && !vec_mask_user)
>         return -EINVAL;
> }
>
> Does this allow an invalid configuration where vec_mask_user is zero to
> bypass validation because vec_mask_intr contains non-zero garbage data?

Hmm, it looks a overkill here. It would be fair enough to check REGS_USER
and REGS_INTR separately. Thanks.


>
