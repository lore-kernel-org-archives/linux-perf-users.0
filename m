Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3750E4B8DE3
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778585429; cv=none; b=axmZxC/Q7Awbg8deuQ1uq0pAPH4aLl27qkAfSvNGSqsN6XhtvVjwOeM7th3UkjhMCMQsriB+J08IJB8yPZGmeGc4F6PhV0roo7bByt1RcHpA2QIrObQqrkF/DSFIC4k1KnGVn8O5KWxXuJIXMPsO624iKHj+2euaS7VOVQhcFVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778585429; c=relaxed/simple;
	bh=8UPDKRZGWDzfyCi7rDkw0Wazc2MlAb8AibQFNpCSEIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFjBS96VqyF3xhfGnxrZOA6TIC89jXqi64XQTNzdsedCQ6NpgGWumfAwQ5ttH55sHAD/PL2TvpCFyVclYYjjn6omilrnQdbgEtKISzFzH2qb3FfxVabUBoUHdetRz6Agm63MbNQik1omJX5Us2zFQ9cBiqR00+8wX3ZuPH3OecA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+G8/GQh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+G8/GQh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778585427; x=1810121427;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8UPDKRZGWDzfyCi7rDkw0Wazc2MlAb8AibQFNpCSEIo=;
  b=A+G8/GQhgsUw5HZ1n9m/5y2V82p/TvqqJaxkd/GXXA8nXmGaG+qqpIrI
   jDCPypAmu1mxCtQL6yh94n1QsIjWpcByD6RwXL46U5CFRuCUdeYeLwZG3
   nTeLXSmrgMHYnalJJ/uitFs4fgsznpfW+6k6rxdJcbGulhy8dnZJ8lNI5
   ypFjaZ8YMqqaIquxsfZ4ySeDdnbEKYwa668KK6jijiZr0cuBeqN0JKkUm
   HGsb2pK9PUHUP6NYojmq0aQ+vqLQc+v3QBEJEdzYwHul8nhLlIZmbTdgs
   EL6fcTTEp379OfjYTzpAWMBIf3vtsWhOJ3n3l7fFqOuw5oAuLtRGtsT+Y
   Q==;
X-CSE-ConnectionGUID: ZuOHKqdbQoChlXPjEvIb9w==
X-CSE-MsgGUID: xvCqFVIxRMWUTLcKBiZuLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="89794753"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="89794753"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 04:30:27 -0700
X-CSE-ConnectionGUID: RjFYg+HTTCOWlChXoDcRAQ==
X-CSE-MsgGUID: lSck8ZzdTVO7EKmykDn9RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="242096049"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 04:30:26 -0700
Message-ID: <ccea937f-8ad5-4a6e-b6a4-917f2ee02579@linux.intel.com>
Date: Tue, 12 May 2026 19:30:23 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] perf/x86/intel: Ensure guest PEBS path doesn't set
 unwanted PERF_GLOBAL_CTRL bits
To: sashiko@lists.linux.dev, Sean Christopherson <seanjc@google.com>
Cc: linux-perf-users@vger.kernel.org
References: <20260508231353.406465-2-seanjc@google.com>
 <20260508234018.F06AEC2BCB0@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260508234018.F06AEC2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/9/2026 7:40 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The host PEBS collision check fails to mask non-counter bits, incorrectly disabling guest PEBS for events like Store Latency.
> --
>
> Note: The format of this report has been altered due to recitation
> restrictions. The original patch code is not quoted directly, and findings are
> provided as a free-form summary.
>
> commit 39adc53b360e88595a3be6fc59b18b048d9e9921
> Author: Sean Christopherson <seanjc@google.com>
>
> perf/x86/intel: Ensure guest PEBS path doesn't set unwanted PERF_GLOBAL_CTRL bits
>
> This commit masks the pebs counter values being reinstated into the global
> control msr for a guest with perf's desired value. This is done to ensure the
> hypervisor doesn't unintentionally enable counters.
>
> In intel_guest_get_msrs(), the host pebs collision check evaluates the host
> field of the pebs_enable array entry to determine if the host is actively
> using pebs. If it is, guest pebs is disabled.
>
> Is it possible for this check to falsely detect a host collision due to
> non-counter bits being set?
>
> When a guest configures a store latency pebs event, a backing perf event is
> created. In intel_pmu_pebs_enable(), this sets both the counter index bit
> and bit 63 in cpuc->pebs_enabled.
>
> Because the host field is calculated as cpuc->pebs_enabled masked against
> the inverse of cpuc->intel_ctrl_guest_mask, and the guest mask exclusively
> tracks valid counter indices (never including bit 63), bit 63 remains set in
> the host field.
>
> Consequently, the check for whether the host is actively using pebs will
> evaluate to true even when only the guest is using pebs. This introduces a
> regression where guest pebs is completely disabled, silently breaking guest
> store latency events.
>
> Should the host pebs usage evaluation also be masked by intel_ctrl to prevent
> non-counter bits from triggering a false collision?

Hmm, I suspect if the issue could happen on real hardwares.  

The function intel_pmu_pebs_enable() indeed sets extra bits into
cpuc->pebs_enabled for load latency and specific store events, like below
code shows.

```

......

    if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) && (x86_pmu.version < 5))
        cpuc->pebs_enabled |= 1ULL << (hwc->idx + 32);
    else if (event->hw.flags & PERF_X86_EVENT_PEBS_ST)
        cpuc->pebs_enabled |= 1ULL << 63;

......

```

But these 2 cases should only be hit on quite old platforms (prior to
Icelake). On these platforms, only GP counters support PEBS sampling and
pebs_capable would be set PEBS_COUNTER_MASK, and so these extra bits would
be filtered out by the pebs_capable and pebs_mask won't really contain
these extra bits. 

Anyway, we could optimize the code further like below and thoroughly filter
away these extra bits. (only building, not test on real HW)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 854881b5e696..6eee7636a822 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4997,7 +4997,7 @@ static struct perf_guest_switch_msr
*intel_guest_get_msrs(int *nr,
        struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
        struct perf_guest_switch_msr *arr = cpuc->guest_switch_msrs;
        u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
-       u64 pebs_mask = cpuc->pebs_enabled & x86_pmu.pebs_capable;
+       u64 pebs_mask = cpuc->pebs_enabled & x86_pmu.pebs_capable & intel_ctrl;
        u64 guest_pebs_mask;
        int global_ctrl;

@@ -5049,7 +5049,7 @@ static struct perf_guest_switch_msr
*intel_guest_get_msrs(int *nr,
         * the guest wants to use for PEBS, (c) are not excluded from counting
         * in the guest, and (d) _are_ excluded from counting in the host.
         */
-       guest_pebs_mask = pebs_mask & intel_ctrl & guest_pebs->enable &
+       guest_pebs_mask = pebs_mask & guest_pebs->enable &
                          ~cpuc->intel_ctrl_exclude_guest_mask &
                          cpuc->intel_ctrl_exclude_host_mask;

>
