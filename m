Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E623314C5;
	Thu, 30 Apr 2026 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566156; cv=none; b=bnv735WZ8Wta/fPlIihseHXOmK6BKMH13mXOn59k9CWAwad+aincoX7cRBi9ephwyow4aU3M9Hqruav2WFWqLHXderP92MSNpd0F8cTgSIsod8NRxIRw9cvLx0p+HdP+/+OI1LR0D1qMuQ2PzCg3YUP3EBtcuGJ3/o4HiurcjQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566156; c=relaxed/simple;
	bh=sc/P6FZzTTBLi+3ivGdxXp2myAVilmI8H/3wAesc2cE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LOLCWhnyIvDK3+jSrRNjm4V3tg/hYCPdUa2QdCuKff3cztPmtW81kdYXDME+k0EUCYXokb9JVkGC0AwK6QZfQtm8TwWG15d1ObQdeh/shJdvDdCUnLmPZQvvnUzDaMbikCz7Utrj9sNCmpCFeT3Bw2ZyZj7aq98cWImMYs9OWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCIpRW5A; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCIpRW5A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777566154; x=1809102154;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sc/P6FZzTTBLi+3ivGdxXp2myAVilmI8H/3wAesc2cE=;
  b=KCIpRW5A5YFY3iEy0Q9S4ioau/6ICsOf8iQ1njCwFow+Go5wRYWtKIRp
   itKQJMLiTus5pqva/NqRGr5mLdVgwPUEYnzjPrGe+tSuNjKcfRz3fclwl
   rxhM1mXyJ+XH9HlRr3jMhVL8PtsD9osFyzKtnySeObEz6/tPaOKT6rSmQ
   4Acu6qjTfze0loX5SjDwqFaB+Czq2UwL+nyo72CeM5+hAHHTgmiC4f0e8
   OM6LzJvADgXCrohUMcsBwjoElE/P+CCD1QqA/pMM677Jj9HY2Ys9N2jGg
   rVhdZuFeQ8wRCAnnQkvb1bw/Vq7CLdkL67BCBMb9C4//efYhTU/Vk7ESu
   g==;
X-CSE-ConnectionGUID: MJmM1NP9R3yQ07efbGtd9w==
X-CSE-MsgGUID: s52z6xptSbyhjWAE0CkxBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="81101490"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="81101490"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 09:22:34 -0700
X-CSE-ConnectionGUID: i46SVqz8Qa+pbiMiHlF4gg==
X-CSE-MsgGUID: iOzUNPy3RQKiwfDNu3qZRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="239637220"
Received: from unknown (HELO [10.241.241.75]) ([10.241.241.75])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 09:22:34 -0700
Message-ID: <d4728975-9194-4f8c-a858-a7f0e1fc1df6@intel.com>
Date: Thu, 30 Apr 2026 09:22:33 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 2/2] perf/x86: Update cap_user_rdpmc base on rdpmc user
 disable state
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260316050838.3624051-1-dapeng1.mi@linux.intel.com>
 <20260316050838.3624051-2-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260316050838.3624051-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/15/2026 10:08 PM, Dapeng Mi wrote:
> After introducing the RDPMC user disable feature, user-space RDPMC may
> return 0 instead of the actual event count. This creates an inconsistency
> with cap_user_rdpmc, where cap_user_rdpmc is set, but user-space RDPMC
> only returns 0.
> 
> To accurately represent the user-space RDPMC capability, update
> cap_user_rdpmc based on the RDPMC user disable state. If RDPMC user
> disable is enabled, cap_user_rdpmc is set to false, allowing user-space
> programs to fall back to the read() syscall to obtain the real event
> count.
> 
> Since arch_perf_update_userpage() could be called for software events,
> enhance x86_pmu_has_rdpmc_user_disable() to only check the x86 PMUs.
> 
> Fixes: 59af95e028d4 ("perf/x86/intel: Add support for rdpmc user disable feature")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---


Reviewed-by: Zide Chen <zide.chen@intel.com>


>  
> v2: Add is_x86_pmu() check before checking if rdpmc user disable feature
> is supported.
> 
> v1: https://lore.kernel.org/all/20260311075201.2951073-2-dapeng1.mi@linux.intel.com/
> 
>  arch/x86/events/core.c       | 3 +++
>  arch/x86/events/perf_event.h | 5 +++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 66b1a873c395..34eda8813716 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2794,6 +2794,9 @@ void arch_perf_update_userpage(struct perf_event *event,
>  	userpg->cap_user_time_zero = 0;
>  	userpg->cap_user_rdpmc =
>  		!!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
> +	if (x86_pmu_has_rdpmc_user_disable(event->pmu) &&
> +	    event->hw.config & ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE)
> +		userpg->cap_user_rdpmc = 0;
>  	userpg->pmc_width = x86_pmu.cntval_bits;
>  
>  	if (!using_native_sched_clock() || !sched_clock_stable())
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 025f67726ecc..307361b106d2 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -1351,8 +1351,9 @@ static inline u64 x86_pmu_get_event_config(struct perf_event *event)
>  
>  static inline bool x86_pmu_has_rdpmc_user_disable(struct pmu *pmu)
>  {
> -	return !!(hybrid(pmu, config_mask) &
> -		 ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE);
> +	return is_x86_pmu(pmu) &&
> +	       (hybrid(pmu, config_mask) &
> +		ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE);
>  }
>  
>  extern struct event_constraint emptyconstraint;

