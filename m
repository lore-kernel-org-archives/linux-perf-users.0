Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072D535E1C4;
	Wed,  3 Jun 2026 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780450239; cv=none; b=N8GJZoXIl2wPyixtLJN3K/q+1XrD/40X2p9V5M/LuvxYYBIqIJ2rmgEi/8MF1ehm5DUDGit5o0VILJANchPTtFWyp0vwRRlYcRH1hU31iTm+7RnTA5LPoixT1cG6Z1PKOaOfvS7WxJkLf/k4X1rWD4nyxq0a5VVJrRLTGjN7IzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780450239; c=relaxed/simple;
	bh=OOUAcdwVNV9AtT0kSfZ/jy1hiLmzr2hZuQv56WhMnTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBktJpDhyf0BRNPDr3BWr5Jmbr3MLBbey5VxD514Ka/gmnAC3wI5J8cbGT87Z0WhGv1F/JbOQkmoeVd+Xe8GxRQxyQKM4xpcZKar3mV29/vxJv3DwWcC9ygdfVoz7mcd9sTsNLDxeWF+idPPVWv2W4zRIjUiPgPVOpNm1MCoWgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OYxdcG+A; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OYxdcG+A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780450238; x=1811986238;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OOUAcdwVNV9AtT0kSfZ/jy1hiLmzr2hZuQv56WhMnTc=;
  b=OYxdcG+Ar8TpEzuC9AYC49Ra/ZHFCTxaIwqVtiC9xVsRdSsCnOm2iwwG
   WUl2wdHuqlYZD9nU0xo+oPjABYoLUZLtxDfnauqSdj6KfvtqEnWRNJCxD
   g7ZRYwjHgu1lz/F6f+nqqgEU12wgJq5GOuiSKm8BBejiRFMiJopSFVBme
   IejGRnQpYFT6gVlNkaFFsbAELfwCaV6QxDyy1MrSyTi9oolAvzSGJ75rj
   31yg41D76x5ISI9KF3WJdYshe3z7ED63DrvAEGNzlS7n4K8zw0txzkP9c
   gV8N+rflm1XNfSFmSbrigCgqDZ+jO1yD1uGllwq41AwXMWY9lvvI8gGr1
   Q==;
X-CSE-ConnectionGUID: lyg7I62fRx6FxjrbsgrZtQ==
X-CSE-MsgGUID: jN9Nndj4TcKK0CxP/5np4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="80278687"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="80278687"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 18:30:37 -0700
X-CSE-ConnectionGUID: 4htR46KDQemo9GoYg73Emg==
X-CSE-MsgGUID: qlvqxnXMRbGvxt7XONg2cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="282184505"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 18:30:35 -0700
Message-ID: <a533aa3d-c2e5-44c8-b007-fdf6c6d977b2@linux.intel.com>
Date: Wed, 3 Jun 2026 09:30:31 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/8] perf/x86/intel/uncore: Factor out box setup code
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260601170114.173359-1-zide.chen@intel.com>
 <20260601170114.173359-6-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260601170114.173359-6-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 6/2/2026 1:01 AM, Zide Chen wrote:
> The PCI uncore PMU path already implements a lazy registration model:
> the PMU is registered when the first active box appears and
> unregistered when the last active box is removed.
>
> Factor this registration management into a shared helper, so the same
> code can be reused by the MSR and MMIO paths in later changes.
>
> No functional change intended.
>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore.c | 40 ++++++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 6df44f69cc5b..283e41933ba7 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1148,6 +1148,29 @@ uncore_pci_find_dev_pmu(struct pci_dev *pdev, const struct pci_device_id *ids)
>  	return pmu;
>  }
>  
> +static int uncore_box_setup(struct intel_uncore_pmu *pmu,
> +			    struct intel_uncore_box *box)
> +{
> +	int ret;
> +
> +	uncore_box_init(box);
> +
> +	/* First active box registers the pmu. */
> +	if (atomic_inc_return(&pmu->activeboxes) > 1)
> +		return 0;
> +
> +	ret = uncore_pmu_register(pmu);
> +	if (ret) {
> +		atomic_dec(&pmu->activeboxes);
> +		goto err;
> +	}
> +
> +	return 0;
> +err:
> +	uncore_box_exit(box);
> +	return ret;
> +}
> +
>  /*
>   * Register the PMU for a PCI device
>   * @pdev: The PCI device.
> @@ -1173,20 +1196,13 @@ static int uncore_pci_pmu_register(struct pci_dev *pdev,
>  	box->dieid = die;
>  	box->pci_dev = pdev;
>  	box->pmu = pmu;
> -	uncore_box_init(box);
>  
> -	pmu->boxes[die] = box;
> -	if (atomic_inc_return(&pmu->activeboxes) > 1)
> -		return 0;
> -
> -	/* First active box registers the pmu */
> -	ret = uncore_pmu_register(pmu);
> -	if (ret) {
> -		atomic_dec(&pmu->activeboxes);
> -		pmu->boxes[die] = NULL;
> -		uncore_box_exit(box);
> +	ret = uncore_box_setup(pmu, box);
> +	if (!ret)
> +		pmu->boxes[die] = box;
> +	else
>  		kfree(box);
> -	}
> +
>  	return ret;
>  }
>  
