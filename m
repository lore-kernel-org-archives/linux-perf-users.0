Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D162D374F;
	Tue, 23 Dec 2025 03:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766460478; cv=none; b=K/AW4YnLa3rmnjI+uBaCRQMomqFi8Nzsr4MU1KnVZ8fAWRoWXmpJ4ctaGzr7HFg2d0k9x/hO/ygpRJuQtOq+vK+YSGtWD4+raIJ6eNyN5kc4UpcPyiXmWV9QukMVIy/xATCPDHnEOGQVVnPzmy5mVP4HAaD/1NTs1W5zkRZE67c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766460478; c=relaxed/simple;
	bh=B66urXGffnZbU68yo2h5qABeyBwoCzT9DwD/VjHJwTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljVVQL57BuSX+dipG2zGxuthNZCRZJYGCmA0OekXY6o2UJ912UbqMF7vYJjV5EwKBGJmeUJ5P/8YsV2lIhh1neaRwsZ7o7haTETE0Qt6ZE6smLcEESboT+CLZv3Jg2C/kbrqXWdEUiATO3bCPEVdTVKUaJRycIQtGBWUDLbJITg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fqsh/Hab; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqsh/Hab"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766460476; x=1797996476;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B66urXGffnZbU68yo2h5qABeyBwoCzT9DwD/VjHJwTk=;
  b=fqsh/HabCyoSvyfjmrwynJ7E1jqTxqPiEcVUv22S4Bu3bmfxslPTglDD
   vBw8VQf+ecDAwV6HKsuFtjSnGTEZLVWUKGKq5RaHL/ZsiYZag/N7nKgBn
   eC1I9gT+x9zAPZjrWTSUA6ROrQze3+u8YEXBZQaI+mlcY6wo1vZ2Xt/IX
   z1OYyTHAznkAjCtdfsqOXB+oGwQgLlXFAgeEWMzKO29g7cysZdYElVGGb
   gfTLNXoCLw9WigmuSJ4tCgUyOGEqqIyd2E1wCplX/HvFM/dH3KWvsfbPl
   pwDJ9DPA6IlqkViEcFDIcaDTYVpSUfzxeawoe3Mnc3J9d+VxaOXBhYlK/
   A==;
X-CSE-ConnectionGUID: e+8na2H5Qoaa6kaJb6959Q==
X-CSE-MsgGUID: gdTalKBITm6MbrrxT5c7Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11650"; a="79764060"
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="79764060"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 19:27:56 -0800
X-CSE-ConnectionGUID: lPxcy6gIQJaInbJNH6VItg==
X-CSE-MsgGUID: icvAnFIFQMmg9wQkKT5iZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,169,1763452800"; 
   d="scan'208";a="223155799"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 19:27:52 -0800
Message-ID: <87b2cd5e-76d0-4c6a-b052-1a492a7ce429@linux.intel.com>
Date: Tue, 23 Dec 2025 11:27:49 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] perf/x86/intel/uncore: Add IMH PMON support for
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
 <20251212210007.13986-3-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251212210007.13986-3-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 12/13/2025 5:00 AM, Zide Chen wrote:
> DMR supports IMH PMON units for PCU, UBox, iMC, and CXL:
> - PCU and UBox are same with SPR.
> - iMC is similar to SPR but uses different offsets for fixed registers.
> - CXL introduces a new port_enable field and changes the position of
>   the threshold field.
>
> DMR also introduces additional PMON units: SCA, HAMVF, D2D_ULA, UBR,
> PCIE4, CRS, CPC, ITC, OTC, CMS, and PCIE6.  Among these, PCIE4 and
> PCIE6 use different unit types, but share the same config register
> layout, and the generic PCIe PMON events apply to both.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore.c           |   8 +
>  arch/x86/events/intel/uncore.h           |   3 +
>  arch/x86/events/intel/uncore_discovery.h |   2 +
>  arch/x86/events/intel/uncore_snbep.c     | 228 +++++++++++++++++++++++
>  4 files changed, 241 insertions(+)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index ecf500470f8e..7ab02638e3f1 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1843,6 +1843,13 @@ static const struct intel_uncore_init_fun gnr_uncore_init __initconst = {
>  	.uncore_units_ignore = gnr_uncore_units_ignore,
>  };
>  
> +static const struct intel_uncore_init_fun dmr_uncore_init __initconst = {
> +	.pci_init = dmr_uncore_pci_init,
> +	.mmio_init = dmr_uncore_mmio_init,
> +	.discovery_pci = DMR_UNCORE_DISCOVERY_TABLE_DEVICE,
> +	.uncore_units_ignore = dmr_uncore_units_ignore,
> +};
> +
>  static const struct intel_uncore_init_fun generic_uncore_init __initconst = {
>  	.cpu_init = intel_uncore_generic_uncore_cpu_init,
>  	.pci_init = intel_uncore_generic_uncore_pci_init,
> @@ -1906,6 +1913,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
>  	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	&gnr_uncore_init),
>  	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	&gnr_uncore_init),
>  	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X,	&gnr_uncore_init),
> +	X86_MATCH_VFM(INTEL_DIAMONDRAPIDS_X,	&dmr_uncore_init),
>  	{},
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_uncore_match);
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
> index d8815fff7588..4f9c6e1e0c1a 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -597,6 +597,7 @@ extern struct pci_extra_dev *uncore_extra_pci_dev;
>  extern struct event_constraint uncore_constraint_empty;
>  extern int spr_uncore_units_ignore[];
>  extern int gnr_uncore_units_ignore[];
> +extern int dmr_uncore_units_ignore[];
>  
>  /* uncore_snb.c */
>  int snb_uncore_pci_init(void);
> @@ -645,6 +646,8 @@ void spr_uncore_mmio_init(void);
>  int gnr_uncore_pci_init(void);
>  void gnr_uncore_cpu_init(void);
>  void gnr_uncore_mmio_init(void);
> +int dmr_uncore_pci_init(void);
> +void dmr_uncore_mmio_init(void);
>  
>  /* uncore_nhmex.c */
>  void nhmex_uncore_cpu_init(void);
> diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
> index a919b1ac88fe..786670276b5f 100644
> --- a/arch/x86/events/intel/uncore_discovery.h
> +++ b/arch/x86/events/intel/uncore_discovery.h
> @@ -5,6 +5,8 @@
>  
>  /* Generic device ID of a discovery table device */
>  #define UNCORE_DISCOVERY_TABLE_DEVICE		0x09a7
> +/* Device ID used on DMR */
> +#define DMR_UNCORE_DISCOVERY_TABLE_DEVICE	0x09a1
>  /* Capability ID for a discovery table device */
>  #define UNCORE_EXT_CAP_ID_DISCOVERY		0x23
>  /* First DVSEC offset */
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index e1f370b8d065..dee94bbdddcf 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -471,6 +471,14 @@
>  
>  #define SPR_C0_MSR_PMON_BOX_FILTER0		0x200e
>  
> +/* DMR */
> +#define DMR_CXLCM_EVENT_MASK_EXT		0xf
> +#define DMR_HAMVF_EVENT_MASK_EXT		0xffffffff
> +#define DMR_PCIE4_EVENT_MASK_EXT		0xffffff
> +
> +#define DMR_IMC_PMON_FIXED_CTR			0x18
> +#define DMR_IMC_PMON_FIXED_CTL			0x10
> +
>  DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
>  DEFINE_UNCORE_FORMAT_ATTR(event2, event, "config:0-6");
>  DEFINE_UNCORE_FORMAT_ATTR(event_ext, event, "config:0-7,21");
> @@ -486,6 +494,10 @@ DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
>  DEFINE_UNCORE_FORMAT_ATTR(tid_en, tid_en, "config:19");
>  DEFINE_UNCORE_FORMAT_ATTR(tid_en2, tid_en, "config:16");
>  DEFINE_UNCORE_FORMAT_ATTR(inv, inv, "config:23");
> +DEFINE_UNCORE_FORMAT_ATTR(inv2, inv, "config:21");
> +DEFINE_UNCORE_FORMAT_ATTR(thresh_ext, thresh_ext, "config:32-35");
> +DEFINE_UNCORE_FORMAT_ATTR(thresh10, thresh, "config:23-32");
> +DEFINE_UNCORE_FORMAT_ATTR(thresh9_2, thresh, "config:23-31");
>  DEFINE_UNCORE_FORMAT_ATTR(thresh9, thresh, "config:24-35");
>  DEFINE_UNCORE_FORMAT_ATTR(thresh8, thresh, "config:24-31");
>  DEFINE_UNCORE_FORMAT_ATTR(thresh6, thresh, "config:24-29");
> @@ -494,6 +506,13 @@ DEFINE_UNCORE_FORMAT_ATTR(occ_sel, occ_sel, "config:14-15");
>  DEFINE_UNCORE_FORMAT_ATTR(occ_invert, occ_invert, "config:30");
>  DEFINE_UNCORE_FORMAT_ATTR(occ_edge, occ_edge, "config:14-51");
>  DEFINE_UNCORE_FORMAT_ATTR(occ_edge_det, occ_edge_det, "config:31");
> +DEFINE_UNCORE_FORMAT_ATTR(port_en, port_en, "config:32-35");
> +DEFINE_UNCORE_FORMAT_ATTR(rs3_sel, rs3_sel, "config:36");
> +DEFINE_UNCORE_FORMAT_ATTR(rx_sel, rx_sel, "config:37");
> +DEFINE_UNCORE_FORMAT_ATTR(tx_sel, tx_sel, "config:38");
> +DEFINE_UNCORE_FORMAT_ATTR(iep_sel, iep_sel, "config:39");
> +DEFINE_UNCORE_FORMAT_ATTR(vc_sel, vc_sel, "config:40-47");
> +DEFINE_UNCORE_FORMAT_ATTR(port_sel, port_sel, "config:48-55");
>  DEFINE_UNCORE_FORMAT_ATTR(ch_mask, ch_mask, "config:36-43");
>  DEFINE_UNCORE_FORMAT_ATTR(ch_mask2, ch_mask, "config:36-47");
>  DEFINE_UNCORE_FORMAT_ATTR(fc_mask, fc_mask, "config:44-46");
> @@ -6709,3 +6728,212 @@ void gnr_uncore_mmio_init(void)
>  }
>  
>  /* end of GNR uncore support */
> +
> +/* DMR uncore support */
> +#define UNCORE_DMR_NUM_UNCORE_TYPES	52
> +
> +static struct attribute *dmr_imc_uncore_formats_attr[] = {
> +	&format_attr_event.attr,
> +	&format_attr_edge.attr,
> +	&format_attr_inv.attr,
> +	&format_attr_thresh10.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group dmr_imc_uncore_format_group = {
> +	.name = "format",
> +	.attrs = dmr_imc_uncore_formats_attr,
> +};
> +
> +static struct intel_uncore_type dmr_uncore_imc = {
> +	.name			= "imc",
> +	.fixed_ctr_bits		= 48,
> +	.fixed_ctr		= DMR_IMC_PMON_FIXED_CTR,
> +	.fixed_ctl		= DMR_IMC_PMON_FIXED_CTL,
> +	.ops			= &spr_uncore_mmio_ops,
> +	.format_group		= &dmr_imc_uncore_format_group,
> +	.attr_update		= uncore_alias_groups,
> +};
> +
> +static struct attribute *dmr_sca_uncore_formats_attr[] = {
> +	&format_attr_event.attr,
> +	&format_attr_umask_ext5.attr,
> +	&format_attr_edge.attr,
> +	&format_attr_inv.attr,
> +	&format_attr_thresh8.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group dmr_sca_uncore_format_group = {
> +	.name = "format",
> +	.attrs = dmr_sca_uncore_formats_attr,
> +};
> +
> +static struct intel_uncore_type dmr_uncore_sca = {
> +	.name			= "sca",
> +	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
> +	.format_group		= &dmr_sca_uncore_format_group,
> +	.attr_update		= uncore_alias_groups,
> +};
> +
> +static struct attribute *dmr_cxlcm_uncore_formats_attr[] = {
> +	&format_attr_event.attr,
> +	&format_attr_umask.attr,
> +	&format_attr_edge.attr,
> +	&format_attr_inv2.attr,
> +	&format_attr_thresh9_2.attr,
> +	&format_attr_port_en.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group dmr_cxlcm_uncore_format_group = {
> +	.name = "format",
> +	.attrs = dmr_cxlcm_uncore_formats_attr,
> +};
> +
> +static struct intel_uncore_type dmr_uncore_cxlcm = {
> +	.name			= "cxlcm",
> +	.event_mask		= GENERIC_PMON_RAW_EVENT_MASK,
> +	.event_mask_ext		= DMR_CXLCM_EVENT_MASK_EXT,
> +	.format_group		= &dmr_cxlcm_uncore_format_group,
> +	.attr_update		= uncore_alias_groups,
> +};
> +
> +static struct intel_uncore_type dmr_uncore_hamvf = {
> +	.name			= "hamvf",
> +	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
> +	.format_group		= &dmr_sca_uncore_format_group,
> +	.attr_update		= uncore_alias_groups,
> +};
> +
> +static struct intel_uncore_type dmr_uncore_ula = {
> +	.name			= "ula",
> +	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
> +	.format_group		= &dmr_sca_uncore_format_group,
> +	.attr_update		= uncore_alias_groups,
> +};
> +
> +static struct intel_uncore_type dmr_uncore_ubr = {
> +	.name			= "ubr",
> +	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
> +	.format_group		= &dmr_sca_uncore_format_group,
> +	.attr_update		= uncore_alias_groups,
> +};
> +
> +static struct attribute *dmr_pcie4_uncore_formats_attr[] = {
> +	&format_attr_event.attr,
> +	&format_attr_umask.attr,
> +	&format_attr_edge.attr,
> +	&format_attr_inv.attr,
> +	&format_attr_thresh8.attr,
> +	&format_attr_thresh_ext.attr,
> +	&format_attr_rs3_sel.attr,
> +	&format_attr_rx_sel.attr,
> +	&format_attr_tx_sel.attr,
> +	&format_attr_iep_sel.attr,
> +	&format_attr_vc_sel.attr,
> +	&format_attr_port_sel.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group dmr_pcie4_uncore_format_group = {
> +	.name = "format",
> +	.attrs = dmr_pcie4_uncore_formats_attr,
> +};
> +
> +static struct intel_uncore_type dmr_uncore_pcie4 = {
> +	.name			= "pcie4",
> +	.event_mask_ext		= DMR_PCIE4_EVENT_MASK_EXT,
> +	.format_group		= &dmr_pcie4_uncore_format_group,
> +	.attr_update		= uncore_alias_groups,
> +};
> +
> +static struct intel_uncore_type dmr_uncore_crs = {
> +	.name			= "crs",
> +	.attr_update		= uncore_alias_groups,
> +};
> +
> +static struct intel_uncore_type dmr_uncore_cpc = {
> +	.name			= "cpc",
> +	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
> +	.format_group		= &dmr_sca_uncore_format_group,
> +	.attr_update		= uncore_alias_groups,
> +};
> +
> +static struct intel_uncore_type dmr_uncore_itc = {
> +	.name			= "itc",
> +	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
> +	.format_group		= &dmr_sca_uncore_format_group,
> +	.attr_update		= uncore_alias_groups,
> +};
> +
> +static struct intel_uncore_type dmr_uncore_otc = {
> +	.name			= "otc",
> +	.event_mask_ext		= DMR_HAMVF_EVENT_MASK_EXT,
> +	.format_group		= &dmr_sca_uncore_format_group,
> +	.attr_update		= uncore_alias_groups,
> +};
> +
> +static struct intel_uncore_type dmr_uncore_cms = {
> +	.name			= "cms",
> +	.attr_update		= uncore_alias_groups,
> +};
> +
> +static struct intel_uncore_type dmr_uncore_pcie6 = {
> +	.name			= "pcie6",
> +	.event_mask_ext		= DMR_PCIE4_EVENT_MASK_EXT,
> +	.format_group		= &dmr_pcie4_uncore_format_group,
> +	.attr_update		= uncore_alias_groups,
> +};
> +
> +static struct intel_uncore_type *dmr_uncores[UNCORE_DMR_NUM_UNCORE_TYPES] = {
> +	NULL, NULL, NULL, NULL,
> +	&spr_uncore_pcu,
> +	&gnr_uncore_ubox,
> +	&dmr_uncore_imc,
> +	NULL,
> +	NULL, NULL, NULL, NULL,
> +	NULL, NULL, NULL, NULL,
> +	NULL, NULL, NULL, NULL,
> +	NULL, NULL, NULL,
> +	&dmr_uncore_sca,
> +	&dmr_uncore_cxlcm,
> +	NULL, NULL, NULL,
> +	NULL, NULL,
> +	&dmr_uncore_hamvf,
> +	NULL,
> +	NULL, NULL, NULL,
> +	&dmr_uncore_ula,
> +	NULL, NULL, NULL, NULL,
> +	NULL, NULL, NULL,
> +	&dmr_uncore_ubr,
> +	NULL,
> +	&dmr_uncore_pcie4,
> +	&dmr_uncore_crs,
> +	&dmr_uncore_cpc,
> +	&dmr_uncore_itc,
> +	&dmr_uncore_otc,
> +	&dmr_uncore_cms,
> +	&dmr_uncore_pcie6,
> +};
> +
> +int dmr_uncore_units_ignore[] = {
> +	0x13,		/* MSE */
> +	UNCORE_IGNORE_END
> +};
> +
> +int dmr_uncore_pci_init(void)
> +{
> +	uncore_pci_uncores = uncore_get_uncores(UNCORE_ACCESS_PCI, 0, NULL,
> +						UNCORE_DMR_NUM_UNCORE_TYPES,
> +						dmr_uncores);
> +	return 0;
> +}
> +void dmr_uncore_mmio_init(void)
> +{
> +	uncore_mmio_uncores = uncore_get_uncores(UNCORE_ACCESS_MMIO, 0, NULL,
> +						 UNCORE_DMR_NUM_UNCORE_TYPES,
> +						 dmr_uncores);
> +}
> +
> +/* end of DMR uncore support */

LGTM. Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


