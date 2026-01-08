Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780D4396D1E;
	Thu,  8 Jan 2026 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767859676; cv=none; b=jEoDjAEZ7oVfssokokn9z1iQb1VRRVsgyt+LHkDjliyXRLkNvdkQwBpu23sykiin1iuG2Dxkcvcr+z+taSSjhqzXvEVwIvk1WuDJYGsBYWOSBz2c/j1X0vtuoRz/f84O79m52hofq7LxKitHCUMDmd0r4kYhijzfk2tCxXXYhy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767859676; c=relaxed/simple;
	bh=FA1FqvfnhVoEmzQKmMsaGobaXtY5ks01xM+NgwFA5hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SddbB4P9qFHW001Zle217Mj27jniPk4Zkss4zONFXeDUEApJOd1OglvPesheZJrhGvpWqo6FBYvx2cDouFLrTnVEHv/sorjx+GHgS2xyDV/lqspC1YcQJ8na2Yhu8xJYIO/v+GWOmuPKdSkpjDwtRmZxNBAP+2YND4b/BiEq40M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=imVGC25+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="imVGC25+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767859668; x=1799395668;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FA1FqvfnhVoEmzQKmMsaGobaXtY5ks01xM+NgwFA5hk=;
  b=imVGC25+308BWLUzyZEfQy0JDstpkf0zQMgKbqjZJdNmyns/lnvoIFyR
   zZQAZxVX5LdPFRnbDaO+vb3gMTwqpF8NR7HqR2XyIiR+pU7xQwFzizW+Z
   goj8MXtWlClNhUet5ZtsT/ypjcBJ+NP1i4zpkdMbwlnMc/QBDpKO8dsZ9
   FbJCJr1UmJTKpQY7mV/FB4sbdKYWbBIV8nauXKdsehcbeBMGBLxg6k/K7
   OU847S6IhFgpqyjElTBxxsBPEDEcG0GMto/aczKo49RpnKayR4A6MFDrl
   VcD0CRu0ugPpJtYe9RsVkxlQjUc1DJZPjAReiziBgMiGZmi2WnNjEh8u0
   A==;
X-CSE-ConnectionGUID: hV1jL3MrQMyGBFgAUhqlvQ==
X-CSE-MsgGUID: emUeVIh2QP6TLq9LNgK9nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="73082410"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="73082410"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:07:39 -0800
X-CSE-ConnectionGUID: PPUETjq6RjC/JGniApqYdw==
X-CSE-MsgGUID: t1qu5xbHQqmxLyGWoZH+rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="203581559"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:07:35 -0800
Message-ID: <42bcaa57-bab3-457f-83cc-d908303090f2@linux.intel.com>
Date: Thu, 8 Jan 2026 16:07:33 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] LoongArch: Fix PMU counter allocation for mixed-type
 event groups
To: Lisa Robinson <lisa@bytefly.space>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Huacai Chen <chenhuacai@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, WANG Xuerui <kernel@xen0n.name>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev
References: <20260104162304.64604-1-lisa@bytefly.space>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260104162304.64604-1-lisa@bytefly.space>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/5/2026 12:23 AM, Lisa Robinson wrote:
> When validating a perf event group, validate_group() unconditionally
> attempts to allocate hardware PMU counters for the leader, sibling
> events and the new event being added.
>
> This is incorrect for mixed-type groups. If a PERF_TYPE_SOFTWARE event
> ispart of the group, the current code still tries to allocate a hardware

ispart -> "is part"


> PMU counter for it, which can wrongly consume hardware PMU resources and
> cause spurious allocation failures.
>
> Fix this by only allocating PMU counters for hardware events during group
> validation, and skipping software events.
>
> A trimmed down reproducer is as simple as this:
>
>   #include <stdio.h>
>   #include <assert.h>
>   #include <unistd.h>
>   #include <string.h>
>   #include <sys/syscall.h>
>   #include <linux/perf_event.h>
>
>   int
>   main (int argc, char *argv[])
>   {
>   	struct perf_event_attr attr = { 0 };
>   	int fds[5];
>
>   	attr.disabled = 1;
>   	attr.exclude_kernel = 1;
>   	attr.exclude_hv = 1;
>   	attr.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
>   		PERF_FORMAT_TOTAL_TIME_RUNNING | PERF_FORMAT_ID | PERF_FORMAT_GROUP;
>   	attr.size = sizeof (attr);
>
>   	attr.type = PERF_TYPE_SOFTWARE;
>   	attr.config = PERF_COUNT_SW_DUMMY;
>   	fds[0] = syscall (SYS_perf_event_open, &attr, 0, -1, -1, 0);
>   	assert (fds[0] >= 0);
>
>   	attr.type = PERF_TYPE_HARDWARE;
>   	attr.config = PERF_COUNT_HW_CPU_CYCLES;
>   	fds[1] = syscall (SYS_perf_event_open, &attr, 0, -1, fds[0], 0);
>   	assert (fds[1] >= 0);
>
>   	attr.type = PERF_TYPE_HARDWARE;
>   	attr.config = PERF_COUNT_HW_INSTRUCTIONS;
>   	fds[2] = syscall (SYS_perf_event_open, &attr, 0, -1, fds[0], 0);
>   	assert (fds[2] >= 0);
>
>   	attr.type = PERF_TYPE_HARDWARE;
>   	attr.config = PERF_COUNT_HW_BRANCH_MISSES;
>   	fds[3] = syscall (SYS_perf_event_open, &attr, 0, -1, fds[0], 0);
>   	assert (fds[3] >= 0);
>
>   	attr.type = PERF_TYPE_HARDWARE;
>   	attr.config = PERF_COUNT_HW_CACHE_REFERENCES;
>   	fds[4] = syscall (SYS_perf_event_open, &attr, 0, -1, fds[0], 0);
>   	assert (fds[4] >= 0);
>
>   	printf ("PASSED\n");
>
>   	return 0;
>   }
>
> Fixes: b37042b2bb7c ("LoongArch: Add perf events support")
> Signed-off-by: Lisa Robinson <lisa@bytefly.space>
> ---
> Changes in v2:
> - Factor out duplicated perf event type checks into an inline helper.
> ---
>  arch/loongarch/kernel/perf_event.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/arch/loongarch/kernel/perf_event.c b/arch/loongarch/kernel/perf_event.c
> index 9d257c8519c9..e34a6fb33e11 100644
> --- a/arch/loongarch/kernel/perf_event.c
> +++ b/arch/loongarch/kernel/perf_event.c
> @@ -626,6 +626,18 @@ static const struct loongarch_perf_event *loongarch_pmu_map_cache_event(u64 conf
>  	return pev;
>  }
>  
> +static inline bool loongarch_pmu_event_requires_counter(const struct perf_event *event)
> +{
> +	switch (event->attr.type) {
> +	case PERF_TYPE_HARDWARE:
> +	case PERF_TYPE_HW_CACHE:
> +	case PERF_TYPE_RAW:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static int validate_group(struct perf_event *event)
>  {
>  	struct cpu_hw_events fake_cpuc;
> @@ -633,15 +645,18 @@ static int validate_group(struct perf_event *event)
>  
>  	memset(&fake_cpuc, 0, sizeof(fake_cpuc));
>  
> -	if (loongarch_pmu_alloc_counter(&fake_cpuc, &leader->hw) < 0)
> +	if (loongarch_pmu_event_requires_counter(leader) &&
> +	    loongarch_pmu_alloc_counter(&fake_cpuc, &leader->hw) < 0)
>  		return -EINVAL;
>  
>  	for_each_sibling_event(sibling, leader) {
> -		if (loongarch_pmu_alloc_counter(&fake_cpuc, &sibling->hw) < 0)
> +		if (loongarch_pmu_event_requires_counter(sibling) &&
> +		    loongarch_pmu_alloc_counter(&fake_cpuc, &sibling->hw) < 0)
>  			return -EINVAL;
>  	}
>  
> -	if (loongarch_pmu_alloc_counter(&fake_cpuc, &event->hw) < 0)
> +	if (loongarch_pmu_event_requires_counter(event) &&
> +	    loongarch_pmu_alloc_counter(&fake_cpuc, &event->hw) < 0)
>  		return -EINVAL;
>  
>  	return 0;

The code looks good to me, but I'm not quite familiar the loongarch perf
code, then I won't give a reviewed-by and leave it to loongarch perf
experts. Thanks.


