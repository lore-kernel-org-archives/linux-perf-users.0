Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F3329E0E1;
	Sun,  4 Jan 2026 02:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767494471; cv=none; b=QatJzlLpN27YtKBlhn8OAVvW+oBaz7oUe27YoINNoBAG6npmuIfQ9YBt4/koXqA/xpSo5KbwP0iX0kIvzPWQD9yo/+ReR4Faft/yE4F9XU97QF4qhJuPxi5cHmcjNdQRRqlqFyMwhyUqIGqrpWMfu612buRV3A/jeVWso+jwcZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767494471; c=relaxed/simple;
	bh=Evlu/AyVD5OMlqVAhdWPthzpO3plZhAuzk6EpvM1HJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3Pp8g1jj/p0tq1ePfgRu75Gyer1bbFKAZm7EF+MyBi1MTMN0c/nC/c/Dr/9QhSVm6o9XDe4H/393Xw8u+Y02NyM/yF2htTIhQCvMMVMUf3SMpRNSdUsNsmEls7f5Mv3iBiqlCFJsf/2GKpLL6XNeKok2yEg+8PgV2W6gIo5DxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kgx88gzp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kgx88gzp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767494469; x=1799030469;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Evlu/AyVD5OMlqVAhdWPthzpO3plZhAuzk6EpvM1HJM=;
  b=Kgx88gzph9aBQEryZXTTS2EBG8uLWKd6z8it2mRiLKbqBUGyNPiHHgvI
   /MsfyERPTzPpyWUhzEi+tWa84zkQlx8opFtJfWhJ1k8ToOr0RyeAJdPhL
   WVCHVRbhQq3rog5Bgn9Gd85FEjLukq56YyCamQms3tKcwKHqqBuIqaRP4
   1L971mDd8ZT67EuaKZuwuKhq3CVFhBVLxOY86ZYyadMgaiOqdX0YgZ7B2
   NApluqetmSS4kUA2M9Nt5GVV0KnHsfFYfAN7cO7xEiovcgKL8FU5WQrg4
   BVtEyMKb5Ptk/PaQjlQSy9csbk06UduXlgqFHqgzHvyte/dR2rYLZCYXa
   Q==;
X-CSE-ConnectionGUID: 0WnlrJG/RkO9YT+a9bpoFw==
X-CSE-MsgGUID: H4S8+IclTcmJkaFGlO3FpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68847989"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68847989"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 18:41:08 -0800
X-CSE-ConnectionGUID: ATzFmd2xTHeGxhnM0V9R+Q==
X-CSE-MsgGUID: JyU03ysfTz6RYf+WEjLJPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,200,1763452800"; 
   d="scan'208";a="201226730"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 18:41:05 -0800
Message-ID: <496ac441-b8bf-44a4-a0de-d6e046f20a16@linux.intel.com>
Date: Sun, 4 Jan 2026 10:41:02 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 10/13] perf/x86/intel/uncore: Update DMR uncore
 constraints preliminarily
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>
References: <20251231224233.113839-1-zide.chen@intel.com>
 <20251231224233.113839-11-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251231224233.113839-11-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/1/2026 6:42 AM, Zide Chen wrote:
> Update event constraints base on the latest DMR uncore event list.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V2:
> - make use of the new UNCORE_EVENT_CONSTRAINT_RANGE
>
>  arch/x86/events/intel/uncore_snbep.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index fac2be780276..3f96fcc8562b 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -6660,10 +6660,19 @@ static const struct attribute_group dmr_cxlcm_uncore_format_group = {
>  	.attrs = dmr_cxlcm_uncore_formats_attr,
>  };
>  
> +static struct event_constraint dmr_uncore_cxlcm_constraints[] = {
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x1, 0x24, 0x0f),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x41, 0x41, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x50, 0x5e, 0xf0),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x60, 0x61, 0xf0),
> +	EVENT_CONSTRAINT_END
> +};
> +
>  static struct intel_uncore_type dmr_uncore_cxlcm = {
>  	.name			= "cxlcm",
>  	.event_mask		= GENERIC_PMON_RAW_EVENT_MASK,
>  	.event_mask_ext		= DMR_CXLCM_EVENT_MASK_EXT,
> +	.constraints		= dmr_uncore_cxlcm_constraints,
>  	.format_group		= &dmr_cxlcm_uncore_format_group,
>  	.attr_update		= uncore_alias_groups,
>  };
> @@ -6675,9 +6684,20 @@ static struct intel_uncore_type dmr_uncore_hamvf = {
>  	.attr_update		= uncore_alias_groups,
>  };
>  
> +static struct event_constraint dmr_uncore_cbo_constraints[] = {
> +	UNCORE_EVENT_CONSTRAINT(0x11, 0x1),
> +	UNCORE_EVENT_CONSTRAINT_RANGE(0x19, 0x1a, 0x1),
> +	UNCORE_EVENT_CONSTRAINT(0x1f, 0x1),
> +	UNCORE_EVENT_CONSTRAINT(0x21, 0x1),
> +	UNCORE_EVENT_CONSTRAINT(0x25, 0x1),
> +	UNCORE_EVENT_CONSTRAINT(0x36, 0x1),
> +	EVENT_CONSTRAINT_END
> +};
> +
>  static struct intel_uncore_type dmr_uncore_cbo = {
>  	.name			= "cbo",
>  	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
> +	.constraints            = dmr_uncore_cbo_constraints,
>  	.format_group		= &dmr_sca_uncore_format_group,
>  	.attr_update		= uncore_alias_groups,
>  };
> @@ -6711,9 +6731,16 @@ static struct intel_uncore_type dmr_uncore_dda = {
>  	.attr_update		= uncore_alias_groups,
>  };
>  
> +static struct event_constraint dmr_uncore_sbo_constraints[] = {
> +	UNCORE_EVENT_CONSTRAINT(0x1f, 0x01),
> +	UNCORE_EVENT_CONSTRAINT(0x25, 0x01),
> +	EVENT_CONSTRAINT_END
> +};
> +
>  static struct intel_uncore_type dmr_uncore_sbo = {
>  	.name			= "sbo",
>  	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
> +	.constraints		= dmr_uncore_sbo_constraints,
>  	.format_group		= &dmr_sca_uncore_format_group,
>  	.attr_update		= uncore_alias_groups,
>  };

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


