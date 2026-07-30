Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A023AB26A;
	Thu, 30 Jul 2026 21:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447274; cv=none; b=qzca1+yC8VtyFrPNEFajL51ZIIk1rNvlLlYC/J3ZBz6EE9KpCAY2YH3v7oQT/+Re7dGlaafWcxNBxGIkWV7WjpzUAiISFGn8ObpPVJt67ftqlCmWReJqBCsfDo+jyQsEZilEUT0om9BjybNUWryELFsaU+Oq0vK+coA29388dYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447274; c=relaxed/simple;
	bh=Y0UgnV7vduq7Rjz4vSWJrk3rFs/kXVl7hVU+wd1omDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmhqWvt1mAb1Z1Ogu6eHglrUHvm8R3g1wuB5ZXICRaUG0xnTCM40+ugeXifW7/8TKhtYT2Gd//t0b+/RhgIn/Gy8piBLMrJGBTIdW4vRDM5du1wdxPAABtDUjH6qVLLMHKkPynVtHBOjcBYJYZTUGW/xIzNhKtJ1CYIp2SAP7Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AvBwRd33; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AvBwRd33"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785447272; x=1816983272;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y0UgnV7vduq7Rjz4vSWJrk3rFs/kXVl7hVU+wd1omDQ=;
  b=AvBwRd33yApdOcE4mbVL/uw8MCGEcEAzrUbe/qWi6JsArcdU5g+oY+Vy
   7emptPO9prRgtD1qre67KfJaYT1DXbwCcO+xZ3rA9JiSWVVn9/364Ddcd
   0+XzN7kySHp8e7fNlkA4UBbO5bek3EWIbxMKpn0ISdaJFF0qpTDBSGZtw
   JtzR/1pJZ9+JPCRgXa454DwnGQ9D6a1FXTOXpgSZZDaEDPu/5AG5zp7ij
   kFcEaIIB3xZC2Pqa9t5Dwb/mfn1pouxIa7SsDooK55xau+FSJtHC0mdL3
   PjrkLQWH5TGLhS3WuiKgSLlAf1wR2tuAkJWWM8iNoUNCIGtfCNeyVWxk3
   Q==;
X-CSE-ConnectionGUID: dTOvM6RJTo2JFkmb8briCg==
X-CSE-MsgGUID: J63nDMk6QpmqSxUZYGIlpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="103485320"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="103485320"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 14:34:32 -0700
X-CSE-ConnectionGUID: h9B7McuQTQSaPQMHODBJ9g==
X-CSE-MsgGUID: LFQ9h2WcSTme43bPFCta7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="254089652"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.111.248]) ([10.125.111.248])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 14:34:30 -0700
Message-ID: <85262d22-3467-43ca-867a-7f17659732c5@intel.com>
Date: Thu, 30 Jul 2026 14:34:30 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] perf/cxl: Keep the overflow interrupt pinned to
 the managed CPU
To: Jonathan Cameron <jic23@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 sashiko-bot@kernel.org
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-6-dave.jiang@intel.com>
 <778b651c-ab2e-41d6-a0d6-5da144989df7@arm.com>
 <20260730195523.6cf9dd2b@jic23-huawei>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260730195523.6cf9dd2b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/26 11:55 AM, Jonathan Cameron wrote:
> On Thu, 30 Jul 2026 12:46:24 +0100
> Robin Murphy <robin.murphy@arm.com> wrote:
> 
>> On 29/07/2026 3:55 pm, Dave Jiang wrote:
>>> The PMU pins its overflow interrupt to info->on_cpu in the hotplug
>>> online/offline callbacks, but requests it with only IRQF_SHARED |
>>> IRQF_NO_THREAD. Without IRQF_NOBALANCING, irqbalance or a userspace
>>> smp_affinity write can move the interrupt to another CPU. cxl_pmu_irq()
>>> then runs cxl_pmu_read() there, doing local64_cmpxchg()/local64_add() on
>>> hwc->prev_count and event->count concurrently with the managing CPU;
>>> local64_t is only atomic against same-CPU access, so counts get
>>> corrupted.
>>>
>>> Add IRQF_NOBALANCING so the pinning done in the hotplug callbacks holds,
>>> matching other uncore-style PMU drivers.
>>>
>>> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
>>> Reported-by: sashiko-bot@kernel.org
>>> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
>>> Assisted-by: Claude:claude-opus-4-8
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>> ---
>>>   drivers/perf/cxl_pmu.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
>>> index d1e810601e36..8b89db8f4d68 100644
>>> --- a/drivers/perf/cxl_pmu.c
>>> +++ b/drivers/perf/cxl_pmu.c
>>> @@ -888,7 +888,8 @@ static int cxl_pmu_probe(struct device *dev)
>>>   	if (!irq_name)
>>>   		return -ENOMEM;
>>>   
>>> -	rc = devm_request_irq(dev, irq, cxl_pmu_irq, IRQF_SHARED | IRQF_NO_THREAD,
>>> +	rc = devm_request_irq(dev, irq, cxl_pmu_irq,
>>> +			      IRQF_SHARED | IRQF_NO_THREAD | IRQF_NOBALANCING,  
>>
>> Bah, sorry, now I see I misspoke just now on the other patch - PMUs 
>> really _shouldn't_ permit shared IRQs, but this one does :(
>>
>> Thus it's all well and good to prevent userspace changing affinity, but 
>> it doesn't help _all_ that much if other drivers can still legitimately 
>> change it behind our backs...
> 
> We do in theory know what drivers might do that (and today I don't think
> any but this one do).  In practice though I think two instances of this
> on same device could foul things up.
> 
> As per other suggestion, Dave would you mind just dropping shared support
> for now?  Can revisit if anyone built that insane hardware.

Yup I'll do that.

