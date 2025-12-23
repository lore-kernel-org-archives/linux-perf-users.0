Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF3722D792;
	Tue, 23 Dec 2025 03:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766461104; cv=none; b=RzUzDVScCfW6nC3QhUfj0WA56YdszdCiPbso0OKlRH6yGcAQeB2mZLsyEKeEYvgeI6xZHKZDhd1VFi4shyeI8S5+fU2i1r7MkcR3J42jAhDH2f//eC7NTTm2tx99uJTMMy0wDv8zazJaJUlUwx2V3rtPlT/no8wuHWinjxOQ2lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766461104; c=relaxed/simple;
	bh=Z4dekkP7Fdre6yTCv6fp362LFjKASX2911gL0DtrlXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSGTb9lMVKllQzlHsaAjGL9qqdiQWgQWpA1Du+njLhJvIlxgKSXPRdbWQYIl7xRQKt6PB7U+O+gEeKOzDXjPSGOwXR7TAeju7yWNLW/CwFODRfuljLiGhZdLr+8E7RRlpMdkoPifOJev3SqSOZ0mljTH4aa2s/R8tNKmaA9zOhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2XPrk0/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2XPrk0/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766461102; x=1797997102;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z4dekkP7Fdre6yTCv6fp362LFjKASX2911gL0DtrlXs=;
  b=g2XPrk0/ipEo3JSTYhDjXVCV26LGcukAwR6KzO3aadmFbtCRBvEKCH3S
   0BpS3B0cfIH0MfUyHhMeVHuacLmR17ULXyebBW0BgZqCP90sZhVGH+DgI
   Q5BQi3Ptk21/AGkugkJWAGn7SidkVXKkmLlZ+5fdCIVC23D2R8Lm2/dLC
   b8XgwP5eGWPBEmlvDCx39WJTow1hXUs/Si0wZlNzflr1UJATJXOshGZ1w
   /gXuWgrpmePWFF8QtngeW4qf2kkDHD62Vzgn/wIrxG9pIk14MfdJLoYjY
   6a4ru8uOO5lzHI0gRhYZgV+Wg8q35aspliGHN5knUyD/bYHS7G9gfm9U0
   A==;
X-CSE-ConnectionGUID: wt0/yzhWQjGKC7gYhUCExw==
X-CSE-MsgGUID: RjnFiN2gRsmFwllCT/fdOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="79764847"
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="79764847"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 19:38:22 -0800
X-CSE-ConnectionGUID: c/z4ummYQh+N/fpUCQ58MQ==
X-CSE-MsgGUID: 97QinbsoQAKFhEd1atFb9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="223157379"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 19:38:18 -0800
Message-ID: <6aa56e97-4fff-4a1d-85de-eb1050ed904f@linux.intel.com>
Date: Tue, 23 Dec 2025 11:38:15 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] perf/x86/intel/uncore: Add CBB PMON support for
 Diamond Rapids
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>
References: <20251212210007.13986-1-zide.chen@intel.com>
 <20251212210007.13986-4-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251212210007.13986-4-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 12/13/2025 5:00 AM, Zide Chen wrote:
> On DMR, PMON units inside the Core Building Block (CBB) are enumerated
> separately from those in the Integrated Memory and I/O Hub (IMH).
>
> A new per-CBB MSR (0x710) is introduced for discovery table enumeration.
>
> For counter control registers, the tid_en bit (bit 16) exists on CBO,
> SBO, and Santa, but it is not used by any events.  Mark this bit as
> reserved.
>
> Similarly, disallow extended umask (bits 32–63) on Santa and sNCU.
>
> Additionally, ignore broken PMON units for MSE and SB2UCIE.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore.c           |  1 +
>  arch/x86/events/intel/uncore_discovery.h |  2 +
>  arch/x86/events/intel/uncore_snbep.c     | 48 ++++++++++++++++++++++--
>  3 files changed, 48 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 7ab02638e3f1..88c32e528add 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1847,6 +1847,7 @@ static const struct intel_uncore_init_fun dmr_uncore_init __initconst = {
>  	.pci_init = dmr_uncore_pci_init,
>  	.mmio_init = dmr_uncore_mmio_init,
>  	.discovery_pci = DMR_UNCORE_DISCOVERY_TABLE_DEVICE,
> +	.discovery_msr = DMR_UNCORE_DISCOVERY_MSR,
>  	.uncore_units_ignore = dmr_uncore_units_ignore,
>  };
>  
> diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
> index 786670276b5f..a558c31ff2b1 100644
> --- a/arch/x86/events/intel/uncore_discovery.h
> +++ b/arch/x86/events/intel/uncore_discovery.h
> @@ -2,6 +2,8 @@
>  
>  /* Store the full address of the global discovery table */
>  #define UNCORE_DISCOVERY_MSR			0x201e
> +/* Alternative MSR that is used by server CPUs like DMR */
> +#define DMR_UNCORE_DISCOVERY_MSR		0x710
>  
>  /* Generic device ID of a discovery table device */
>  #define UNCORE_DISCOVERY_TABLE_DEVICE		0x09a7
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index dee94bbdddcf..bd1569876640 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -6806,6 +6806,28 @@ static struct intel_uncore_type dmr_uncore_hamvf = {
>  	.attr_update		= uncore_alias_groups,
>  };
>  
> +static struct intel_uncore_type dmr_uncore_cbo = {
> +	.name			= "cbo",
> +	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
> +	.format_group		= &dmr_sca_uncore_format_group,
> +	.attr_update		= uncore_alias_groups,
> +};
> +
> +static struct intel_uncore_type dmr_uncore_santa = {
> +	.name			= "santa",
> +	.attr_update		= uncore_alias_groups,
> +};
> +
> +static struct intel_uncore_type dmr_uncore_cncu = {
> +	.name			= "cncu",
> +	.attr_update		= uncore_alias_groups,
> +};
> +
> +static struct intel_uncore_type dmr_uncore_sncu = {
> +	.name			= "sncu",
> +	.attr_update		= uncore_alias_groups,
> +};
> +
>  static struct intel_uncore_type dmr_uncore_ula = {
>  	.name			= "ula",
>  	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
> @@ -6813,6 +6835,20 @@ static struct intel_uncore_type dmr_uncore_ula = {
>  	.attr_update		= uncore_alias_groups,
>  };
>  
> +static struct intel_uncore_type dmr_uncore_dda = {
> +	.name			= "dda",
> +	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
> +	.format_group		= &dmr_sca_uncore_format_group,
> +	.attr_update		= uncore_alias_groups,
> +};
> +
> +static struct intel_uncore_type dmr_uncore_sbo = {
> +	.name			= "sbo",
> +	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
> +	.format_group		= &dmr_sca_uncore_format_group,
> +	.attr_update		= uncore_alias_groups,
> +};
> +
>  static struct intel_uncore_type dmr_uncore_ubr = {
>  	.name			= "ubr",
>  	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
> @@ -6901,10 +6937,15 @@ static struct intel_uncore_type *dmr_uncores[UNCORE_DMR_NUM_UNCORE_TYPES] = {
>  	NULL, NULL, NULL,
>  	NULL, NULL,
>  	&dmr_uncore_hamvf,
> -	NULL,
> -	NULL, NULL, NULL,
> +	&dmr_uncore_cbo,
> +	&dmr_uncore_santa,
> +	&dmr_uncore_cncu,
> +	&dmr_uncore_sncu,
>  	&dmr_uncore_ula,
> -	NULL, NULL, NULL, NULL,
> +	&dmr_uncore_dda,
> +	NULL,
> +	&dmr_uncore_sbo,
> +	NULL,
>  	NULL, NULL, NULL,
>  	&dmr_uncore_ubr,
>  	NULL,
> @@ -6919,6 +6960,7 @@ static struct intel_uncore_type *dmr_uncores[UNCORE_DMR_NUM_UNCORE_TYPES] = {
>  
>  int dmr_uncore_units_ignore[] = {
>  	0x13,		/* MSE */
> +	0x25,		/* SB2UCIE */
>  	UNCORE_IGNORE_END
>  };
>  

LGTM. Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


