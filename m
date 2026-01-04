Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C51729992A;
	Sun,  4 Jan 2026 02:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767494986; cv=none; b=TNrnLPQD7kxd+UOaWK83zfzF0KWAutBbYLxTPNDbQhO+1lBfsKOJzURrYLrQp0ztoLIVhx34io9f4/+RoDGgxAmV6BWnVflEJ8+6EP5xio/e5r8Hz6NYpqJQOa0JAgODSFrlmQRM7jdkaccapLInNsTQ9pgbZAQCtx0AmcW5oCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767494986; c=relaxed/simple;
	bh=Z2MCfjHI1oAIdXYm24/1WDleNPPY1GjtRjiHDLJvct8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=As34agcwZjkzAzx9eNvz4ZffD+kcJxOUa1X+LhpfcxW+VtBw6d/mMFaOtgnFE1laiyCcQjYGv7Jbqmzi+csXgE8LvZDAf1egmVT3lWvwoqqrEzkn9faNw6fzmztEvvCl6EsVNJPesjHKzfiom+Q9XMnccRMvSLuGMXVlEfeLFBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=idAHsTIZ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="idAHsTIZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767494985; x=1799030985;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z2MCfjHI1oAIdXYm24/1WDleNPPY1GjtRjiHDLJvct8=;
  b=idAHsTIZXuXlrfOX9dgzyd/WtEXUtgKNV/pS1wVQ15qPk8mGHv+V37JX
   /fhHWoC3vFpMDCP3IQ7nBvI9zohABleZeiQTrX5Gpwf3e4fz6OrLsgqOw
   IC0EN8+NxctGmndt/t6dR2TmCfBL/0uC2jssMIqgAq1IQ6d/g+puTSJdh
   q5Buhy3EkzuC55tPfh2NzV3mjEIEQeVSa7jKl2+ngTbpCavToiNhzJqU4
   tVaX0iv6DOotOezpX/ScvLpGyMMmHW/iGOd/bjfq2txB2Od5SI7YvYXSH
   hy+W6DOqncKVmqredOtE8vDk3wNAkFxhjPI8domh2UM0U1QmCPz8YyM8Z
   w==;
X-CSE-ConnectionGUID: jU5QRfNFS+ST2bB7aSOT7w==
X-CSE-MsgGUID: Rp8D76o5TquBjo8miR0YCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="86500972"
X-IronPort-AV: E=Sophos;i="6.21,200,1763452800"; 
   d="scan'208";a="86500972"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 18:49:44 -0800
X-CSE-ConnectionGUID: YSOUVVxMQ4iBZkk17ZB0DQ==
X-CSE-MsgGUID: M05rggQfQxu+G7bAKlTb6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,200,1763452800"; 
   d="scan'208";a="201321894"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 18:49:40 -0800
Message-ID: <ab790924-2e69-4003-9e75-884a0a871012@linux.intel.com>
Date: Sun, 4 Jan 2026 10:49:38 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 12/13] perf/x86/intel/uncore: Add missing PMON units
 for Panther Lake
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>
References: <20251231224233.113839-1-zide.chen@intel.com>
 <20251231224233.113839-13-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251231224233.113839-13-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/1/2026 6:42 AM, Zide Chen wrote:
> Besides CBOX, Panther Lake includes several legacy uncore PMON units
> not enumerated via discovery tables, including cNCU, SANTA, and
> ia_core_bridge.
>
> The cNCU PMON is similar to Meteor Lake but has two boxes with two
> counters each. SANTA and IA Core Bridge PMON units follow the legacy
> model used on Lunar Lake, Meteor Lake, and others.
>
> Panther Lake implements the Global Control Register; the freeze_all bit
> must be cleared before programming counters.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V2: new patch
>
>  arch/x86/events/intel/uncore.c     |  1 +
>  arch/x86/events/intel/uncore_snb.c | 45 ++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 54b3c1e3af32..07a9a2826398 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1814,6 +1814,7 @@ static const struct uncore_plat_init ptl_uncore_init __initconst = {
>  	.cpu_init = ptl_uncore_cpu_init,
>  	.mmio_init = ptl_uncore_mmio_init,
>  	.domain[0].discovery_base = UNCORE_DISCOVERY_MSR,
> +	.domain[0].global_init = uncore_mmio_global_init,
>  };
>  
>  static const struct uncore_plat_init icx_uncore_init __initconst = {
> diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
> index 807e582b8f17..c663b00b68fe 100644
> --- a/arch/x86/events/intel/uncore_snb.c
> +++ b/arch/x86/events/intel/uncore_snb.c
> @@ -245,6 +245,17 @@
>  #define MTL_UNC_HBO_CTR				0x2048
>  #define MTL_UNC_HBO_CTRL			0x2042
>  
> +/* PTL Low Power Bridge register */
> +#define PTL_UNC_IA_CORE_BRIDGE_PER_CTR0		0x2028
> +#define PTL_UNC_IA_CORE_BRIDGE_PERFEVTSEL0	0x2022
> +
> +/* PTL Santa register */
> +#define PTL_UNC_SANTA_CTR0			0x2418
> +#define PTL_UNC_SANTA_CTRL0			0x2412
> +
> +/* PTL cNCU register */
> +#define PTL_UNC_CNCU_MSR_OFFSET			0x140
> +
>  DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
>  DEFINE_UNCORE_FORMAT_ATTR(umask, umask, "config:8-15");
>  DEFINE_UNCORE_FORMAT_ATTR(chmask, chmask, "config:8-11");
> @@ -1921,8 +1932,36 @@ void ptl_uncore_mmio_init(void)
>  						 ptl_uncores);
>  }
>  
> +static struct intel_uncore_type ptl_uncore_ia_core_bridge = {
> +	.name		= "ia_core_bridge",
> +	.num_counters   = 2,
> +	.num_boxes	= 1,
> +	.perf_ctr_bits	= 48,
> +	.perf_ctr	= PTL_UNC_IA_CORE_BRIDGE_PER_CTR0,
> +	.event_ctl	= PTL_UNC_IA_CORE_BRIDGE_PERFEVTSEL0,
> +	.event_mask	= ADL_UNC_RAW_EVENT_MASK,
> +	.ops		= &icl_uncore_msr_ops,
> +	.format_group	= &adl_uncore_format_group,
> +};
> +
> +static struct intel_uncore_type ptl_uncore_santa = {
> +	.name		= "santa",
> +	.num_counters   = 2,
> +	.num_boxes	= 2,
> +	.perf_ctr_bits	= 48,
> +	.perf_ctr	= PTL_UNC_SANTA_CTR0,
> +	.event_ctl	= PTL_UNC_SANTA_CTRL0,
> +	.event_mask	= ADL_UNC_RAW_EVENT_MASK,
> +	.msr_offset	= SNB_UNC_CBO_MSR_OFFSET,
> +	.ops		= &icl_uncore_msr_ops,
> +	.format_group	= &adl_uncore_format_group,
> +};
> +
>  static struct intel_uncore_type *ptl_msr_uncores[] = {
>  	&mtl_uncore_cbox,
> +	&ptl_uncore_ia_core_bridge,
> +	&ptl_uncore_santa,
> +	&mtl_uncore_cncu,
>  	NULL
>  };
>  
> @@ -1930,6 +1969,12 @@ void ptl_uncore_cpu_init(void)
>  {
>  	mtl_uncore_cbox.num_boxes = 6;
>  	mtl_uncore_cbox.ops = &lnl_uncore_msr_ops;
> +
> +	mtl_uncore_cncu.num_counters = 2;
> +	mtl_uncore_cncu.num_boxes = 2;
> +	mtl_uncore_cncu.msr_offset = PTL_UNC_CNCU_MSR_OFFSET;
> +	mtl_uncore_cncu.single_fixed = 0;
> +
>  	uncore_msr_uncores = ptl_msr_uncores;
>  }
>  

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


