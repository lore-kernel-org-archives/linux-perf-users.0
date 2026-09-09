Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D29B29B200;
	Wed,  9 Sep 2026 01:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917756; cv=none; b=n1h9uj9T7AoVAyYVcp4lUL0LrZz3PV6u5vI/D6PTAOSOX4ZluTYnN27jOnTTwJsggz/gSCxHaqqcuZpPzYFdb0qaG3VJKPcyOEFmwGUXyctebpsCHoE2S8kQaxUKLUfM7JusdGEKItjIFmR+6cXtdAq0dYx623JJRFnq7YWM7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917756; c=relaxed/simple;
	bh=64HKkviFc6EbPKtDPnq2iEu3Q3iKzsnApLj8LGWy9PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ab/rnjzRLdD5drCZVwdPDVeZjigk9qh6sWBlZLEPxlBD11mAjYVKGukEURzoX7Ms2/ptYX2Afxwc15lfra92UZn2KW+OoiKwJzfzCIoCXAEZE+axVt7uhlFSJKUQxSE9sz4c+viPALZWSzGqG0KY0NoGVhINLh8m5ibzSd1ba5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YcjBlS+H; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YcjBlS+H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788917755; x=1820453755;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=64HKkviFc6EbPKtDPnq2iEu3Q3iKzsnApLj8LGWy9PY=;
  b=YcjBlS+HtDtxthL2ZFUbrRXB/ShMqWTEJR/wJyDJEwF/9JLBrVCFY48s
   9cAKUiUayWgh8yMYsPLX4oCBPMGDZ8P3oswTuvvm8wTNCCEO3gqCNItvh
   HhUW5HiDjSuiUhxHq4cU1GR2Z62AWIHf5Xi1cjbp53ZdLflL1n/4NWgAu
   gEUmp+st0jgenxFsaRs5qsilY/gM3e83DGIWyAWqnZk85H1LU3TcdXpua
   iSmJimAWKJuHLuoEKIBBtQNvqWDG5TUoI+r3NZ2S6q88OoZHmJd7La0+F
   1Eu0wpgwf51T+y2gx7SOzAoFnKY6TVrF3ZExaJN5mmiazRTkwaNqzmKbv
   A==;
X-CSE-ConnectionGUID: UxWJXgagSc2nt+VvKffD1g==
X-CSE-MsgGUID: /UR7gqxoSVqhWuvCAqv6Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89537992"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="89537992"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 18:35:54 -0700
X-CSE-ConnectionGUID: DNikuua/Tc+e4h0024tXjw==
X-CSE-MsgGUID: LXEk4ik5RD6Jip3AOS3IUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="294678959"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 18:35:47 -0700
Message-ID: <de698eb3-94ba-4545-bb4f-951014c98008@linux.intel.com>
Date: Wed, 9 Sep 2026 09:35:44 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/core: Simplify hybrid PMU registration failure
 path
To: Thorsten Blum <blum@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260904201313.271421-3-blum@kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260904201313.271421-3-blum@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 9/5/2026 4:13 AM, Thorsten Blum wrote:
> Handle perf_pmu_register() errors directly instead of breaking out of
> the registration loop and checking the index separately. Reuse the loop
> index i to unregister any previously registered PMUs in reverse order
> and drop the extra index j.
>
> Also log the failing PMU's name and error code.
>
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
>  arch/x86/events/core.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 8eb14add44c8..0a8fcfd52ad0 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2256,7 +2256,7 @@ static int __init init_hw_perf_events(void)
>  			goto out2;
>  	} else {
>  		struct x86_hybrid_pmu *hybrid_pmu;
> -		int i, j;
> +		int i;
>  
>  		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
>  			hybrid_pmu = &x86_pmu.hybrid_pmu[i];
> @@ -2268,15 +2268,13 @@ static int __init init_hw_perf_events(void)
>  
>  			err = perf_pmu_register(&hybrid_pmu->pmu, hybrid_pmu->name,
>  						(hybrid_pmu->pmu_type == hybrid_big) ? PERF_TYPE_RAW : -1);
> -			if (err)
> -				break;
> -		}
> -
> -		if (i < x86_pmu.num_hybrid_pmus) {
> -			for (j = 0; j < i; j++)
> -				perf_pmu_unregister(&x86_pmu.hybrid_pmu[j].pmu);
> -			pr_warn("Failed to register hybrid PMUs\n");
> -			goto out2;
> +			if (err) {
> +				while (i--)
> +					perf_pmu_unregister(&x86_pmu.hybrid_pmu[i].pmu);
> +				pr_warn("Failed to register hybrid PMU %s: %d\n",
> +					hybrid_pmu->name, err);
> +				goto out2;
> +			}
>  		}
>  	}
>  
