Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E93230BCB;
	Thu, 30 Oct 2025 01:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761788285; cv=none; b=q9ttNXBLjIgam09GDPRZ4tNgmLCnBQs4JHQ5pcR7DbYsiG3YD96VgMAxuKmJ4l8pYVodo8EVqUqsjdUEZH1rQDsL6/VfHQWOgxDZaXJB99Zsfh8q/H+tVtYQeS5MBxZ883SowIpJ3E1ZIZmekxr9AoPTMj8/A9cZZv9fzrdwUgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761788285; c=relaxed/simple;
	bh=8CXfEmdN7+qbIHv8ZgbRK4KEOPrzqAYXFfVFVXNHKCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z36XAqut4KRH8JHGiASnJ5ZdtNDMYndh16sua7ckccLj+hE8Pe3SmI+42sAuGULrM3b7fLAWBfpMkxpcA0HXe1mlKsaKJy9QSAOm0VaHxjGm0dysjRFtYUTadajel8XJaSYGXh/Y1ojqs2gwXqzdpklvvLJdhoOtePi5AIWQ5SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jpeMWmtz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jpeMWmtz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761788282; x=1793324282;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8CXfEmdN7+qbIHv8ZgbRK4KEOPrzqAYXFfVFVXNHKCo=;
  b=jpeMWmtzGRm0aoL0Y5Kn4ojzxcCm25O9jRlLUWUq2dfzLs9ZxX163biZ
   tjKsTP4hj7tNJWxVgrog9lIlK5VBlSODaLyZRDX90UGVoeouA4Zw+v9hW
   eZ1MGW8dulrWhqq+WFwlnD3RWCGTs0YPQBdyzYeLADuUMIE1sbbFA49en
   JYZeraTbR0aVhaHzTsH0SdiP5ljAf3b+s/z8FiozDKZ2KK8fx934/PrTI
   l4bwIIZnuHPhHI7JcPyx3OFoKN6kJpgRsilca650wry232RICm2e6deTu
   EK6A3o7BVGe9clESEOKUPcmvMxBHHCH5KWklXr8Q8mBmHDQbLG+hKJ+pW
   A==;
X-CSE-ConnectionGUID: GqFjvIw1TyCzT8jiPNo3MA==
X-CSE-MsgGUID: ti5p83lcQgaMsunPKEdYzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="62946809"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="62946809"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 18:38:01 -0700
X-CSE-ConnectionGUID: WyGLG1SGRci4D4Kk5FReCw==
X-CSE-MsgGUID: ADaadpWjRrin+SsKlbWaOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185910309"
Received: from haochenw-mobl1.ccr.corp.intel.com (HELO [10.238.3.228]) ([10.238.3.228])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 18:37:57 -0700
Message-ID: <8b53854e-f407-4c58-badc-01327d2d4be0@linux.intel.com>
Date: Thu, 30 Oct 2025 09:37:55 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf/x86/intel/uncore: Skip discovery table for
 offline dies
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Steve Wahl <steve.wahl@hpe.com>
References: <20251029220711.57909-1-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251029220711.57909-1-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/30/2025 6:07 AM, Zide Chen wrote:
> This warning can be triggered if NUMA is disabled and the system
> boots with fewer CPUs than the number of CPUs in die 0.
>
> WARNING: CPU: 9 PID: 7257 at uncore.c:1157 uncore_pci_pmu_register+0x136/0x160 [intel_uncore]
>
> Currently, the discovery table continues to be parsed even if all CPUs
> in the associated die are offline. This can lead to an array overflow
> at "pmu->boxes[die] = box" in uncore_pci_pmu_register(), which may
> trigger the warning above or cause other issues.
>
> Reported-by: Steve Wahl <steve.wahl@hpe.com>
> Fixes: edae1f06c2cd ("perf/x86/intel/uncore: Parse uncore discovery tables")
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore.c           | 4 ++++
>  arch/x86/events/intel/uncore_discovery.c | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index ee586eb714ec..5c3aeea5c78d 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1380,6 +1380,10 @@ static void uncore_pci_pmus_register(void)
>  
>  		for (node = rb_first(type->boxes); node; node = rb_next(node)) {
>  			unit = rb_entry(node, struct intel_uncore_discovery_unit, node);
> +
> +			if (WARN_ON(unit->die >= uncore_max_dies()))

Base on my understanding, it seems an valid situation which could happen.
If so, we'd better remove the WARN_on to avoid it mislead users. Thanks.



> +				continue;
> +
>  			pdev = pci_get_domain_bus_and_slot(UNCORE_DISCOVERY_PCI_DOMAIN(unit->addr),
>  							   UNCORE_DISCOVERY_PCI_BUS(unit->addr),
>  							   UNCORE_DISCOVERY_PCI_DEVFN(unit->addr));
> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
> index 1bf6e4288577..d6aee12139f1 100644
> --- a/arch/x86/events/intel/uncore_discovery.c
> +++ b/arch/x86/events/intel/uncore_discovery.c
> @@ -388,7 +388,7 @@ static bool intel_uncore_has_discovery_tables_pci(int *ignore)
>  				     (val & UNCORE_DISCOVERY_DVSEC2_BIR_MASK) * UNCORE_DISCOVERY_BIR_STEP;
>  
>  			die = get_device_die_id(dev);
> -			if (die < 0)
> +			if ((die < 0) || (die >= uncore_max_dies()))
>  				continue;
>  
>  			parse_discovery_table(dev, die, bar_offset, &parsed, ignore);
