Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0822623BCED;
	Tue, 22 Sep 2026 01:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039007; cv=none; b=dPMsVinnj9AwVeZ4yl5ZYDOq+7JfYFr5rgiZzyQP3ipNaS9lP/J7l3sF8KleLmpR9yFW4ds8evovYPNVG2am1Ud1TDXBWEppyWyRmORBs7YE2OOqNPfbOYXo7mPChHdwD0lnknAvwKuLB+f5m/cImDQjhZpUQvkbK8NTDz1Pw8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039007; c=relaxed/simple;
	bh=2xhBi68DZwccfXE7xnaqc/eegH2ZyWyXrVrdyjJrFmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WfrRpKxhfhNPNg9wsTOhhq1b93S8HZcvTbF/F9zT10AuEM0vBnGICf/DFWFr3ZkMUn0g9XD2KzfcgVJhg6DbVMMAkV5eBDC+APsWVWKT0K6MeSdjHeZyU82eD0UBYlUlxqHeJ3YM5MoRcKqfyePEMx3ZbS/f6992c7Kv6P6VtCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kYuK0w0i; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kYuK0w0i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790039006; x=1821575006;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2xhBi68DZwccfXE7xnaqc/eegH2ZyWyXrVrdyjJrFmE=;
  b=kYuK0w0iW7yBjKCd7+uXsrROIL3V2uYC3pyPGmyVr6399zsmvsxImf1E
   TOI+hEA6RWgRPtvAhymKjx0uHxYxVJ/UIBJfwyL8SP2i2kvimBd615QGW
   CBimdmQ58e3Swft2ZUoC/GSQFQ3UDdpnhW34TapuKamgpuh1x3962NAHc
   sxKfLpNdRc2cVoul5NFf8PUZpcQ+MHjvZYUrIX4Apq90ekqsgb1dgG36i
   PvdFhx2P8O5IM+4SMC4V+6ixiru4UZdL2WX0XZcMDE21JL3e2NADKh4UU
   Nh/4Hho26EKH57uJpcyT2HxhMAOh+fEnhdyL42Lh+jyyLr5YsKkFe7BMg
   Q==;
X-CSE-ConnectionGUID: R0s0xwYNS1SfRhALWiUXmA==
X-CSE-MsgGUID: NSFOYj2pRW2uQcBzb85nXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101193130"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="101193130"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 18:03:18 -0700
X-CSE-ConnectionGUID: 5GaVgt6mQ1Gz/U0498JZ9Q==
X-CSE-MsgGUID: PKRxYQPGSbyQo9S9zpl+SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="280970359"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 18:03:14 -0700
Message-ID: <d0bb5fea-4147-4f38-b2df-b8914a67b1a4@linux.intel.com>
Date: Tue, 22 Sep 2026 09:03:11 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] perf/x86/intel: Check only PMC bits in
 PEBS_ENABLED when detecting host PEBS usage
To: Sean Christopherson <seanjc@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Stephane Eranian <eranian@google.com>, Sashiko Bot <sashiko-bot@kernel.org>
References: <20260921191418.950933-1-seanjc@google.com>
 <20260921191418.950933-11-seanjc@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260921191418.950933-11-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Thanks.

On 9/22/2026 3:14 AM, Sean Christopherson wrote:
> When checking to see if guest PEBS usage should be disabled due to host
> PEBS usage, filter out non-counter bits in PEBS_ENABLE to avoid getting
> false positives in the unlikely scenario that "Enable Precise Store" is
> enabled without PEBS actually being active for any PMCs.
>
> Note, the other "hidden" usage of pebs_mask is already explicitly masked
> with intel_ctrl:
>
>   .guest = intel_ctrl & ~cpuc->intel_ctrl_exclude_guest_mask & ~pebs_mask,
>
> I.e. removing the non-counter bits from pebs_mask doesn't change the value
> that is loaded into arr[global_ctrl].guest.
>
> Fixes: 854250329c02 ("KVM: x86/pmu: Disable guest PEBS temporarily in two rare situations")
> Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260508234018.F06AEC2BCB0@smtp.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/events/intel/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index d9315bb2f221..1ff0586c7b71 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5323,7 +5323,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr,
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	struct perf_guest_switch_msr *arr = cpuc->guest_switch_msrs;
>  	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
> -	u64 pebs_mask = cpuc->pebs_enabled & x86_pmu.pebs_capable;
> +	u64 pebs_mask = intel_ctrl & cpuc->pebs_enabled & x86_pmu.pebs_capable;
>  	u64 guest_pebs_mask;
>  	int global_ctrl;
>  
> @@ -5375,7 +5375,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr,
>  	 * the guest wants to use for PEBS, (c) are not excluded from counting
>  	 * in the guest, and (d) _are_ excluded from counting in the host.
>  	 */
> -	guest_pebs_mask = pebs_mask & intel_ctrl & guest_pebs->enable &
> +	guest_pebs_mask = pebs_mask & guest_pebs->enable &
>  			  ~cpuc->intel_ctrl_exclude_guest_mask &
>  			  cpuc->intel_ctrl_exclude_host_mask;
>  
