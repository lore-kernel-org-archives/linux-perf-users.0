Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86FDDF59;
	Mon, 27 Apr 2026 02:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777256669; cv=none; b=MG9JmdP4Fr7K9UKBTmlS7oj4iBGmoUnyRTLYQVSv9z9zFqsL9P5eKIGwzG/wDXkYpVW9BQfn6OslYIniZoYrus3SsYF0SraYGOlAnTSGI+jY63tGQVSYkwEoQ1trsrHisCwx9sAqnGAICOYq1nJv9yjW63Vx0Bu4Aojqj9IcRFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777256669; c=relaxed/simple;
	bh=sXXmNsUN3Jpy5tAmjjL9KXMIZQ04aR1cpyiAdCwplx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFxwsK3hKXsZYVV4vTiI2r8/541b/ioPvN6uCZzG9Sy/DWCZfe7GzKmb32f9Lc+PiUKgZMCxiv61B+RO7CzcF/IkNOVDKwq1gY+fHhu8+xrhVGImA52G6/nakx0TCThC7t3Z0gy6w42Gn8vsbQ0Rn+KyvSCUQSE53dhoPtF/J4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kklzmTBb; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kklzmTBb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777256668; x=1808792668;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sXXmNsUN3Jpy5tAmjjL9KXMIZQ04aR1cpyiAdCwplx4=;
  b=kklzmTBbX5b+s1OzMvXxShi+nl2m5++7itaLDpeIjPRsQzmU9pIdUUHw
   A7r9i5n+onfVaFZ5JqAWsfOiYSIb9hyMoHq5MlVlqgZzp1xoJN+Wu8zUh
   nMlwdpSQFQckPPQk7k9y968qAz1snX+iBCoYJLpGDlCbA9HigF4mVT1fE
   eppFwJ+WZVXWc5Jj++SmBv1XqvBd7yM41qSDvETpeislAOkstU3bWzQcx
   8FZCP8j11Y6ZnXphOflrkZ6kTXuVtvCIEOPnlasCShk/MZuek/cY0O0L9
   oUMkF4oabMK7dcU/IQntwOWAFsn5hwoJXnsfBy5Sy4OHGx0eCQO03Ve3y
   A==;
X-CSE-ConnectionGUID: eewU0fsnSrSmK8BbvvRKRw==
X-CSE-MsgGUID: 8BshCgjhTTOp7PmLNfWSkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="78125093"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="78125093"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2026 19:24:27 -0700
X-CSE-ConnectionGUID: 2J0ZuCHiQOaDAh8Q6L5KCQ==
X-CSE-MsgGUID: 8eSEhLPcTrCJxAf6ESmteQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="257024054"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2026 19:24:22 -0700
Message-ID: <9d318656-3faf-479c-817f-f32f7d5caaae@linux.intel.com>
Date: Mon, 27 Apr 2026 10:24:20 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] perf/x86/intel: Don't context switch DS_AREA (and
 PEBS config) if PEBS is unused
To: Sean Christopherson <seanjc@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
 Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>
References: <20260423150340.463896-1-seanjc@google.com>
 <20260423150340.463896-3-seanjc@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260423150340.463896-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/23/2026 11:03 PM, Sean Christopherson wrote:
> When filling the list of MSRs to be loaded by KVM on VM-Enter and VM-Exit,
> load the guest values for DS_AREA and (conditionally) MSR_PEBS_DATA_CFG if
> and only if PEBS will be active in the guest, i.e. only if a PEBS record
> may be generated while running the guest.  As shown by the !pebs_ept path,
> it's perfectly safe to run with the host's DS_AREA, so long as PEBS-enabled
> counters are disabled via PERF_GLOBAL_CTRL.
>
> Omitting DS_AREA and MSR_PEBS_DATA_CFG when PEBS is unused saves two MSR
> writes per MSR on each VMX transition, i.e. eliminates two/four pointless
> MSR writes on each VMX roundtrip when PEBS isn't being used by the guest.
>
> Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Mingwei Zhang <mizhang@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/events/intel/core.c | 39 +++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 002d809f82ef..407fd392fd46 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5037,23 +5037,14 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>  		return arr;
>  	}
>  
> +	/*
> +	 * If the guest won't use PEBS or the CPU doesn't support PEBS in the
> +	 * guest, then there's nothing more to do as disabling PMCs via
> +	 * PERF_GLOBAL_CTRL is sufficient on CPUs with guest/host isolation.
> +	 */
>  	if (!kvm_pmu || !x86_pmu.pebs_ept)
>  		return arr;
>  
> -	arr[(*nr)++] = (struct perf_guest_switch_msr){
> -		.msr = MSR_IA32_DS_AREA,
> -		.host = (unsigned long)cpuc->ds,
> -		.guest = kvm_pmu->ds_area,
> -	};
> -
> -	if (x86_pmu.intel_cap.pebs_baseline) {
> -		arr[(*nr)++] = (struct perf_guest_switch_msr){
> -			.msr = MSR_PEBS_DATA_CFG,
> -			.host = cpuc->active_pebs_data_cfg,
> -			.guest = kvm_pmu->pebs_data_cfg,
> -		};
> -	}
> -
>  	/*
>  	 * Disable counters where the guest PMC is different than the host PMC
>  	 * being used on behalf of the guest, as the PEBS record includes
> @@ -5065,6 +5056,26 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>  	if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
>  		guest_pebs_mask = 0;
>  
> +	/*
> +	 * Context switch DS_AREA and PEBS_DATA_CFG if and only if PEBS will be
> +	 * active in the guest; if no records will be generated while the guest
> +	 * is running, then simply keep the host values resident in hardware.
> +	 */
> +	arr[(*nr)++] = (struct perf_guest_switch_msr){
> +		.msr = MSR_IA32_DS_AREA,
> +		.host = (unsigned long)cpuc->ds,
> +		.guest = guest_pebs_mask ? kvm_pmu->ds_area : (unsigned long)cpuc->ds,
> +	};

The code looks good to me.

one nit: people may be curious on why set same host value for guest if they
don't notice that the same value on host and guest would lead to the MSRs
would be removed from MSR load-list. Maybe add comments to further explain it.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Thanks.


> +
> +	if (x86_pmu.intel_cap.pebs_baseline) {
> +		arr[(*nr)++] = (struct perf_guest_switch_msr){
> +			.msr = MSR_PEBS_DATA_CFG,
> +			.host = cpuc->active_pebs_data_cfg,
> +			.guest = guest_pebs_mask ? kvm_pmu->pebs_data_cfg :
> +						   cpuc->active_pebs_data_cfg,
> +		};
> +	}
> +
>  	/*
>  	 * Do NOT mess with PEBS_ENABLED.  As above, disabling counters via
>  	 * PERF_GLOBAL_CTRL is sufficient, and loading a stale PEBS_ENABLED,
