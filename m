Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE74248F5C;
	Sun,  4 Jan 2026 04:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767502701; cv=none; b=klbiJrZ7LDPIPMlG+SvFnZep+2DgTI3NKBoJ3kGhxz5GFcWyaMaL5n9sA5dfP4KFUL84aOPQln7bmvP6uk0Dy+0/nIxgLkHzLO9mFg7CrcYwAnz9cVrgJ4setLcFtWSSV5BAY0sck92PkqgQf4MB0Zgd1f/T15fe1f3q9KhOWhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767502701; c=relaxed/simple;
	bh=SPk05DH6d+e7NScDZCXch8OVPGw6o0Ni8DWwxHeunWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKxGmq4suRdSL69I9v2ktwxlHAsHg/kEQDVB86nVUogXkbS21I9f+poe+63zy9Y85Qkh/5LOvqPL5W31PTa58taTHKRlb/L+AqyrqpAobnMd0JBmr5mbXDrlI8dATepsjmA0/95PSQE06wRRpGTGjilB96/jd3j095wGE/lMvrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2PGc8Na; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2PGc8Na"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767502700; x=1799038700;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SPk05DH6d+e7NScDZCXch8OVPGw6o0Ni8DWwxHeunWk=;
  b=F2PGc8NaIWRMaxUuZhJNfDF+9znhP/43SIb3IrQUnfmXDoJ4OMXMKa8r
   vGaxGibNvDk0ZODF5BMmmnINkeIgug4oz9/zaXorUdNFPyJZRFjpwq8PQ
   sVSAYTd+JP+jOA3x4X4YxWTjyAxurGDkYArQdR03tyiQ2cFPRFvbYT+vK
   mJP21fOqxpn6TdBrdsPsdu9J4MF3ExWuZU8Ka1k6BUuw3/eTnehQlvSul
   ghIvebdi2DD9RHiW8ZooPvslTvyaGV5FLbngpDCGgIJMeqoXoyEg3+gnP
   mSj7zKIWAmlWLvctR1whpQGbBloAkuHxGelAKzm1J6SZUpp3davV8e7ZS
   Q==;
X-CSE-ConnectionGUID: mfpZ3XTcS/OfvdJShM4HlQ==
X-CSE-MsgGUID: i9NL0wxDS/2Qr7yPeIdIIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="94383252"
X-IronPort-AV: E=Sophos;i="6.21,200,1763452800"; 
   d="scan'208";a="94383252"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 20:58:19 -0800
X-CSE-ConnectionGUID: eeOzE9QuRci49bOSmoyeiQ==
X-CSE-MsgGUID: w8DYRJktSgulAJez2gEiPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,200,1763452800"; 
   d="scan'208";a="202576729"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 20:58:15 -0800
Message-ID: <7214053a-070c-45c3-8cd8-b4306c49328a@linux.intel.com>
Date: Sun, 4 Jan 2026 12:58:12 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LoongArch: Fix PMU counter allocation for mixed-type
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
References: <20251231091500.530432-1-lisa@bytefly.space>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251231091500.530432-1-lisa@bytefly.space>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 12/31/2025 5:15 PM, Lisa Robinson wrote:
> When validating a perf event group, validate_group() unconditionally
> attempts to allocate hardware PMU counters for the leader, sibling
> events and the new event being added.
>
> This is incorrect for mixed-type groups. If a PERF_TYPE_SOFTWARE event
> ispart of the group, the current code still tries to allocate a hardware
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
>  arch/loongarch/kernel/perf_event.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/arch/loongarch/kernel/perf_event.c b/arch/loongarch/kernel/perf_event.c
> index 9d257c8519c9..82cc08c2b056 100644
> --- a/arch/loongarch/kernel/perf_event.c
> +++ b/arch/loongarch/kernel/perf_event.c
> @@ -633,15 +633,24 @@ static int validate_group(struct perf_event *event)
>  
>  	memset(&fake_cpuc, 0, sizeof(fake_cpuc));
>  
> -	if (loongarch_pmu_alloc_counter(&fake_cpuc, &leader->hw) < 0)
> +	if ((PERF_TYPE_HARDWARE == leader->attr.type ||
> +	     PERF_TYPE_HW_CACHE == leader->attr.type ||
> +	     PERF_TYPE_RAW == leader->attr.type) &&

Better introduce an inline function to check these event types instead of
duplicating same code.


> +	    loongarch_pmu_alloc_counter(&fake_cpuc, &leader->hw) < 0)
>  		return -EINVAL;
>  
>  	for_each_sibling_event(sibling, leader) {
> -		if (loongarch_pmu_alloc_counter(&fake_cpuc, &sibling->hw) < 0)
> +		if ((PERF_TYPE_HARDWARE == sibling->attr.type ||
> +		     PERF_TYPE_HW_CACHE == sibling->attr.type ||
> +		     PERF_TYPE_RAW == sibling->attr.type) &&
> +		    loongarch_pmu_alloc_counter(&fake_cpuc, &sibling->hw) < 0)
>  			return -EINVAL;
>  	}
>  
> -	if (loongarch_pmu_alloc_counter(&fake_cpuc, &event->hw) < 0)
> +	if ((PERF_TYPE_HARDWARE == event->attr.type ||
> +	     PERF_TYPE_HW_CACHE == event->attr.type ||
> +	     PERF_TYPE_RAW == event->attr.type) &&
> +	    loongarch_pmu_alloc_counter(&fake_cpuc, &event->hw) < 0)
>  		return -EINVAL;
>  
>  	return 0;
