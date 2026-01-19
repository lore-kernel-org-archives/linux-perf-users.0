Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07837277CAF;
	Mon, 19 Jan 2026 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808298; cv=none; b=vFs8uoGUxEs7ak4/3Ij/N1OBgZzG6gwYkX0w38MIKmuEtpx7xbsdr/6ClQW9u4WuQcNdAxCuW/payqJ8I3KZiJ+/slGlmFhW7JXMSrCs+wJJwTKi7HcNy/88R73l6WfCLiTZczKQ33lBotCwQAOiEjxsMU7jFo6shjYsAdf4uHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808298; c=relaxed/simple;
	bh=JoH1DSTlUbe4mzS1ORqIMcGBCUe5KB3rwzHLQE5e60E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BeptI9IndiWdlWBsUKzq0B/0uz99nIj/Xt1KFHX/U6oMgR52ibUzB0RrNqhw7g+NDeLY6v8n7O4Al8Zd1Vrq216R+oA5s65tslEw2kKrd7cKjtbYpXq+4fSnhNQNK9fHWzynpKqhKh5EWyHPZi16dbDI4+jHk7rLYAX7ct7u46g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TyEh3Wjz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TyEh3Wjz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768808298; x=1800344298;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JoH1DSTlUbe4mzS1ORqIMcGBCUe5KB3rwzHLQE5e60E=;
  b=TyEh3WjzxKZ9PfYwX4OOUX5rzLk+JxPBn61e8PsReFPVLJkLoPzfNDe1
   h4XpP5TnOgLQ2NObBfTiEFSJqNbQDUytZe9yvotrO8XZqgBT8Vt9R1uo5
   qz2bRRAOocE8mkbAcv3Z4AUJWReUA0AXz5fC6/MJDU5LC6mxCa7FDMME7
   r2YXQczWBiKRBDAtUVJK3qGFfdJXtexd2zyz0fvhndXiYjS9x5ONs0Ex2
   mFdKxRF31K9sjOEmdnkZddMgNXQwbssFJaD7x+GG9Uogko3dIC+AFrmr1
   AR9fOD4ucByfxQd0rQVstTzzllsqOMksdegT9xSWBlSsaflXqmY1/cOdb
   w==;
X-CSE-ConnectionGUID: FVhJGw7sSjSfLpTib/btOw==
X-CSE-MsgGUID: bsBY+ojuRrOJGgH3HPijwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="87430168"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="87430168"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:38:17 -0800
X-CSE-ConnectionGUID: XcJmpoDSQUyM+PRwV9cdkQ==
X-CSE-MsgGUID: mC5hlVcjRZijcNM76/HpCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="206155423"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:38:13 -0800
Message-ID: <9b1806c7-c1ae-44f4-a03a-2a607dcf144e@linux.intel.com>
Date: Mon, 19 Jan 2026 15:38:11 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] perf/amd/ibs: Define macro for ldlat mask
To: Ravi Bangoria <ravi.bangoria@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Manali Shukla <manali.shukla@amd.com>,
 Santosh Shukla <santosh.shukla@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, Sandipan Das <sandipan.das@amd.com>
References: <20260116033450.965-1-ravi.bangoria@amd.com>
 <20260116033450.965-6-ravi.bangoria@amd.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260116033450.965-6-ravi.bangoria@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/16/2026 11:34 AM, Ravi Bangoria wrote:
> Load latency filter threshold is encoded in config1[11:0]. Define a mask
> for it instead of hardcoded 0xFFF. Unlike "config" fields whose layout
> maps to PERF_{FETCH|OP}_CTL MSR, layout of "config1" is custom defined
> so a new set of macros are needed for "config1" fields.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 27b764eee6c7..02e7bffe1208 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -32,6 +32,9 @@ static u32 ibs_caps;
>  /* attr.config2 */
>  #define IBS_SW_FILTER_MASK	1
>  
> +/* attr.config1 */
> +#define IBS_OP_CONFIG1_LDLAT_MASK		(0xFFFULL <<  0)
> +
>  /*
>   * IBS states:
>   *
> @@ -274,7 +277,7 @@ static bool perf_ibs_ldlat_event(struct perf_ibs *perf_ibs,
>  {
>  	return perf_ibs == &perf_ibs_op &&
>  	       (ibs_caps & IBS_CAPS_OPLDLAT) &&
> -	       (event->attr.config1 & 0xFFF);
> +	       (event->attr.config1 & IBS_OP_CONFIG1_LDLAT_MASK);
>  }
>  
>  static int perf_ibs_init(struct perf_event *event)
> @@ -349,7 +352,7 @@ static int perf_ibs_init(struct perf_event *event)
>  	}
>  
>  	if (perf_ibs_ldlat_event(perf_ibs, event)) {
> -		u64 ldlat = event->attr.config1 & 0xFFF;
> +		u64 ldlat = event->attr.config1 & IBS_OP_CONFIG1_LDLAT_MASK;
>  
>  		if (ldlat < 128 || ldlat > 2048)
>  			return -EINVAL;
> @@ -1302,7 +1305,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>  		 * within [128, 2048] range.
>  		 */
>  		if (!op_data3.ld_op || !op_data3.dc_miss ||
> -		    op_data3.dc_miss_lat <= (event->attr.config1 & 0xFFF)) {
> +		    op_data3.dc_miss_lat <= (event->attr.config1 & IBS_OP_CONFIG1_LDLAT_MASK)) {
>  			throttle = perf_event_account_interrupt(event);
>  			goto out;
>  		}

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


