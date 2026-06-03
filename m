Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEE62EBDE9;
	Wed,  3 Jun 2026 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780454590; cv=none; b=YMx3FZsblBFnkVrAB27xFwUYAqYSjkfo+UuRWOnb+kqaTg/BWNPVFrHizW9zYlaOKHEtBY5i8dVqOghzqfsuXMnWkhJzw9AxgbH0oZvUBYFozxqR+jRtl3Hr3VssioxUDOReRkxb8i16gPeKTLV3HnNhuo4Mp1dRAUZKeCuOZ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780454590; c=relaxed/simple;
	bh=WPC2d6LGAOAcaB0nNEf2Dk9AWzs8sD7V3RSb8OQTX9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T54ZuP7UPb0YTXYmpeOuXcjdbfpE+NRuit+c0ByR3VIY7PPlLYLlaqUnb0PxusEFJ+99pxtlRV4Bd5fTXmhLYDc16BGngxa6pBcwOJJwkij4rFLjEMzuDqGECh5zi4lPBYh3ZSXy2Aee4YLqw/3pRAU1Cvhbre+5uujoJzciSGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SyE/6aOT; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SyE/6aOT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780454589; x=1811990589;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WPC2d6LGAOAcaB0nNEf2Dk9AWzs8sD7V3RSb8OQTX9g=;
  b=SyE/6aOTHwAjGkdTpgbtXoSJMOI83O0kn7nwfL3mbyhk/zTRTPEfHOfQ
   RqVAbt/uylfQtUTGwsidvbTxkLanwzRYrL49TVSZuJspvmmMKMSZ1ygl7
   b51bqOrFzsOb9GkIHVn2PjNkdfYYrz892+TRT6ynCAaDDWfNY253NBN3n
   NknciqqCOKKZGlVji1/Oov270GJ27sWReS34Iy0RWIq7YVVwsnyeBcqB/
   RSfuIAz4kCCBPTaREJc7Ud/De5/ZKXIgvpqUy8eerCPsMtm+D1oBs9wdP
   OkmSu5QG76PEGhCHlaJ/e624Gv1jiJDkSA7HNOZBj32kHWwRx+90yJpOT
   w==;
X-CSE-ConnectionGUID: TP6ZiX+OTiWd2NgDrWLuAQ==
X-CSE-MsgGUID: UwWOyBQPSTOfPqObpHiYRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="91564858"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="91564858"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 19:43:09 -0700
X-CSE-ConnectionGUID: 0M3+/mZNT4ijxbmsVC32KQ==
X-CSE-MsgGUID: 4Jjss0g+ThKoY6aybWAK6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="243930190"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 19:43:06 -0700
Message-ID: <9d242939-2ccb-4a80-bdbb-9de7f4c23c66@linux.intel.com>
Date: Wed, 3 Jun 2026 10:43:03 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 8/8] perf/x86/intel/uncore: Implement lazy setup for
 MSR/MMIO PMU
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260601170114.173359-1-zide.chen@intel.com>
 <20260601170114.173359-9-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260601170114.173359-9-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 6/2/2026 1:01 AM, Zide Chen wrote:
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
> V2:
> - uncore_box_unref(): Only decrement pmu->activeboxes for active boxes
>   (those without init_box callback or successfully initialized) to prevent
>   underflow when initialization fails.
> - Set uncore_{msr,mmio}_uncores to empty_uncore when
>   uncore_pmu_types_init() fails.
> - Rename uncore_cpu_mmio_init() to uncore_pmu_types_init() (Dapeng).
> ---
>  arch/x86/events/intel/uncore.c | 78 +++++++---------------------------
>  arch/x86/events/intel/uncore.h |  6 +++
>  2 files changed, 22 insertions(+), 62 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 6d710aef52ac..06f50f5fae8c 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1567,8 +1567,13 @@ static void uncore_box_unref(struct intel_uncore_type **types, int die)
>  		pmu = type->pmus;
>  		for (i = 0; i < type->num_boxes; i++, pmu++) {
>  			box = pmu->boxes[die];
> -			if (box && box->cpu >= 0 && atomic_dec_return(&box->refcnt) == 0)
> +			if (box && box->cpu >= 0 &&
> +			    atomic_dec_return(&box->refcnt) == 0) {
> +				if (uncore_box_active(box) &&
> +				    atomic_dec_return(&pmu->activeboxes) == 0)
> +					uncore_pmu_unregister(pmu);
>  				uncore_box_exit(box);
> +			}
>  		}
>  	}
>  }
> @@ -1655,7 +1660,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
>  		for (i = 0; i < type->num_boxes; i++, pmu++) {
>  			box = pmu->boxes[die];
>  			if (box && box->cpu >= 0 && atomic_inc_return(&box->refcnt) == 1)
> -				uncore_box_init(box);
> +				uncore_box_setup(pmu, box);
>  		}
>  	}
>  	return 0;
> @@ -1686,67 +1691,12 @@ static int uncore_event_cpu_online(unsigned int cpu)
>  	return 0;
>  }
>  
> -static int __init type_pmu_register(struct intel_uncore_type *type)
> +static int __init uncore_pmu_types_init(struct intel_uncore_type **types)
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
> -	int ret;
> -
> -	ret = uncore_types_init(types);
> +	int ret = uncore_types_init(types);
>  	if (ret)
> -		goto err;
> +		uncore_types_exit(types);
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
>  	return ret;
>  }
>  
> @@ -2047,12 +1997,16 @@ static int __init intel_uncore_init(void)
>  
>  	if (uncore_init->cpu_init) {
>  		uncore_init->cpu_init();
> -		cret = uncore_cpu_init();
> +		cret = uncore_pmu_types_init(uncore_msr_uncores);
> +		if (cret)
> +			uncore_msr_uncores = empty_uncore;
>  	}
>  
>  	if (uncore_init->mmio_init) {
>  		uncore_init->mmio_init();
> -		mret = uncore_mmio_init();
> +		mret = uncore_pmu_types_init(uncore_mmio_uncores);
> +		if (mret)
> +			uncore_mmio_uncores = empty_uncore;
>  	}
>  
>  	if (cret && pret && mret) {
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
> index 0adb477d9708..c8dfa2d21bfd 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -568,6 +568,12 @@ static inline u64 uncore_read_counter(struct intel_uncore_box *box,
>  	return box->pmu->type->ops->read_counter(box, event);
>  }
>  
> +static inline bool uncore_box_active(struct intel_uncore_box *box)
> +{
> +	return (!box->pmu->type->ops->init_box ||
> +		test_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags));
> +}
> +
>  static inline int uncore_box_init(struct intel_uncore_box *box)
>  {
>  	int ret = 0;
