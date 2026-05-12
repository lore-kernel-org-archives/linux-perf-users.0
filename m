Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D7B2E62A9;
	Tue, 12 May 2026 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578080; cv=none; b=Go6P/kMXSssEKxIQDU4Ax86VekdqSfcu3wFyMENTI1w0rn8NRg03C1mQcPZpCz9Qn5+mOYcjOh9HRdtvn8socZWmKe2acufo1FZH8BY44NPt0qfHBfA9SxLej6ShWG0SLt3FMft+WwscKgZOoz82Se2mL8CLylO+8MjzUb874tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578080; c=relaxed/simple;
	bh=g19CLWxVZUL0awtylS4oLS1iR71+SGr78b8tU+V4ZxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UcuvSH+52fj+tOgtBwQR85EdndzPXNnQhSXys3qBh254ba/YRkIA/DIe0kkcq1x9suz0tzXyOU29CAWeF1jmQ0umpSlaV3F8b0aEdPH7JJbxzbV+fLlwbcdXWsBYw+pLoVLLxi8yarg0VVJcfRCIbUXvYe/P/INr+mm8JSJ/Ask=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KBoMtH2R; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KBoMtH2R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778578078; x=1810114078;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g19CLWxVZUL0awtylS4oLS1iR71+SGr78b8tU+V4ZxY=;
  b=KBoMtH2RSha3JKmoEeqttAmTiRSVXY9y1H8o4aOkekUAemluhQQxhcIx
   MdSc4Armj+aatpuPBJCGTi3Dh7To6tv5MpIMVnbn2auOX9TTpX107+ps3
   9dLRqtxYn4/TDllr8IelQSJC6dML13RGbbiB2gHIiW3r9SNsDeyGkEG7T
   lwdKbUyFDiODSprNbpU4ai8tlt1gmo3iK/nwMHoEh97Nv6S36vgDYgii5
   zBWqa5xpbheAg6VFuT27EcladMq5WIZA94vZx4aJ6BP6hQ/Zq+AKIRLGE
   CydXA1dETUPDD8cZEDXHI7NKsTeUuBW/Za3A0RzCSN4/hXtHPZwZuCfQx
   Q==;
X-CSE-ConnectionGUID: PmTtTzIAQrCTMGtklQ0M/g==
X-CSE-MsgGUID: 1KqMLNjCQ1mHt37hi5s3sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90582861"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="90582861"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:27:57 -0700
X-CSE-ConnectionGUID: 9iK9FoneR0GIy84efwVupA==
X-CSE-MsgGUID: KT3wgPJZSLqS1LkvTRlJew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233238518"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:27:54 -0700
Message-ID: <7c3aed41-c68c-4cd4-862f-66039b87c7e8@linux.intel.com>
Date: Tue, 12 May 2026 17:27:52 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] perf/x86/intel/uncore: Fix PCI device refcount leak
 in UPI discovery
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260511230527.26096-1-zide.chen@intel.com>
 <20260511230527.26096-3-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260511230527.26096-3-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/12/2026 7:05 AM, Zide Chen wrote:
> pci_get_domain_bus_and_slot() increments the reference count of the
> returned PCI device and therefore requires a matching pci_dev_put().
>
> In skx_upi_topology_cb() and discover_upi_topology(), the lookup is
> performed inside a loop, but pci_dev_put() is only called once after
> the loop. As a result, references from all previous iterations are
> leaked.
>
> Move pci_dev_put(dev) into the if (dev) block immediately after
> upi_fill_topology() returns.
>
> Opportunistically, fix uninitialized variable in skx_upi_topology_cb().
>
> Fixes: 4cfce57fa42d ("perf/x86/intel/uncore: Enable UPI topology discovery for Skylake Server")
> Fixes: f680b6e6062e ("perf/x86/intel/uncore: Enable UPI topology discovery for Icelake Server")
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore_snbep.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 215d33e260ed..c9ce206fcbb6 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -4261,7 +4261,7 @@ static int upi_fill_topology(struct pci_dev *dev, struct intel_uncore_topology *
>  static int skx_upi_topology_cb(struct intel_uncore_type *type, int segment,
>  				int die, u64 cpu_bus_msr)
>  {
> -	int idx, ret;
> +	int idx, ret = 0;
>  	struct intel_uncore_topology *upi;
>  	unsigned int devfn;
>  	struct pci_dev *dev = NULL;
> @@ -4274,12 +4274,12 @@ static int skx_upi_topology_cb(struct intel_uncore_type *type, int segment,
>  		dev = pci_get_domain_bus_and_slot(segment, bus, devfn);
>  		if (dev) {
>  			ret = upi_fill_topology(dev, upi, idx);
> +			pci_dev_put(dev);
>  			if (ret)
>  				break;
>  		}
>  	}
>  
> -	pci_dev_put(dev);
>  	return ret;
>  }
>  
> @@ -5499,6 +5499,7 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
>  							  devfn);
>  			if (dev) {
>  				ret = upi_fill_topology(dev, upi, idx);
> +				pci_dev_put(dev);
>  				if (ret)
>  					goto err;
>  			}
> @@ -5506,7 +5507,6 @@ static int discover_upi_topology(struct intel_uncore_type *type, int ubox_did, i
>  	}
>  err:
>  	pci_dev_put(ubox);
> -	pci_dev_put(dev);

Should we move the "pci_dev_put(ubox)" into the while loop as well? In
theory, the ubox device could be found multiple times.

Besides, could you please search "pci_get_device()" in uncore code, it
seems some functions don't call pci_dev_put() or only calls it once, like
the funciton spr_update_device_location() ...

Thanks.



>  	return ret;
>  }
>  
