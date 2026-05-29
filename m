Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6BC3BE623;
	Fri, 29 May 2026 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044467; cv=none; b=DBsaomXlxXE0g3fH37uM6SrMhsvQLIrcbWrwViZHIG3V+3lmJIJcL5S2QnrKn/cGme/+oAqqTgtAyjasM5w8hftl7uL6zcKCPl3A3sONIRWz2278hWB0623IRWkbVg0jB0LztLEG61cc7NFRh3iJG1z2tzRTcq9U+RioUYQDG2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044467; c=relaxed/simple;
	bh=n0FZc3hG7CysVfxGmzAly0+YB278xXZrLVS9tAteWgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ak6IEMO4fxEhP9WTYoqCSIuWJFiPFR00dIk7AXTrEJw4GCfA4SusZcB6lphz2r77Mlbbtq2ZDb9R31BtfaYWr5Nu0IXyFhY4jN5t8sBbjDSNkelZVaqlnQ5l4yvCS4pP/VbENUqRqQdL3ZHTZJQjanZ1kf1Yg3qgD5m43R3srpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e30a2JaP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e30a2JaP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780044465; x=1811580465;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n0FZc3hG7CysVfxGmzAly0+YB278xXZrLVS9tAteWgw=;
  b=e30a2JaPd8fmWCMkyNqyRXVHpS8sXd45fLEgfSSMF8V52WQ2qxEvHpoD
   t9Z6q/rUeFvNRL2+JlZvC4R63sOx+Pco/t6NqALhlDUvo7VgTFfWslUOa
   Cixz5RT4K+ulKYJ/utkBBKiRAWWoplHmOhCdNqIViPlUUs+i4maf6qfJh
   MiZW3wEZzIB2zz+/7JCS1ELPLmM9q1JnoqH6cIDSUp4MihF7FlFCDon86
   ERCWwWCrpoMv0j4s229Wdz1x8YaovvgMi4ub9a58n0/ZUpa6/4uev9lrX
   d0desAVpoC947m0yHyBtjJpgM89syszV5ngscd2UQEeC5vXJ46VYB79t9
   Q==;
X-CSE-ConnectionGUID: Imai41Y2TR2mpJZJFMCg2g==
X-CSE-MsgGUID: TZOhdu7SRSWkOfJP1JS/VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106345174"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="106345174"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:47:45 -0700
X-CSE-ConnectionGUID: exy3Z9HwRoi1ObhlQERSrA==
X-CSE-MsgGUID: hzSXPLSxRfGRmNLpvluydg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="241984138"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:47:42 -0700
Message-ID: <93acba88-3f6a-43dc-8392-63d977fb2dfa@linux.intel.com>
Date: Fri, 29 May 2026 16:47:39 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 7/7] perf/x86/intel/uncore: Implement global init
 callback for GNR uncore
To: "Chen, Zide" <zide.chen@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260527151154.130505-1-zide.chen@intel.com>
 <20260527151154.130505-7-zide.chen@intel.com>
 <507feaea-25fc-4111-a39b-648ce44e3316@linux.intel.com>
 <03ad940f-747b-432c-9dca-1be305ee5cc7@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <03ad940f-747b-432c-9dca-1be305ee5cc7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/29/2026 2:14 AM, Chen, Zide wrote:
>
> On 5/28/2026 1:46 AM, Mi, Dapeng wrote:
>> On 5/27/2026 11:11 PM, Zide Chen wrote:
>>> On Sierra Forest and Clearwater Forest, the FRZ_ALL bit in the global
>>> control register defaults to 0 at boot, but UBOX PMON units do not
>>> work until the global control register is explicitly written with 0
>>> to trigger hardware initialization properly.
>>>
>>> Implement the generic uncore_msr_global_init() callback and add it to
>>> gnr_uncore_init[], which is shared by GNR, GRR, SRF, and CWF.
>> Need a "Fixes" tag?
> No Fixes tag needed. This is a hardware initialization workaround rather
> than a fix for a software bug. The register defaults to 0, but the
> hardware requires an explicit write to trigger PMON functionality.

Zide, per my understanding, some uncore PMUs can't work for SRF and CWF
without this change. Is it right? If so, we need to add a "Fixes" tag to
ensure this patch is merged to the corresponding stable branches. Thanks.


>
>> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>>
>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>> ---
>>> V2:
>>> - Propagate return value of wrmsrq_on_cpu() to global_init().
>>> ---
>>>  arch/x86/events/intel/uncore.c           | 13 ++++++++++++-
>>>  arch/x86/events/intel/uncore.h           |  2 +-
>>>  arch/x86/events/intel/uncore_discovery.c |  2 +-
>>>  3 files changed, 14 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>>> index 4b3a1fa5b41b..7857959c6e82 100644
>>> --- a/arch/x86/events/intel/uncore.c
>>> +++ b/arch/x86/events/intel/uncore.c
>>> @@ -1716,7 +1716,7 @@ static int __init uncore_mmio_init(void)
>>>  	return ret;
>>>  }
>>>  
>>> -static int uncore_mmio_global_init(u64 ctl)
>>> +static int uncore_mmio_global_init(int die, u64 ctl)
>>>  {
>>>  	void __iomem *io_addr;
>>>  
>>> @@ -1731,6 +1731,16 @@ static int uncore_mmio_global_init(u64 ctl)
>>>  	return 0;
>>>  }
>>>  
>>> +static int uncore_msr_global_init(int die, u64 msr)
>>> +{
>>> +	int cpu = uncore_die_to_cpu(die);
>>> +
>>> +	if (cpu == -1)
>>> +		return -ENODEV;
>>> +
>>> +	return wrmsrq_on_cpu(cpu, msr, 0);
>>> +}
>>> +
>>>  static const struct uncore_plat_init nhm_uncore_init __initconst = {
>>>  	.cpu_init = nhm_uncore_cpu_init,
>>>  };
>>> @@ -1871,6 +1881,7 @@ static const struct uncore_plat_init gnr_uncore_init __initconst = {
>>>  	.domain[0].base_is_pci = true,
>>>  	.domain[0].discovery_base = UNCORE_DISCOVERY_TABLE_DEVICE,
>>>  	.domain[0].units_ignore = gnr_uncore_units_ignore,
>>> +	.domain[0].global_init = uncore_msr_global_init,
>>>  };
>>>  
>>>  static const struct uncore_plat_init dmr_uncore_init __initconst = {
>>> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
>>> index 94c68e3417b6..c2e5ccb1d72c 100644
>>> --- a/arch/x86/events/intel/uncore.h
>>> +++ b/arch/x86/events/intel/uncore.h
>>> @@ -53,7 +53,7 @@ struct uncore_discovery_domain {
>>>  	/* MSR address or PCI device used as the discovery base */
>>>  	u32	discovery_base;
>>>  	bool	base_is_pci;
>>> -	int	(*global_init)(u64 ctl);
>>> +	int	(*global_init)(int die, u64 ctl);
>>>  
>>>  	/* The units in the discovery table should be ignored. */
>>>  	int	*units_ignore;
>>> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
>>> index af2217b44a81..e36613d934b1 100644
>>> --- a/arch/x86/events/intel/uncore_discovery.c
>>> +++ b/arch/x86/events/intel/uncore_discovery.c
>>> @@ -287,7 +287,7 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
>>>  	if (!io_addr)
>>>  		return -ENOMEM;
>>>  
>>> -	if (domain->global_init && domain->global_init(global.ctl)) {
>>> +	if (domain->global_init && domain->global_init(die, global.ctl)) {
>>>  		ret = -ENODEV;
>>>  		goto out;
>>>  	}
>
