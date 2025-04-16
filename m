Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C661DB34E;
	Wed, 16 Apr 2025 06:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785740; cv=none; b=sx6cp06BQbCxCuK/riUBklYQaJSlRxf2YIrnBd9WsN9wwrjFMbEZFFR6t69RtlHkDpYuMOATDUjv9x14q1ZqFzmfUcDC23q/32mS8mMgenbMMTOvwlulNHaE/fj6rEu9JfjGvEZbtPdH745fxiD2MobUeSMilu/cYD9CjnqUXSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785740; c=relaxed/simple;
	bh=GRVp9P917blqRbz/a0s5zO5oAzopvzG7tEqL7bBBXNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JP0jJg4lwqLPqotyKqfsMVIPcA3vGddaOnbznUhTzDv/8sNI0mH9lZ4+naSsi1dGIoxJzyI6tZUYT2MZ3KjOk0tOTvsiow5D/gub0yEpa9erz9THwfSCTd7aiLPleDiAHoYtrrlRYB2QneZ2iTiMOKyFlRP1lORv9qD1HUGHaiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n5qnUNED; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n5qnUNED"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744785739; x=1776321739;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GRVp9P917blqRbz/a0s5zO5oAzopvzG7tEqL7bBBXNw=;
  b=n5qnUNEDa4Skfakcwx+6Qtd2Xy4cj5vxBr5RvQKS8R01PnefIp+5Imkc
   sCGNL6u/0LiW2s+pv33VioIHw7d63hrHwExVeylFhUNtOKswa2moD9hzx
   FaSM5K9MiH04aaXaIojUMPmmegqBfq0Ka7KknjD+n6dya4ng3yGtusSI3
   yqf5YUN2F6dN0LTYxRPmED1jHb+eHuby3DW//yYODYPujIw72qT/7e7S/
   4hSNnfvU/KH6U6prTBbd3tglCZJIQouoWbyz2pON3i/8FWBDN597f0ycg
   bhARgAlIBulCN92KeWOSjtJJjdry3ESM3vc7EaVyygwupkuPoCS0haq/0
   g==;
X-CSE-ConnectionGUID: NNqFPBzrS+uP65tdyhuylA==
X-CSE-MsgGUID: FjedKStjS+Cl/pSSIWsVAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46334163"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="46334163"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 23:42:18 -0700
X-CSE-ConnectionGUID: koED1CSRSeS12ubHm/DcqA==
X-CSE-MsgGUID: Qu+1IbnFQ6yen9OroQkKIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="153566334"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 23:42:15 -0700
Message-ID: <26799b7e-c3a6-4de2-afd1-7bda0639fa37@linux.intel.com>
Date: Wed, 16 Apr 2025 14:42:12 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 16/22] perf/core: Support to capture higher width
 vector registers
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
 <20250415114428.341182-17-dapeng1.mi@linux.intel.com>
 <20250415143626.GF4031@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250415143626.GF4031@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/15/2025 10:36 PM, Peter Zijlstra wrote:
> On Tue, Apr 15, 2025 at 11:44:22AM +0000, Dapeng Mi wrote:
>>  extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
>> diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
>> index f9c5b16b1882..5e2d9796b2cc 100644
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
>> @@ -53,6 +53,83 @@ enum perf_event_x86_regs {
>>  
>>  	/* These include both GPRs and XMMX registers */
>>  	PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
>> +
>> +	/* Leave bits[127:64] for other GP registers, like R16 ~ R31.*/
>> +
>> +	/*
>> +	 * Each YMM register need 4 bits to represent because they are 256 bits.
>> +	 * PERF_REG_X86_YMMH0 = 128
>> +	 */
>> +	PERF_REG_X86_YMM0	= 128,
>> +	PERF_REG_X86_YMM1	= PERF_REG_X86_YMM0 + 4,
>> +	PERF_REG_X86_YMM2	= PERF_REG_X86_YMM1 + 4,
>> +	PERF_REG_X86_YMM3	= PERF_REG_X86_YMM2 + 4,
>> +	PERF_REG_X86_YMM4	= PERF_REG_X86_YMM3 + 4,
>> +	PERF_REG_X86_YMM5	= PERF_REG_X86_YMM4 + 4,
>> +	PERF_REG_X86_YMM6	= PERF_REG_X86_YMM5 + 4,
>> +	PERF_REG_X86_YMM7	= PERF_REG_X86_YMM6 + 4,
>> +	PERF_REG_X86_YMM8	= PERF_REG_X86_YMM7 + 4,
>> +	PERF_REG_X86_YMM9	= PERF_REG_X86_YMM8 + 4,
>> +	PERF_REG_X86_YMM10	= PERF_REG_X86_YMM9 + 4,
>> +	PERF_REG_X86_YMM11	= PERF_REG_X86_YMM10 + 4,
>> +	PERF_REG_X86_YMM12	= PERF_REG_X86_YMM11 + 4,
>> +	PERF_REG_X86_YMM13	= PERF_REG_X86_YMM12 + 4,
>> +	PERF_REG_X86_YMM14	= PERF_REG_X86_YMM13 + 4,
>> +	PERF_REG_X86_YMM15	= PERF_REG_X86_YMM14 + 4,
>> +	PERF_REG_X86_YMM_MAX	= PERF_REG_X86_YMM15 + 4,
>> +
>> +	/*
>> +	 * Each ZMM register needs 8 bits to represent because they are 512 bits
>> +	 * PERF_REG_X86_ZMMH0 = 192
>> +	 */
>> +	PERF_REG_X86_ZMM0	= PERF_REG_X86_YMM_MAX,
>> +	PERF_REG_X86_ZMM1	= PERF_REG_X86_ZMM0 + 8,
>> +	PERF_REG_X86_ZMM2	= PERF_REG_X86_ZMM1 + 8,
>> +	PERF_REG_X86_ZMM3	= PERF_REG_X86_ZMM2 + 8,
>> +	PERF_REG_X86_ZMM4	= PERF_REG_X86_ZMM3 + 8,
>> +	PERF_REG_X86_ZMM5	= PERF_REG_X86_ZMM4 + 8,
>> +	PERF_REG_X86_ZMM6	= PERF_REG_X86_ZMM5 + 8,
>> +	PERF_REG_X86_ZMM7	= PERF_REG_X86_ZMM6 + 8,
>> +	PERF_REG_X86_ZMM8	= PERF_REG_X86_ZMM7 + 8,
>> +	PERF_REG_X86_ZMM9	= PERF_REG_X86_ZMM8 + 8,
>> +	PERF_REG_X86_ZMM10	= PERF_REG_X86_ZMM9 + 8,
>> +	PERF_REG_X86_ZMM11	= PERF_REG_X86_ZMM10 + 8,
>> +	PERF_REG_X86_ZMM12	= PERF_REG_X86_ZMM11 + 8,
>> +	PERF_REG_X86_ZMM13	= PERF_REG_X86_ZMM12 + 8,
>> +	PERF_REG_X86_ZMM14	= PERF_REG_X86_ZMM13 + 8,
>> +	PERF_REG_X86_ZMM15	= PERF_REG_X86_ZMM14 + 8,
>> +	PERF_REG_X86_ZMM16	= PERF_REG_X86_ZMM15 + 8,
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
>> +	 * PERF_REG_X86_OPMASK0 = 448
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
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index 5fc753c23734..78aae0464a54 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -379,6 +379,10 @@ enum perf_event_read_format {
>>  #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
>>  #define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
>>  #define PERF_ATTR_SIZE_VER8	136	/* add: config3 */
>> +#define PERF_ATTR_SIZE_VER9	168	/* add: sample_regs_intr_ext[PERF_EXT_REGS_ARRAY_SIZE] */
>> +
>> +#define PERF_EXT_REGS_ARRAY_SIZE	7
>> +#define PERF_NUM_EXT_REGS		(PERF_EXT_REGS_ARRAY_SIZE * 64)
>>  
>>  /*
>>   * Hardware event_id to monitor via a performance monitoring event:
>> @@ -533,6 +537,13 @@ struct perf_event_attr {
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
> I still utterly hate this interface. This is a giant waste of bits.
>
> What makes it even worse is that XMMn is the lower half of YMMn which in
> turn is the lower half of ZMMn.
>
> So by exposing only ZMMn you already expose all of them. The interface
> explicitly allows asking for sub-words.
>
> But most importantly of all, last time I asked if there are users that
> actually care about the whole per-register thing and I don't see an
> answer here.
>
> Can we please find a better interface? Ideally one that scales up to
> 1024 and 2048 bit vector width, because I'd hate to have to rev this
> again.
>
> Perhaps add sample_vec_regs_*[] with a saner format, and if that is !0
> then the XMM regs dissapear from sample_regs_*[] and we get to use that
> space to extended GPs.

Just think twice, using bitmap to represent these extended registers indeed
wastes bits and is hard to extend, there could be much much more vector
registers if considering AMX.

Considering different arch/HW may support different number vector register,
like platform A supports 8 XMM registers and 8 YMM registers, but platform
B only supports 16 XMM registers, a better way to represent these vector
registers may add two fields, one is a bitmap which represents which kinds
of vector registers needs to be captures. The other field could be a u16
array which represents the corresponding register length of each kind of
vector register. It may look like this.

#define    PERF_SAMPLE_EXT_REGS_XMM    BIT(0)
#define    PERF_SAMPLE_EXT_REGS_YMM    BIT(1)
#define    PERF_SAMPLE_EXT_REGS_ZMM    BIT(2)
    __u32    sample_regs_intr_ext;
    __u16    sample_regs_intr_ext_len[4];
    __u32    sample_regs_user_ext;

    __u16    sample_regs_user_ext_len[4];


Peter, how do you think this? Thanks.


