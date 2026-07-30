Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BA146EF9B;
	Thu, 30 Jul 2026 23:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785452443; cv=none; b=au0/eBumGjtB0Sti9diEGw3l4VgWVXWFsJ7jGF8j9lbW7s89w8kRWy15k6lcYzwPIDplqnW0euXdHJG3npXXeNLqGiVF3Did30G3PimhLTz3WVjs5coXEzFGk/sXBHGjKXiN3EJam6S+sOGrv4z0XX0dWWiKTrq33ofF2CDdkxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785452443; c=relaxed/simple;
	bh=uCYWKp4UStM+MGuse6L/bw9Ttb4tZx0GkNoTb28c1PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wm2SdI7BDdGHKGaEMoeaaaMoUIPz4rrZweB+ZpbLYmt6FqmUxZsBpc3haoedmj55zaDFIyBuSxUu4CLf6GbpQJcxtJ3SVDfwMdlF4cJuhl3nKqdn9UJQhk25q/amq1ghnkCIOUCg2wkn6Mu2v1cnkG3pIaaGP2k+A6y5P30vrR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BkCyq/vU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BkCyq/vU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785452442; x=1816988442;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uCYWKp4UStM+MGuse6L/bw9Ttb4tZx0GkNoTb28c1PQ=;
  b=BkCyq/vUFfBdtmJld5HpmDPuNLI2YbskONG/k7AyZ9uldljp0lhI+AhJ
   fuzUWVJCc/TUkO/N8voBbMSeFyABAIwZrkh15gKlLt3j3aoAW+lcbsGFz
   nS9vrRvRGITXXTUkHKA6d7fZVJA9DEG0FXbKSGZgHRRyiVT4OlNazvVdJ
   l2bZkhSnaymswkx8aZsHzoRN4R1DCIcW68/pUIx5udWacio4kwTh5OgiE
   qanexvHU3RY2zElekrPhqFycAs5CuGBa2yopvZM4lUcthPoSJo25y3r2j
   v00dMl04isCqkioFH9zxisM671Do5ZatNIGOW/MyRNSf2HN2A5368oC7f
   A==;
X-CSE-ConnectionGUID: aKx7jmOwSgm9KRFFd6bq8A==
X-CSE-MsgGUID: z+DIgYAMT3yocQsMOPMrnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="96440830"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="96440830"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 16:00:41 -0700
X-CSE-ConnectionGUID: yGU3RCGTRp6+wnL3vF1C6g==
X-CSE-MsgGUID: dWKxWgzcRL+/itCZyFc73A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="262368533"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.111.248]) ([10.125.111.248])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 16:00:39 -0700
Message-ID: <6d0c2109-6e02-4df8-a732-557e0d6e81df@intel.com>
Date: Thu, 30 Jul 2026 16:00:38 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] perf/cxl: Unfreeze counters after handling an
 overflow interrupt
To: Jonathan Cameron <jic23@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 sashiko-bot@kernel.org
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-7-dave.jiang@intel.com>
 <3dc5c366-652f-4977-84a1-6e5a921a74cc@arm.com>
 <20260730195313.3e2c0b8e@jic23-huawei>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260730195313.3e2c0b8e@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/30/26 11:53 AM, Jonathan Cameron wrote:
> On Thu, 30 Jul 2026 13:04:17 +0100
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
>> On 29/07/2026 3:55 pm, Dave Jiang wrote:
>>> The counters are configured with Freeze on Overflow, so when any counter
>>> overflows the CPMU freezes every counter in the block (CXL r4.0
>>> §8.2.7.2.1). cxl_pmu_irq() reads the overflowed counters and clears the
>>> overflow status, but never writes the CPMU Freeze register to unfreeze,
>>> so all counters stay frozen until the next pmu_enable() and events in
>>> that window are silently lost.
>>>
>>> Unfreeze after clearing the overflow status so counting resumes.
>>>
>>> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
>>> Reported-by: sashiko-bot@kernel.org
>>> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
>>> Assisted-by: Claude:claude-opus-4-8
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>> ---
>>>   drivers/perf/cxl_pmu.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
>>> index 8b89db8f4d68..52e78a6e0960 100644
>>> --- a/drivers/perf/cxl_pmu.c
>>> +++ b/drivers/perf/cxl_pmu.c
>>> @@ -804,6 +804,15 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
>>>   
>>>   	writeq(overflowed, base + CXL_PMU_OVERFLOW_REG);
>>>   
>>> +	/*
>>> +	 * Counters are configured to freeze on overflow (Freeze on Overflow),
>>> +	 * which freezes every counter in the CPMU. Once the overflowed counters
>>> +	 * have been read and their status cleared, unfreeze so counting resumes;
>>> +	 * otherwise all counters stay frozen until the next pmu_enable() and
>>> +	 * events are silently lost.
>>> +	 */
>>> +	writeq(0, base + CXL_PMU_FREEZE_REG);  
>>
>> Does this unconditionally unfreeze _all_ counters, including any which 
>> might have have overflowed since the read of CXL_PMU_OVERFLOW_REG and 
>> thus have not been handled yet? Or are we hoping that the "global 
>> freeze" behaviour prevents that from being able to happen?
>>
> 
> Yes global freeze should stop world on first one overflowing - if two go together
> we should see them both in the handler.
> 
>> Furthermore, what if an overflow happens to occur just as 
>> cxl_pmu_disable() is intentionally freezing all the counters, such that 
>> by the time we get here, unfreezing them would be the wrong thing to do?
> 
> Hmm. That may indeed be bad.

I can add a bool as a en/disable state in info to guard against that. > 
>>
>> Thanks,
>> Robin.
>>
>>> +
>>>   	return IRQ_HANDLED;
>>>   }
>>>     
>>
> 

