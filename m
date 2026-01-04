Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F220E12D1F1;
	Sun,  4 Jan 2026 02:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767495088; cv=none; b=OWBDJaTMhgUzxwrUTuF3e1toB5b69dWQngA+CVry7WAlV7UHAVLIsJKEIzNA0kok5ekpFVO/42tlOAbJG9APp09uqiSrztNSxsLA8+Kf+sy05BOBAX8ccDxUOcvv6FqhALgbWYScsnXsoNvwxTCYNtQ+b/v7HE+7iMMHFUCv29M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767495088; c=relaxed/simple;
	bh=9zmuqcyczJJP3lDCAdCvFDx3GSm1SPcvYvFYScZgNoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fuhhuRz15NIJ6E54Y6sqWEC+gst+T8Zih5AMFhJg+oVrqFyUWzzGe1dNq6fj4qKvXJyeqhilXO95s14SLDZZydPJlKAfOK02cMMa0dTe164kJb//Il6MyIwOi8PyZ6RBKuhdt15kzZsJnx6D9mnqDUuq84Y6DGrYprRuK4C3czc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mp04rYYv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mp04rYYv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767495087; x=1799031087;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9zmuqcyczJJP3lDCAdCvFDx3GSm1SPcvYvFYScZgNoc=;
  b=mp04rYYvrB7AACkDZTDTOPkqpb6EjevhQhsS4wkwHYPTI7la0V0yLZwn
   YOdqeH/ONBktmj0Izr+NB2R5cKavlBLd3L/kFddWEd9FjgD73YDo5lMTW
   RxS0LLw9mpR7V/DXeEcUMEcd5F/A1LxMLgl13Fk9R8A5sasl5QbHbnh5J
   PsKvmabk1NiYHlCLEWCiPJbFCZZTZwUT460yQvJW+1iM5Fb9zcbysd+DN
   p3u4cIbyJHOproE9cLa3Z5j7qbrnyQ8uPQ7AdFFjslzQkJmjc4Qv94XVd
   z3rFRu9JA/3wWuW9osGbokuyYXMVIIV9I8dSjPSgwEh/FyWw2+lMYGo14
   A==;
X-CSE-ConnectionGUID: zJ20MkQRTcyvqI+4Z/ctRA==
X-CSE-MsgGUID: 1punSiERTu6PqrR2gDvzPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="56476310"
X-IronPort-AV: E=Sophos;i="6.21,200,1763452800"; 
   d="scan'208";a="56476310"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 18:51:26 -0800
X-CSE-ConnectionGUID: cfbLhtHTSKSzzXKoOBaYCQ==
X-CSE-MsgGUID: 7JX4Bg6jQ9+5j3aVUdwF4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,200,1763452800"; 
   d="scan'208";a="232780974"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 18:51:22 -0800
Message-ID: <469b889f-2497-420e-98ff-b6575d6c5643@linux.intel.com>
Date: Sun, 4 Jan 2026 10:51:20 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 13/13] perf/x86/intel/uncore: Add Nova Lake support
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>
References: <20251231224233.113839-1-zide.chen@intel.com>
 <20251231224233.113839-14-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251231224233.113839-14-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/1/2026 6:42 AM, Zide Chen wrote:
> Nova Lake uncore PMON largely follows Panther Lake and supports CBOX,
> iMC, cNCU, SANTA, sNCU, and HBO units.
>
> As with Panther Lake, CBOX, cNCU, and SANTA are not enumerated via
> discovery tables.  Their programming model matches Panther Lake, with
> differences limited to MSR addresses and the number of boxes or counters
> per box.
>
> The remaining units are enumerated via discovery tables using a new
> base MSR (0x711) and otherwise reuse the Panther Lake implementation.
> Nova Lake also supports iMC free-running counters.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V2: new patch
>
>  arch/x86/events/intel/uncore.c           |  9 ++++++
>  arch/x86/events/intel/uncore.h           |  1 +
>  arch/x86/events/intel/uncore_discovery.h |  2 ++
>  arch/x86/events/intel/uncore_snb.c       | 40 ++++++++++++++++++++++++
>  4 files changed, 52 insertions(+)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 07a9a2826398..2607bf178658 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1817,6 +1817,13 @@ static const struct uncore_plat_init ptl_uncore_init __initconst = {
>  	.domain[0].global_init = uncore_mmio_global_init,
>  };
>  
> +static const struct uncore_plat_init nvl_uncore_init __initconst = {
> +	.cpu_init = nvl_uncore_cpu_init,
> +	.mmio_init = ptl_uncore_mmio_init,
> +	.domain[0].discovery_base = PACKAGE_UNCORE_DISCOVERY_MSR,
> +	.domain[0].global_init = uncore_mmio_global_init,
> +};
> +
>  static const struct uncore_plat_init icx_uncore_init __initconst = {
>  	.cpu_init = icx_uncore_cpu_init,
>  	.pci_init = icx_uncore_pci_init,
> @@ -1916,6 +1923,8 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
>  	X86_MATCH_VFM(INTEL_LUNARLAKE_M,	&lnl_uncore_init),
>  	X86_MATCH_VFM(INTEL_PANTHERLAKE_L,	&ptl_uncore_init),
>  	X86_MATCH_VFM(INTEL_WILDCATLAKE_L,	&ptl_uncore_init),
> +	X86_MATCH_VFM(INTEL_NOVALAKE,		&nvl_uncore_init),
> +	X86_MATCH_VFM(INTEL_NOVALAKE_L,		&nvl_uncore_init),
>  	X86_MATCH_VFM(INTEL_SAPPHIRERAPIDS_X,	&spr_uncore_init),
>  	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&spr_uncore_init),
>  	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	&gnr_uncore_init),
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
> index 564cb26c4468..c35918c01afa 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -636,6 +636,7 @@ void adl_uncore_cpu_init(void);
>  void lnl_uncore_cpu_init(void);
>  void mtl_uncore_cpu_init(void);
>  void ptl_uncore_cpu_init(void);
> +void nvl_uncore_cpu_init(void);
>  void tgl_uncore_mmio_init(void);
>  void tgl_l_uncore_mmio_init(void);
>  void adl_uncore_mmio_init(void);
> diff --git a/arch/x86/events/intel/uncore_discovery.h b/arch/x86/events/intel/uncore_discovery.h
> index 63b8f7634e42..e1330342b92e 100644
> --- a/arch/x86/events/intel/uncore_discovery.h
> +++ b/arch/x86/events/intel/uncore_discovery.h
> @@ -4,6 +4,8 @@
>  #define UNCORE_DISCOVERY_MSR			0x201e
>  /* Base address of uncore perfmon discovery table for CBB domain */
>  #define CBB_UNCORE_DISCOVERY_MSR		0x710
> +/* Base address of uncore perfmon discovery table for the package */
> +#define PACKAGE_UNCORE_DISCOVERY_MSR		0x711
>  
>  /* Generic device ID of a discovery table device */
>  #define UNCORE_DISCOVERY_TABLE_DEVICE		0x09a7
> diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
> index c663b00b68fe..e8e44741200e 100644
> --- a/arch/x86/events/intel/uncore_snb.c
> +++ b/arch/x86/events/intel/uncore_snb.c
> @@ -256,6 +256,19 @@
>  /* PTL cNCU register */
>  #define PTL_UNC_CNCU_MSR_OFFSET			0x140
>  
> +/* NVL cNCU register */
> +#define NVL_UNC_CNCU_BOX_CTL			0x202e
> +#define NVL_UNC_CNCU_FIXED_CTR			0x2028
> +#define NVL_UNC_CNCU_FIXED_CTRL			0x2022
> +
> +/* NVL SANTA register */
> +#define NVL_UNC_SANTA_CTR0			0x2048
> +#define NVL_UNC_SANTA_CTRL0			0x2042
> +
> +/* NVL CBOX register */
> +#define NVL_UNC_CBOX_PER_CTR0			0x2108
> +#define NVL_UNC_CBOX_PERFEVTSEL0		0x2102
> +
>  DEFINE_UNCORE_FORMAT_ATTR(event, event, "config:0-7");
>  DEFINE_UNCORE_FORMAT_ATTR(umask, umask, "config:8-15");
>  DEFINE_UNCORE_FORMAT_ATTR(chmask, chmask, "config:8-11");
> @@ -1979,3 +1992,30 @@ void ptl_uncore_cpu_init(void)
>  }
>  
>  /* end of Panther Lake uncore support */
> +
> +/* Nova Lake uncore support */
> +
> +static struct intel_uncore_type *nvl_msr_uncores[] = {
> +	&mtl_uncore_cbox,
> +	&ptl_uncore_santa,
> +	&mtl_uncore_cncu,
> +	NULL
> +};
> +
> +void nvl_uncore_cpu_init(void)
> +{
> +	mtl_uncore_cbox.num_boxes = 12;
> +	mtl_uncore_cbox.perf_ctr = NVL_UNC_CBOX_PER_CTR0,
> +	mtl_uncore_cbox.event_ctl = NVL_UNC_CBOX_PERFEVTSEL0,
> +
> +	ptl_uncore_santa.perf_ctr = NVL_UNC_SANTA_CTR0,
> +	ptl_uncore_santa.event_ctl = NVL_UNC_SANTA_CTRL0,
> +
> +	mtl_uncore_cncu.box_ctl = NVL_UNC_CNCU_BOX_CTL;
> +	mtl_uncore_cncu.fixed_ctr = NVL_UNC_CNCU_FIXED_CTR;
> +	mtl_uncore_cncu.fixed_ctl = NVL_UNC_CNCU_FIXED_CTRL;
> +
> +	uncore_msr_uncores = nvl_msr_uncores;
> +}
> +
> +/* end of Nova Lake uncore support */

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


