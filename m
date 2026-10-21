Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792565962;
	b=VDfw5PwbUeIMEqJQr/3PwjH76rB4zoFJ6SKB4z9CLm7c3nSWvHKF5BCs/DRPj59DCAtu
	 8URGayizbosQ6KWIN52UVQoF+iS3NC+06xI6dPqjwvXMNRzhZ3/I0+ZmsM5W3HuvRvAC3
	 gbcRX0+F4LN8SsyzjGdkyv7yvoDejg/7T3Sd81LSUReN8KM3l3HV/Tf/Cg4Qolg8iTpDn
	 2+OGIrDejmr0ooXcMqsFLZHwBvIbi2SR2+DVVUf6sNDi0ctY4ENrFfjaXIotwlNh6LcJ5
	 2vQM7d4M/cwWIcns9pPOEHuThZ9xG/DJVYQi7IpPJRCH2RQDE5P2329MzYblcbbELgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565962;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Lq4BkkFI9gjoEGXPVNlMaanSlhd6OXQdZ6pgRoMGZQg=;
	b=ypSDRSHgrC6ccchFBxyCc7q2TBBeclXnWtsAa2kD1DeZbHuSyis62FZa8KNryNhjJEps
	 YmV9Y+jaE7u+VDjGj7bFYqIMbOqy2GCJ0JGns3YskAtSlZJsNZDkBnjAXpxpkmSrj1NQR
	 QVPZqN1X5qjA3cEbQ8ormEqDPmsfq7sQfzjXqtTwYDRRxegoOwwrE5NWlUS1cvOdCWZ2E
	 fFwCo+Rp6xpiCHb/LF47i71++f9d59PglEVhL9ww1ynEkMxZvXVJvgTMG5IRlQk3sSf+N
	 P4cAkmr5voQo1exQyjluwF95UgIjj2fEDZSxzSGP9aNehIXXYFObgYSxHAurQ3AoLOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="FZb/wjp/";
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D76606A31A;
	Wed, 21 Oct 2026 06:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24D76606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FZb/wjp/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792565963; x=1824101963;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lFLwbry7H3titTEgipKlI5PazJVchb8dodkdEPspUO0=;
  b=FZb/wjp/8geC96eM3GdYEe9iO9fcuCwGlr7sB/Zsy4GV65OMJrm65eUh
   R5HxQv2Q5/KLoAz8nozV5QFCgyL93//lJbcX4vLYE/PxlFs4X7s7BpkiH
   44WbUSq5lJTaQykY/6ZoKkW7ZNepqhSQqIoTrxem8rvxZOlZql7XnbQcE
   X+q4cO2zkhZRh8W3MhNThIm6KWuAPn/X3dusWyZWNf1l8KDv5aQp6DkxW
   YSXlg+EQYl6Vkb/X04AH7ofskfeXu47cb+s7oGUdkigmCVEYn9TnAfMc2
   VSJc4AONphBIcq3dZSnjreN7zBYymKqOTqNHI+UngWpBZNT8IilGPZxNb
   A==;
X-CSE-ConnectionGUID: 0FYWC1lBSZ23ikK6dR8JDQ==
X-CSE-MsgGUID: a9rPMfG9Rfu1VycpHgIVlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1175511"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1175511"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:59:22 -0700
X-CSE-ConnectionGUID: UdE7TSTtSMuE6QXo0JssDw==
X-CSE-MsgGUID: IrI3onQEQSmu1DR/ginlHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3014450"
Received: from unknown (HELO [10.238.3.193]) ([10.238.3.193])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 23:59:18 -0700
Message-ID: <b8fbf942-22e5-4b4d-865b-3b024b4e50c7@linux.intel.com>
Date: Wed, 21 Oct 2026 14:59:15 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 5/5] pef/x86/intel: Always snapshot live hardware LBR
 state for BPF path
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Sandipan Das <sandipan.das@amd.com>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20261021050711.4043703-1-dapeng1.mi@linux.intel.com>
 <20261021050711.4043703-6-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261021050711.4043703-6-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Sashiko found several new long-standing LBR issues (not caused by the patch
series), https://lore.kernel.org/all/sashiko-outbox-179823@kernel.org/

Would post new patch series to fix the newly found issues. Thanks.

On 10/21/2026 1:07 PM, Dapeng Mi wrote:
> __intel_pmu_snapshot_branch_stack() is meant to snapshot the current
> runtime LBR state from hardware for the BPF path. However, stale cached
> PEBS LBR data can be snapshotted instead when a PEBS LBR user is active.
>
> Fix this by always snapshotting the live hardware LBR state, regardless
> of whether a PEBS LBR user is active. Reading the runtime LBR registers
> can overwrite the cached PEBS LBR stack, so save and restore the cached
> PEBS LBR state around the snapshot. This preserves the PEBS LBR data for
> later output to userspace in the normal PEBS record path.
>
> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 43 ++++++++++++++++++++++++++++++++++--
>  arch/x86/events/intel/lbr.c  |  9 --------
>  2 files changed, 41 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 5dfb9e9156e8..07d1a8a7845b 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2815,16 +2815,50 @@ static void intel_pmu_enable_all(int added)
>  	__intel_pmu_enable_all(added, false);
>  }
>  
> +struct lbr_snapshot {
> +	struct perf_branch_stack stack;
> +	struct perf_branch_entry entries[MAX_LBR_ENTRIES];
> +	u64 counters[MAX_LBR_ENTRIES];
> +};
> +static DEFINE_PER_CPU(struct lbr_snapshot, lbr_snapshot);
> +
>  static noinline int
>  __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
>  				  unsigned int cnt, unsigned long flags)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	struct lbr_snapshot *snapshot = this_cpu_ptr(&lbr_snapshot);
> +
> +	/*
> +	 * This may be called from bpf_event_handler() in a PMI context. If
> +	 * a PEBS LBR user is active, the PEBS sample record has already updated
> +	 * cpuc->lbr_stack. Reading the LBR registers here would overwrite that
> +	 * cached PEBS LBR stack, so save it first and restore it afterward. This
> +	 * keeps the cached LBR data available for later output to userspace in
> +	 * the normal PEBS record path.
> +	 */
> +	if (cpuc->lbr_pebs_users) {
> +		memcpy(&snapshot->stack, &cpuc->lbr_stack,
> +		       sizeof(struct perf_branch_stack));
> +		memcpy(snapshot->entries, cpuc->lbr_entries,
> +		       sizeof(struct perf_branch_entry) * cpuc->lbr_stack.nr);
> +		memcpy(snapshot->counters, cpuc->lbr_counters,
> +		       sizeof(u64) * cpuc->lbr_stack.nr);
> +	}
>  
>  	intel_pmu_lbr_read();
>  	cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
> -
>  	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
> +
> +	if (cpuc->lbr_pebs_users) {
> +		memcpy(&cpuc->lbr_stack, &snapshot->stack,
> +		       sizeof(struct perf_branch_stack));
> +		memcpy(cpuc->lbr_entries, snapshot->entries,
> +		       sizeof(struct perf_branch_entry) * cpuc->lbr_stack.nr);
> +		memcpy(cpuc->lbr_counters, snapshot->counters,
> +		       sizeof(u64) * cpuc->lbr_stack.nr);
> +	}
> +
>  	intel_pmu_enable_all(0);
>  	local_irq_restore(flags);
>  	return cnt;
> @@ -4022,7 +4056,12 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
>  
>  	loops = 0;
>  again:
> -	intel_pmu_lbr_read();
> +	/*
> +	 * No need to read the LBR stack when all LBR users are PEBS events,
> +	 * since the PEBS handler updates it.
> +	 */
> +	if (cpuc->lbr_users != cpuc->lbr_pebs_users)
> +		intel_pmu_lbr_read();
>  	intel_pmu_ack_status(status);
>  	if (++loops > 100) {
>  		static bool warned;
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index ac1759a71288..07b32255e48d 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1030,15 +1030,6 @@ void intel_pmu_lbr_read(void)
>  		return;
>  	}
>  
> -	/*
> -	 * Don't read when all LBRs users are using adaptive PEBS.
> -	 *
> -	 * This could be smarter and actually check the event,
> -	 * but this simple approach seems to work for now.
> -	 */
> -	if (cpuc->lbr_users == cpuc->lbr_pebs_users)
> -		return;
> -
>  	x86_pmu.lbr_read(cpuc);
>  
>  	intel_pmu_lbr_filter(cpuc);
