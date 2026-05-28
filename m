Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9901196C7C;
	Thu, 28 May 2026 06:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779950341; cv=none; b=R8MtZCDfzc6CX4McbETgdGUOEVzb7JtIrXOB9hJaJJnh+TRCKnlYf0Gvk3sjShdQJDrfah7Nl4Ni2zSQgf0YeutnZeAx2EKDQxpdFtwptRwvzxvYxkOAF2SEwlh28eVJ4wFFT4bo/BZTYdUMFv55bJ+hEHe5uqBqqVh/wIUeYpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779950341; c=relaxed/simple;
	bh=DwHQwTdCuvP8EbyBzIF394xwoCCJxsYtHiAxfDqkS1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sjzp0OHLsCawrUK/1jeiGTAOu+HMqN5tzdi1xE7WYur1bVgS60XTTgAQ7FjxKYaun/kJHpdCMJxsOYc9CZoQSKk2p/bw3IjcmPiy9p1rHtMfNGF8jsrFyZ5ZUEtGpGfUc6Ji7HGtOxuaYIxCUgi+0PsQp8LPun0mJZs1JRYxon4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A0z8MPVK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A0z8MPVK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779950340; x=1811486340;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DwHQwTdCuvP8EbyBzIF394xwoCCJxsYtHiAxfDqkS1k=;
  b=A0z8MPVKHgj+1xiam0kcs64swC++ZO+z1e3eHxO6JyiNm7l94P4HApY8
   XZyejTOqJ/6sZOfa0fyxjNKlTGerzGBH4XE9Q4S7y45U2GZKcDQX3105e
   14RkmIbDuTYn+GPB/zTegPDUh1TPzgR3DKzo6E5Ug5CFKXFSR+7sknPKO
   kckph/FLHdNTmkkCdO0q6iKdsN/NHlSv864sVipkl+bduBsJQoIj6fkPo
   7GwO5Va4IcY8JrGzqOMCosSdARMf2lqMaC7LI4DtUa9p+05hWKZ2QHD+o
   +nJ7TkFIp3yK9a+w0UugJWt4p/4H3+vuPf/oPyqDq/h5O24GNBjKwLCMe
   A==;
X-CSE-ConnectionGUID: rRvjHWTLR9mcW5bZ4sGJEQ==
X-CSE-MsgGUID: SA59gOCEQlGkAA62Rq6xCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80691428"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80691428"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 23:38:59 -0700
X-CSE-ConnectionGUID: JRvNYI1pTgKpGY8qnOAzkg==
X-CSE-MsgGUID: LDM4ms86T0OFJtE+UU02UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="241430089"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 23:38:56 -0700
Message-ID: <de2c6e31-12be-4cb5-8723-c9e412bd8eed@linux.intel.com>
Date: Thu, 28 May 2026 14:38:53 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 6/7] perf/x86/intel/uncore: Fix uncore_die_to_cpu() for
 offline dies
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260527151154.130505-1-zide.chen@intel.com>
 <20260527151154.130505-6-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260527151154.130505-6-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


On 5/27/2026 11:11 PM, Zide Chen wrote:
> If the die is offline when uncore_die_to_cpu() is called, it silently
> returns 0, which is misleading.  Return -1 in this case to indicate
> that all CPUs on the die are offline and the caller can take care of
> it accordingly.
>
> Opportunistically, replace -EPERM with -ENODEV, as -ENODEV is
> the appropriate error when no CPUs are online across all dies.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
>  arch/x86/events/intel/uncore.c       | 2 +-
>  arch/x86/events/intel/uncore_snbep.c | 9 +++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 22256ded2d67..4b3a1fa5b41b 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -91,7 +91,7 @@ int uncore_device_to_die(struct pci_dev *dev)
>   */
>  int uncore_die_to_cpu(int die)
>  {
> -	int res = 0, cpu;
> +	int res = -1, cpu;
>  
>  	for_each_online_cpu(cpu) {
>  		if (topology_logical_die_id(cpu) == die) {
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index 772b78237424..334dc384b5b9 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -3772,12 +3772,17 @@ static void pmu_free_topology(struct intel_uncore_type *type)
>  static int skx_pmu_get_topology(struct intel_uncore_type *type,
>  				 int (*topology_cb)(struct intel_uncore_type*, int, int, u64))
>  {
> -	int die, ret = -EPERM;
> +	int die, ret = -ENODEV;
>  	u64 cpu_bus_msr;
> +	int cpu;
>  
>  	cpus_read_lock();
>  	for (die = 0; die < uncore_max_dies(); die++) {
> -		ret = skx_msr_cpu_bus_read(uncore_die_to_cpu(die), &cpu_bus_msr);
> +		cpu = uncore_die_to_cpu(die);
> +		if (cpu == -1)
> +			continue;
> +
> +		ret = skx_msr_cpu_bus_read(cpu, &cpu_bus_msr);
>  		if (ret)
>  			break;
>  
