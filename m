Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853F44756AE;
	Wed,  2 Sep 2026 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351229; cv=none; b=mxtMnXV24BHfcmqc1uX/L1fIwUMXnW/kztnu8tZn4C8uz8Mdg3uddsryT2M2w8gBapCWHnOqQ/Kag+GvG5nKCFh8uBn66s9TDu3LHk2E0i0l2Et2uomfeqYHUtCgXYQ2/wp3MsKKCcgDWr67pYlEoFniFY0eTFlrO2j0ozTovaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351229; c=relaxed/simple;
	bh=T87Tavca9VA6N5fmjyP0dF7ikgSh9YULnBg7srZwEEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O/MgqAY6X7nH+tCvtCkAjR/4/FErlYR+SJ0lrfKC1QnO4K6I1QqdAILe/tH7V0SUOOmL6+xyYpEj/IO+2p03NyKqZieXdqP7kGWe8ed3gBWwEML5+0G+k7AivWgTFImCm4Pivgs8B/41GvoIxHeyUEqwwwW3p8ZL7cxF0YysnHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsMET0Xx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsMET0Xx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788351226; x=1819887226;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T87Tavca9VA6N5fmjyP0dF7ikgSh9YULnBg7srZwEEA=;
  b=TsMET0XxAieWHzTNbb+//BqtIvFmA4CnAcKn7zfNMBvnu03nCqXmzIo5
   HXxlTWw3yEXWYo5S4vEiaNgPB063CUt7yTjoPa2RyPpCl7u0SMrGxs2jt
   3acFQ5aOzvJ4j/pvkNmzRI02QcdJbyuzSRtNwvQpHBtrX9ryWfCVyt/4i
   hTPkEcKja2a5evF2iJy/LQqDfuXupf7GOO0sgxJdqdK9X7f35jg1aY0yq
   hfPL+4pnQ7eGgx3rRbwTocwqU8dV0NGMxpneTSRVLRIdsr+yTABl4iyLh
   0oqKbxDIPcc7sNMQhwmY+MxDdynG/4sQHLfTVbD+uXehG8EG1IyTHA8of
   g==;
X-CSE-ConnectionGUID: PN5rlWaDRO6GM73/WjMZwA==
X-CSE-MsgGUID: 362r6eqsR7qtd0HiXBO13g==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="99403875"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="99403875"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 05:13:44 -0700
X-CSE-ConnectionGUID: DANYDSa3Qwq1nMMFU3AZ2Q==
X-CSE-MsgGUID: Q4GGGdZJTROqoGWjJ0KGBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="273149375"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 05:13:39 -0700
Message-ID: <a4730a2e-c45b-4d3a-93e8-6a841829be8d@linux.intel.com>
Date: Wed, 2 Sep 2026 20:13:36 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND Patch v10 00/23] Support SIMD/eGPRs/SSP registers
 sampling for perf
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
 Xudong Hao <xudong.hao@intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <e80b6588-1ac7-48df-a8f1-8305cffcd14a@linux.intel.com>
 <20260902115658.GK4121339@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260902115658.GK4121339@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/2/2026 7:56 PM, Peter Zijlstra wrote:
> On Tue, Sep 01, 2026 at 04:55:27PM +0800, Mi, Dapeng wrote:
>> Hi Peter,
>>
>> Kindly ping ... Not sure if you have bandwidth to review this patch series? 
>>
>> Currently all review comments are addressed and finally Sashiko can't find
>> issues. :)
> Ok, so I started going through things and the only bit I've found so far
> is that I'm not sure about the below bits.
>
> Is that really something we want to expose as UAPI? It seems to me
> userspace that is interested in SIMD stuff knows this stuff already.

Thanks for reviewing. :)

I ever tried to remove these macros from this UAPI header, but it seems
this is still the best place as below two reasons.

1. These SIMD register number and qword length are shared by both kernel
and user space. If they are not exposed to user space, user space still
needs to define them.

2. In kernel, these macros are used by the files
arch/x86/kernel/perf_regs.c and arch/x86/events/perf_event.h, it seems
arch/x86/include/uapi/asm/perf_regs.h is the best place to define these
macros just like the normal GPR macros.


>
> Anyway, let me continue looking.
>
>
> ---
> diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
> index 7c9d2bb3833b..faaa82df688d 100644
> --- a/arch/x86/include/uapi/asm/perf_regs.h
> +++ b/arch/x86/include/uapi/asm/perf_regs.h
> @@ -2,6 +2,8 @@
>  #ifndef _ASM_X86_PERF_REGS_H
>  #define _ASM_X86_PERF_REGS_H
>  
> +#include <linux/bits.h>
> +
>  enum perf_event_x86_regs {
>  	PERF_REG_X86_AX,
>  	PERF_REG_X86_BX,
> @@ -54,5 +82,30 @@ enum perf_event_x86_regs {
>  };
>  
>  #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
> +#define PERF_X86_EGPRS_MASK	__GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16)
> +
> +enum {
> +	PERF_X86_SIMD_XMM_REGS      = 16,
> +	PERF_X86_SIMD_YMM_REGS      = 16,
> +	PERF_X86_SIMD_ZMM_REGS      = 32,
> +	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_ZMM_REGS,
> +
> +	PERF_X86_SIMD_OPMASK_REGS   = 8,
> +	PERF_X86_SIMD_PRED_REGS_MAX = PERF_X86_SIMD_OPMASK_REGS,
> +};
> +
> +#define PERF_X86_SIMD_PRED_MASK	__GENMASK(PERF_X86_SIMD_PRED_REGS_MAX - 1, 0)
> +#define PERF_X86_SIMD_VEC_MASK	__GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
> +
> +#define PERF_X86_H16ZMM_BASE		16
> +
> +enum {
> +	/* 1 qword = 8 bytes */
> +	PERF_X86_OPMASK_QWORDS   = 1,
> +	PERF_X86_XMM_QWORDS      = 2,
> +	PERF_X86_YMM_QWORDS      = 4,
> +	PERF_X86_ZMM_QWORDS      = 8,
> +	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_ZMM_QWORDS,
> +};
>  
>  #endif /* _ASM_X86_PERF_REGS_H */
