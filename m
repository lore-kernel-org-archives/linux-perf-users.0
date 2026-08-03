Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530F02EF66B;
	Mon,  3 Aug 2026 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772868; cv=none; b=DYxT8D9KgXcHjGBmXNlfIEkPTUlpE6gl4JqD0fiue8zYQKW25uSJmyjy5xcPv8cg0AbaOJCppdBKXJc9iG9OojmRgGKnX6xfs6lHsSSdTW9fLPuUpK/TvnR/Xjvug5fhYHzzBYen1qXlVrYo0uqpaY3W8df77dxwNnSVKhC6wKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772868; c=relaxed/simple;
	bh=Ir8o5TbqMkWU4xH647a9ZPxtXOsvWt+HjGoWV195J88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kvd8FsTNo9xuRfiLhi9alJEVLbus1h3NFDJX6HM+o/Kms6cQ4G+98REoqzrSkKQe585J0DIEfVECajseEWl30DDESQoLpvfFLA8uir0RHX3LgZjKgT99Cmr/5AwZrma+YLkrvXIzET6PAOi8+QW6hDVqMGGDGnwwnePXgTaK3Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dShiq9Xr; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dShiq9Xr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785772867; x=1817308867;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ir8o5TbqMkWU4xH647a9ZPxtXOsvWt+HjGoWV195J88=;
  b=dShiq9Xro7CaU8zSuuqWF2SssxfSH4iovC4bXw2HaiNk13KdCSLZdbZU
   AAVNDW+tAKHITtl4UTShN1JL2JozhwFDB6rruElmD3NX0Mh0BmLRSM0Hf
   N0MVchkam5pLI/caqTRhJvqA1suE4U9DgU5kKIOfGB/lh4wAF/keUc8EH
   rVYK9Z8BN5G6fChkxoCoAQAHxQcx4MaO3fhflwhq4gK8UKpI7CkEuSiAu
   fxHuqxSKvJ99KS6vRwl98kDDNWZn+sHHzo0MhNw41DTOQ7sTnS0htbLUJ
   h5uRHI5Gg1FTAUs8oycA2iSu4oMnredL9PeKmu9mE1nYEvIGcJ9hdgEOd
   w==;
X-CSE-ConnectionGUID: o0omsYheTBW7N3wYd0f5Iw==
X-CSE-MsgGUID: RXzQ+2t8SB+OyDmgfZkRuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86435055"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="86435055"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 09:01:06 -0700
X-CSE-ConnectionGUID: 4HFuHvY8SsuKMffI5xJh0g==
X-CSE-MsgGUID: OyLEquncT2eqzuUio+GwOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="265526755"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.108.187]) ([10.125.108.187])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 09:01:06 -0700
Message-ID: <ab9b7f3a-e2a5-4627-b2ac-d53ce3a82477@intel.com>
Date: Mon, 3 Aug 2026 09:01:04 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] perf/cxl: Split the MSI vector out of info->irq
To: Robin Murphy <robin.murphy@arm.com>, linux-cxl@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org, will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net
References: <20260731232827.401447-1-dave.jiang@intel.com>
 <20260731232827.401447-5-dave.jiang@intel.com>
 <a4a807e6-b477-40c3-ac42-2bef8dd82d7e@arm.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <a4a807e6-b477-40c3-ac42-2bef8dd82d7e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/3/26 5:04 AM, Robin Murphy wrote:
> On 01/08/2026 12:28 am, Dave Jiang wrote:
>> info->irq means two different things depending on how far probe has got.
>> cxl_pmu_parse_caps() sets it to the MSI/MSI-X message number from the CPMU
>> Capability register. cxl_pmu_probe() passes that to pci_irq_vector() and
>> then overwrites it with the Linux virq, which is what the hotplug callbacks
>> hand to irq_set_affinity().
>>
>> Give the message number its own field. No functional change.
> 
> Thanks, this makes it much less confusing;
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> If the fix itself was just the comparison operator then I'd suggest folding it in so as to avoid extra backporting dependencies/conflicts, but it sounds like we might have a corner case where 0 may still mean "no IRQ", so maybe sort that first then put this refactoring on top?

Will do. I'll flip the order.

DJ

> 
> Cheers,
> Robin.
> 
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v3:
>> - New patch
>> ---
>>   drivers/perf/cxl_pmu.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
>> index 3511d049aea4..56e6ae7bebf7 100644
>> --- a/drivers/perf/cxl_pmu.c
>> +++ b/drivers/perf/cxl_pmu.c
>> @@ -106,6 +106,7 @@ struct cxl_pmu_info {
>>       int on_cpu;
>>       struct hlist_node node;
>>       bool filter_hdm;
>> +    int msi_vec;
>>       int irq;
>>   };
>>   @@ -143,9 +144,9 @@ static int cxl_pmu_parse_caps(struct device *dev, struct cxl_pmu_info *info)
>>         info->filter_hdm = FIELD_GET(CXL_PMU_CAP_FILTERS_SUP_MSK, val) & CXL_PMU_FILTER_HDM;
>>       if (FIELD_GET(CXL_PMU_CAP_INT, val))
>> -        info->irq = FIELD_GET(CXL_PMU_CAP_MSI_N_MSK, val);
>> +        info->msi_vec = FIELD_GET(CXL_PMU_CAP_MSI_N_MSK, val);
>>       else
>> -        info->irq = -1;
>> +        info->msi_vec = -1;
>>         /* First handle fixed function counters; note if configurable counters found */
>>       for (i = 0; i < info->num_counters; i++) {
>> @@ -874,10 +875,10 @@ static int cxl_pmu_probe(struct device *dev)
>>           .capabilities = PERF_PMU_CAP_NO_EXCLUDE,
>>       };
>>   -    if (info->irq <= 0)
>> +    if (info->msi_vec <= 0)
>>           return -EINVAL;
>>   -    rc = pci_irq_vector(pdev, info->irq);
>> +    rc = pci_irq_vector(pdev, info->msi_vec);
>>       if (rc < 0)
>>           return rc;
>>       irq = rc;
> 

