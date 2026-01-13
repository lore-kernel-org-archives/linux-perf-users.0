Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D58288C0E;
	Tue, 13 Jan 2026 01:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768269576; cv=none; b=XW3ZUbc94yXdUQEtnPK80nkuyuqe2XBhqB7Pk5JVsVgHHH8BeHtFXZkjod3h/6pfqBMRyzI+0hnXObVf4F4pB2n+OcSRJ34EnbU9uSj+YGXt4BFvsOuqXaO70bqdDi0vpvYuYTxacr6MeRn6Znp+YS1+DP9NStbdgZutMi08twg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768269576; c=relaxed/simple;
	bh=OUhOmPKSxFsdzDlgxow29cCFcMM59b32pyTyf1m6AOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HuKzUzKxiwcoBbo6j9NiPYyT1CDd0FmvigyR+VCMyXXmywM8Dz+2+cLo2Y4zKuyX6rwLAQgJL2S/YvNcIOjzSEFM/vgQkEMACm2Xdco2LN0A/3YLG/7xW2kKioufu2dFKjQBR0KXkIf7hPLZj3wnItFTX8294WT4yhZJIrkv6Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HPOaeQqb; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HPOaeQqb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768269574; x=1799805574;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OUhOmPKSxFsdzDlgxow29cCFcMM59b32pyTyf1m6AOQ=;
  b=HPOaeQqbZF2Z7TT9b2sNZ/t05Vc/u7pOJuzoCdhrZi6/8o/+tEwpydEZ
   jTwTfMud3bh6xaGIpdup5Vjuje/KHBMDeGz+kTMIiNc7xzrd5UdQvXpzA
   z+IEYfrdDm3h3tKUYIExyOAu3JsYthNjUbTclnwfyLdYkGdAFui5g2VTm
   tzO5XyI41ecXjIGdKsMx6rOyl5LRmmJVnoH5wfX/HfSYMBaKsIJuepuvF
   3twcmSTRH9Vtr+VCpnR9inBktTX1tszScwzDauuguCt1psuqigSQOESTN
   9fdVYSLCovTWxxxojkZqybCHzFcptBNbelgvgPzynDW7Ze+EmBpBwj+6e
   A==;
X-CSE-ConnectionGUID: g6fyJlx0SzGN3UdjIkpXeQ==
X-CSE-MsgGUID: Ei6SZq7WRnuqJ5wLNgzrVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="57106881"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="57106881"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 17:59:33 -0800
X-CSE-ConnectionGUID: Y9q7cfnSS1+ClYcVUqrvbQ==
X-CSE-MsgGUID: qg2QkhnuS8WOj4XO15kpLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204340254"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 17:59:29 -0800
Message-ID: <c08e5eeb-2949-4a13-951d-b7ae39d1e062@linux.intel.com>
Date: Tue, 13 Jan 2026 09:59:26 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 3/7] perf/x86/intel: Add core PMU support for DMR
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260112051649.1113435-1-dapeng1.mi@linux.intel.com>
 <20260112051649.1113435-4-dapeng1.mi@linux.intel.com>
 <20260112104131.GF830755@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260112104131.GF830755@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/12/2026 6:41 PM, Peter Zijlstra wrote:
> On Mon, Jan 12, 2026 at 01:16:45PM +0800, Dapeng Mi wrote:
>> @@ -7906,6 +8072,22 @@ __init int intel_pmu_init(void)
>>  		intel_pmu_pebs_data_source_skl(true);
>>  		break;
>>  
>> +	case INTEL_DIAMONDRAPIDS_X:
>> +		intel_pmu_init_pnc(NULL);
>> +		x86_pmu.pebs_ept = 1;
>> +		x86_pmu.hw_config = hsw_hw_config;
>> +		x86_pmu.pebs_latency_data = pnc_latency_data;
>> +		x86_pmu.get_event_constraints = glc_get_event_constraints;
>> +		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
>> +			hsw_format_attr : nhm_format_attr;
>> +		extra_skl_attr = skl_format_attr;
>> +		mem_attr = glc_events_attrs;
>> +		td_attr = glc_td_events_attrs;
>> +		tsx_attr = glc_tsx_events_attrs;
>> +		pr_cont("Panthercove events, ");
>> +		name = "panthercove";
>> +		break;
>> +
>>  	case INTEL_ALDERLAKE:
>>  	case INTEL_ALDERLAKE_L:
>>  	case INTEL_RAPTORLAKE:
> Does something like so make sense?
>
>
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -8066,6 +8066,9 @@ __init int intel_pmu_init(void)
>  
>  	glc_common:
>  		intel_pmu_init_glc(NULL);
> +		intel_pmu_pebs_data_source_skl(true);
> +	
> +	glc_base:
>  		x86_pmu.pebs_ept = 1;
>  		x86_pmu.hw_config = hsw_hw_config;
>  		x86_pmu.get_event_constraints = glc_get_event_constraints;
> @@ -8075,24 +8078,14 @@ __init int intel_pmu_init(void)
>  		mem_attr = glc_events_attrs;
>  		td_attr = glc_td_events_attrs;
>  		tsx_attr = glc_tsx_events_attrs;
> -		intel_pmu_pebs_data_source_skl(true);
>  		break;
>  
>  	case INTEL_DIAMONDRAPIDS_X:
> -		intel_pmu_init_pnc(NULL);
> -		x86_pmu.pebs_ept = 1;
> -		x86_pmu.hw_config = hsw_hw_config;
> -		x86_pmu.pebs_latency_data = pnc_latency_data;
> -		x86_pmu.get_event_constraints = glc_get_event_constraints;
> -		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
> -			hsw_format_attr : nhm_format_attr;
> -		extra_skl_attr = skl_format_attr;
> -		mem_attr = glc_events_attrs;
> -		td_attr = glc_td_events_attrs;
> -		tsx_attr = glc_tsx_events_attrs;
>  		pr_cont("Panthercove events, ");
>  		name = "panthercove";
> -		break;
> +		intel_pmu_init_pnc(NULL);
> +		x86_pmu.pebs_latency_data = pnc_latency_data;
> +		goto glc_base;
>  
>  	case INTEL_ALDERLAKE:
>  	case INTEL_ALDERLAKE_L:

Yes, that looks better, but "goto behind" seems a little weird, I tweak the
code a little bit. Thanks.

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 77cf849a1381..85134d80d9fc 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -8155,26 +8155,23 @@ __init int intel_pmu_init(void)
                x86_pmu.extra_regs = intel_rwc_extra_regs;
                pr_cont("Granite Rapids events, ");
                name = "granite_rapids";
+               goto glc_common;
+
+       case INTEL_DIAMONDRAPIDS_X:
+               intel_pmu_init_pnc(NULL);
+               x86_pmu.pebs_latency_data = pnc_latency_data;
+
+               pr_cont("Panthercove events, ");
+               name = "panthercove";
+               goto glc_base;

        glc_common:
                intel_pmu_init_glc(NULL);
-               x86_pmu.pebs_ept = 1;
-               x86_pmu.hw_config = hsw_hw_config;
-               x86_pmu.get_event_constraints = glc_get_event_constraints;
-               extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
-                       hsw_format_attr : nhm_format_attr;
-               extra_skl_attr = skl_format_attr;
-               mem_attr = glc_events_attrs;
-               td_attr = glc_td_events_attrs;
-               tsx_attr = glc_tsx_events_attrs;
                intel_pmu_pebs_data_source_skl(true);
-               break;

-       case INTEL_DIAMONDRAPIDS_X:
-               intel_pmu_init_pnc(NULL);
+       glc_base:
                x86_pmu.pebs_ept = 1;
                x86_pmu.hw_config = hsw_hw_config;
-               x86_pmu.pebs_latency_data = pnc_latency_data;
                x86_pmu.get_event_constraints = glc_get_event_constraints;
                extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
                        hsw_format_attr : nhm_format_attr;
@@ -8182,8 +8179,6 @@ __init int intel_pmu_init(void)
                mem_attr = glc_events_attrs;
                td_attr = glc_td_events_attrs;
                tsx_attr = glc_tsx_events_attrs;
-               pr_cont("Panthercove events, ");
-               name = "panthercove";


