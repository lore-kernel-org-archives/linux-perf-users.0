Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950A7258EE0;
	Wed, 11 Feb 2026 06:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770792980; cv=none; b=gIlfvPHaJ7NLWU9IAM17v0fZ/6mpzA4sDguShBb7lbyTw4O2naXREeUlyxXBAEYwW7KsOTCX/Mv6f9PXQpi6Xtibajb+iT0Iwk2YOjVLIVEtMqiYyZu6jA+wbF2mFz2IY3rf/LMf/ReXXAHeIK82EvYhJ93QEtU9bo5A/N5ITi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770792980; c=relaxed/simple;
	bh=bb8Q9KwW7ltxBD+3Y8E+uYuQBevxV8lv0+kes4WD5XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nw+RzdcTBew0BzWw9uTSkNWBIAbIegZRIy6aezd+9tS7s0+Ftre+dJCz1IHRWRrIW68pgPnx83l8JyVvK4EQHLeHMlBsLT4gxtrLK4p+dseKX6iCKO8tzDxP0ROG9rO5+39T08miGVVHGugrRU0PbTippalko5HDzePh2aA8oh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgyjepNG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgyjepNG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770792980; x=1802328980;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bb8Q9KwW7ltxBD+3Y8E+uYuQBevxV8lv0+kes4WD5XY=;
  b=JgyjepNGFPGxIBBtW8zt46BoEr4ZSlGCiYQA4HzOkoTfZYZ5DC/xhsC5
   Mv6g6L9K/y0DxP6Hqm8xg4Pg/vp/hvn5hh+nqLHBR3lF2qNSCqWHVaFsw
   nDGjzZfHEPQRd+Y58vcqtgDd4aNnzr+St4O18nNI8NkK82f8GuwjUFUEj
   po3tfO4JbVShknydYW6m/ctIHOrTdSb/FxnT40Y30iE0alb8fQZb0Itw7
   CMWdeQIFJKEp8rsCESd6vZNgj+pOtWmKvLwGEdN5+bTn/V8tpGl9ch91M
   0Wackz5hi/VfXbMOzJ7d3f8ko+EQkAgyUmzgTf12YHads0rH81DDlepgF
   Q==;
X-CSE-ConnectionGUID: m+JyYtekQ7CBOhER/KcD6w==
X-CSE-MsgGUID: i6l+MyxdSVqhhVQbPHkxGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71835511"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71835511"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 22:56:19 -0800
X-CSE-ConnectionGUID: nc+h6cePR5azpU0nzVS5uQ==
X-CSE-MsgGUID: QQKAGFoSQFS+GAfzmhAjlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="249796347"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 22:56:14 -0800
Message-ID: <05159761-274e-4a6b-97d9-a1251d6cac7b@linux.intel.com>
Date: Wed, 11 Feb 2026 14:56:11 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 12/22] perf: Add sampling support for SIMD registers
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
 <20260209072047.2180332-13-dapeng1.mi@linux.intel.com>
 <20260210200407.GQ2995752@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260210200407.GQ2995752@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/11/2026 4:04 AM, Peter Zijlstra wrote:
> On Mon, Feb 09, 2026 at 03:20:37PM +0800, Dapeng Mi wrote:
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index d487c55a4f3e..5742126f50cc 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -7761,6 +7761,50 @@ perf_output_sample_regs(struct perf_output_handle *handle,
>>  	}
>>  }
>>  
>> +static void
>> +perf_output_sample_simd_regs(struct perf_output_handle *handle,
>> +			     struct perf_event *event,
>> +			     struct pt_regs *regs,
>> +			     u64 mask, u32 pred_mask)
>> +{
>> +	u16 pred_qwords = event->attr.sample_simd_pred_reg_qwords;
>> +	u16 vec_qwords = event->attr.sample_simd_vec_reg_qwords;
>> +	u16 nr_vectors;
>> +	u16 nr_pred;
>> +	int bit;
>> +	u64 val;
>> +	u16 i;
>> +
>> +	nr_vectors = hweight64(mask);
>> +	nr_pred = hweight32(pred_mask);
>> +
>> +	perf_output_put(handle, nr_vectors);
>> +	perf_output_put(handle, vec_qwords);
>> +	perf_output_put(handle, nr_pred);
>> +	perf_output_put(handle, pred_qwords);
>> +
>> +	if (nr_vectors) {
>> +		for (bit = 0; bit < sizeof(mask) * BITS_PER_BYTE; bit++) {
>> +			if (!(BIT_ULL(bit) & mask))
>> +				continue;
>> +			for (i = 0; i < vec_qwords; i++) {
>> +				val = perf_simd_reg_value(regs, bit, i, false);
>> +				perf_output_put(handle, val);
>> +			}
>> +		}
>> +	}
>> +	if (nr_pred) {
>> +		for (bit = 0; bit < sizeof(pred_mask) * BITS_PER_BYTE; bit++) {
>> +			if (!(BIT(bit) & pred_mask))
>> +				continue;
>> +			for (i = 0; i < pred_qwords; i++) {
>> +				val = perf_simd_reg_value(regs, bit, i, true);
>> +				perf_output_put(handle, val);
>> +			}
>> +		}
>> +	}
>> +}
> Yeah, that works, but it does make me sad. The existing
> perf_output_sample_regs() has yet another solution.
>
> Wondering how hard it could possibly be to write a for_each_set_bit()
> variant that works on a given word (instead of an array), I did the
> below.
>
> It works (at least, the assembly looks about right); but I'm not sure
> its all I had hoped for either :-(

Pretty code! It looks I still haven't gotten used to writing such kind of
macros.

The code looks good to me, I would test it later. Thanks.


>
> ---
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7754,18 +7754,27 @@ void __weak perf_get_regs_user(struct pe
>  	regs_user->abi = perf_reg_abi(current);
>  }
>  
> +/* Until GCC-14+/clang-19+, which have __builtin_ctzg() */
> +#define __ctzg(val, def) \
> +	(val) ? _Generic((val), \
> +			 unsigned int: __builtin_ctz(val), \
> +			 unsigned long: __builtin_ctzl(val), \
> +			 unsigned long long: __builtin_ctzll(val)) : (def)
> +
> +#define __next_bit(val, bit) \
> +	({ auto __v = (val); \
> +	   __v &= GENMASK(sizeof(__v) * BITS_PER_BYTE - 1, bit); \
> +	   __ctzg(__v, -1); })
> +
> +#define word_for_each_set_bit(bit, val) \
> +	for (int bit = 0; bit = __next_bit(val, bit), bit >= 0; bit++)
> +
>  static void
>  perf_output_sample_regs(struct perf_output_handle *handle,
>  			struct pt_regs *regs, u64 mask)
>  {
> -	int bit;
> -	DECLARE_BITMAP(_mask, 64);
> -
> -	bitmap_from_u64(_mask, mask);
> -	for_each_set_bit(bit, _mask, sizeof(mask) * BITS_PER_BYTE) {
> -		u64 val;
> -
> -		val = perf_reg_value(regs, bit);
> +	word_for_each_set_bit(bit, mask) {
> +		u64 val = perf_reg_value(regs, bit);
>  		perf_output_put(handle, val);
>  	}
>  }
> @@ -7778,14 +7787,8 @@ perf_output_sample_simd_regs(struct perf
>  {
>  	u16 pred_qwords = event->attr.sample_simd_pred_reg_qwords;
>  	u16 vec_qwords = event->attr.sample_simd_vec_reg_qwords;
> -	u16 nr_vectors;
> -	u16 nr_pred;
> -	int bit;
> -	u64 val;
> -	u16 i;
> -
> -	nr_vectors = hweight64(mask);
> -	nr_pred = hweight32(pred_mask);
> +	u16 nr_vectors = hweight64(mask);
> +	u16 nr_pred = hweight32(pred_mask);
>  
>  	perf_output_put(handle, nr_vectors);
>  	perf_output_put(handle, vec_qwords);
> @@ -7793,21 +7796,17 @@ perf_output_sample_simd_regs(struct perf
>  	perf_output_put(handle, pred_qwords);
>  
>  	if (nr_vectors) {
> -		for (bit = 0; bit < sizeof(mask) * BITS_PER_BYTE; bit++) {
> -			if (!(BIT_ULL(bit) & mask))
> -				continue;
> -			for (i = 0; i < vec_qwords; i++) {
> -				val = perf_simd_reg_value(regs, bit, i, false);
> +		word_for_each_set_bit(bit, mask) {
> +			for (int i = 0; i < vec_qwords; i++) {
> +				u64 val = perf_simd_reg_value(regs, bit, i, false);
>  				perf_output_put(handle, val);
>  			}
>  		}
>  	}
>  	if (nr_pred) {
> -		for (bit = 0; bit < sizeof(pred_mask) * BITS_PER_BYTE; bit++) {
> -			if (!(BIT(bit) & pred_mask))
> -				continue;
> -			for (i = 0; i < pred_qwords; i++) {
> -				val = perf_simd_reg_value(regs, bit, i, true);
> +		word_for_each_set_bit(bit, pred_mask) {
> +			for (int i = 0; i < pred_qwords; i++) {
> +				u64 val = perf_simd_reg_value(regs, bit, i, true);
>  				perf_output_put(handle, val);
>  			}
>  		}
