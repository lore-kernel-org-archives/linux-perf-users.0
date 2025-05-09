Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C5A45038;
	Fri,  9 May 2025 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746810092; cv=none; b=KqLZ4V27tuk0k37+IJhKNqZNH3Ot3UsrxwZoFjMjrRm/i+vb6cBIy83W24LpnI9G30XHcN0NaTuFE/UXqNp2ilU8O99mHuZsgv6vbD0jH9MEpD4RUw0bd63Pzh24l1qhxlKhXTjZ1F4J7WWbpKrt3BzICXb8ArS6WtfTuI69B7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746810092; c=relaxed/simple;
	bh=/w4P765IV7uAAFXrKC5J83/GWV8vEEtvplPc++mjWm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0Q3mHmmh+k/cBIRT0SGcoRtSpu2IHxdolQa8MdsBpOxzGG43/y0MPvVVYg6w06s0lLAe1Xn5sDeplkzKeBw1RDkmMRoL3Om6G2GViqycadLEJq5XxdvRCNkSlmoyD5pEyXPKfQwVub09WX8tb5iI5DaWAr27IfWuqy1fE5Gmvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fMR5aum8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fMR5aum8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746810090; x=1778346090;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/w4P765IV7uAAFXrKC5J83/GWV8vEEtvplPc++mjWm8=;
  b=fMR5aum8O3h2Yl2UCn8Ko0NWtjlfQJYwLyYORxluNXWVm29r2vAae1S5
   mkHXeJCS9dAhyf/A6I/O8FTjmtvxPLVrnCKlUioUTIkHPXkUinzeoTSBY
   p1a6ywlJ+5lmu/rVOOrZwh2+F1vKbsyIQ7GnC53ww3dz+vztVDrEWXm1T
   aI9EDEzAUsST7o9QLc9dP5VBUidDAcd4rtF9vXbVJkeW1r8AHI6dBL+u/
   m0eYuHJVUeRop5rXx/GD1m79kjMTJtNEaBq4QFlChLhrf+FkBj10zbRor
   2cuLMraDxNM839jmP9qbN+raAmrCGdbidXdDylugXzFNhAaetF7gwBuaq
   Q==;
X-CSE-ConnectionGUID: vHxQt2zEQbmzT07y0hr18A==
X-CSE-MsgGUID: /UFo65DeQlaTqGTPMojf5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48562114"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="48562114"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 10:01:12 -0700
X-CSE-ConnectionGUID: Vud84jh6Qqq6txVXDtu69w==
X-CSE-MsgGUID: iPpdFma3SDC0m1e4Z47sTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="141781628"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 10:01:11 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id AC97120B5736;
	Fri,  9 May 2025 10:01:10 -0700 (PDT)
Message-ID: <467513ae-3d02-4639-97e9-a5f0d3451a7b@linux.intel.com>
Date: Fri, 9 May 2025 13:01:09 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: Fix segfault with PEBS-via-PT with
 sample_freq
To: Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20250508134452.73960-1-adrian.hunter@intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250508134452.73960-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-08 9:44 a.m., Adrian Hunter wrote:
> Currently, using PEBS-via-PT with a sample frequency instead of a sample
> period, causes a segfault.  For example:
> 
>  [  103.607823] BUG: kernel NULL pointer dereference, address: 0000000000000195
>  [  103.607876]  <NMI>
>  [  103.607879]  ? __die_body.cold+0x19/0x27
>  [  103.607885]  ? page_fault_oops+0xca/0x290
>  [  103.607891]  ? exc_page_fault+0x7e/0x1b0
>  [  103.607897]  ? asm_exc_page_fault+0x26/0x30
>  [  103.607901]  ? intel_pmu_pebs_event_update_no_drain+0x40/0x60
>  [  103.607903]  ? intel_pmu_pebs_event_update_no_drain+0x32/0x60
>  [  103.607905]  intel_pmu_drain_pebs_icl+0x333/0x350
>  [  103.607910]  handle_pmi_common+0x272/0x3c0
>  [  103.607919]  intel_pmu_handle_irq+0x10a/0x2e0
>  [  103.607922]  perf_event_nmi_handler+0x2a/0x50
> 
> That happens because intel_pmu_pebs_event_update_no_drain() assumes all the
> pebs_enabled bits represent counter indexes, which is not always the case.
> In this particular case, bits 60 and 61 are set for PEBS-via-PT purposes.
> 
> The behaviour of PEBS-via-PT with sample frequency is questionable because
> although a PMI is generated (PEBS_PMI_AFTER_EACH_RECORD), the period is not
> adjusted anyway.
> 
> Putting that aside, fix intel_pmu_pebs_event_update_no_drain() by passing
> the mask of counter bits instead of 'size'.  Note, prior to the Fixes
> commit, 'size' would be limited to the maximum counter index, so the issue
> was not hit.
> 
> Fixes: 722e42e45c2f1 ("perf/x86: Support counter mask")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks for the fix.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  arch/x86/events/intel/ds.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index adb2e44761b2..8da1105a419f 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2469,8 +2469,9 @@ static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_
>  				setup_pebs_fixed_sample_data);
>  }
>  
> -static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, int size)
> +static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, u64 mask)
>  {
> +	u64 pebs_enabled = cpuc->pebs_enabled & mask;
>  	struct perf_event *event;
>  	int bit;
>  
> @@ -2481,7 +2482,7 @@ static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, int
>  	 * It needs to call intel_pmu_save_and_restart_reload() to
>  	 * update the event->count for this case.
>  	 */
> -	for_each_set_bit(bit, (unsigned long *)&cpuc->pebs_enabled, size) {
> +	for_each_set_bit(bit, (unsigned long *)&pebs_enabled, X86_PMC_IDX_MAX) {
>  		event = cpuc->events[bit];
>  		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
>  			intel_pmu_save_and_restart_reload(event, 0);
> @@ -2516,7 +2517,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>  	}
>  
>  	if (unlikely(base >= top)) {
> -		intel_pmu_pebs_event_update_no_drain(cpuc, size);
> +		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
>  		return;
>  	}
>  
> @@ -2630,7 +2631,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
>  	       (hybrid(cpuc->pmu, fixed_cntr_mask64) << INTEL_PMC_IDX_FIXED);
>  
>  	if (unlikely(base >= top)) {
> -		intel_pmu_pebs_event_update_no_drain(cpuc, X86_PMC_IDX_MAX);
> +		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
>  		return;
>  	}
>  

