Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1343D2BE7BE;
	Thu, 21 May 2026 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325581; cv=none; b=UQUPqAr6dOcesuzICccLbTV897HJdabObhF+K1r56vDmFhknDNvUsf3eqy2eM+7SjF005KyWePYJm+mXEyL804Ll1j/RHjrD4+d/HtZbFCBxXKM7fD9vAY+7kYlMlXcX/5rGA1q4R/SwGORIyZKlrEJvXQZXv0JrdjtfZuoxuSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325581; c=relaxed/simple;
	bh=wU8b523kmZJGV94bFlFYc6nnY6vEi5b9flk699exrm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RgjD5w1u7UJvYlQHqgV0KguU+2K7+BCRzF4CyuIv+21+9NJIPBjVTpyfKpOMD7lBTlB+6mzDRkGZ2aGjV9JSqs0dF2KQD3ywvtj13WSksAW8+UvRViMtGP4b7QD1GUwC+qOQ39vIjfYUuD2k9MRB3m2JvlWhGVy1RF2/KSYhHIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G0yDrUmR; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G0yDrUmR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779325580; x=1810861580;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wU8b523kmZJGV94bFlFYc6nnY6vEi5b9flk699exrm4=;
  b=G0yDrUmR0v34qrhCu0kZHyxJES0by/v7XpYoYhdBfOFF7p42ChihNIsh
   yDaL9N4ab+0SHfomtNeH9zvozkUuAu7s7LONaIA3xQv1ks4r8kLTagumD
   Df20SpVj/XC0gHDWjP4+Fs2sk9DpDVvgFU5DlZgtEJgJ3/yRwie3XeckN
   QxzseXUIIYa7kEYz8MyfQFcU3w+1KqUWTGwvobxdOexph4bDbjcwjQm0D
   Q2F3ivxYe7n0s/dsu30F/hvLE47135JdxqakblXOAiOSNt02Du+F4Lmy8
   ltVC/yCdaHEOwlT0UT4hwq1BuRtyIiDpbO4CpRYHHlA8V3fT3C9t1nYrx
   g==;
X-CSE-ConnectionGUID: 0HnmMGJzR5q/xz6X1nhD6g==
X-CSE-MsgGUID: 1tQ3To3wT9++dNW/KFIdqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="105699146"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="105699146"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 18:06:19 -0700
X-CSE-ConnectionGUID: xHWCgL4iRRKZfrAnsO6WNg==
X-CSE-MsgGUID: RbOj982kTJSk1bl1Jl5XHw==
X-ExtLoop1: 1
Received: from unknown (HELO [10.238.3.164]) ([10.238.3.164])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 18:06:16 -0700
Message-ID: <ca2e6309-ec61-451a-8105-35045e0e90a8@linux.intel.com>
Date: Thu, 21 May 2026 09:06:14 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/2] perf/x86: Introduce is_x86_pmu() helper
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260316050838.3624051-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260316050838.3624051-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Kindly ping. :)

Thanks.

On 3/16/2026 1:08 PM, Dapeng Mi wrote:
> From: Ian Rogers <irogers@google.com>
>
> To facilitate the detection of x86 PMU structures in upcoming patches,
> the is_x86_pmu() helper is introduced. Additionally, the is_x86_event()
> helper has been refactored to utilize is_x86_pmu().
>
> No function changes intended.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>
> v2: new patch.
>
>  arch/x86/events/core.c       | 16 ----------------
>  arch/x86/events/perf_event.h | 18 +++++++++++++++++-
>  2 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 810ab21ffd99..66b1a873c395 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -774,22 +774,6 @@ void x86_pmu_enable_all(int added)
>  	}
>  }
>  
> -int is_x86_event(struct perf_event *event)
> -{
> -	/*
> -	 * For a non-hybrid platforms, the type of X86 pmu is
> -	 * always PERF_TYPE_RAW.
> -	 * For a hybrid platform, the PERF_PMU_CAP_EXTENDED_HW_TYPE
> -	 * is a unique capability for the X86 PMU.
> -	 * Use them to detect a X86 event.
> -	 */
> -	if (event->pmu->type == PERF_TYPE_RAW ||
> -	    event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE)
> -		return true;
> -
> -	return false;
> -}
> -
>  struct pmu *x86_get_pmu(unsigned int cpu)
>  {
>  	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index fad87d3c8b2c..025f67726ecc 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -115,7 +115,23 @@ static inline bool is_topdown_event(struct perf_event *event)
>  	return is_metric_event(event) || is_slots_event(event);
>  }
>  
> -int is_x86_event(struct perf_event *event);
> +static inline bool is_x86_pmu(struct pmu *pmu)
> +{
> +	/*
> +	 * For a non-hybrid platforms, the type of X86 pmu is
> +	 * always PERF_TYPE_RAW.
> +	 * For a hybrid platform, the PERF_PMU_CAP_EXTENDED_HW_TYPE
> +	 * is a unique capability for the X86 PMU.
> +	 * Use them to detect a X86 event.
> +	 */
> +	return pmu->type == PERF_TYPE_RAW ||
> +	       pmu->capabilities & PERF_PMU_CAP_EXTENDED_HW_TYPE;
> +}
> +
> +static inline bool is_x86_event(struct perf_event *event)
> +{
> +	return is_x86_pmu(event->pmu);
> +}
>  
>  static inline bool check_leader_group(struct perf_event *leader, int flags)
>  {
>
> base-commit: becb26c89be3a6448dcd92522894427544d5b091
