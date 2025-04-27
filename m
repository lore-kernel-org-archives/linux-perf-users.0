Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8DA24E4A9;
	Sun, 27 Apr 2025 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745745053; cv=none; b=cG5d8C8fzuV/aNIa9EeyNk9y5mAVBsTuBblIFgN6GKPSZB26uDYT0pDSHVifHM+NaoZZZkxn4h3qtPgziZSieH7MvNAiV8FpOzsJ7B2VRR9W2gjMSJFrAcAi4jMSj/U89NAlYBBbeWuBHr4jyybEI4QTNCDWS5Py+WTZhdnSLVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745745053; c=relaxed/simple;
	bh=l27j9bbFzg5WdPYW60QEheUSRLlp0arn/ghs/Nzwozo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iEZPkaHJd9a0A6RIK/K3CGycPiyDHwaS9iwdTcXXmfOU4N/Y4pwnzfig6mR3aL7tfBzzJnMtziNWbHuDgHq3HtMm6Y2X2xDZCZSRvwKQIS0XKA7Fpkot6qIbf7ddvdxWfEwtj87Sp2Ogo0Uyr4Yc4h+IKwia0Nv777NGjAV34L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wmw2akk6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wmw2akk6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745745051; x=1777281051;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l27j9bbFzg5WdPYW60QEheUSRLlp0arn/ghs/Nzwozo=;
  b=Wmw2akk65oG1R4ymJEGFNtunTiXzQVaUlUK0EQf8iW7cMHanuM1S+5P7
   JmmfkLypMevtVswcgjIG6D3//q4LHg0+G2VfOURKczBVXVAL6FdtuXDY6
   +4VJFAn6z9QTdQiqgO1KfoHe6OffvsyxbNbxJQXMwiR53ee1yXnvGZ8Rd
   QJS1JCV6JOiSsljYbssf2QOAWBspaTNkhSXqiwzC1V1K+sl0xNQT/y+X+
   QcqFt2shl15xyPcAzK7CaQVkH3DR8+sxrhGkoxDu6mCuTx7Tsc344MkoA
   KtmuhjT3xVAwWeAM76LR5yLttqfJuOx3cF6BA5QE68nMfOWxcXiZ5FPvD
   w==;
X-CSE-ConnectionGUID: uYDaokDHQ3KBt1oePv+0JQ==
X-CSE-MsgGUID: N7VQM6NORoSXWl6jxFRWDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="57994264"
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="57994264"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 02:10:50 -0700
X-CSE-ConnectionGUID: vpIpS3DeTp2CXfSkUqwIig==
X-CSE-MsgGUID: 3vCkie5AToGeIrdu6tlCCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,243,1739865600"; 
   d="scan'208";a="134202862"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 02:10:47 -0700
Message-ID: <701a94eb-feac-4578-850c-5b1f015877af@linux.intel.com>
Date: Sun, 27 Apr 2025 17:10:44 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for guest
 with vCPU's value.
To: Sean Christopherson <seanjc@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Seth Forshee <sforshee@kernel.org>
References: <20250426001355.1026530-1-seanjc@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250426001355.1026530-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/26/2025 8:13 AM, Sean Christopherson wrote:
> When generating the MSR_IA32_PEBS_ENABLE value that will be loaded on
> VM-Entry to a KVM guest, mask the value with the vCPU's desired PEBS_ENABLE
> value.  Consulting only the host kernel's host vs. guest masks results in
> running the guest with PEBS enabled even when the guest doesn't want to use
> PEBS.  Because KVM uses perf events to proxy the guest virtual PMU, simply
> looking at exclude_host can't differentiate between events created by host
> userspace, and events created by KVM on behalf of the guest.
>
> Running the guest with PEBS unexpectedly enabled typically manifests as
> crashes due to a near-infinite stream of #PFs.  E.g. if the guest hasn't
> written MSR_IA32_DS_AREA, the CPU will hit page faults on address '0' when
> trying to record PEBS events.
>
> The issue is most easily reproduced by running `perf kvm top` from before
> commit 7b100989b4f6 ("perf evlist: Remove __evlist__add_default") (after
> which, `perf kvm top` effectively stopped using PEBS).	The userspace side
> of perf creates a guest-only PEBS event, which intel_guest_get_msrs()
> misconstrues a guest-*owned* PEBS event.
>
> Arguably, this is a userspace bug, as enabling PEBS on guest-only events
> simply cannot work, and userspace can kill VMs in many other ways (there
> is no danger to the host).  However, even if this is considered to be bad
> userspace behavior, there's zero downside to perf/KVM restricting PEBS to
> guest-owned events.
>
> Note, commit 854250329c02 ("KVM: x86/pmu: Disable guest PEBS temporarily
> in two rare situations") fixed the case where host userspace is profiling
> KVM *and* userspace, but missed the case where userspace is profiling only
> KVM.
>
> Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
> Reported-by: Seth Forshee <sforshee@kernel.org>
> Closes: https://lore.kernel.org/all/Z_VUswFkWiTYI0eD@do-x1carbon
> Cc: stable@vger.kernel.org
> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/events/intel/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index cd6329207311..75a376478b21 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4625,7 +4625,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>  	arr[pebs_enable] = (struct perf_guest_switch_msr){
>  		.msr = MSR_IA32_PEBS_ENABLE,
>  		.host = cpuc->pebs_enabled & ~cpuc->intel_ctrl_guest_mask,
> -		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask,
> +		.guest = pebs_mask & ~cpuc->intel_ctrl_host_mask & kvm_pmu->pebs_enable,

Although I can't reproduce the guest crash issue on local SPR server, the
logic is correct.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Furthermore,  the below global_ctrl guest value calculation  seems
incorrect as well.

    u64 pebs_mask = cpuc->pebs_enabled & x86_pmu.pebs_capable;

    arr[global_ctrl] = (struct perf_guest_switch_msr){
        .msr = MSR_CORE_PERF_GLOBAL_CTRL,
        .host = intel_ctrl & ~cpuc->intel_ctrl_guest_mask,
        .guest = intel_ctrl & ~cpuc->intel_ctrl_host_mask & ~pebs_mask,
    };

For guest PEBS events, its HW counter idx would be set into
cpuc->pebs_enabled as well, so the calculated guest value would clear the
corresponding bit of the guest PEBS events. Thus the guest PEBS events
should not be enabled in non-root mode, but coincidentally since the
calculated host and guest value of global_ctrl MSR is same,
atomic_switch_perf_msrs() doesn't really write the guest value into
GLOBAL_CTRL MSR before vm-entry and GLOBAL_CTRL MSR still keeps the default
value (all HW counters are enabled). That's why we see guest PEBS still works.

for (i = 0; i < nr_msrs; i++)
        if (msrs[i].host == msrs[i].guest)
            clear_atomic_switch_msr(vmx, msrs[i].msr);
        else
            add_atomic_switch_msr(vmx, msrs[i].msr, msrs[i].guest,
                    msrs[i].host, false);

Currently we have this Sean's fix, only the guest PEBS event bits of
IA32_PEBS_ENABLE MSR are enabled in non-root mode, suppose we can simply
change global_ctrl guest value calculation to this.

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 09d2d66c9f21..5bc56bb616ec 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4342,9 +4342,12 @@ static struct perf_guest_switch_msr
*intel_guest_get_msrs(int *nr, void *data)
        arr[global_ctrl] = (struct perf_guest_switch_msr){
                .msr = MSR_CORE_PERF_GLOBAL_CTRL,
                .host = intel_ctrl & ~cpuc->intel_ctrl_guest_mask,
-               .guest = intel_ctrl & ~cpuc->intel_ctrl_host_mask & ~pebs_mask,
+               .guest = intel_ctrl & ~cpuc->intel_ctrl_host_mask,
        };

>  	};
>  
>  	if (arr[pebs_enable].host) {
>
> base-commit: 2492e5aba2be064d0604ae23ae0770ecc0168192
