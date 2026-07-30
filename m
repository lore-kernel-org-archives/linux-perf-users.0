Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467E638D6AD;
	Thu, 30 Jul 2026 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785449970; cv=none; b=VEM9G7J3K48SMRMR5qpaMy7fLHfruriXOW18WjTrf9jw/JywAZAYIYatVCnGZF20iV1Gx7NoVc039xEP8EXWl+rsaWH+dTR6/xFMT0Ky6iNRo0yvC8dhajaAWAWe4r2yNOHZ4rtjACHXf54MILDVj8DI+7Mhbkb4lGmOy20yjf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785449970; c=relaxed/simple;
	bh=VqBFKdbAR7Nwn0VbdXcll6QCf1GKCxaMAyVMu+QFrgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2dVy6rgxyzFAPhvfinBxVecfIVCz61dclGTqY9jhjrG/huxkt9rCPwESsTtuVPOk3pSUKfW72LyjOR7mU2jeBTqVuX2ppxWlWVAifVU1TweOAa2hPgy0MKNvMq3bxKYV4JFwKzNxCSOc8M8nP9l+ewkIxIVADUoDAyCjOjdI2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lyIXFpl5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lyIXFpl5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785449968; x=1816985968;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VqBFKdbAR7Nwn0VbdXcll6QCf1GKCxaMAyVMu+QFrgY=;
  b=lyIXFpl57f0XOZBNTDfQloF2MBdgLBXiqbOhLvjs/ppS77ujiWCZmQKt
   PJyqQeDN/DLcpViO2PHpPyJHbnappDOhiqv4M75Xrxn+BQ7Qxinaycaf2
   eUT9YQC0/ua4qrvFBxkwpmS3qp8qkUv9QahDy3JZ9XsKWyM0JxD52aYsF
   EFmUaBoBauVqkT7mitsdTA9Xk8/UIGr3+Z4JK8C6qISCmwK4ofbcy5ePJ
   TTHMnpGoDaSwcTcQXR1eiItq0vTbkYSNPEMuiRtsU4JjqayOn+AdRGZDf
   K/dnJSo7vaUDwDXCz5YGqUQ6uPlumZR/bZ5Mc9PS8rOcWS7BL3Aa8Dz8k
   Q==;
X-CSE-ConnectionGUID: 3Wi1xsZpSTOEmGG1nzLZHQ==
X-CSE-MsgGUID: 6sOLEKiNSyGhvcLf0UpXGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="89890726"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="89890726"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:19:27 -0700
X-CSE-ConnectionGUID: ZqeNvxlTTuyQv654+Xyg8A==
X-CSE-MsgGUID: cMPVSnKDQ16pKgWD+UIA4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="264223865"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.111.248]) ([10.125.111.248])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:19:27 -0700
Message-ID: <d77fc1b6-2962-41fe-ad83-10207bea1382@intel.com>
Date: Thu, 30 Jul 2026 15:19:26 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] perf/cxl: Keep the overflow interrupt pinned to
 the managed CPU
To: Robin Murphy <robin.murphy@arm.com>, linux-cxl@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org, will@kernel.org, mark.rutland@arm.com,
 dave@stgolabs.net, sashiko-bot@kernel.org
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-6-dave.jiang@intel.com>
 <778b651c-ab2e-41d6-a0d6-5da144989df7@arm.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <778b651c-ab2e-41d6-a0d6-5da144989df7@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/30/26 4:46 AM, Robin Murphy wrote:
> On 29/07/2026 3:55 pm, Dave Jiang wrote:
>> The PMU pins its overflow interrupt to info->on_cpu in the hotplug
>> online/offline callbacks, but requests it with only IRQF_SHARED |
>> IRQF_NO_THREAD. Without IRQF_NOBALANCING, irqbalance or a userspace
>> smp_affinity write can move the interrupt to another CPU. cxl_pmu_irq()
>> then runs cxl_pmu_read() there, doing local64_cmpxchg()/local64_add() on
>> hwc->prev_count and event->count concurrently with the managing CPU;
>> local64_t is only atomic against same-CPU access, so counts get
>> corrupted.
>>
>> Add IRQF_NOBALANCING so the pinning done in the hotplug callbacks holds,
>> matching other uncore-style PMU drivers.
>>
>> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
>> Reported-by: sashiko-bot@kernel.org
>> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/perf/cxl_pmu.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
>> index d1e810601e36..8b89db8f4d68 100644
>> --- a/drivers/perf/cxl_pmu.c
>> +++ b/drivers/perf/cxl_pmu.c
>> @@ -888,7 +888,8 @@ static int cxl_pmu_probe(struct device *dev)
>>       if (!irq_name)
>>           return -ENOMEM;
>>   -    rc = devm_request_irq(dev, irq, cxl_pmu_irq, IRQF_SHARED | IRQF_NO_THREAD,
>> +    rc = devm_request_irq(dev, irq, cxl_pmu_irq,
>> +                  IRQF_SHARED | IRQF_NO_THREAD | IRQF_NOBALANCING,
> 
> Bah, sorry, now I see I misspoke just now on the other patch - PMUs really _shouldn't_ permit shared IRQs, but this one does :(
> 
> Thus it's all well and good to prevent userspace changing affinity, but it doesn't help _all_ that much if other drivers can still legitimately change it behind our backs...

I'm also adding NOBALANCING on the CXL side. The interrupts shouldn't be that frequent and are not used for I/O. So it's ok if we block balancing all around if the PMU needs it. And as Jonathan mentioned, dropping SHARED.
> 
> Thanks,
> Robin.
> 
>>                     irq_name, info);
>>       if (rc)
>>           return rc;
> 

