Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D8D1DB95E;
	Mon,  8 Dec 2025 06:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765174252; cv=none; b=BlZcUs+WHqUGrUJeehXzdtXST+E+r3dEUAtHLMcb/wCmr6lDAvL7Eh51QVvDTQMynv4prKcwxmeMSaEa98YgzmAuCYU0jfbtf1WnCRSPJgRGIvfAIooyvSSxE+4GuPcTsecuOmqxq/hPaQ3b3eLX71be+J11rND50fGkJeTyLls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765174252; c=relaxed/simple;
	bh=ItJVesisIYmgIOHsDrL4ZMoHgj7n6miST0Kjz1Syg14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aOIx8zMt4tJQjdoAxYxh3vSv4xlDwcP8iNpuEc3lpsmU/fg0O15ovITh0M8sHAu+5d64rEIWJkKRDrXu2GNR3BwH9xIoN2YSkp5qYtnrUtv+WLBDrWIox+AxTexlTClsGx4uvdkQ2HlGwMrBaAokqa2F8ZYgONQjnsSZOSsAa/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEj/4DbA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEj/4DbA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765174252; x=1796710252;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ItJVesisIYmgIOHsDrL4ZMoHgj7n6miST0Kjz1Syg14=;
  b=EEj/4DbAWflUKIv2HVqWHAuyGokZy1gaEUYrBr7czhQ80W6HEkIjYkq7
   FRHN/cbuOrqXAaYg87J+JqYSsgfCSrPQekG8JkUECwRL4fKl3Yy2fJTFu
   hSLdR/q6NyZXv/P41nlXY9YZEHmO4qgoz0IznqyJjDDE3sQ9Z99Vp/6J/
   aosE8fILET+b/xvZ8viuiVy6BO08PVMECIt12PW2z3bC0yRbxrNVbmOG5
   BHpuhlFVD/ZqgQaouPTnUqwdo792TUQHlBTiLytiVzZRQKygSPm8SRm+V
   EUPFns0yhzW3iLJ4FhMp/T2rB7fPLhiyFWEj9zpvVY4YFeoX+OSWEU6Vj
   w==;
X-CSE-ConnectionGUID: vja2KxOtRTW4YPMtfF1Yew==
X-CSE-MsgGUID: dGNqeXcqQ4yYK3rLfS8ROg==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67160280"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="67160280"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 22:10:51 -0800
X-CSE-ConnectionGUID: OpqZbjoqSGy6jxlsYl1Zvw==
X-CSE-MsgGUID: 3hLHdUyQQAmh0tye3JLACg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="196313275"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.12]) ([10.124.240.12])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2025 22:10:45 -0800
Message-ID: <f36e5477-d405-4da0-bdae-f79d496cf465@linux.intel.com>
Date: Mon, 8 Dec 2025 14:10:42 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 08/19] perf/x86: Enable XMM sampling using
 sample_simd_vec_reg_* fields
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
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-9-dapeng1.mi@linux.intel.com>
 <20251205112516.GU2528459@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251205112516.GU2528459@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 12/5/2025 7:25 PM, Peter Zijlstra wrote:
> On Wed, Dec 03, 2025 at 02:54:49PM +0800, Dapeng Mi wrote:
>
>> diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
>> index 7c9d2bb3833b..c3862e5fdd6d 100644
>> --- a/arch/x86/include/uapi/asm/perf_regs.h
>> +++ b/arch/x86/include/uapi/asm/perf_regs.h
>> @@ -55,4 +55,21 @@ enum perf_event_x86_regs {
>>  
>>  #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
>>  
>> +enum {
>> +	PERF_REG_X86_XMM,
>> +	PERF_REG_X86_MAX_SIMD_REGS,
>> +};
>> +
>> +enum {
>> +	PERF_X86_SIMD_XMM_REGS      = 16,
>> +	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_XMM_REGS,
>> +};
>> +
>> +#define PERF_X86_SIMD_VEC_MASK		GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
>> +
>> +enum {
>> +	PERF_X86_XMM_QWORDS      = 2,
>> +	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_XMM_QWORDS,
>> +};
>> +
>>  #endif /* _ASM_X86_PERF_REGS_H */
> I don't understand this bit -- the next few patches add to it for YMM
> and ZMM, but what's the point? I don't see why this is needed at all,
> let alone why it needs to be UABI.

Currently these bits are only used in user space perf tools. Let me remove
it from the header perf_regs.h.


>
