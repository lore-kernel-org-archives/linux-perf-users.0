Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4E03D6CB4;
	Thu, 30 Jul 2026 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447171; cv=none; b=C1Klb8R4qKszWoukGCiGbrEBYTlpYfUChKbZK3htsJSmyZZKqpu/9TSEni9mwyLv+ZwIGpE3XeWwfG8tenh1FKIrnj/thzxY2OkZY/uJ1gpEeVlslYgL35+hyHapeVk8NKXu4k6dW9UuPGQQGQASdZ/rdiqfEatwJ40BytvMh0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447171; c=relaxed/simple;
	bh=CqW8ing/3P5z+cbuGE0kjT2cI97PuhqFI9Q1dTak05o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A9jdRSbl8TSwNkTAKuOmEIOVq6a1S8ssRrwzp/+rOg3FmTv1bRnJ1Mb9kQ6fb097ALZazKOqWXLAH2NPI59C866Sxf901y5WtsjAknhX8cJN9zLrnV2htrk5Nd2aRGjaiAYQb3R5qR4gynxrEN+xS7qDR+JPc9Tha76AUuzmoAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fffPQjeE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fffPQjeE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785447169; x=1816983169;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CqW8ing/3P5z+cbuGE0kjT2cI97PuhqFI9Q1dTak05o=;
  b=fffPQjeEnmY246tFr776xnQ3mRfcSKfyE2RP1RQoWG+MMiqNB+qlpsj9
   CcidUyCCppj4a1s1JHIJVjDJJKVbOttGfVUx8xXG46mUZfEWV+cZCH10c
   xMOcHpt69K5buW6E0hFDYDM3siTv9SU2zrreAHr6O9En4KGILS7QwwavZ
   VzHObOSNVdVOmk/ZkHnsqD5RO7cpdQUDe/s61jK3k5R445C8/WHVUT21g
   toxiij9FpVG0j68BuIpfgvD6jpbnCyHzf8uRqgUif2UPOyHEXPXAGGBjt
   soL7mV5I3TFJkYCIGvTdYKcQMhyM0aVuK6KI1HJCiE4kyeaUHy4wiqfsH
   Q==;
X-CSE-ConnectionGUID: z2ILeQ2ZSd2yimlGLZrFIg==
X-CSE-MsgGUID: K+7sij6rTLeT6omFsaVDyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="103485232"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="103485232"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 14:32:48 -0700
X-CSE-ConnectionGUID: 3AFHPfw1QW+VuEk2MmCJRw==
X-CSE-MsgGUID: KHvNXZ20S8iYEl0cPn7ZBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="254089491"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.111.248]) ([10.125.111.248])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 14:32:46 -0700
Message-ID: <cf97261e-a7a1-4b82-a142-72d6e5c962ea@intel.com>
Date: Thu, 30 Jul 2026 14:32:45 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] perf/cxl: Accept an overflow interrupt on MSI
 message number 0
To: Jonathan Cameron <jic23@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 sashiko-bot@kernel.org
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-5-dave.jiang@intel.com>
 <5196c172-9ef3-43ae-98df-57a95427a00a@arm.com>
 <20260730195707.553670cd@jic23-huawei>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260730195707.553670cd@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/26 11:57 AM, Jonathan Cameron wrote:
> On Thu, 30 Jul 2026 13:18:42 +0100
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
>> On 29/07/2026 3:55 pm, Dave Jiang wrote:
>>> cxl_pmu_probe() rejects the PMU with -EINVAL when info->irq <= 0, but
>>> info->irq holds the MSI/MSI-X message number the device signals overflow
>>> on (CXL_PMU_CAP_MSI_N_MSK, a 0-based 4-bit field), with -1 meaning "no
>>> interrupt support". Message number 0 is valid and pci_irq_vector() takes
>>> a 0-based index, so a compliant device signalling on the first vector is
>>> wrongly refused and fails to probe.  
>>
>> If info->irq is a PCI MSI vector index, not the Linux vIRQ number, then 
>> surely that means the irq_set_affinity() calls are wrong as well?
> 
> yup.  I really messed this driver up :(
> 
> should rename this one and then have irq mean irq.

I have a patch for v3 :) > 
> 
>>
>> Thanks,
>> Robin.
>>
>>> Reject only the no-interrupt case (info->irq < 0), matching the sibling
>>> CXL mailbox and event IRQ handling.
>>>
>>> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
>>> Reported-by: sashiko-bot@kernel.org
>>> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
>>> Assisted-by: Claude:claude-opus-4-8
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>> ---
>>>   drivers/perf/cxl_pmu.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
>>> index 956da8202551..d1e810601e36 100644
>>> --- a/drivers/perf/cxl_pmu.c
>>> +++ b/drivers/perf/cxl_pmu.c
>>> @@ -876,7 +876,7 @@ static int cxl_pmu_probe(struct device *dev)
>>>   		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
>>>   	};
>>>   
>>> -	if (info->irq <= 0)
>>> +	if (info->irq < 0)
>>>   		return -EINVAL;
>>>   
>>>   	rc = pci_irq_vector(pdev, info->irq);  
>>
> 

