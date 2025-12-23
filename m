Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704702ECD37;
	Tue, 23 Dec 2025 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766526864; cv=none; b=s2+U68+fmEOf4kX+qmhknPaaAD+kvd6A6Xl8W+rcBcY8GEME00lwDqOIpsCvP4Wz0A7KQGoUvo5Xq/IdWugohWBUlngyH56LIs+8sBIJy0yk0bjQytfckSnof/CyFG8mPoXS2tw92k0nc0y0gk1eYGVhzcGoTadKtnuVN2Wq+B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766526864; c=relaxed/simple;
	bh=q3ZmaJ8qfRkqvus6osz7CvbEFcgrtPcpsSU8ugraorA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ladhzdtmMVy4xG3HNNRdXpDsRwDDOr+SX7vQYk8fL7+Tvhk4jDNoO805z668kI0DUIF2gJLxeND7cEYaZU3Vhm9YqhV9m3jyomOg3dIoknuLCZa/6PwWvJFgyrDz3y0YBqwB3xG3M/n5Fd2ILWys8rsKrbYQcO5JtZjQop7Nqfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFicwU5k; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFicwU5k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766526862; x=1798062862;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q3ZmaJ8qfRkqvus6osz7CvbEFcgrtPcpsSU8ugraorA=;
  b=JFicwU5ktug9Xh7VafO8094//E7QtQvTlrWlj5JagRzAGV6j71bidoiq
   Bx5EwGuPGmttCjyARgeB5CF2r5YAvDZEGNorrG90CXPGDqGSPVIM1ZwzP
   diA2CW00tRpm22c+1bZ6e9mX3AmEj5E60dWdkFXyos0PMhSffHjRZ4Iqb
   UUqxg0lQYkx/thqdBWMocWZfZaj+yqGNq+f44Irk4aHCbcxlfy1ZSySFN
   ZCgBFssN8qFSDaaAHVeSNOVoNqAr9Jk7dZBwGkJtElIOvfiFJ4w6X2BHJ
   X15S9T7iMBAk7wbfXaOVfD71aGODgfZrmqqkC0XBX8wJttzkOT4VZH/Gm
   w==;
X-CSE-ConnectionGUID: 72hx0ci7Ru2CC+ydlmFolQ==
X-CSE-MsgGUID: GNumbkm1QrWqqaMseIge6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="70955649"
X-IronPort-AV: E=Sophos;i="6.21,171,1763452800"; 
   d="scan'208";a="70955649"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 13:54:22 -0800
X-CSE-ConnectionGUID: InuXSqYYRdyeqIuryP9hsg==
X-CSE-MsgGUID: CCGDjDCASjCXmHLAsbV86w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,171,1763452800"; 
   d="scan'208";a="223358397"
Received: from unknown (HELO [10.241.240.141]) ([10.241.240.141])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 13:54:21 -0800
Message-ID: <728e95c7-df78-4a6a-80df-7f7e88579440@intel.com>
Date: Tue, 23 Dec 2025 13:54:21 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] perf/x86/intel/uncore: Support IIO free-running
 counters on DMR
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>
References: <20251212210007.13986-1-zide.chen@intel.com>
 <20251212210007.13986-6-zide.chen@intel.com>
 <c31a79f4-3579-4b67-a859-ec0c69824edc@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <c31a79f4-3579-4b67-a859-ec0c69824edc@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/22/2025 9:18 PM, Mi, Dapeng wrote:
> 
> On 12/13/2025 5:00 AM, Zide Chen wrote:
>> The free-running counters for IIO uncore blocks on Diamond Rapids are
>> similar to Sapphire Rapids IMC freecounters, with the following
>> differences:
>>
>> - The counters are MMIO based.
>> - Only a subset of IP blocks implement free-running counters:
>>   HIOP0 (IP Base Addr: 2E7000h)
>>   HIOP1 (IP Base Addr: 2EF000h)
>>   HIOP3 (IP Base Addr: 2FF000h)
>>   HIOP4 (IP Base Addr: 307000h)
>> - IMH2 (Secondary IMH) does not provide free-running counters.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>>  arch/x86/events/intel/uncore_snbep.c | 120 +++++++++++++++++++++++++--
>>  1 file changed, 115 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
>> index 56c6ac86f28e..21cca1b28075 100644
>> --- a/arch/x86/events/intel/uncore_snbep.c
>> +++ b/arch/x86/events/intel/uncore_snbep.c
>> @@ -472,10 +472,14 @@
>>  #define SPR_C0_MSR_PMON_BOX_FILTER0		0x200e
>>  
>>  /* DMR */
>> +#define DMR_IMH1_HIOP_MMIO_BASE			0x1ffff6ae7000
>> +#define DMR_HIOP_MMIO_SIZE			0x8000
>>  #define DMR_CXLCM_EVENT_MASK_EXT		0xf
>>  #define DMR_HAMVF_EVENT_MASK_EXT		0xffffffff
>>  #define DMR_PCIE4_EVENT_MASK_EXT		0xffffff
>>  
>> +#define UNCORE_DMR_ITC				0x30
>> +
>>  #define DMR_IMC_PMON_FIXED_CTR			0x18
>>  #define DMR_IMC_PMON_FIXED_CTL			0x10
>>  
>> @@ -6442,7 +6446,11 @@ static int uncore_type_max_boxes(struct intel_uncore_type **types,
>>  	for (node = rb_first(type->boxes); node; node = rb_next(node)) {
>>  		unit = rb_entry(node, struct intel_uncore_discovery_unit, node);
>>  
>> -		if (unit->id > max)
>> +		/*
>> +		 * on DMR IMH2, the unit id starts from 0x8000,
>> +		 * and we don't need to count it.
>> +		 */
>> +		if ((unit->id > max) && (unit->id < 0x8000))
>>  			max = unit->id;
>>  	}
>>  	return max + 1;
>> @@ -6925,6 +6933,103 @@ int dmr_uncore_units_ignore[] = {
>>  	UNCORE_IGNORE_END
>>  };
>>  
>> +static unsigned int dmr_iio_freerunning_box_offsets[] = {
>> +	0x0, 0x8000, 0x18000, 0x20000
>> +};
>> +
>> +static void dmr_uncore_freerunning_init_box(struct intel_uncore_box *box)
>> +{
>> +	struct intel_uncore_type *type = box->pmu->type;
>> +	u64 mmio_base;
>> +
>> +	if (box->pmu->pmu_idx >= type->num_boxes) {
>> +		pr_warn("perf uncore: Failed to ioremap for %s.\n", type->name);
> 
> The warning message is not quite matched with the error case, please update it.


My mistake. This is only a sanity check to prevent out-of-bounds access
to dmr_iio_freerunning_box_offsets[] and should never be triggered in
practice. I think it is safe to remove the pr_warn().


> Other part looks good to me.
