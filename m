Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503CD246766;
	Thu, 16 Apr 2026 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363866; cv=none; b=YYAs1Ky+w5TXvCBvYSsjnUzGi8J07oW3/1W50Fbxz7EBS20phJaV3Uhlv9jXr7c3cnyi6UdsYgNTaMqLSS5XZLwYQhFheRGMrcHH1a7NVSKzbrMbcX7Wu3sVd6RgzQ77CqbodLXN20CnAShjUf2R+azHYBBwq5L4y9OA+72EjcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363866; c=relaxed/simple;
	bh=EET7AEqsqeNKGUh2djycBsR6CuvbqaXpc6GyzCzF1uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGkKR//cgjylRCwAtMFd3YX+OIbKa017jh035eajcUhEeROT+4Feot2kHppYMvP/u3f+CHKc3xYdiOeUXl3RPuP4HfY+AWSsBLsrDvSEpEroBpTzpqSNq0nPr2oXUlfBjIVnESq5S3QiMQMEK55/QKSgCcwQwOykXt9zrMr6hCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtOBSa+Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtOBSa+Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB08C2BCAF;
	Thu, 16 Apr 2026 18:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776363865;
	bh=EET7AEqsqeNKGUh2djycBsR6CuvbqaXpc6GyzCzF1uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AtOBSa+ZrmPjRc3npo+3iI35i2uEA4vTVE9yk686rN3DHUu3ws4f+TfZfDMSXBWxt
	 keL3RrBXqFcCRB4lohq3VRewIEvEvDMk6IUGFhrZtpYM6soYyuQk4fjOUp4aOTEACk
	 ZE76HwcWXm8F1xnkSEUU+nVPzUraUGGoWmj3FX7h+XwhbLdyPN5p/90xK8xfqJeI54
	 Thauo5LHFrD2uSJO1CKgd8+WqpkBx6atfkfsGy/IL9IRB7y/JdeM+dag9XvySiQ0a1
	 1jmZhX1wu2YZsC6vUMylAaRwIGYgsIo2h61jJDF8gJNQFOb5i/ygH3chfd086V3vXJ
	 I86QMs7FNqtqQ==
Date: Thu, 16 Apr 2026 11:24:23 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
	Mingwei Zhang <mizhang@google.com>,
	Stephane Eranian <eranian@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [PATCH 1/4] perf/x86/intel: Don't write PEBS_ENABLED on
 host<=>guest xfers if CPU has isolation
Message-ID: <aeEpV9kfBSQrxwm-@google.com>
References: <20260414191425.2697918-1-seanjc@google.com>
 <20260414191425.2697918-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260414191425.2697918-2-seanjc@google.com>

Hello,

On Tue, Apr 14, 2026 at 12:14:22PM -0700, Sean Christopherson wrote:
> When filling the list of MSRs to be loaded by KVM on VM-Enter and VM-Exit,
> *never* insert an entry for PEBS_ENABLED if the CPU properly isolates PEBS
> events, in which case disabling counters via PERF_GLOBAL_CTRL is sufficient
> to prevent unwanted PEBS events in the guest (or host).  Because perf loads
> PEBS_ENABLE with the unfiltered cpu_hw_events.pebs_enabled, i.e. with both
> host and guest masks, there is no need to load different values for the
> guest versus host, perf+KVM can and should simply control which counters
> are enabled/disabled via PERF_GLOBAL_CTRL.
> 
> Avoiding touching PEBS_ENABLED fixes a bug where PEBS_ENABLED can end up
> with "stuck" bits if a PEBS event is throttled better generating the list
> and actually entering the guest (Intel CPUs can't arbtitrarily block NMIs).
> And stating the obvious, leaving PEBS_ENABLED as-is avoids two MSR writes
> on every VMX transition.
> 
> Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Mingwei Zhang <mizhang@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/events/intel/core.c | 42 ++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 793335c3ce78..002d809f82ef 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4999,12 +4999,15 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>  	struct kvm_pmu *kvm_pmu = (struct kvm_pmu *)data;
>  	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
>  	u64 pebs_mask = cpuc->pebs_enabled & x86_pmu.pebs_capable;
> -	int global_ctrl, pebs_enable;
> +	u64 guest_pebs_mask = pebs_mask & ~cpuc->intel_ctrl_host_mask;
> +	int global_ctrl;
>  
>  	/*
>  	 * In addition to obeying exclude_guest/exclude_host, remove bits being
>  	 * used for PEBS when running a guest, because PEBS writes to virtual
> -	 * addresses (not physical addresses).
> +	 * addresses (not physical addresses).  If the guest wants to utilize
> +	 * PEBS, and PEBS can safely enabled in the guest, bits for the guest's
> +	 * PEBS-enabled counters will be OR'd back in as appropriate.
>  	 */
>  	*nr = 0;
>  	global_ctrl = (*nr)++;
> @@ -5051,24 +5054,25 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>  		};
>  	}
>  
> -	pebs_enable = (*nr)++;
> -	arr[pebs_enable] = (struct perf_guest_switch_msr){
> -		.msr = MSR_IA32_PEBS_ENABLE,
> -		.host = cpuc->pebs_enabled & ~cpuc->intel_ctrl_guest_mask,
> -		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask & kvm_pmu->pebs_enable,
> -	};
> -
> -	if (arr[pebs_enable].host) {
> -		/* Disable guest PEBS if host PEBS is enabled. */
> -		arr[pebs_enable].guest = 0;
> -	} else {
> -		/* Disable guest PEBS thoroughly for cross-mapped PEBS counters. */
> -		arr[pebs_enable].guest &= ~kvm_pmu->host_cross_mapped_mask;
> -		arr[global_ctrl].guest &= ~kvm_pmu->host_cross_mapped_mask;
> -		/* Set hw GLOBAL_CTRL bits for PEBS counter when it runs for guest */
> -		arr[global_ctrl].guest |= arr[pebs_enable].guest;
> -	}
> +	/*
> +	 * Disable counters where the guest PMC is different than the host PMC
> +	 * being used on behalf of the guest, as the PEBS record includes
> +	 * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
> +	 * wrong counter(s).  Similarly, disallow PEBS in the guest if the host
> +	 * is using PEBS, to avoid bleeding host state into PEBS records.
> +	 */
> +	guest_pebs_mask &= kvm_pmu->pebs_enable & ~kvm_pmu->host_cross_mapped_mask;
> +	if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
> +		guest_pebs_mask = 0;
>  
> +	/*
> +	 * Do NOT mess with PEBS_ENABLED.  As above, disabling counters via
> +	 * PERF_GLOBAL_CTRL is sufficient, and loading a stale PEBS_ENABLED,
> +	 * e.g. on VM-Exit, can put the system in a bad state.  Simply enable
> +	 * counters in PERF_GLOBAL_CTRL, as perf load PEBS_ENABLED with the
> +	 * full value, i.e. perf *also* relies on PERF_GLOBAL_CTRL.
> +	 */
> +	arr[global_ctrl].guest |= guest_pebs_mask;

I was confused by the earlier comment in the funcion that says it is not
enough to disable counters but I've realized it's only for the case PEBS
isolation is not supported by CPU/ucode.

I think it's ok for disabling guest PEBS, but I'm curious if there's a
case to enable PEBS only in guest and it'd be handled correctly.

Thanks,
Namhyung

>  	return arr;
>  }
>  
> -- 
> 2.54.0.rc0.605.g598a273b03-goog
> 
