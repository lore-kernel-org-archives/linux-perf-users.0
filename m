Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5868F1AA1C4
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Dec 2024 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733930926; cv=none; b=cLnWk3AbyPCJlBMtoglVrjG3c99Uc0f7ejSp7gNFJ0HRHGsM2kyLuspteo3UFnLv7pVvnBr38CIV4TwffYPPogmC1VUL6dG4h3p9N8ftueDrH8Q5ctZKWOs11WRcs6ouiFfpdqKwmrqdd9GIGM6MQT1PEoRTDDMzJm1xXbQANhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733930926; c=relaxed/simple;
	bh=DISuUbcvoGtqwmxV6M2OMmuO1I2oG4mY9akZoZTj/fY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pv8AcR26AUV0B7fWxGjMK6L8hGf+F10QP0lNocnH0l6YcQt7tSvfUvR+q89xBmHTeODJjm/LmawjHr8SxQrDRD8aVgTxCfspLA9TWIoSAPazlnCHxJvoXiYTKCxHgR3pIjbWFYU6fbCDKXg5/HQ7kbHpP1kwe5Lt9MaEyJzlUic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPa387vA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPa387vA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733930925; x=1765466925;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=DISuUbcvoGtqwmxV6M2OMmuO1I2oG4mY9akZoZTj/fY=;
  b=FPa387vAj18yuP35djelH7gkG/zEVhNal/2Zh+nv1/1lK7skJQUrQrxW
   3HtVG0ik1FVd913XjURzsvlxZVlDqcnP2mi7a9nE5z8YrAxtQLLwej9Ol
   VR5ZJdBpFwMFPYtqCv02XXQyx06AtAJ8WBlzuG/wm8QcNaddMJ+Fcq7tT
   Ww2OnHf/VCQ/jUP+/F39DII06HJnPjEipuXCriT2hpHAm9+4o7x0MuQlA
   wbgZ6IYXFrSge9MJ8WktG/d5uAuDwd2WFII7mBbTFqM/5kNnT8mbXsVgL
   87HNxJa/YEac2hsQqHX0YEvcSPlWrPV59xsZP5Uou5UiCcJ451IrloBHp
   Q==;
X-CSE-ConnectionGUID: U5okPiuIRyS8SPlCdOHcaw==
X-CSE-MsgGUID: s1La8CvBSGuKIrUeskDe4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34189296"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="34189296"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 07:28:44 -0800
X-CSE-ConnectionGUID: IdnXcn1MRJ6Dd3ZQdxJ2Rw==
X-CSE-MsgGUID: VIMAUzkXTJaBONlHCtJBbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133228642"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 07:28:44 -0800
Received: from [10.246.136.4] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.4])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 11C7C20B5703;
	Wed, 11 Dec 2024 07:28:43 -0800 (PST)
Message-ID: <997d6f52-05a0-4f24-a7c7-41279c7543da@linux.intel.com>
Date: Wed, 11 Dec 2024 10:28:42 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Update perf tools topdown documentation
To: Andi Kleen <ak@linux.intel.com>, linux-perf-users@vger.kernel.org
References: <20241210193554.93013-1-ak@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20241210193554.93013-1-ak@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-12-10 2:35 p.m., Andi Kleen wrote:
> - Document and give examples for the Lunar Lake perf metrics reset mode.
> - Fix the error handling for mmap (it returns -1 on error, not 0)
> - Clarify the slots placement documentation. It is not Icelake specific
> and also applies for non sampling.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/Documentation/topdown.txt | 33 +++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/Documentation/topdown.txt b/tools/perf/Documentation/topdown.txt
> index 5c17fff694ee..3e2340f3f78e 100644
> --- a/tools/perf/Documentation/topdown.txt
> +++ b/tools/perf/Documentation/topdown.txt
> @@ -87,7 +87,7 @@ if (slots_fd < 0)
>  
>  /* Memory mapping the fd permits _rdpmc calls from userspace */
>  void *slots_p = mmap(0, getpagesize(), PROT_READ, MAP_SHARED, slots_fd, 0);
> -if (!slot_p)
> +if (slot_p == (void*)-1L)
>  	.... error ...
>  
>  /*
> @@ -107,7 +107,7 @@ if (metrics_fd < 0)
>  
>  /* Memory mapping the fd permits _rdpmc calls from userspace */
>  void *metrics_p = mmap(0, getpagesize(), PROT_READ, MAP_SHARED, metrics_fd, 0);
> -if (!metrics_p)
> +if (metrics_p == (void*)-1L)
>  	... error ...
>  
>  Note: the file descriptors returned by the perf_event_open calls must be memory
> @@ -290,15 +290,38 @@ This "opens" a new measurement period.
>  A program using RDPMC for TopDown should schedule such a reset
>  regularly, as in every few seconds.
>  
> -Limits on Intel Ice Lake
> -========================
> +Newer Intel CPUs (Lunar Lake, Arrow Lake+) support resetting the perf
> +metrics automatically RDPMC, which can avoid a system call or needing
> +to schedule special resets.
> +
> +This is available if /sys/devices/cpu*/cap/metrics_clear

It's under the "format/metrics_clear", not "cap/metrics_clear"

https://lore.kernel.org/lkml/20240926184558.3797290-1-kan.liang@linux.intel.com/

Since the kernel patch hasn't been merged yet, I will add this document
patch to the kernel patch series. I will re-post the whole series soon.

Thanks,
Kan
> +exists, and requires setting an opt-in bit when opening the 
> +slots counter:
> +
> +if (access("/sys/devices/cpu/cap/metrics_clear") &&
> +    access("/sys/devices/cpu_core/cap/metrics_clear"))
> +     ... functionality not supported ...
> +
> +#define INTEL_TD_CFG_METRIC_CLEAR 1ULL
> +
> +struct perf_event_attr slots_event = {
> +	... same as slots example above ...
> +	.config1 = INTEL_TD_CFG_METRIC_CLEAR,
> +};
> +
> +... open and map counter same as example above ...
> +
> +Then any metric read will reset the metrics and slots.
> +
> +Using perf metrics with perf stat
> +=================================
>  
>  Four pseudo TopDown metric events are exposed for the end-users,
>  topdown-retiring, topdown-bad-spec, topdown-fe-bound and topdown-be-bound.
>  They can be used to collect the TopDown value under the following
>  rules:
>  - All the TopDown metric events must be in a group with the SLOTS event.
> -- The SLOTS event must be the leader of the group.
> +- The SLOTS event must be the first entry of the group.
>  - The PERF_FORMAT_GROUP flag must be applied for each TopDown metric
>    events
>  

