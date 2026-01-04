Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E2423C4F2;
	Sun,  4 Jan 2026 02:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767494888; cv=none; b=NpMMEpmunRXOXX6dNY+tpKuetkBGonivSNMy0CFpr8NRDxJsxh5E7bx7LK35G7Zn7kbEVv81Gi15LdAscA2W+coffyz3la/Rh0KA05og4ZR89aHEpMBNUQIxQQHKS7vFqbWE6SThjsBMN0DICORGcYsAI9koJ5G7HcG6meD8KIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767494888; c=relaxed/simple;
	bh=Z2MCfjHI1oAIdXYm24/1WDleNPPY1GjtRjiHDLJvct8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdDKjqP0kPfx/MEpUWjaoxw+QB4XTQXQcRbbhvaScRPttQmEfJwBGG03nr9pO2Ii8f7KKAjzMhVBYXFiZs9y4/K2AABoB2AZOCEJ/xoDqaIVoN3h36Cn1yhV3IrRIofCnjWvjinEJ5tHcOEWfTeDXcxru4t6BHvC7jW2lexk1xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z5KbvxPO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5KbvxPO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767494886; x=1799030886;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z2MCfjHI1oAIdXYm24/1WDleNPPY1GjtRjiHDLJvct8=;
  b=Z5KbvxPOmZYag0QlCDhuu6GSJp96CAeaiofBg4jrXiYzpukCHXVHlQzm
   HLQsumVZEsTDTlNWpVGXD39GCsOw7BYacleuSAkNuV4Ktb8FZzeN/3q45
   i+5B5Uis0zC/bwtCSl0+CSkjF5lRC8th+OTppV3qkufSlAATrgPJXOsW6
   RuzBGUNv+KtuClHASjB1clfOtEp2AlNvhrDyB0z2V1P9NCyrB2r/WeLKh
   zQbDz6Tg7PnhBqMdD5oWxYmmXoDM2LDVdyzGJ6v2NPMOszfMssmnOEw47
   pPLkuW7g8qhWDQALmoA5ofxEF59ptVDwcDP8xocMQiA+DlURumZYi+qMI
   A==;
X-CSE-ConnectionGUID: i3wQciEpR22zGyl6gLryEw==
X-CSE-MsgGUID: mepKBtCxQ02vNPt5MjbzOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68848170"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68848170"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 18:48:06 -0800
X-CSE-ConnectionGUID: fH7muA8JQFS2x4csaB4MsA==
X-CSE-MsgGUID: Z1j3RbLGRv+vzjidAfJ/tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,200,1763452800"; 
   d="scan'208";a="202562841"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 18:48:02 -0800
Message-ID: <45a7ed05-8dde-4f53-8e75-5224b6410435@linux.intel.com>
Date: Sun, 4 Jan 2026 10:48:00 +0800
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


