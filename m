Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2431DA114;
	Wed,  4 Sep 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725454180; cv=none; b=kzFF4lJbEwQd7vRyrUr081eEpJzONhASQskhyjsF58+ef7GO8HdIHlFz6i5GBqcSDAUfYK42EfMctlUNi4+4gmxYdKTv7Ko4fkM04qwQ9ytVhr6Qg0EuqUO5sfLgPZ7C9MFYHDhTvgXtaXSC61fv537bJAYD1OvnPx9xuPXXv+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725454180; c=relaxed/simple;
	bh=TsAmiwTBEI8ZRGbyNmWA+DW/Ik/tDwupd5XcMLrgtM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DA/hyYJIfCGpH5bMYHZI5JSQADvJD6Ug2B42CdG9dGJKKth85y9258DnXA7U586AJloeqUqTzqE0v7/YMGhhVHhpJwXKNPY4v7rWJYaBm4F6cpHEUdscl3+j04BKMhrnc+DO+jUL+l4GIxuLx4J6s1drijXfQz7/qpnPkNF8vnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCm5Cuyn; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCm5Cuyn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725454179; x=1756990179;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TsAmiwTBEI8ZRGbyNmWA+DW/Ik/tDwupd5XcMLrgtM4=;
  b=HCm5Cuyn2nDV2cgpgZrtE95IT0PVL66Y4Wumsk3pXD49nOLjvGYMKWoo
   OoKNy3Hc1G31D1mQFwkBvB69QZ58SELNE18ccsNCB7rN4S9LOWihhchi/
   NB7ZeAt6mNpzBH9qfgHZ2j4LmScQu11assr+4wwq9/nl6blTkwPQl2cxw
   CM07+PfApgvRxntroh82wwBkQxKGuHt5dQufJl84ynC+xtgVUNQ1bEHbx
   NZnCKsZlAHM9y1f+a1+pVraJIZC5ycweIX1x32IwoceKk7xc48iAmDD3s
   R2JW2P0YUtGptsQ+cl6kdvhUrbb/5r8D1oAaACkMVOD/m6c5Red4CfENn
   A==;
X-CSE-ConnectionGUID: 4v51tUjASDyKNHriBcFI/A==
X-CSE-MsgGUID: 9WToUH21T9eXpBbdicf4qA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23913914"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="23913914"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 05:48:38 -0700
X-CSE-ConnectionGUID: qhwJsCmZR6y1bQxwZhgCsA==
X-CSE-MsgGUID: IcByinP9Tme8bnQirqGJLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="65599072"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 05:48:38 -0700
Received: from [10.212.20.134] (kliang2-mobl1.ccr.corp.intel.com [10.212.20.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 7AF1220B5782;
	Wed,  4 Sep 2024 05:48:35 -0700 (PDT)
Message-ID: <90028792-19b0-4371-a8b4-0a37612b4c9b@linux.intel.com>
Date: Wed, 4 Sep 2024 08:48:34 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf/x86/rapl: Fix the energy-pkg event for AMD CPUs
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc: gautham.shenoy@amd.com, ravi.bangoria@amd.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240904100934.3260-1-Dhananjay.Ugwekar@amd.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240904100934.3260-1-Dhananjay.Ugwekar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-04 6:09 a.m., Dhananjay Ugwekar wrote:
> After commit ("x86/cpu/topology: Add support for the AMD 0x80000026 leaf"),
> on AMD processors that support extended CPUID leaf 0x80000026, the
> topology_die_cpumask() and topology_logical_die_id() macros, no longer
> return the package cpumask and package id, instead they return the CCD
> (Core Complex Die) mask and id respectively. This leads to the energy-pkg
> event scope to be modified to CCD instead of package.
> 
> So, change the PMU scope for AMD and Hygon back to package.
> 
> On a 12 CCD 1 Package AMD Zen4 Genoa machine:
> 
> Before:
> $ cat /sys/devices/power/cpumask
> 0,8,16,24,32,40,48,56,64,72,80,88.
> 
> The expected cpumask here is supposed to be just "0", as it is a package
> scope event, only one CPU will be collecting the event for all the CPUs in
> the package.
> 
> After:
> $ cat /sys/devices/power/cpumask
> 0
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
> v2 Link: https://lore.kernel.org/all/20240730044917.4680-2-Dhananjay.Ugwekar@amd.com/
> 
> Changes from v2:
> * Rebase on top of kan.liang's PMU scope patchset [1]
> * Set pmu.scope variable to package for AMD/Hygon CPUs
> 
> tip/master + PMU scope patchset [1] to be taken as base for testing this patch. 
> 
> [1]: https://lore.kernel.org/all/20240802151643.1691631-1-kan.liang@linux.intel.com/
> ---
>  arch/x86/events/rapl.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index b70ad880c5bc..0c57dd5aa767 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -139,9 +139,32 @@ static unsigned int rapl_cntr_mask;
>  static u64 rapl_timer_ms;
>  static struct perf_msr *rapl_msrs;
>  
> +/*
> + * RAPL Package energy counter scope:
> + * 1. AMD/HYGON platforms have a per-PKG package energy counter
> + * 2. For Intel platforms
> + *	2.1. CLX-AP is multi-die and its RAPL MSRs are die-scope
> + *	2.2. Other Intel platforms are single die systems so the scope can be
> + *	     considered as either pkg-scope or die-scope, and we are considering
> + *	     them as die-scope.
> + */
> +#define rapl_pmu_is_pkg_scope()				\
> +	(boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||	\
> +	 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
> +
> +/*
> + * Helper function to get the correct topology id according to the
> + * RAPL PMU scope.
> + */
> +static inline unsigned int get_rapl_pmu_idx(int cpu)
> +{
> +	return rapl_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
> +					 topology_logical_die_id(cpu);
> +}
> +
>  static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
>  {
> -	unsigned int rapl_pmu_idx = topology_logical_die_id(cpu);
> +	unsigned int rapl_pmu_idx = get_rapl_pmu_idx(cpu);
>  
>  	/*
>  	 * The unsigned check also catches the '-1' return value for non
> @@ -617,7 +640,7 @@ static void __init init_rapl_pmu(void)
>  		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
>  		rapl_hrtimer_init(pmu);
>  
> -		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
> +		rapl_pmus->pmus[get_rapl_pmu_idx(cpu)] = pmu;
>  	}
>  
>  	cpus_read_unlock();
> @@ -646,6 +669,12 @@ static int __init init_rapl_pmus(void)
>  	rapl_pmus->pmu.module		= THIS_MODULE;
>  	rapl_pmus->pmu.scope		= PERF_PMU_SCOPE_DIE;
>  	rapl_pmus->pmu.capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
> +
> +	if (rapl_pmu_is_pkg_scope()) {
> +		rapl_pmus->nr_rapl_pmu	= topology_max_packages();
> +		rapl_pmus->pmu.scope	= PERF_PMU_SCOPE_PKG;
> +	}
> +
>  	return 0;
>  }
>  
