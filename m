Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA6C247292;
	Mon, 14 Apr 2025 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640994; cv=none; b=b2FfsCAv5mK5IwK6oKD/Twqdmbu/2qokCQFiSQ24Hz4JrQK526MxfUBPOpAEjtZE1qDuT8Ukm5KhN9EnjUwsKm5j0BDNkx/eFlXlCzusDEuByckAxYR3EXxyKdkiUwr6UxDY/Qty5ocjU/GqUfqKG3Ig4KQadPWV40DuZ4/DdEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640994; c=relaxed/simple;
	bh=Pv5QTCrjFekbxWmq1MabY838sbrhB9iCwkIZ0j0oU6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UgrLE97ELc35+XAJJdgYGI1iTmSqCkPAgAU5kyveN2VdkUbUSzHFp81r6Bk02M7gPrtn4ppwsK1jRVYHYB6ASfhJagNn++oNhJCTK8NrX/ZdsWJkiWvXjvN8L0rh7dAwVm09XFJkorvPxvJrkBTCpUAAPb/X/rv/+yI4PfKP0TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2AgAj9s; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2AgAj9s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744640993; x=1776176993;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Pv5QTCrjFekbxWmq1MabY838sbrhB9iCwkIZ0j0oU6o=;
  b=d2AgAj9s1GkhWr+1c6ecskit1jUsyCxclsFtp47G+yL7UaMKgYM8fbFc
   3o5dN12gXWKSHwNYSAMXZ6dpLDo3wTH+YmVNSbxiXSLxOBcmla81B8l3P
   XNskIgrLjx6fCktg3rbZC7hQpac38YPgh7gWu8JmARn8eCndzQPzwMR3g
   GuEnw1UO+joSL+rW9aoGg4/vVSfP/wHhKE1uGZDNZ3P/pqgBHBy6fipub
   7ZReXaOuM9cKRdIqw6PQJRPBTam6cHIqzTKaFFhLilIjRAYDN3KDNXe0+
   ETvr43vavu1FxorGAIRrGI8GOzRncvGs/8IZb186RY0rG7CRMONTqIQDf
   Q==;
X-CSE-ConnectionGUID: 8RS1ul39TMO3WpBmkf1Jzg==
X-CSE-MsgGUID: 3jp4VokZS2mVXBXbx8CShA==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="63518007"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="63518007"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 07:29:52 -0700
X-CSE-ConnectionGUID: 9pb2hTvjQyO9b3jhGguzjA==
X-CSE-MsgGUID: U9dsM1VbRWOTr7zGqFZrYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="129683270"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 07:29:52 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 2B81A20B5736;
	Mon, 14 Apr 2025 07:29:48 -0700 (PDT)
Message-ID: <342ad7ad-417b-446d-8269-521a1ce9a6c6@linux.intel.com>
Date: Mon, 14 Apr 2025 10:29:47 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: Fix lbr event can placed into non lbr
 group
To: Luo Gengkun <luogengkun@huaweicloud.com>, peterz@infradead.org
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250412091423.1839809-1-luogengkun@huaweicloud.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250412091423.1839809-1-luogengkun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-04-12 5:14 a.m., Luo Gengkun wrote:
> The following perf command can trigger a warning on
> intel_pmu_lbr_counters_reorder.
> 
>  # perf record -e "{cpu-clock,cycles/call-graph="lbr"/}" -- sleep 1
> 
> The reason is that a lbr event are placed in non lbr group. And the
> previous implememtation cannot force the leader to be a lbr event in this
> case. 

Perf should only force the LBR leader for the branch counters case, so
perf only needs to reset the LBRs for the leader.
I don't think the leader restriction should be applied to other cases.

> And is_branch_counters_group will check if the group_leader supports
> BRANCH_COUNTERS.
> So if a software event becomes a group_leader, which
> hw.flags is -1, this check will alway pass.

I think the default flags for all events is 0. Can you point me to where
it is changed to -1?

Thanks,
Kan>
> To fix this problem, using has_branch_stack to judge if leader is lbr
> event.
> 
> Fixes: 33744916196b ("perf/x86/intel: Support branch counters logging")
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> ---
>  arch/x86/events/intel/core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 09d2d66c9f21..c6b394019e54 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4114,6 +4114,13 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  			event->hw.flags |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
>  	}
>  
> +	/*
> +	 * Force the leader to be a LBR event. So LBRs can be reset
> +	 * with the leader event. See intel_pmu_lbr_del() for details.
> +	 */
> +	if (has_branch_stack(event) && !has_branch_stack(event->group_leader))
> +		return -EINVAL;
> +
>  	if (branch_sample_counters(event)) {
>  		struct perf_event *leader, *sibling;
>  		int num = 0;
> @@ -4157,13 +4164,6 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  			  ~(PERF_SAMPLE_BRANCH_PLM_ALL |
>  			    PERF_SAMPLE_BRANCH_COUNTERS)))
>  			event->hw.flags  &= ~PERF_X86_EVENT_NEEDS_BRANCH_STACK;
> -
> -		/*
> -		 * Force the leader to be a LBR event. So LBRs can be reset
> -		 * with the leader event. See intel_pmu_lbr_del() for details.
> -		 */
> -		if (!intel_pmu_needs_branch_stack(leader))
> -			return -EINVAL;
>  	}
>  
>  	if (intel_pmu_needs_branch_stack(event)) {

