Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEC24C85;
	Thu, 12 Jun 2025 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749750021; cv=none; b=WB9f0n/chlV0tlEUwmycnOE0KY1eWZP6QLkijhP63yiEdpK4clfHOktiSWqqLBUJG8xYP/+RVsJQe2yUPHdHl750MlEC9yYmTiFPJcylZJh++ZkCVbD3DFarPZokG5E3QP+3xbMQc7fsVizPlpaVlCSw/JAskhe35HLLQvT7rxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749750021; c=relaxed/simple;
	bh=SRloaVNpXDaXqvapsg1naBXxSdFMRrgAS0Tqj+PXaAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dAcNOVbDtqUsOketdb/GA2t2SH5+gLGcuWBoZ9mOs2D6xTI9+7KQHKTUYoqWNWyquM68fjmcHKiEv3wmaUU5H8Q78zBQLg16CsHAOnPNEPIXJaoevJhiO3qul/ekpM20w1f6PXW7Bgkr+YbBNFmEmW7Lfx5YTovWWjWCAdP9+rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bibCV43N; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bibCV43N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749750020; x=1781286020;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SRloaVNpXDaXqvapsg1naBXxSdFMRrgAS0Tqj+PXaAM=;
  b=bibCV43Nzu3FIXBJJto9IcNv1/QV8nDt2rVeq2ZtA4sMThoWjNl6BVMm
   YvuoBjOWaomLqXa5oa8PRItrjfr4DB/HbjQFvejMtLcSvi1jDHCSx9GY3
   hBMsqY0v/7es+i1bwCkDPtMaYm3XpEi4Xw9WvLe2+jw7Z5qx69UVR6u+b
   GbuZrmAz6v05PVHoce8VmebLBR9uQK0Ek8mu73EvDnLUiVGeymfeuOpmz
   vGjYqej1cHRyK9UO6hIHRKEhdlo8D4CHn7u7J14eFarn0r4L255GwVP85
   9fjcsG858mU8+2I42vYHb/oj2BEQjLk4S7bPqhJylYGFT0RHZn7GrEDhG
   A==;
X-CSE-ConnectionGUID: uzE7jQk4RH2t6OgX4Cjrlw==
X-CSE-MsgGUID: yT3CHNYYS/2bJy56FOlEPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="39557135"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="39557135"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 10:40:19 -0700
X-CSE-ConnectionGUID: WKrX3G0HQpeZzEORQPlC5g==
X-CSE-MsgGUID: OasHHfLsQOaZ2CDx7ZAp7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="148081340"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 10:40:19 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id E140B20B5736;
	Thu, 12 Jun 2025 10:40:17 -0700 (PDT)
Message-ID: <7961f1f7-d4ef-439c-aead-2b39080f089d@linux.intel.com>
Date: Thu, 12 Jun 2025 13:40:16 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: Fix crashing bug in
 icl_update_topdown_event
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, linux-perf-users@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
Cc: Vince Weaver <vincent.weaver@maine.edu>
References: <20250612143818.2889040-1-kan.liang@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250612143818.2889040-1-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Peter and Ingo,

On 2025-06-12 10:38 a.m., kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The perf_fuzzer found a hard-lock crash on a RaptorLake
> machine.
> 
> Oops: general protection fault, maybe for address 0xffff89aeceab400: 0000
> CPU: 23 UID: 0 PID: 0 Comm: swapper/23
> Tainted: [W]=WARN
> Hardware name: Dell Inc. Precision 9660/0VJ762
> RIP: 0010:native_read_pmc+0x7/0x40
> Code: cc e8 8d a9 01 00 48 89 03 5b cd cc cc cc cc 0f 1f ...
> RSP: 000:fffb03100273de8 EFLAGS: 00010046
> ....
> Call Trace:
>   <TASK>
>   icl_update_topdown_event+0x165/0x190
>   ? ktime_get+0x38/0xd0
>   intel_pmu_read_event+0xf9/0x210
>   __perf_event_read+0xf9/0x210
> 
> The CPUs 16-23 are e-core CPUs that don't support perf metrics feature.
> The icl_update_topdown_event() should not be invoked.
> 
> It's an regression of the commit f9bdf1f95339 ("perf/x86/intel: Avoid
> disable PMU if !cpuc->enabled in sample read"). The is_topdown_event()
> is mistakenly used to replace the is_topdown_count() to check if the
> topdown functions for the perf metrics feature should be invoked.
> The is_topdown_event() only checks the event encoding. It's possible
> that the same encoding 0x0400 is created on an e-core CPU (although
> there is no valid event with such encoding on e-core).
> The is_topdown_count() checks the PERF_X86_EVENT_TOPDOWN flag. Only
> when the topdown events require the perf metrics magic, the flag is set.
> 
> It should be a typo when merging the intel_pmu_auto_reload_read() and
> intel_pmu_read_topdown_event() in the commit.
> 
> Fixes: f9bdf1f95339 ("perf/x86/intel: Avoid disable PMU if !cpuc->enabled in sample read")
> Reported-by: Vince Weaver <vincent.weaver@maine.edu>
> Closes: https://lore.kernel.org/lkml/352f0709-f026-cd45-e60c-60dfd97f73f3@maine.edu/
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Please help to add the tested-by tag from Vince if the patch looks good
to you.

Tested-by: Vince Weaver <vincent.weaver@maine.edu>

https://lore.kernel.org/lkml/da4d8a9a-66a4-32b4-0283-ef4687357349@maine.edu/

Thanks,
Kan> ---
>  arch/x86/events/intel/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index c60b6f199f51..38886cd7aa65 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2826,7 +2826,7 @@ static void intel_pmu_read_event(struct perf_event *event)
>  		 * If the PEBS counters snapshotting is enabled,
>  		 * the topdown event is available in PEBS records.
>  		 */
> -		if (is_topdown_event(event) && !is_pebs_counter_event_group(event))
> +		if (is_topdown_count(event) && !is_pebs_counter_event_group(event))
>  			static_call(intel_pmu_update_topdown_event)(event, NULL);
>  		else
>  			intel_pmu_drain_pebs_buffer();

