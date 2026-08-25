Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F287B2F84F
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 01:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787620397; cv=none; b=cJia34V7gQfq/WfEmp0JqHWAUPQlYRWljVVHsf+I8SL1Mkyj6tZF5vB7afhFmiyZ4YdK3IwwtI20si4mCJACys8xeM3cEif3n+h2XUR/G3Ae7MWHtqAtfRnwMrtDW5LinoXmMetlJuUFBv+piGtwar/diksJ0YO592yTogQ6kZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787620397; c=relaxed/simple;
	bh=n3ldVbnIHEQOycDzDHOPU1g51dHXkcMh7dDCcMby4RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sB/XriWpLPevK+bECIAluqJy0Sx//XcNkdEtrOIt2bl1qquFBc0uDuOQtvpkOa6A0AsY9NE5b0wi2dgenCAnryBQwUs0SVRMHNbRR0qtfxh9pvStKhBfu5USjBJnp3lebakA0e0CYwcT1rT2rDQCb3sXY5+mFLzbdXHFSl+yWz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHXh3Tor; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHXh3Tor"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787620395; x=1819156395;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n3ldVbnIHEQOycDzDHOPU1g51dHXkcMh7dDCcMby4RE=;
  b=bHXh3ToricrQ5B9fwxiQxrqesXceNeJJNdRxSUHAlNAKj8WZ+o80mv2y
   2FGNsJMPucRixf0J6o0i51aWYyek3FQ8KvD1BCreb5Uz2kGAZdJJyNvjS
   BKotffLbEMITDCDzPAkBLTlEs7PkT2VpfC/96UBEVWzgwNtCCVR13bDTc
   GgyuZNWvyrv+b0DgaIxcotEFgnuUv/Mtd8CvxkyjekmqrSfgakELOFGJZ
   03kt3sZyR0d7LSB1JV6zTIo8wGtNZnX9F0BRXr1Tcpo0IMpgme4ISE5h+
   ob6wlQMfHBqx20/1BwV5A2F9YBF8DMwsVT3ma6PgDdpp7EZeIsPBITzKa
   w==;
X-CSE-ConnectionGUID: t5k7UAHKQDSXuVcdxoN6xg==
X-CSE-MsgGUID: G3kw9TjeSCOygvFRy5bYYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="91897774"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="91897774"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 18:13:14 -0700
X-CSE-ConnectionGUID: QujsoWDdRZyavm4tkqvwYQ==
X-CSE-MsgGUID: hsQQxRfbTPu+28eOwrUVoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="265836083"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 18:13:14 -0700
Message-ID: <662c5d2e-0c6f-4d1f-a505-b6dba2ae8a4f@linux.intel.com>
Date: Tue, 25 Aug 2026 09:13:11 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND Patch v10 11/23] perf/x86: Enable XMM register sampling
 for REGS_USER case
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
 <20260824082731.1013973-12-dapeng1.mi@linux.intel.com>
 <20260824101603.6D42D1F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260824101603.6D42D1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/24/2026 6:16 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] NMI re-entrancy corrupts per-CPU `x86_user_regs` during PEBS drains
> --
>
> --- Patch [11]: [RESEND Patch v10 11/23] perf/x86: Enable XMM register sampling for REGS_USER case ---
> commit 1dabe6f859e16c09faeea0ab1b864b14dc315cd4
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Enable XMM register sampling for REGS_USER case
>
> This commit adds support for XMM register sampling in the REGS_USER case.
> It introduces a per-CPU x86_user_regs variable to store REGS_USER-specific
> XMM registers to prevent overwriting by REGS_INTR-specific data. A helper
> function x86_pmu_update_user_xregs() is introduced to read these registers
> from either cached task FPU states or hardware registers.
>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 1c3e2bfa2673a..20140643e21c9 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
> [ ... ]
>> @@ -1832,14 +1826,129 @@ static void x86_pmu_update_regs_intr(struct perf_event *event,
>>  	data->sample_flags |= PERF_SAMPLE_REGS_INTR;
>>  }
>>  
>> +static DEFINE_PER_CPU(struct x86_perf_regs, x86_user_regs);
>> +
>> +static void x86_pmu_get_regs_user(struct perf_sample_data *data,
>> +				  struct pt_regs *regs)
>> +{
>> +	struct x86_perf_regs *x86_regs_user = this_cpu_ptr(&x86_user_regs);
>> +	struct perf_regs regs_user;
>> +
>> +	x86_pmu_clear_perf_regs(&x86_regs_user->regs);
>> +
>> +	perf_get_regs_user(&regs_user, regs);
>> +	data->regs_user.abi = regs_user.abi;
>> +	if (regs_user.regs) {
>> +		x86_regs_user->regs = *regs_user.regs;
>> +		data->regs_user.regs = &x86_regs_user->regs;
>> +	} else {
>> +		data->regs_user.regs = NULL;
>> +	}
>> +}
>> +
>> +/*
>> + * The x86 specific variant of perf_sample_regs_user().
>> + * Update data->regs_user fields for extended registers (e.g., SIMD).
>> + */
>> +static void x86_pmu_update_regs_user(struct perf_event *event,
>> +				     struct perf_sample_data *data,
>> +				     struct pt_regs *regs)
>> +{
>> +	struct x86_perf_regs *x86_regs_user = this_cpu_ptr(&x86_user_regs);
>> +	struct perf_event_attr *attr = &event->attr;
>> +	struct x86_perf_regs *perf_regs;
>> +
>> +	/*
>> +	 * PERF_SAMPLE_REGS_INTR and PERF_SAMPLE_REGS_USER can both be
>> +	 * requested for one event. Keep user regs in a separate x86_perf_regs
>> +	 * instance, so intr-reg collection does not overwrite user-reg data.
>> +	 */
>> +	if (user_mode(regs)) {
>> +		x86_pmu_clear_perf_regs(&x86_regs_user->regs);
>> +		perf_regs = container_of(regs, struct x86_perf_regs, regs);
>> +		/* Copy all sampled regs data to x86_regs_user. */
>> +		*x86_regs_user = *perf_regs;
>> +		data->regs_user.regs = &x86_regs_user->regs;
> [Severity: High]
> Does this code corrupt the un-nested per-CPU x86_user_regs during NMIs?
>
> If a context-switch PEBS drain runs with local IRQs disabled but NMIs enabled,
> a PMI (NMI) could interrupt the drain. If the PMI handler processes a perf event
> requesting REGS_USER, it will call x86_pmu_update_regs_user(), which
> unconditionally overwrites the same per-CPU x86_user_regs variable here without
> in_nmi() protection.
>
> Upon returning from the NMI, the interrupted PEBS drain would resume copying
> the now-corrupted x86_user_regs into the ring buffer, silently corrupting the
> recorded user registers.

The x86_pmu_update_regs_user() is called in two places, one is in the NMI
handler (handle_pmi_common()), which naturally prevents the NMI reentry,
the other place is in the drain_pebs() helper. The patch
https://lore.kernel.org/all/20260813064346.335458-1-dapeng1.mi@linux.intel.com/
would block the drain_pebs() helper reentry.

Thanks.


>
