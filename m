Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433413EF665;
	Wed, 13 May 2026 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778662993; cv=none; b=HywH2MRlsA89e7dpuRXO6MceZxtcOv2F6PfDu77hcjAdiPfSpubYwUdMg+G/1on+QbtsFkq9/l2TndSIcYuvl6qpOcxb3EC80klaZytb8pTSWSpVmGu8gyzlT6+D6stCE+H483V6JYyvxiS349ZNj2Idyc/TJArvRhkGtFQGDn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778662993; c=relaxed/simple;
	bh=sIBIqPcV938ZjwUYHDxW6Omdc+1/PYCFRnyBdCyTBoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTm9MH6jF52vbtgQvPQnlhIDxCbm6WPADkFQ6z2ZvoNsWtg3sTRsq5eQXFSSAHaZO62oR+nlFNxP84dWanA9hn9LG5gApPM50auty9DBnHnbgz4iOyoiDlIPYLQMZdHsWCahLdLvABeRuyUIlq5TkfpdbHjX2/mA0z3FlEzpP/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHUbpjxA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHUbpjxA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778662989; x=1810198989;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sIBIqPcV938ZjwUYHDxW6Omdc+1/PYCFRnyBdCyTBoU=;
  b=SHUbpjxAvejZt8lleGRA1QlF3dAEVaRV8vyAY8xQRgK/2LeCx+kd9xit
   AwzVKxq/SV29XP2QE2feN269CYgqBYQb53zfMSBaPVysZEi9WwYzhDghb
   yFCNne3oVWVlniO2WTkMTBZw3kdh2SVNobQ8UsGT3BXfj1luZrjHnIlNM
   1y4afsjizu8/08QaL+MMlskL/fkiQLYbybtkswvZTbBJtqcTpgzsO3q+D
   Zrl1YlBecXf3Tiju3RXkgZL3uHK80mAbaxti4AdJtQZktIgeMzAPCy2hl
   BejmeAKvyUtQXXaWolK84BU4LZxSXpIk2++UWpYNrcd67tJCZraEtqmY2
   w==;
X-CSE-ConnectionGUID: okldJnajQKyNxCdHj0zPPg==
X-CSE-MsgGUID: ihAiKQr2TeSpsaIHYA4bGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="97152677"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="97152677"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 02:03:07 -0700
X-CSE-ConnectionGUID: 0a7v3X+QSRKYPjcnijRikg==
X-CSE-MsgGUID: le9R9uz1QOm2DldqTkfAJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="234961720"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 02:03:05 -0700
Message-ID: <607f0708-e437-4835-bc3d-169fe45e8320@linux.intel.com>
Date: Wed, 13 May 2026 17:03:02 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] perf/x86/intel/uncore: Implement lazy setup for
 MSR/MMIO PMU
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260512233048.9577-1-zide.chen@intel.com>
 <20260512233048.9577-8-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260512233048.9577-8-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/13/2026 7:30 AM, Zide Chen wrote:
> MSR and MMIO uncore PMUs are currently registered at module init time
> and appear in sysfs even when no PMU boxes are functional.
>
> Apply the same lazy registration model used by PCI uncore PMUs: the
> PMU is registered when the first box is successfully initialized, and
> unregistered when the last box exits.  If a box fails to initialize on
> a subsequent die, the PMU is marked broken but remains registered to
> avoid disrupting any in-flight perf events.
>
> Box allocation and free remain at module init/exit time to avoid
> repeated kfree/alloc cycles across CPU offline/online events.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore.c | 72 ++++++----------------------------
>  1 file changed, 12 insertions(+), 60 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 399f434e1a7d..2aaac0b49bb6 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1564,8 +1564,11 @@ static void uncore_box_unref(struct intel_uncore_type **types, int die)
>  		for (i = 0; i < type->num_boxes; i++, pmu++) {
>  			box = pmu->boxes[die];
>  			if (box && box->cpu >= 0 &&
> -			    atomic_dec_return(&box->cpu_refcnt) == 0)
> +			    atomic_dec_return(&box->cpu_refcnt) == 0) {
> +				if (atomic_dec_return(&pmu->die_refcnt) == 0)
> +					uncore_pmu_unregister(pmu);
>  				uncore_box_exit(box);
> +			}
>  		}
>  	}
>  }
> @@ -1659,7 +1662,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
>  			box = pmu->boxes[die];
>  			if (box && box->cpu >= 0 &&
>  			    atomic_inc_return(&box->cpu_refcnt) == 1)
> -				uncore_box_init(box);
> +				uncore_box_setup(pmu, box);
>  		}
>  	}
>  	return 0;
> @@ -1690,67 +1693,16 @@ static int uncore_event_cpu_online(unsigned int cpu)
>  	return 0;
>  }
>  
> -static int __init type_pmu_register(struct intel_uncore_type *type)
> +static int __init uncore_cpu_mmio_init(struct intel_uncore_type **types)

The name seems a little bit weird, could we name it to a more generic name?
maybe uncore_pmu_types_init() or something similar? Thanks.


>  {
> -	int i, ret;
> -
> -	for (i = 0; i < type->num_boxes; i++) {
> -		ret = uncore_pmu_register(&type->pmus[i]);
> -		if (ret)
> -			return ret;
> -	}
> -	return 0;
> -}
> -
> -static int __init uncore_msr_pmus_register(void)
> -{
> -	struct intel_uncore_type **types = uncore_msr_uncores;
> -	int ret;
> -
> -	for (; *types; types++) {
> -		ret = type_pmu_register(*types);
> -		if (ret)
> -			return ret;
> -	}
> -	return 0;
> -}
> -
> -static int __init uncore_cpu_init(void)
> -{
> -	int ret;
> -
> -	ret = uncore_types_init(uncore_msr_uncores);
> -	if (ret)
> -		goto err;
> -
> -	ret = uncore_msr_pmus_register();
> -	if (ret)
> -		goto err;
> -	return 0;
> -err:
> -	uncore_types_exit(uncore_msr_uncores);
> -	uncore_msr_uncores = empty_uncore;
> -	return ret;
> -}
> -
> -static int __init uncore_mmio_init(void)
> -{
> -	struct intel_uncore_type **types = uncore_mmio_uncores;
>  	int ret;
>  
>  	ret = uncore_types_init(types);
> -	if (ret)
> -		goto err;
> +	if (!ret)
> +		return 0;
>  
> -	for (; *types; types++) {
> -		ret = type_pmu_register(*types);
> -		if (ret)
> -			goto err;
> -	}
> -	return 0;
> -err:
> -	uncore_types_exit(uncore_mmio_uncores);
> -	uncore_mmio_uncores = empty_uncore;
> +	uncore_types_exit(types);
> +	types = empty_uncore;
>  	return ret;
>  }
>  
> @@ -2052,12 +2004,12 @@ static int __init intel_uncore_init(void)
>  
>  	if (uncore_init->cpu_init) {
>  		uncore_init->cpu_init();
> -		cret = uncore_cpu_init();
> +		cret = uncore_cpu_mmio_init(uncore_msr_uncores);
>  	}
>  
>  	if (uncore_init->mmio_init) {
>  		uncore_init->mmio_init();
> -		mret = uncore_mmio_init();
> +		mret = uncore_cpu_mmio_init(uncore_mmio_uncores);
>  	}
>  
>  	if (cret && pret && mret) {
