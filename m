Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7202F0661;
	Thu, 28 May 2026 06:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779948202; cv=none; b=D1akFQ+Nb3mBtO26P27mGawXDrFSCkt7VOmpatXRJBdFaIzUCO7437LoURFBIsT272uyyRYD4eS4eBRMOxTfNqPEPJBtPMlYThRpt2tWI7+dTM9CKWT8i9NftFFpyNFW4QZs0Tt4Jdos7qcGxbbBtZramBqfdgjxfXX3O/N4hXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779948202; c=relaxed/simple;
	bh=w2aziwmc4ab/Uq/FPz13DWaFuTWrWhshk/hOSR7cHzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sb4xgHQtCI6ArRgAjtTkIVdU9U0NAVsrGzQVAZ1xs5Djzs3r7QnJRbuMa8BOsHoU9nW9G50juGJImr3IHewZ6rWOIZImU+9ImhgBSEdoXeLoZg8FDhPWvXSRMFIGmaMAD/5xa9naCD6dQiXkctBacUpFvt8ZOm/MdeB/QpF0QeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9RoMmRt; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9RoMmRt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779948200; x=1811484200;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w2aziwmc4ab/Uq/FPz13DWaFuTWrWhshk/hOSR7cHzA=;
  b=O9RoMmRtEHElfGbuqCrr8yRpEGF7RJNNtbVvHuf/QD6ldQHFTSqWmyYd
   ILNRgNUpWeM92Re1o6ynJCi0lnJCSNjkuzdhDROMRBKsDkZKfdgJiYLsm
   CzamHSiRZv1dSYIBGfcpdjqbc6LOx1bO2BVgIJzM/MzcVtCqupLodkBTp
   kS+kc2ZMkOW9ziVd8WASzSFizPsfhGO1vLcI4CBEyiAfj6oh+V3EEXWvK
   1qOkiiAVOw63LTGq/0zMlrj2tKfIMIQ1ZtkRmyeroGtWY6CQobBrFtEnU
   9ICLHHz1w8LrTuyFbXRjOy6SJt/6oZXu9Jn55lIfbWOJ6K5NODTooF2Iw
   A==;
X-CSE-ConnectionGUID: giRjd6QeSGWPYjYl4uKBaw==
X-CSE-MsgGUID: 19ZiWoZ6QiijQXCaCeenwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80777320"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80777320"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 23:03:20 -0700
X-CSE-ConnectionGUID: PIL2toTWQUCVXdxBN3N0NA==
X-CSE-MsgGUID: 3DXIEF3pT0GLZrCy5QKH1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="272789581"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 23:03:16 -0700
Message-ID: <6b5428ae-d31f-4a21-b7c2-65b0db00a9e8@linux.intel.com>
Date: Thu, 28 May 2026 14:03:14 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/7] perf/x86/intel/uncore: Guard against invalid box
 control address
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260527151154.130505-1-zide.chen@intel.com>
 <20260527151154.130505-2-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260527151154.130505-2-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 5/27/2026 11:11 PM, Zide Chen wrote:
> Theoretically, intel_uncore_find_discovery_unit() could return NULL,
> e.g., when a CPU die is offline during uncore enumeration and its PMU
> units are not added to the discovery RB-tree.
>
> Guard against a NULL return value and the resulting invalid box control
> address (0) before accessing hardware.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> V2:
> - New patch.
> - Address pre-existing invalid box control address issue (Sashiko).
> ---
>  arch/x86/events/intel/uncore_discovery.c | 36 ++++++++++++++++++------
>  1 file changed, 27 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
> index 60e1200c4691..af2217b44a81 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
> @@ -490,17 +490,28 @@ static u64 intel_generic_uncore_box_ctl(struct intel_uncore_box *box)
>  
>  void intel_generic_uncore_msr_init_box(struct intel_uncore_box *box)
>  {
> -	wrmsrq(intel_generic_uncore_box_ctl(box), GENERIC_PMON_BOX_CTL_INT);
> +	u64 box_ctl = intel_generic_uncore_box_ctl(box);
> +
> +	if (!box_ctl)
> +		return;
> +
> +	wrmsrq(box_ctl, GENERIC_PMON_BOX_CTL_INT);
>  }
>  
>  void intel_generic_uncore_msr_disable_box(struct intel_uncore_box *box)
>  {
> -	wrmsrq(intel_generic_uncore_box_ctl(box), GENERIC_PMON_BOX_CTL_FRZ);
> +	u64 box_ctl = intel_generic_uncore_box_ctl(box);
> +
> +	if (box_ctl)
> +		wrmsrq(box_ctl, GENERIC_PMON_BOX_CTL_FRZ);
>  }
>  
>  void intel_generic_uncore_msr_enable_box(struct intel_uncore_box *box)
>  {
> -	wrmsrq(intel_generic_uncore_box_ctl(box), 0);
> +	u64 box_ctl = intel_generic_uncore_box_ctl(box);
> +
> +	if (box_ctl)
> +		wrmsrq(box_ctl, 0);
>  }
>  
>  static void intel_generic_uncore_msr_enable_event(struct intel_uncore_box *box,
> @@ -549,6 +560,10 @@ bool intel_generic_uncore_assign_hw_event(struct perf_event *event,
>  
>  	if (box->pci_dev) {
>  		box_ctl = UNCORE_DISCOVERY_PCI_BOX_CTRL(box_ctl);
> +
> +		if (!box_ctl)
> +			return false;
> +
>  		hwc->config_base = box_ctl + uncore_pci_event_ctl(box, hwc->idx);
>  		hwc->event_base  = box_ctl + uncore_pci_perf_ctr(box, hwc->idx);
>  		return true;
> @@ -567,27 +582,30 @@ static inline int intel_pci_uncore_box_ctl(struct intel_uncore_box *box)
>  
>  void intel_generic_uncore_pci_init_box(struct intel_uncore_box *box)
>  {
> -	struct pci_dev *pdev = box->pci_dev;
>  	int box_ctl = intel_pci_uncore_box_ctl(box);
>  
> +	if (!box_ctl)
> +		return;
> +
>  	__set_bit(UNCORE_BOX_FLAG_CTL_OFFS8, &box->flags);
> -	pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_INT);
> +	pci_write_config_dword(box->pci_dev, box_ctl, GENERIC_PMON_BOX_CTL_INT);
>  }
>  
>  void intel_generic_uncore_pci_disable_box(struct intel_uncore_box *box)
>  {
> -	struct pci_dev *pdev = box->pci_dev;
>  	int box_ctl = intel_pci_uncore_box_ctl(box);
>  
> -	pci_write_config_dword(pdev, box_ctl, GENERIC_PMON_BOX_CTL_FRZ);
> +	if (box_ctl)
> +		pci_write_config_dword(box->pci_dev, box_ctl,
> +				       GENERIC_PMON_BOX_CTL_FRZ);
>  }
>  
>  void intel_generic_uncore_pci_enable_box(struct intel_uncore_box *box)
>  {
> -	struct pci_dev *pdev = box->pci_dev;
>  	int box_ctl = intel_pci_uncore_box_ctl(box);
>  
> -	pci_write_config_dword(pdev, box_ctl, 0);
> +	if (box_ctl)
> +		pci_write_config_dword(box->pci_dev, box_ctl, 0);
>  }
>  
>  static void intel_generic_uncore_pci_enable_event(struct intel_uncore_box *box,
