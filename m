Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2CC18C17A;
	Mon, 15 Jul 2024 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051173; cv=none; b=ig5Jo1gLisg+ng+R9ehUIWiAFExDZYR6VW+e4htpI/ystZ3v7hqceFMTaRc/9Mnylg1D7IebjAxyLRP9rti+e0rp2BjSMvHz0/Bv/U+0djHdO6lp1LGOj9v/Lm8aMlvuIK2NPdIjMw51n9DbHqGImy3YUpCpWSz7AN4OkY4H0iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051173; c=relaxed/simple;
	bh=C3UomQt+LDwDWwqHlF+gaXhlBOREJ0AvQT6vXKHjL0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tiNa2tokH+eKR4END2RDFGpsHFFJtxvcNAMcM9ZQLOIiL1Q067XeZdq7CbLG8pZQYaBF1fPv9qEomf/4j4jZ7FgoO4RIzpV0A98IlL4z933JbDbXnC6LXUr3w389ERZ0m8fiHa/rHB2aPMR22Rjg8Q80ZDs/P09f/GxHRfC/sPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CGpBWb3w; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CGpBWb3w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721051171; x=1752587171;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C3UomQt+LDwDWwqHlF+gaXhlBOREJ0AvQT6vXKHjL0g=;
  b=CGpBWb3w2GUxZIkfgYTEGJNfvxJ8BT83AHVTvcvdJDJ5L2lSa87qMdn0
   E7H0pFyc3gEoTowDYXXobYZtp4c64hzPP8nG6fexWinRpMApWcCeDRAR9
   RfZ/cJIqypPvwgS4ZJ2+m4DcWnGp72rihw8he2w8+zJvRjJElJdc4yUYe
   WIudQ2rklZnQwN9rF4d98XMGVOFfedCjTOG0I8HNsSMoDi3pHDRA6Kqkr
   I9R8sCiHnGHgEeeYjV8sv7OkMYyzdYW085KTTGF2rkBV8AiCzGTFXuTOX
   EweRq509w1ia9XM/sz2M4OVElRADHoQ/DmZPBFj3yAzNTe7sD9/Fakhi2
   g==;
X-CSE-ConnectionGUID: 01HVP51wTWm38JmWQdMmiQ==
X-CSE-MsgGUID: 53MHh/UvSd60RyIlZSJNow==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="35972896"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="35972896"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 06:46:09 -0700
X-CSE-ConnectionGUID: dsEDmF7KS0ymTeymrC+UkA==
X-CSE-MsgGUID: 34fWCt+fRz+z72KMvWMZSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="80305680"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 06:46:09 -0700
Received: from [10.212.96.36] (kliang2-mobl1.ccr.corp.intel.com [10.212.96.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 97B5120B8CD6;
	Mon, 15 Jul 2024 06:46:06 -0700 (PDT)
Message-ID: <ef5b1e4e-39df-46fe-8eb8-a242cd43d5cb@linux.intel.com>
Date: Mon, 15 Jul 2024 09:46:05 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Constify struct
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <9dc5e67d1b19e56c952e740371be9d42a5011c2c.1720960818.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <9dc5e67d1b19e56c952e740371be9d42a5011c2c.1720960818.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-07-14 8:40 a.m., Christophe JAILLET wrote:
> 'struct freerunning_counters' are not modified in these drivers.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   79637	  71836	     16	 151489	  24fc1	arch/x86/events/intel/uncore_snbep.o
>   24000	  13628	      0	  37628	   92fc	arch/x86/events/intel/uncore_snb.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   80309	  71196	     16	 151521	  24fe1	arch/x86/events/intel/uncore_snbep.o
>   24448	  13180	      0	  37628	   92fc	arch/x86/events/intel/uncore_snb.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
> Compile tested-only.
> ---
>  arch/x86/events/intel/uncore.h       |  2 +-
>  arch/x86/events/intel/uncore_snb.c   |  8 ++++----
>  arch/x86/events/intel/uncore_snbep.c | 16 ++++++++--------
>  3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
> index 027ef292c602..b7cdf9b8e88a 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -80,7 +80,7 @@ struct intel_uncore_type {
>  	struct intel_uncore_pmu *pmus;
>  	struct intel_uncore_ops *ops;
>  	struct uncore_event_desc *event_descs;
> -	struct freerunning_counters *freerunning;
> +	const struct freerunning_counters *freerunning;
>  	const struct attribute_group *attr_groups[4];
>  	const struct attribute_group **attr_update;
>  	struct pmu *pmu; /* for custom pmu ops */
> diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
> index 9462fd9f3b7a..001ba9230722 100644
> --- a/arch/x86/events/intel/uncore_snb.c
> +++ b/arch/x86/events/intel/uncore_snb.c
> @@ -804,7 +804,7 @@ enum perf_snb_uncore_imc_freerunning_types {
>  	SNB_PCI_UNCORE_IMC_FREERUNNING_TYPE_MAX,
>  };
>  
> -static struct freerunning_counters snb_uncore_imc_freerunning[] = {
> +static const struct freerunning_counters snb_uncore_imc_freerunning[] = {
>  	[SNB_PCI_UNCORE_IMC_DATA_READS]		= { SNB_UNCORE_PCI_IMC_DATA_READS_BASE,
>  							0x0, 0x0, 1, 32 },
>  	[SNB_PCI_UNCORE_IMC_DATA_WRITES]	= { SNB_UNCORE_PCI_IMC_DATA_WRITES_BASE,
> @@ -1435,13 +1435,13 @@ enum perf_tgl_uncore_imc_freerunning_types {
>  	TGL_MMIO_UNCORE_IMC_FREERUNNING_TYPE_MAX
>  };
>  
> -static struct freerunning_counters tgl_l_uncore_imc_freerunning[] = {
> +static const struct freerunning_counters tgl_l_uncore_imc_freerunning[] = {
>  	[TGL_MMIO_UNCORE_IMC_DATA_TOTAL]	= { 0x5040, 0x0, 0x0, 1, 64 },
>  	[TGL_MMIO_UNCORE_IMC_DATA_READ]		= { 0x5058, 0x0, 0x0, 1, 64 },
>  	[TGL_MMIO_UNCORE_IMC_DATA_WRITE]	= { 0x50A0, 0x0, 0x0, 1, 64 },
>  };
>  
> -static struct freerunning_counters tgl_uncore_imc_freerunning[] = {
> +static const struct freerunning_counters tgl_uncore_imc_freerunning[] = {
>  	[TGL_MMIO_UNCORE_IMC_DATA_TOTAL]	= { 0xd840, 0x0, 0x0, 1, 64 },
>  	[TGL_MMIO_UNCORE_IMC_DATA_READ]		= { 0xd858, 0x0, 0x0, 1, 64 },
>  	[TGL_MMIO_UNCORE_IMC_DATA_WRITE]	= { 0xd8A0, 0x0, 0x0, 1, 64 },
> @@ -1661,7 +1661,7 @@ enum perf_adl_uncore_imc_freerunning_types {
>  	ADL_MMIO_UNCORE_IMC_FREERUNNING_TYPE_MAX
>  };
>  
> -static struct freerunning_counters adl_uncore_imc_freerunning[] = {
> +static const struct freerunning_counters adl_uncore_imc_freerunning[] = {
>  	[ADL_MMIO_UNCORE_IMC_DATA_TOTAL]	= { 0x40, 0x0, 0x0, 1, 64 },
>  	[ADL_MMIO_UNCORE_IMC_DATA_READ]		= { 0x58, 0x0, 0x0, 1, 64 },
>  	[ADL_MMIO_UNCORE_IMC_DATA_WRITE]	= { 0xA0, 0x0, 0x0, 1, 64 },
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index ca98744343b8..a88343bbd6a6 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -4042,7 +4042,7 @@ enum perf_uncore_iio_freerunning_type_id {
>  };
>  
>  
> -static struct freerunning_counters skx_iio_freerunning[] = {
> +static const struct freerunning_counters skx_iio_freerunning[] = {
>  	[SKX_IIO_MSR_IOCLK]	= { 0xa45, 0x1, 0x20, 1, 36 },
>  	[SKX_IIO_MSR_BW]	= { 0xb00, 0x1, 0x10, 8, 36 },
>  	[SKX_IIO_MSR_UTIL]	= { 0xb08, 0x1, 0x10, 8, 36 },
> @@ -4881,7 +4881,7 @@ enum perf_uncore_snr_iio_freerunning_type_id {
>  	SNR_IIO_FREERUNNING_TYPE_MAX,
>  };
>  
> -static struct freerunning_counters snr_iio_freerunning[] = {
> +static const struct freerunning_counters snr_iio_freerunning[] = {
>  	[SNR_IIO_MSR_IOCLK]	= { 0x1eac, 0x1, 0x10, 1, 48 },
>  	[SNR_IIO_MSR_BW_IN]	= { 0x1f00, 0x1, 0x10, 8, 48 },
>  };
> @@ -5238,7 +5238,7 @@ enum perf_uncore_snr_imc_freerunning_type_id {
>  	SNR_IMC_FREERUNNING_TYPE_MAX,
>  };
>  
> -static struct freerunning_counters snr_imc_freerunning[] = {
> +static const struct freerunning_counters snr_imc_freerunning[] = {
>  	[SNR_IMC_DCLK]	= { 0x22b0, 0x0, 0, 1, 48 },
>  	[SNR_IMC_DDR]	= { 0x2290, 0x8, 0, 2, 48 },
>  };
> @@ -5480,7 +5480,7 @@ static unsigned icx_iio_bw_freerunning_box_offsets[] = {
>  	0x0, 0x10, 0x20, 0x90, 0xa0, 0xb0,
>  };
>  
> -static struct freerunning_counters icx_iio_freerunning[] = {
> +static const struct freerunning_counters icx_iio_freerunning[] = {
>  	[ICX_IIO_MSR_IOCLK]	= { 0xa55, 0x1, 0x20, 1, 48, icx_iio_clk_freerunning_box_offsets },
>  	[ICX_IIO_MSR_BW_IN]	= { 0xaa0, 0x1, 0x10, 8, 48, icx_iio_bw_freerunning_box_offsets },
>  };
> @@ -5838,7 +5838,7 @@ enum perf_uncore_icx_imc_freerunning_type_id {
>  	ICX_IMC_FREERUNNING_TYPE_MAX,
>  };
>  
> -static struct freerunning_counters icx_imc_freerunning[] = {
> +static const struct freerunning_counters icx_imc_freerunning[] = {
>  	[ICX_IMC_DCLK]	= { 0x22b0, 0x0, 0, 1, 48 },
>  	[ICX_IMC_DDR]	= { 0x2290, 0x8, 0, 2, 48 },
>  	[ICX_IMC_DDRT]	= { 0x22a0, 0x8, 0, 2, 48 },
> @@ -6314,7 +6314,7 @@ enum perf_uncore_spr_iio_freerunning_type_id {
>  	SPR_IIO_FREERUNNING_TYPE_MAX,
>  };
>  
> -static struct freerunning_counters spr_iio_freerunning[] = {
> +static const struct freerunning_counters spr_iio_freerunning[] = {
>  	[SPR_IIO_MSR_IOCLK]	= { 0x340e, 0x1, 0x10, 1, 48 },
>  	[SPR_IIO_MSR_BW_IN]	= { 0x3800, 0x1, 0x10, 8, 48 },
>  	[SPR_IIO_MSR_BW_OUT]	= { 0x3808, 0x1, 0x10, 8, 48 },
> @@ -6393,7 +6393,7 @@ enum perf_uncore_spr_imc_freerunning_type_id {
>  	SPR_IMC_FREERUNNING_TYPE_MAX,
>  };
>  
> -static struct freerunning_counters spr_imc_freerunning[] = {
> +static const struct freerunning_counters spr_imc_freerunning[] = {
>  	[SPR_IMC_DCLK]		= { 0x22b0, 0x0, 0, 1, 48 },
>  	[SPR_IMC_PQ_CYCLES]	= { 0x2318, 0x8, 0, 2, 48 },
>  };
> @@ -6744,7 +6744,7 @@ static struct intel_uncore_type *gnr_uncores[UNCORE_GNR_NUM_UNCORE_TYPES] = {
>  	NULL,
>  };
>  
> -static struct freerunning_counters gnr_iio_freerunning[] = {
> +static const struct freerunning_counters gnr_iio_freerunning[] = {
>  	[SPR_IIO_MSR_IOCLK]	= { 0x290e, 0x01, 0x10, 1, 48 },
>  	[SPR_IIO_MSR_BW_IN]	= { 0x360e, 0x10, 0x80, 8, 48 },
>  	[SPR_IIO_MSR_BW_OUT]	= { 0x2e0e, 0x10, 0x80, 8, 48 },
