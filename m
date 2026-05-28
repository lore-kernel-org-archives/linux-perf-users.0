Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75E93FE348;
	Thu, 28 May 2026 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992062; cv=none; b=odG5tf493RFJbGC4T9Me+7DcYIIXgdagwJ4ULCZA9dBQOm5Vo5sSCWIECXDlsD7EDwysnbuBezWaq1/oab5y/YmW3f03d+ptn3H4KGT8vbnlSwV7yH8L4KSiuoICZDd6gEBHkm0T66zBuywH9gqW9XsZesZ1NfQblzbJtOlRSgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992062; c=relaxed/simple;
	bh=TdyKsBeSOKF98DKddh3R0euizQWVwUseyk1l9hZHlyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFH8ZrdRzoN6xMGLp6i13PmNFxBRzBpO0ory8URhvmu+GiU+OZhjdxhCGXaJghweAKwytDGv96RCbmcdnRtOkBu6DE/+r6lx0xsm0UBbwKVOEJVqGbkFDI/nqmKGdlqoZKIzHV3zT7BydRf9ctm8yukul/JMmmrY6vSGNd4rFjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JlOAzRNK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JlOAzRNK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779992061; x=1811528061;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TdyKsBeSOKF98DKddh3R0euizQWVwUseyk1l9hZHlyw=;
  b=JlOAzRNKNxEMDh3WBnlakNU3DRvrPhzGJkFU+FLKu90cOixM2tn9tSv2
   BQZ3Vz/sWgFWSAhRcsB9mtXeJsBrYV9GlGJb2vhhXSx9FGqja3HqUtXiM
   N+VQpGexKNPifWMkgUfLjsaGn62MrnzKuy3bg7VuP1dhklEqmVHVMw4Ry
   1qlIleVVA266+l7k+C3/ekE/r5JZWV62ffsc0uuHL9jJP5mdFZQvLv8lu
   juxoynSuoN8WS/NFuh6j+aqW7OOnt2bEK3I2mCZBFdsNs9teot16Hv+pq
   V9at74utkMuPSp0SIYsi0fh9UUPtVoiR3Q/0mFFPzruTlc6+BegpeJ/8y
   g==;
X-CSE-ConnectionGUID: QcW9Boe3TOOkpsWqcsnGkg==
X-CSE-MsgGUID: bkLqV0LJS5aFb1pp7f4mrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80567373"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80567373"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 11:14:20 -0700
X-CSE-ConnectionGUID: kwLEUKPNQOSOe59LX5g+Cg==
X-CSE-MsgGUID: 5B3Ka+nYQ9qt5mViVT+SqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="244443507"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 11:14:19 -0700
Message-ID: <03ad940f-747b-432c-9dca-1be305ee5cc7@intel.com>
Date: Thu, 28 May 2026 13:14:18 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 7/7] perf/x86/intel/uncore: Implement global init
 callback for GNR uncore
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260527151154.130505-1-zide.chen@intel.com>
 <20260527151154.130505-7-zide.chen@intel.com>
 <507feaea-25fc-4111-a39b-648ce44e3316@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <507feaea-25fc-4111-a39b-648ce44e3316@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/28/2026 1:46 AM, Mi, Dapeng wrote:
> 
> On 5/27/2026 11:11 PM, Zide Chen wrote:
>> On Sierra Forest and Clearwater Forest, the FRZ_ALL bit in the global
>> control register defaults to 0 at boot, but UBOX PMON units do not
>> work until the global control register is explicitly written with 0
>> to trigger hardware initialization properly.
>>
>> Implement the generic uncore_msr_global_init() callback and add it to
>> gnr_uncore_init[], which is shared by GNR, GRR, SRF, and CWF.
> 
> Need a "Fixes" tag?
No Fixes tag needed. This is a hardware initialization workaround rather
than a fix for a software bug. The register defaults to 0, but the
hardware requires an explicit write to trigger PMON functionality.

> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> 
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> V2:
>> - Propagate return value of wrmsrq_on_cpu() to global_init().
>> ---
>>  arch/x86/events/intel/uncore.c           | 13 ++++++++++++-
>>  arch/x86/events/intel/uncore.h           |  2 +-
>>  arch/x86/events/intel/uncore_discovery.c |  2 +-
>>  3 files changed, 14 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>> index 4b3a1fa5b41b..7857959c6e82 100644
>> --- a/arch/x86/events/intel/uncore.c
>> +++ b/arch/x86/events/intel/uncore.c
>> @@ -1716,7 +1716,7 @@ static int __init uncore_mmio_init(void)
>>  	return ret;
>>  }
>>  
>> -static int uncore_mmio_global_init(u64 ctl)
>> +static int uncore_mmio_global_init(int die, u64 ctl)
>>  {
>>  	void __iomem *io_addr;
>>  
>> @@ -1731,6 +1731,16 @@ static int uncore_mmio_global_init(u64 ctl)
>>  	return 0;
>>  }
>>  
>> +static int uncore_msr_global_init(int die, u64 msr)
>> +{
>> +	int cpu = uncore_die_to_cpu(die);
>> +
>> +	if (cpu == -1)
>> +		return -ENODEV;
>> +
>> +	return wrmsrq_on_cpu(cpu, msr, 0);
>> +}
>> +
>>  static const struct uncore_plat_init nhm_uncore_init __initconst = {
>>  	.cpu_init = nhm_uncore_cpu_init,
>>  };
>> @@ -1871,6 +1881,7 @@ static const struct uncore_plat_init gnr_uncore_init __initconst = {
>>  	.domain[0].base_is_pci = true,
>>  	.domain[0].discovery_base = UNCORE_DISCOVERY_TABLE_DEVICE,
>>  	.domain[0].units_ignore = gnr_uncore_units_ignore,
>> +	.domain[0].global_init = uncore_msr_global_init,
>>  };
>>  
>>  static const struct uncore_plat_init dmr_uncore_init __initconst = {
>> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
>> index 94c68e3417b6..c2e5ccb1d72c 100644
>> --- a/arch/x86/events/intel/uncore.h
>> +++ b/arch/x86/events/intel/uncore.h
>> @@ -53,7 +53,7 @@ struct uncore_discovery_domain {
>>  	/* MSR address or PCI device used as the discovery base */
>>  	u32	discovery_base;
>>  	bool	base_is_pci;
>> -	int	(*global_init)(u64 ctl);
>> +	int	(*global_init)(int die, u64 ctl);
>>  
>>  	/* The units in the discovery table should be ignored. */
>>  	int	*units_ignore;
>> diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
>> index af2217b44a81..e36613d934b1 100644
>> --- a/arch/x86/events/intel/uncore_discovery.c
>> +++ b/arch/x86/events/intel/uncore_discovery.c
>> @@ -287,7 +287,7 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
>>  	if (!io_addr)
>>  		return -ENOMEM;
>>  
>> -	if (domain->global_init && domain->global_init(global.ctl)) {
>> +	if (domain->global_init && domain->global_init(die, global.ctl)) {
>>  		ret = -ENODEV;
>>  		goto out;
>>  	}

