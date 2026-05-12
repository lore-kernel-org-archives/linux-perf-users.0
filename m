Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56B23002C8;
	Tue, 12 May 2026 04:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778561651; cv=none; b=msVD4x3IPI7QaUIvjX67+0uCPkqQ0nUh4jUOmP0vza4pTW17z8OSKjC8IN+hAwWoCxtUH46PaCmEDFw/cVZWdwG/k1JYHNQSo4e/JtPuKbwZm6y4Jd9qdvfy0hgNWslrZHgA/kXBLI22GvCAhebUrhWBCOJzUrGO7oosTOq+/VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778561651; c=relaxed/simple;
	bh=IiA4yCbpBKdzJxqa6tfSx7AHcN/CioONlv19L2rOz1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwe43/v7Vp1I5bWrxvm2NokyfDUWpex9dQ5sKDgV4J/+5rQyJSNRi2LA2v+YbLnGwbjhbNI9beEmKTnEkhCwxJSJLVZSRJPMW5K7zSJCWEtZKiA8Ys4EvoT8APu/hAg9qvlR5T9ekdIrLO5N3iNgW1Tr6nt7iNMAiEZ0tzaMxco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bdCB4Ys5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bdCB4Ys5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778561649; x=1810097649;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IiA4yCbpBKdzJxqa6tfSx7AHcN/CioONlv19L2rOz1Q=;
  b=bdCB4Ys5ktZD62HKwVp9Ed+mPyRqvlAV7hL0GEkM95jCMsAHRI6dVOTg
   CRhJPAjgShHIsxBCdYqItZ7S/Hmnk28o4KDTDkvtwZOAG7l8zYDVnvrIf
   0CWjq41+UFs2Cs7gZHhwjpgCtoA3n7R3w0ikoYKPtayOD2LBTD1tQTEuB
   CBt0zznmILyzgwRvxXrwkF7ixnlqgi/PdqSnf2pyMxSebksZ1LdbAY1kK
   QjcxvDjESvv09MTH0sSE4V8mPPbXvD3b1evZEFxTKZ7SNh+z4z4UT0a5g
   Hxhf0opmL6hTLdiV7GOyE8H+ViAuEGKDE81fCQvE3HrLSJ9a64WCXs5su
   w==;
X-CSE-ConnectionGUID: rQhswqsMR4KZqrJWwxTyCA==
X-CSE-MsgGUID: XVZO+2fGTuSIlMgvsF8MUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90159605"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="90159605"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 21:53:56 -0700
X-CSE-ConnectionGUID: UF6S4lL1RuW/gARWJFmRhg==
X-CSE-MsgGUID: PpyYLNcFTdyQFxrOHWDLgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="231254272"
Received: from unknown (HELO [10.238.3.169]) ([10.238.3.169])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 21:53:52 -0700
Message-ID: <0a3535cb-b519-4225-9c09-733d47adfe5e@linux.intel.com>
Date: Tue, 12 May 2026 12:53:50 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/9] perf/x86/intel: Don't write PEBS_ENABLED on
 host<=>guest xfers if CPU has isolation
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
 Stephane Eranian <eranian@google.com>
References: <20260508231353.406465-1-seanjc@google.com>
 <20260508231353.406465-3-seanjc@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260508231353.406465-3-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/9/2026 7:13 AM, Sean Christopherson wrote:
> When filling the list of MSRs to be loaded by KVM on VM-Enter and VM-Exit,
> *never* insert an entry for PEBS_ENABLED if the CPU properly isolates PEBS
> events, in which case disabling counters via PERF_GLOBAL_CTRL is sufficient
> to prevent unwanted PEBS events in the guest (or host).  Because perf loads
> PEBS_ENABLE with the unfiltered cpu_hw_events.pebs_enabled, i.e. with both
> host and guest masks, there is no need to load different values for the
> guest versus host, perf+KVM can and should simply control which counters
> are enabled/disabled via PERF_GLOBAL_CTRL.
>
> Avoiding touching PEBS_ENABLED "fixes" a bug where PEBS_ENABLED can end up
> with "stuck" bits if a PEBS event is throttled between generating the list
> and actually entering the guest (Intel CPUs can't arbtitrarily block NMIs).
> Fixes in quotes because leaving PEBS_ENABLED as-is doesn't fix the
> underlying problem of perf (via PMIs) being able to modify state after the
> perf<=>KVM handoff.
>
> But not writing PEBS_ENABLED is desirable no matter what, as stating the
> obvious, leaving PEBS_ENABLED as-is avoids three MSR writes on every VMX
> transition: one each on entry/exit, and one more explicit WRMSR to zero
> PEBS_ENABLED before VM-Entry (KVM assumes the only reason PEBS_ENABLED is
> in the load list is if the CPU lacks isolation and thus needs a quiescent
> period).
>
> Opportunistically add comments to (better) explain the rules for generating
> the set of PEBS counters that will be active while the guest is running,
> along with a FIXME for the suspected hack-a-fix where perf disables guest
> PEBS if _any_ PEBS event is configured to count in the host (commit
> 854250329c02 ("KVM: x86/pmu: Disable guest PEBS temporarily in two rare
> situations") doesn't explain the motivation, at all).
>
> Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Mingwei Zhang <mizhang@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/events/intel/core.c | 55 ++++++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index b70dc35fcceb..13cd12d3eeee 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4999,12 +4999,15 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>  	struct kvm_pmu *kvm_pmu = (struct kvm_pmu *)data;
>  	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
>  	u64 pebs_mask = cpuc->pebs_enabled & x86_pmu.pebs_capable;
> -	int global_ctrl, pebs_enable;
> +	u64 guest_pebs_mask;
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
> @@ -5051,24 +5054,40 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>  		};
>  	}
>  
> -	pebs_enable = (*nr)++;
> -	arr[pebs_enable] = (struct perf_guest_switch_msr){
> -		.msr = MSR_IA32_PEBS_ENABLE,
> -		.host = cpuc->pebs_enabled & ~cpuc->intel_ctrl_guest_mask,
> -		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask & kvm_pmu->pebs_enable,
> -	};
> +	/*
> +	 * Restrict guest PEBS events to counters that (a) perf supports, (b)
> +	 * the guest wants to use for PEBS, (c) are not excluded from counting
> +	 * in the guest, and (d) _are_ excluded from counting in the host.
> +	 */
> +	guest_pebs_mask = pebs_mask & intel_ctrl & kvm_pmu->pebs_enable &
> +			  ~cpuc->intel_ctrl_host_mask &
> +			  cpuc->intel_ctrl_guest_mask;
>  
> -	if (arr[pebs_enable].host) {
> -		/* Disable guest PEBS if host PEBS is enabled. */
> -		arr[pebs_enable].guest = 0;
> -	} else {
> -		/* Disable guest PEBS thoroughly for cross-mapped PEBS counters. */
> -		arr[pebs_enable].guest &= ~kvm_pmu->host_cross_mapped_mask;
> -		arr[global_ctrl].guest &= ~kvm_pmu->host_cross_mapped_mask;
> -		/* Set hw GLOBAL_CTRL bits for PEBS counter when it runs for guest */
> -		arr[global_ctrl].guest |= intel_ctrl & arr[pebs_enable].guest;
> -	}
> +	/*
> +	 * Disable counters where the guest PMC is different than the host PMC
> +	 * being used on behalf of the guest, as the PEBS record includes
> +	 * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
> +	 * wrong counter(s).
> +	 */
> +	guest_pebs_mask &= ~kvm_pmu->host_cross_mapped_mask;
>  
> +	/*
> +	 * FIXME: Allow guest and host usage of PEBS events to co-exist instead
> +	 *        of disabling guest PEBS entirely if the host is using PEBS.
> +	 *        What exactly goes wrong if guest and host are using PEBS is
> +	 *        unknown.
> +	 */
> +	if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
> +		guest_pebs_mask = 0;
> +
> +	/*
> +	 * Do NOT mess with PEBS_ENABLED.  As above, disabling counters via
> +	 * PERF_GLOBAL_CTRL is sufficient, and loading a stale PEBS_ENABLED,
> +	 * e.g. on VM-Exit, can put the system in a bad state.  Simply enable
> +	 * counters in PERF_GLOBAL_CTRL, as perf load PEBS_ENABLED with the
> +	 * full value, i.e. perf *also* relies on PERF_GLOBAL_CTRL.
> +	 */
> +	arr[global_ctrl].guest |= guest_pebs_mask;
>  	return arr;
>  }

LGTM.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


>  
