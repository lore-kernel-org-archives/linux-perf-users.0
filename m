Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D82A3DB30C;
	Tue, 19 May 2026 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229427; cv=none; b=OAr/+0mgT5co2IqsuYQOL/x5Pvep7Ax+H5jDVrl8UV0NsfyIoqvInLb1DrE95ZmWhy/YyfwFrfT98LzYjg8bpFuzx36pjjz/0VvlKzT33GRClUF2F6GobLIqJn8NtLbND59e8K2wjCZEd3qKQiocfisKwwoUZy3jVO0RqeXnHzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229427; c=relaxed/simple;
	bh=oGGRSDFC/7FZO6P/35C2rb3tftVa5tlqnUOVz29V/CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOXtRvsx4CD5C2CUmPWcHDAbF7geFzD4Da3F6FHYUlJ+dfR+n/D8JDSCujLJtatvygPp+Th1QenrucURj99lNIgXoYKMZcsBzJMcZrLXwORGAN2AvTuswj1uLUhQkrKdzDo3tVq7vRX59WtILDMWSOjisFN9uF8rLRn2GI2g37Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXCTxNCT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXCTxNCT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779229426; x=1810765426;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oGGRSDFC/7FZO6P/35C2rb3tftVa5tlqnUOVz29V/CY=;
  b=PXCTxNCT2p9qm5kyiSXPQohx9yppStqrkn0DbdgAQCgwMFjdrbTZobHx
   JKfKJR20GQ2V6UDsGUSOSd1z0QQQVwm1b7qNJjWguU+d7TvFQ4RqsGk+X
   /+Gw8FYMDAg8Y0V2viykCdeze+STggQunaEa5WFc/EygenkIr583KeZMj
   EwI0uJa5J8bwewFc0zpPARAXuIQd5KrbOg3wKc19nmbzt6xB5/FFJlIAS
   xwpuY6mQnoH2Tyiwi3+4MyjZa+MQBmiXgC48QoGPtA2tJ0pHaeCDAvuR0
   WWQmft5vNFtdX6FQOj4QxL5XoD2lb4nOlfMnS9yMcz//n5i/3vO8/j99C
   A==;
X-CSE-ConnectionGUID: o2WI4pvrQ76Q46k92O7iMA==
X-CSE-MsgGUID: wdaSBJl0SoCIS+dv1qwFFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80154176"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80154176"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 15:23:45 -0700
X-CSE-ConnectionGUID: PlMadv5nSt2cu4r9hCAiTw==
X-CSE-MsgGUID: rSStkuJvQdegjdBcXof09Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="237303136"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 15:23:45 -0700
Message-ID: <a2ad411c-e844-493e-8c50-d5821588170d@intel.com>
Date: Tue, 19 May 2026 17:23:43 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] perf/x86/intel: Update event constraints and
 cache_extra_regs[] for SRF
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
References: <20260515061143.338553-1-dapeng1.mi@linux.intel.com>
 <20260515061143.338553-11-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260515061143.338553-11-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/2026 11:11 PM, Dapeng Mi wrote:
> Update perf hard-coded event constraints and cache_extra_regs[] for
> Sierra Forest according to the latest SRF perfmon events (V1.17).
> 
> SRF has same uarch (crestmont) as MTL E-core and shares same perf
> events, so directly apply the crestmont perf events.

Nit: Crestmont.
> SRF perfmon events:
> https://github.com/intel/perfmon/blob/main/SRF/events/sierraforest_core.json
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---

Reviewed-by: zide.chen@intel.com

>  arch/x86/events/intel/core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 587167dbb98f..e1c6fb127f10 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -8101,8 +8101,7 @@ __init int intel_pmu_init(void)
>  
>  	case INTEL_ATOM_CRESTMONT:
>  	case INTEL_ATOM_CRESTMONT_X:
> -		intel_pmu_init_grt(NULL);
> -		x86_pmu.extra_regs = intel_cmt_extra_regs;
> +		intel_pmu_init_cmt(NULL);
>  		intel_pmu_pebs_data_source_cmt();
>  		x86_pmu.pebs_latency_data = cmt_latency_data;
>  		x86_pmu.get_event_constraints = cmt_get_event_constraints;

