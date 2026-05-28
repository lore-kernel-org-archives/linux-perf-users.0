Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B136327C00;
	Thu, 28 May 2026 06:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779950215; cv=none; b=iOSHeOySY0WdXT68X9AXmgd1clAVIFcbM3lB9kHI56v59ECoUmyJ8b3+v0V2aRe+dSjkcM9BenAzY88pTgXjYKusaWSIF9Z88gw1RxxtP4pUMCXm6EO5wqd2rQYF+nceccV7PutUNL2grdKK4QMKU4f7Udeu8vaYmft4v8Znqhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779950215; c=relaxed/simple;
	bh=8x5A5aVfpQ3/MSOL85B74kjUTms6CYXMuaI4U3K4ba0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFC/zKq8l7txT76/2QFk60q+DFtcqmQ0FAzt3Um0LwF844Rm3lrkWaij7w9tieG1a3elA4ANkYr0+jBt98k2GaCufU3EWBBPHXHVotwAJpbfJ09KzV1nkXcOhEwYrACK8YK3LobUeEsN7wN1mz+iRRFI8XDujwFPWC45UhyenU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qgf01qDQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qgf01qDQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779950214; x=1811486214;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8x5A5aVfpQ3/MSOL85B74kjUTms6CYXMuaI4U3K4ba0=;
  b=Qgf01qDQag+fgajNc1XqE1cf1nPqzVWmXvBaXfOQmoTKJj0Fdu8RiCSI
   qDestrzHD4isd+Lm+PqzxBEvxfIKntUXJoUVxFicXo1rQ+Vn7y2bjQunk
   2ARq9nzTXnh4EC3D1pJKtf/81sb059+u5BMHkueeFigaRfcJ9V2/mqOdr
   K3dFj31muzgRgRLK7opGvR+ZJMnWWqorkIaBeD1YO6xiTb8UHrKwdCBf8
   Hn/pmXLrsts179ZFdeMfD536fccMU4LNS/dnOXBIpLOhuBUrq+z2+12aP
   h3X8NF+GPKeEeb0YOvf60akeTRhIs7tW9N7xsQofz3v61R2XpxH8qCk/B
   A==;
X-CSE-ConnectionGUID: 7U8hy7qfRA+/tDJQnEhJCQ==
X-CSE-MsgGUID: foQbf10LRmWZgEzcDFNF3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80847164"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80847164"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 23:36:54 -0700
X-CSE-ConnectionGUID: EsIFC2jySOim2ovnUFAm8A==
X-CSE-MsgGUID: mvY3RlMOTEy5fg0xXagtgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="266357709"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 23:36:51 -0700
Message-ID: <ee6c2d0b-3b59-4f87-8987-87f8defcb768@linux.intel.com>
Date: Thu, 28 May 2026 14:36:49 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/7] perf/x86/intel/uncore: Move die_to_cpu() to
 uncore.c
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260527151154.130505-1-zide.chen@intel.com>
 <20260527151154.130505-5-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260527151154.130505-5-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 5/27/2026 11:11 PM, Zide Chen wrote:
> Move die_to_cpu() into uncore.c so it can be reused by the MSR
> initialization path, preparing for the introduction of an MSR global
> initialization callback.
>
> Move the cpus_read_{lock,unlock}() out of the API, in order to make
> it possible to be called when the lock is being held.
>
> Add the uncore_ prefix for consistency with other uncore APIs.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
>
> V2:
> - Move cpus_read_{lock,unlock}() out of uncore_die_to_cpu() and rely
>   on callers to manage the lock. (Sashiko)
> - Remove "No functional change intended" from the changelog.
> ---
>  arch/x86/events/intel/uncore.c       | 19 +++++++++++++++++++
>  arch/x86/events/intel/uncore.h       |  1 +
>  arch/x86/events/intel/uncore_snbep.c | 23 +++--------------------
>  3 files changed, 23 insertions(+), 20 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index e9cc1ba921c5..22256ded2d67 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -83,6 +83,25 @@ int uncore_device_to_die(struct pci_dev *dev)
>  	return -1;
>  }
>  
> +/*
> + * Using cpus_read_lock() to ensure cpu is not going down between
> + * looking at cpu_online_mask.
> + *
> + * The lock must be held by the caller.
> + */
> +int uncore_die_to_cpu(int die)
> +{
> +	int res = 0, cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		if (topology_logical_die_id(cpu) == die) {
> +			res = cpu;
> +			break;
> +		}
> +	}
> +	return res;
> +}
> +
>  static void uncore_free_pcibus_map(void)
>  {
>  	struct pci2phy_map *map, *tmp;
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
> index c35918c01afa..94c68e3417b6 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -235,6 +235,7 @@ struct pci2phy_map *__find_pci2phy_map(int segment);
>  int uncore_pcibus_to_dieid(struct pci_bus *bus);
>  int uncore_die_to_segment(int die);
>  int uncore_device_to_die(struct pci_dev *dev);
> +int uncore_die_to_cpu(int die);
>  
>  ssize_t uncore_event_show(struct device *dev,
>  			  struct device_attribute *attr, char *buf);
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index c9ce206fcbb6..772b78237424 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -3704,25 +3704,6 @@ static int skx_msr_cpu_bus_read(int cpu, u64 *topology)
>  	return 0;
>  }
>  
> -static int die_to_cpu(int die)
> -{
> -	int res = 0, cpu, current_die;
> -	/*
> -	 * Using cpus_read_lock() to ensure cpu is not going down between
> -	 * looking at cpu_online_mask.
> -	 */
> -	cpus_read_lock();
> -	for_each_online_cpu(cpu) {
> -		current_die = topology_logical_die_id(cpu);
> -		if (current_die == die) {
> -			res = cpu;
> -			break;
> -		}
> -	}
> -	cpus_read_unlock();
> -	return res;
> -}
> -
>  enum {
>  	IIO_TOPOLOGY_TYPE,
>  	UPI_TOPOLOGY_TYPE,
> @@ -3794,8 +3775,9 @@ static int skx_pmu_get_topology(struct intel_uncore_type *type,
>  	int die, ret = -EPERM;
>  	u64 cpu_bus_msr;
>  
> +	cpus_read_lock();
>  	for (die = 0; die < uncore_max_dies(); die++) {
> -		ret = skx_msr_cpu_bus_read(die_to_cpu(die), &cpu_bus_msr);
> +		ret = skx_msr_cpu_bus_read(uncore_die_to_cpu(die), &cpu_bus_msr);
>  		if (ret)
>  			break;
>  
> @@ -3807,6 +3789,7 @@ static int skx_pmu_get_topology(struct intel_uncore_type *type,
>  		if (ret)
>  			break;
>  	}
> +	cpus_read_unlock();
>  
>  	return ret;
>  }
