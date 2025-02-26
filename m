Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213DF1E1E00;
	Wed, 26 Feb 2025 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556538; cv=none; b=QFEVfYtu2tihLTsXf1KNYaw6Qc6eY6XGledI+nhG6AnL7xqHrS/mhs5/JpJPyZ3ODPGXpThKVHqJJZc/EDCtAwvOUqXnT4vbc5iB09p74rQQFb944jgm+i28sx3WcxvHPAVEdo1xlx9flRd207FAsGGjuAWS9WxSGaHNADZnzro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556538; c=relaxed/simple;
	bh=/YceScPPQMvHiNJjr+5pdUHJJ20GDGgy99xO79TB4oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RR8gawAdCrtqGtlSr63cP2jap+csA+VkvvWWVrLoqABxSwgv44Oa6hOJbX+XFOiRrCvOJ6rbTVUN5d5mzdN7pU8hC7BAA3q8Rr3pQDKcICc0XVq+QrAMgmmtXe8V3ynFzz4YV8tubJ3vwwwibrjBIqoM39wVofvVqgvHQ8AphLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qd8gPi7k; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qd8gPi7k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740556537; x=1772092537;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/YceScPPQMvHiNJjr+5pdUHJJ20GDGgy99xO79TB4oo=;
  b=Qd8gPi7kOhI6cQ5xgVHRxWU9dMjrGBvBmvfNt6b2DE5RNuFuOFmw4tQs
   p5eeTxLiZTZIGfJRiOCpK2o3piN0D6TtA11gwVZhbXpngkGM5ALthIUsP
   W1yHycm8fJErnrt76mNGqn8kHZBuD2c7lwusPazpgsdwibc5HBB2HTYqM
   n0kLnOyp3rF1hdz7InQwU1CBky/nNWYtCPSwVveBHs4g0SyFo5hCHyG0C
   m8H1FUiHj5WEQ3OFf9STGeNY3KTjkG1NjtKuJ5Y7XSj3bledjzRIgZsV+
   st6JvL2b8GoEv7ojECuVqBHHNYVDm30hVYDm4xO7I58za+6n1ns1tVYyP
   A==;
X-CSE-ConnectionGUID: Gw7Wq4mpTVaJFTcxvkhJhw==
X-CSE-MsgGUID: PogOqnqRT1KYDNY2CLsaiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41644266"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="41644266"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 23:55:36 -0800
X-CSE-ConnectionGUID: 3cJ6f5llTW6EhFWJIkmLsA==
X-CSE-MsgGUID: 03D8LZSzQbWr9l417L5DIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="116825690"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 23:55:33 -0800
Message-ID: <b92f8e0b-7dc1-49a2-89e1-c47c0ecc1d89@linux.intel.com>
Date: Wed, 26 Feb 2025 15:55:30 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 17/24] perf/core: Support to capture higher width
 vector registers
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-18-dapeng1.mi@linux.intel.com>
 <20250225203224.GB1278@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250225203224.GB1278@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/26/2025 4:32 AM, Peter Zijlstra wrote:
> On Tue, Feb 18, 2025 at 03:28:11PM +0000, Dapeng Mi wrote:
>> diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
>> index 9ee9e55aed09..3851f627ca60 100644
>> --- a/arch/x86/include/uapi/asm/perf_regs.h
>> +++ b/arch/x86/include/uapi/asm/perf_regs.h
>> @@ -33,7 +33,7 @@ enum perf_event_x86_regs {
>>  	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
>>  	PERF_REG_X86_64_MAX = PERF_REG_X86_SSP + 1,
>>  
>> -	/* These all need two bits set because they are 128bit */
>> +	/* These all need two bits set because they are 128 bits */
>>  	PERF_REG_X86_XMM0  = 32,
>>  	PERF_REG_X86_XMM1  = 34,
>>  	PERF_REG_X86_XMM2  = 36,
>> @@ -53,6 +53,87 @@ enum perf_event_x86_regs {
>>  
>>  	/* These include both GPRs and XMMX registers */
>>  	PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
>> +
>> +	/*
>> +	 * YMM upper bits need two bits set because they are 128 bits.
>> +	 * PERF_REG_X86_YMMH0 = 64
>> +	 */
>> +	PERF_REG_X86_YMMH0	= PERF_REG_X86_XMM_MAX,
>> +	PERF_REG_X86_YMMH1	= PERF_REG_X86_YMMH0 + 2,
>> +	PERF_REG_X86_YMMH2	= PERF_REG_X86_YMMH1 + 2,
>> +	PERF_REG_X86_YMMH3	= PERF_REG_X86_YMMH2 + 2,
>> +	PERF_REG_X86_YMMH4	= PERF_REG_X86_YMMH3 + 2,
>> +	PERF_REG_X86_YMMH5	= PERF_REG_X86_YMMH4 + 2,
>> +	PERF_REG_X86_YMMH6	= PERF_REG_X86_YMMH5 + 2,
>> +	PERF_REG_X86_YMMH7	= PERF_REG_X86_YMMH6 + 2,
>> +	PERF_REG_X86_YMMH8	= PERF_REG_X86_YMMH7 + 2,
>> +	PERF_REG_X86_YMMH9	= PERF_REG_X86_YMMH8 + 2,
>> +	PERF_REG_X86_YMMH10	= PERF_REG_X86_YMMH9 + 2,
>> +	PERF_REG_X86_YMMH11	= PERF_REG_X86_YMMH10 + 2,
>> +	PERF_REG_X86_YMMH12	= PERF_REG_X86_YMMH11 + 2,
>> +	PERF_REG_X86_YMMH13	= PERF_REG_X86_YMMH12 + 2,
>> +	PERF_REG_X86_YMMH14	= PERF_REG_X86_YMMH13 + 2,
>> +	PERF_REG_X86_YMMH15	= PERF_REG_X86_YMMH14 + 2,
>> +	PERF_REG_X86_YMMH_MAX	= PERF_REG_X86_YMMH15 + 2,
>> +
>> +	/*
>> +	 * ZMM0-15 upper bits need four bits set because they are 256 bits
>> +	 * PERF_REG_X86_ZMMH0 = 96
>> +	 */
>> +	PERF_REG_X86_ZMMH0	= PERF_REG_X86_YMMH_MAX,
>> +	PERF_REG_X86_ZMMH1	= PERF_REG_X86_ZMMH0 + 4,
>> +	PERF_REG_X86_ZMMH2	= PERF_REG_X86_ZMMH1 + 4,
>> +	PERF_REG_X86_ZMMH3	= PERF_REG_X86_ZMMH2 + 4,
>> +	PERF_REG_X86_ZMMH4	= PERF_REG_X86_ZMMH3 + 4,
>> +	PERF_REG_X86_ZMMH5	= PERF_REG_X86_ZMMH4 + 4,
>> +	PERF_REG_X86_ZMMH6	= PERF_REG_X86_ZMMH5 + 4,
>> +	PERF_REG_X86_ZMMH7	= PERF_REG_X86_ZMMH6 + 4,
>> +	PERF_REG_X86_ZMMH8	= PERF_REG_X86_ZMMH7 + 4,
>> +	PERF_REG_X86_ZMMH9	= PERF_REG_X86_ZMMH8 + 4,
>> +	PERF_REG_X86_ZMMH10	= PERF_REG_X86_ZMMH9 + 4,
>> +	PERF_REG_X86_ZMMH11	= PERF_REG_X86_ZMMH10 + 4,
>> +	PERF_REG_X86_ZMMH12	= PERF_REG_X86_ZMMH11 + 4,
>> +	PERF_REG_X86_ZMMH13	= PERF_REG_X86_ZMMH12 + 4,
>> +	PERF_REG_X86_ZMMH14	= PERF_REG_X86_ZMMH13 + 4,
>> +	PERF_REG_X86_ZMMH15	= PERF_REG_X86_ZMMH14 + 4,
>> +	PERF_REG_X86_ZMMH_MAX	= PERF_REG_X86_ZMMH15 + 4,
>> +
>> +	/*
>> +	 * ZMM16-31 need eight bits set because they are 512 bits
>> +	 * PERF_REG_X86_ZMM16 = 160
>> +	 */
>> +	PERF_REG_X86_ZMM16	= PERF_REG_X86_ZMMH_MAX,
>> +	PERF_REG_X86_ZMM17	= PERF_REG_X86_ZMM16 + 8,
>> +	PERF_REG_X86_ZMM18	= PERF_REG_X86_ZMM17 + 8,
>> +	PERF_REG_X86_ZMM19	= PERF_REG_X86_ZMM18 + 8,
>> +	PERF_REG_X86_ZMM20	= PERF_REG_X86_ZMM19 + 8,
>> +	PERF_REG_X86_ZMM21	= PERF_REG_X86_ZMM20 + 8,
>> +	PERF_REG_X86_ZMM22	= PERF_REG_X86_ZMM21 + 8,
>> +	PERF_REG_X86_ZMM23	= PERF_REG_X86_ZMM22 + 8,
>> +	PERF_REG_X86_ZMM24	= PERF_REG_X86_ZMM23 + 8,
>> +	PERF_REG_X86_ZMM25	= PERF_REG_X86_ZMM24 + 8,
>> +	PERF_REG_X86_ZMM26	= PERF_REG_X86_ZMM25 + 8,
>> +	PERF_REG_X86_ZMM27	= PERF_REG_X86_ZMM26 + 8,
>> +	PERF_REG_X86_ZMM28	= PERF_REG_X86_ZMM27 + 8,
>> +	PERF_REG_X86_ZMM29	= PERF_REG_X86_ZMM28 + 8,
>> +	PERF_REG_X86_ZMM30	= PERF_REG_X86_ZMM29 + 8,
>> +	PERF_REG_X86_ZMM31	= PERF_REG_X86_ZMM30 + 8,
>> +	PERF_REG_X86_ZMM_MAX	= PERF_REG_X86_ZMM31 + 8,
>> +
>> +	/*
>> +	 * OPMASK Registers
>> +	 * PERF_REG_X86_OPMASK0 = 288
>> +	 */
>> +	PERF_REG_X86_OPMASK0	= PERF_REG_X86_ZMM_MAX,
>> +	PERF_REG_X86_OPMASK1	= PERF_REG_X86_OPMASK0 + 1,
>> +	PERF_REG_X86_OPMASK2	= PERF_REG_X86_OPMASK1 + 1,
>> +	PERF_REG_X86_OPMASK3	= PERF_REG_X86_OPMASK2 + 1,
>> +	PERF_REG_X86_OPMASK4	= PERF_REG_X86_OPMASK3 + 1,
>> +	PERF_REG_X86_OPMASK5	= PERF_REG_X86_OPMASK4 + 1,
>> +	PERF_REG_X86_OPMASK6	= PERF_REG_X86_OPMASK5 + 1,
>> +	PERF_REG_X86_OPMASK7	= PERF_REG_X86_OPMASK6 + 1,
>> +
>> +	PERF_REG_X86_VEC_MAX	= PERF_REG_X86_OPMASK7 + 1,
>>  };
>>  
>>  #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index 0524d541d4e3..8a17d696d78c 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -379,6 +379,10 @@ enum perf_event_read_format {
>>  #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
>>  #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
>>  #define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
>> +#define PERF_ATTR_SIZE_VER9	168	/* add: sample_regs_intr_ext[PERF_EXT_REGS_ARRAY_SIZE] */
>> +
>> +#define PERF_EXT_REGS_ARRAY_SIZE	4
>> +#define PERF_NUM_EXT_REGS		(PERF_EXT_REGS_ARRAY_SIZE * 64)
>>  
>>  /*
>>   * Hardware event_id to monitor via a performance monitoring event:
>> @@ -531,6 +535,13 @@ struct perf_event_attr {
>>  	__u64	sig_data;
>>  
>>  	__u64	config3; /* extension of config2 */
>> +
>> +	/*
>> +	 * Extension sets of regs to dump for each sample.
>> +	 * See asm/perf_regs.h for details.
>> +	 */
>> +	__u64	sample_regs_intr_ext[PERF_EXT_REGS_ARRAY_SIZE];
>> +	__u64   sample_regs_user_ext[PERF_EXT_REGS_ARRAY_SIZE];
>>  };
>>  
>>  /*
> *groan*... so do people really need per-register (or even partial
> register) masks for all this?

Yeah, I agree. Users should never read partial registers. But as current
perf tool has already supported to read per-register on XMM registers, not
sure if it would introduce back-compatible issues if we only support read
register group, like XMM, YMM or ZMM group.


>
> Or can we perhaps -- like XSAVE/PEBS -- do it per register group?

If there is no back-compatible issue, I think it should work.


>
> Also, we're going to be getting EGPRs, which I think just about fit in
> this 320 bit mask we now have, but it is quite insane.
>
