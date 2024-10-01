Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172DF1C6F70;
	Tue,  1 Oct 2024 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798618; cv=none; b=R6fbjpSRl5GT0ySbGS6DDJ7mi0p+BDTLM38sz28KN8CtheJjxvAEaSgIg1uHHUnF/dnSt+FemFRZSUsYBox/ZUkm61fwmOxYphTnpOZj9ovqv6OJL2VsDegv5HmP1mBPQmXQWCSvS/xVzWJHiX55jSsZ+piuJEe9Ux5y7Pea/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798618; c=relaxed/simple;
	bh=jHe0vPY/4o7nGUS9zh3N3Oe1gm7muj2TCK/zgtKYUxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhAmM0tZnhmSW5RDy/54qAW4gF92oAikZlvDYc56CEjiCo9urKoYzS+cTm4qz4loH6FoTPFdhMk7TSv6cltZSq/O7olVI4Pn52N3Afr90zcQHL2/ZEUWerK1g5YCsHtkqTOzT0dJ8Q95fAWhmvVEUj8ok92RTiHpbRcPT3qaWu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JVqL2jxh; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JVqL2jxh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727798616; x=1759334616;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jHe0vPY/4o7nGUS9zh3N3Oe1gm7muj2TCK/zgtKYUxk=;
  b=JVqL2jxhnA2UrnlgDsm6/J62ueZX5OFSWPdSp3JclHzld2x6UsscuBVu
   pICmK/fbMCxIXdeJHy0uGXdMw9XXM19ztQj3NZ1oGDPj3DnxQNA4QntC/
   YQ/pSgdhdZOWkjYAt121G8tYQPnARMo72n59UFSJCQ7wAzoYIRsjzV75B
   Ak388ju2f5UvXfRC2QECHXq05ONAlP/gppoYagTUFJnXnknCqjcnugmiF
   Ch7eSU+tbdZO5UzSPr7Pm0mmLjY2x+KMO2L1HxdbfyG2c11fUE/wB5Wlr
   2BjEpVMc0lUJl1GlEfEJpOrPXtwfzeQhPGhOs5OGLZIUO81ygwJjz8E/a
   w==;
X-CSE-ConnectionGUID: vHQMLAyVSA2+hlZH2CqIvQ==
X-CSE-MsgGUID: 1JShg39eRDeHxz8LGy+wAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="44467716"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="44467716"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 09:03:34 -0700
X-CSE-ConnectionGUID: 98GIaonZR3eI5Q3bqj5NNw==
X-CSE-MsgGUID: oC+5ar3eTqWw8QeGTx9MFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="73691314"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 09:03:33 -0700
Received: from [10.212.71.24] (kliang2-mobl1.ccr.corp.intel.com [10.212.71.24])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 485B820B8DDA;
	Tue,  1 Oct 2024 09:03:31 -0700 (PDT)
Message-ID: <489f89cd-ce61-4d40-84b0-755a1da4249c@linux.intel.com>
Date: Tue, 1 Oct 2024 12:03:29 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] perf tools: Move x86__is_amd_cpu() to util/env.c
To: Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, Mark Rutland <mark.rutland@arm.com>,
 James Clark <james.clark@arm.com>, Kajol Jain <kjain@linux.ibm.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Atish Patra <atishp@atishpatra.org>,
 Palmer Dabbelt <palmer@rivosinc.com>, Mingwei Zhang <mizhang@google.com>
References: <20241001002027.1272889-1-namhyung@kernel.org>
 <20241001002027.1272889-7-namhyung@kernel.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20241001002027.1272889-7-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-30 8:20 p.m., Namhyung Kim wrote:
> It can be called from non-x86 platform so let's move it to the general
> util directory.  Also add a new helper perf_env__is_x86_amd_cpu() so
> that it can be called with an existing perf_env as well.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/arch/x86/util/Build |  1 -
>  tools/perf/arch/x86/util/env.c | 19 -------------------
>  tools/perf/arch/x86/util/env.h |  7 -------
>  tools/perf/arch/x86/util/pmu.c |  2 +-
>  tools/perf/util/env.c          | 24 ++++++++++++++++++++++++
>  tools/perf/util/env.h          |  4 ++++
>  6 files changed, 29 insertions(+), 28 deletions(-)
>  delete mode 100644 tools/perf/arch/x86/util/env.c
>  delete mode 100644 tools/perf/arch/x86/util/env.h
> 
> diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
> index 2607ed5c42966543..ce6d802a1381c5ab 100644
> --- a/tools/perf/arch/x86/util/Build
> +++ b/tools/perf/arch/x86/util/Build
> @@ -10,7 +10,6 @@ perf-util-y += evlist.o
>  perf-util-y += mem-events.o
>  perf-util-y += evsel.o
>  perf-util-y += iostat.o
> -perf-util-y += env.o
>  
>  perf-util-$(CONFIG_DWARF) += dwarf-regs.o
>  perf-util-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
> diff --git a/tools/perf/arch/x86/util/env.c b/tools/perf/arch/x86/util/env.c
> deleted file mode 100644
> index 3e537ffb1353aab2..0000000000000000
> --- a/tools/perf/arch/x86/util/env.c
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include "linux/string.h"
> -#include "util/env.h"
> -#include "env.h"
> -
> -bool x86__is_amd_cpu(void)
> -{
> -	struct perf_env env = { .total_mem = 0, };
> -	static int is_amd; /* 0: Uninitialized, 1: Yes, -1: No */
> -
> -	if (is_amd)
> -		goto ret;
> -
> -	perf_env__cpuid(&env);
> -	is_amd = env.cpuid && strstarts(env.cpuid, "AuthenticAMD") ? 1 : -1;
> -	perf_env__exit(&env);
> -ret:
> -	return is_amd >= 1 ? true : false;
> -}
> diff --git a/tools/perf/arch/x86/util/env.h b/tools/perf/arch/x86/util/env.h
> deleted file mode 100644
> index d78f080b6b3f889a..0000000000000000
> --- a/tools/perf/arch/x86/util/env.h
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _X86_ENV_H
> -#define _X86_ENV_H
> -
> -bool x86__is_amd_cpu(void);
> -
> -#endif /* _X86_ENV_H */
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> index c3d89d6ba1bf03ad..e0060dac2a9f9242 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -16,7 +16,7 @@
>  #include "../../../util/fncache.h"
>  #include "../../../util/pmus.h"
>  #include "mem-events.h"
> -#include "env.h"
> +#include "util/env.h"
>  
>  void perf_pmu__arch_init(struct perf_pmu *pmu __maybe_unused)
>  {
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 1edbccfc3281d2b1..470a0156e0722e4e 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -5,6 +5,7 @@
>  #include "util/header.h"
>  #include "linux/compiler.h"
>  #include <linux/ctype.h>
> +#include <linux/string.h>
>  #include <linux/zalloc.h>
>  #include "cgroup.h"
>  #include <errno.h>
> @@ -625,6 +626,7 @@ char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
>  	return NULL;
>  }
>  
> +

Useless empty line.

Thanks,
Kan
>  void perf_env__find_br_cntr_info(struct perf_env *env,
>  				 unsigned int *nr,
>  				 unsigned int *width)
> @@ -639,3 +641,25 @@ void perf_env__find_br_cntr_info(struct perf_env *env,
>  					     env->pmu_caps->br_cntr_width;
>  	}
>  }
> +
> +bool perf_env__is_x86_amd_cpu(struct perf_env *env)
> +{
> +	static int is_amd; /* 0: Uninitialized, 1: Yes, -1: No */
> +
> +	if (is_amd == 0)
> +		is_amd = env->cpuid && strstarts(env->cpuid, "AuthenticAMD") ? 1 : -1;
> +
> +	return is_amd >= 1 ? true : false;
> +}
> +
> +bool x86__is_amd_cpu(void)
> +{
> +	struct perf_env env = { .total_mem = 0, };
> +	bool is_amd;
> +
> +	perf_env__cpuid(&env);
> +	is_amd = perf_env__is_x86_amd_cpu(&env);
> +	perf_env__exit(&env);
> +
> +	return is_amd;
> +}
> diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
> index 51b36c36019be666..ae604c4edbb7eb44 100644
> --- a/tools/perf/util/env.h
> +++ b/tools/perf/util/env.h
> @@ -195,4 +195,8 @@ bool perf_env__has_pmu_mapping(struct perf_env *env, const char *pmu_name);
>  void perf_env__find_br_cntr_info(struct perf_env *env,
>  				 unsigned int *nr,
>  				 unsigned int *width);
> +
> +bool x86__is_amd_cpu(void);
> +bool perf_env__is_x86_amd_cpu(struct perf_env *env);
> +
>  #endif /* __PERF_ENV_H */
