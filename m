Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F83357CEA;
	Mon, 19 Oct 2026 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402294; cv=none; b=QMLBFAatJM0xY7tK0lSceHbQkg7A/2qnTN+d2khF0x3jEmLvAfBD/Sa1t899aJRSjGfKMIiPzi7CAaWI3UbHUqmiDUy9j4olEiuInBHeY6Vfavzq/bOAhHa5naYub3M1r3L0dwQSlD8UafAjE7wnbQG6SM01oN9SN77GqOY2NJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402294; c=relaxed/simple;
	bh=9jnIGsfNtI3Ak6BEIcNPaxhBHE3+X+uso5UgAtnkWiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r0YnECMjT/9dOdJZOdMpKGXv5oIB7vXP0PKGOZwNG6AYUpO9N7Drw2kcmJh3sqc/OOWCZ9vPmnjMbtCnCK6dqA19pO5Zlq5cPYQPPYObJPOo8YIgD/im+oE6ruU9VvHiGVmwq/dlZWdUj8HG98KE+Nh5sJKcz7ulJcdfwtIT2/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSoc0oQA; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSoc0oQA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792402293; x=1823938293;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9jnIGsfNtI3Ak6BEIcNPaxhBHE3+X+uso5UgAtnkWiE=;
  b=nSoc0oQA2jra9110ZxCFN1xNJz5If1kPtuOhWw5cx/LLu7mvSjNZnyDc
   RNXF8M3W3lDHIRXi0T5JFVlhqn5SOxFISFXngctcrgerO38NduSr1vI4W
   QBY3LPWQW0XPV7t1y7QPnd+twHdvRh3LDTiz7ZHn/3BAMBzJIqe7GqxKR
   Z4TAhn+Whe+cZzfHUwHv9SKkPUHaM71gis36ptsKwbopGruM2mX2BdDgo
   3+0pLTTI9BHRN2FYWtTluZn3cTP3qrcxDIyqhafWffwoConBeNAHpQDH9
   Htxw00XaV2XNmxZvIV0fbd23/HirEbEEhCv7EI/mcjUuvBRXAYdePyITP
   g==;
X-CSE-ConnectionGUID: kt6YBTk2QnWgxGUKVoXOfA==
X-CSE-MsgGUID: IZTOxa64S76ESmk3/jqX7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="972598"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="972598"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:31:32 -0700
X-CSE-ConnectionGUID: zLac+zmTQc+z7QkrFFHJ2Q==
X-CSE-MsgGUID: kwB3FMjxRrGEQsqpd1shgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2473212"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:31:27 -0700
Message-ID: <1d56b889-0730-41cc-ac41-976f9ba543c5@linux.intel.com>
Date: Mon, 19 Oct 2026 17:31:24 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 4/4] perf/x86/intel/lbr: Limit branch snapshots to
 valid entries
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
 Xudong Hao <xudong.hao@intel.com>, Sashiko <sashiko-bot@kernel.org>
References: <20261019070836.2972403-1-dapeng1.mi@linux.intel.com>
 <20261019070836.2972403-5-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261019070836.2972403-5-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Sashiko raises new comments about this patch,
https://lore.kernel.org/all/sashiko-outbox-176751@kernel.org/

It looks we need a new version to address the comments. Thanks.

On 10/19/2026 3:08 PM, Dapeng Mi wrote:
> The branch snapshot callback used by bpf_get_branch_snapshot() always
> copies x86_pmu.lbr_nr entries from cpuc->lbr_entries[], even when the
> last LBR read kept fewer branches. The entries past lbr_stack.nr hold
> invalid branches which end up reaching BPF programs.
>
> Limit copying to lbr_stack.nr entries and also reset lbr_stack.nr when
> no active LBR events or LBR hardware is owned by guest. So the stale or
> guest LBR stack data can't be leaked.
>
> When all active LBR users are PEBS events, the LBR stack is already
> updated from the PEBS records, so there is no need to read the LBR
> hardware again.
>
> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-163130@kernel.org/
> Co-developed-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 2 +-
>  arch/x86/events/intel/lbr.c  | 9 +++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 0a34d674df59..5dfb9e9156e8 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2822,7 +2822,7 @@ __intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries,
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  
>  	intel_pmu_lbr_read();
> -	cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
> +	cnt = min_t(unsigned int, cnt, cpuc->lbr_stack.nr);
>  
>  	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
>  	intel_pmu_enable_all(0);
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 249db12e927e..cc0300aba7de 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -1022,14 +1022,19 @@ void intel_pmu_lbr_read(void)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  
> +	if (!cpuc->lbr_users || vlbr_exclude_host()) {
> +		/* Reset lbr_stack.nr to prevent stale data leakage. */
> +		cpuc->lbr_stack.nr = 0;
> +		return;
> +	}
> +
>  	/*
>  	 * Don't read when all LBRs users are using adaptive PEBS.
>  	 *
>  	 * This could be smarter and actually check the event,
>  	 * but this simple approach seems to work for now.
>  	 */
> -	if (!cpuc->lbr_users || vlbr_exclude_host() ||
> -	    cpuc->lbr_users == cpuc->lbr_pebs_users)
> +	if (cpuc->lbr_users == cpuc->lbr_pebs_users)
>  		return;
>  
>  	x86_pmu.lbr_read(cpuc);
