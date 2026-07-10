Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C9B3E1D08;
	Fri, 10 Jul 2026 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671664; cv=none; b=a7yPnsueT+YAFcQqaqOVf/VhFro3h+DauRJW7nwloEE1tLpAhB+qPU+pCDfdM9tOTuCIS56JD+W5Ex+s1B7SVqsmvNLCfIR1ymiZMCwfh1fSE1FTtkaliR7kUlzYkvoCE59LphL0WCEo7wi+PsOsDgDbKIwJM+xt9gEcUC5OfKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671664; c=relaxed/simple;
	bh=xZTvgChtkl5fK2QHhQ7RBOyF30OmE+fFAMwnQdny7+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tx76c1nIxu02LqXGYU5Plj99MnYIJsKs3KYBc1C6i9MKEBWhBvNESLjJUG9laiRPD+ptLkpqurojJvFuFJK9A2wVIkfpyWo7++P1fRKNe6MnK749N9DugLb22MYj9c5FxGCb7+c/pG6/zTJHRuWvP8ysgNtjgIUXdaBOTqKLxIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RFhskar2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFhskar2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783671663; x=1815207663;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xZTvgChtkl5fK2QHhQ7RBOyF30OmE+fFAMwnQdny7+g=;
  b=RFhskar2lZ+CFN5Z621TDogP4B5AV/Mzj0HS4RcUjlTPaDhTJvdqxlRg
   MM48Uqj4FNZ8hD1wdJt0AUyyjwShjPHXD4I4RcKtrvW6Ft3UnZah2IaCl
   dqv7P6knD9HNXmI1UNxRp67B+OXAUnRvJiW8vwhb9n6r2TNhKQYNGc47h
   yW61f1mDlEFoAY5X31R2t0Otd8unoklBVjP02CZbh0q6GYQNkW91ms47s
   OKiaE5Sxvnn7J12v96J1jkPBFn4BubYmhuw1P29q4wFf6vgk1q7iDz4de
   Hnb8Wv5qYGP2O5VH0g7QQoWSeAHM4eM7TnT52fZcien7/Pl8ZeLap34m+
   w==;
X-CSE-ConnectionGUID: NyHSomXvTY2wDPi3QtcGFw==
X-CSE-MsgGUID: OhoB8CLvSySxihM+I1rbDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83345080"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83345080"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:21:03 -0700
X-CSE-ConnectionGUID: fugrW5XbSp2C6idQJC+Bgg==
X-CSE-MsgGUID: mgkaj0jkQ4ya1F9dpXMBeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="284925606"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 01:20:59 -0700
Message-ID: <a53150a0-7334-495e-88c4-188853479843@linux.intel.com>
Date: Fri, 10 Jul 2026 16:20:55 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] perf/x86/intel: Clear cpuc->pmu on hybrid PMU init
 failure
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260710065128.1799838-1-dapeng1.mi@linux.intel.com>
 <20260710065128.1799838-4-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260710065128.1799838-4-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Sashiko raises comments about this patch.
https://lore.kernel.org/all/20260710072619.5E3011F000E9@smtp.kernel.org/

The latter 2 comments are valid. Would send v2 to address these 2 comments.
Thanks.


On 7/10/2026 2:51 PM, Dapeng Mi wrote:
> When init_hybrid_pmu() fails at check_hw_exists(), cpuc->pmu may still
> point to the default static PMU.
>
> The CPU hotplug rollback then runs intel_pmu_cpu_dead(). On hybrid
> systems, that path may call hybrid_pmu(cpuc->pmu), which is not valid
> for the static PMU pointer and can result in incorrect hybrid state
> access.
>
> Fix this by resetting cpuc->pmu to NULL on hybrid PMU init failure.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index b39c6ce0efb5..9d4774278b50 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -6329,8 +6329,10 @@ static bool init_hybrid_pmu(int cpu)
>  
>  	intel_pmu_check_hybrid_pmus(pmu);
>  
> -	if (!check_hw_exists(&pmu->pmu, pmu->cntr_mask, pmu->fixed_cntr_mask))
> +	if (!check_hw_exists(&pmu->pmu, pmu->cntr_mask, pmu->fixed_cntr_mask)) {
> +		cpuc->pmu = NULL;
>  		return false;
> +	}
>  
>  	pr_info("%s PMU driver: ", pmu->name);
>  
