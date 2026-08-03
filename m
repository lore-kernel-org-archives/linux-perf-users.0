Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE22E7165;
	Mon,  3 Aug 2026 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767405; cv=none; b=luU/fa6lKt+tqFgA3R9HYGuz0qo7kosVMu9X7KmZY9oJIOAwoRlzDl92vXY60Lv8T3RaY8GgjoYo4JEmFsri5nPLH2Cgj9eYhqHo2SaAN2WBibeqYGuxUuwm/Y5O9qSqErG5FzqPOXPuZDVhsAGfhJRSUCPGXQJnPetRPfD4Hf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767405; c=relaxed/simple;
	bh=PYAv4bqgM/MLswi+SC1lDlrOY7sM4RTk8o4SNYMUtbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVIGv22T7aRP+OpXlmlWDUAnmyV6ZLjLRBTSXKQhnpHtGG8PZp0VQ/MqIXVgvsU64sTvXh0JIS1JEvDZVLtQH3mH+OIVlrc4z2fu6NnmITrVy/VXWGN2IW5CnrYygky2lTcvJLMpN6/z5Zp4CpqTIGQaw7vbpmFzEUvNmKUazuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9dXX/mT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9dXX/mT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785767404; x=1817303404;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PYAv4bqgM/MLswi+SC1lDlrOY7sM4RTk8o4SNYMUtbA=;
  b=K9dXX/mTWTcOXAdaRCkrS5CviAqD/Cpbebziwi6lp0FcdoC118zTRpg9
   r/eiTHTZrMnlIpbL2c7KQT2FofpLiIIS51+avEeA+WavF1olxm0INRjtz
   RVAI6zKhh5SCGTqCdQWCD7HCEuMr9Go+EYvcVb+ZaXW3eRdKJHmrKQCyT
   mrxmr5cCL9aQLkfx9a17UztdOZb7MqyuAHFHV8fAqJTjvmArqmJGAu7z7
   36R+P6fxRzZGN1pRCCcckJagPXWIwX4HNHqpzYAQZJRyjNJuBPCtzqTWD
   yvYJUljHy16yYVOzJhOdn3vyAd1JBZYogUJTrO4X4YcG4kLrNMTFP2cXI
   w==;
X-CSE-ConnectionGUID: OGcAe5yYSequR93B5ZMw+A==
X-CSE-MsgGUID: 379z6DdiSk6EaocQ8GwhAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="96892331"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="96892331"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 07:30:03 -0700
X-CSE-ConnectionGUID: cmdQApsrSbmp0EuChi6QLQ==
X-CSE-MsgGUID: 3LlnOa9ERXCZMDQtherwEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="285869655"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.108.187]) ([10.125.108.187])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 07:30:02 -0700
Message-ID: <2d89c314-c0d9-4895-83cf-52f12a3f6ef0@intel.com>
Date: Mon, 3 Aug 2026 07:30:00 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] perf/cxl: Accept an overflow interrupt on MSI
 message number 0
To: Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 jic23@kernel.org, will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 robin.murphy@arm.com, sashiko-bot@kernel.org,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <20260731232827.401447-1-dave.jiang@intel.com>
 <20260731232827.401447-6-dave.jiang@intel.com> <anAs42gO1Yd7MCid@MWDK4CY14F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <anAs42gO1Yd7MCid@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/2/26 10:57 PM, Richard Cheng wrote:
> On Fri, Jul 31, 2026 at 04:28:23PM +0800, Dave Jiang wrote:
>> cxl_pmu_probe() rejects the PMU when info->msi_vec <= 0, but that field
>> holds the MSI/MSI-X message number the device signals overflow on. The
>> field is 0-based, and -1 means no interrupt support. Message number 0 is
>> valid and pci_irq_vector() takes a 0-based index, so a compliant device
>> signalling on the first vector fails to probe.
>>
>> Reject only the no-interrupt case, matching how the CXL mailbox and event
>> interrupts handle it.
>>
>> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
>> Reported-by: sashiko-bot@kernel.org
>> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
>> Assisted-by: Claude:claude-opus-4-8
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v3:
>> - Rebase on the preceding patch, so this tests info->msi_vec rather than
>>   info->irq. The fix is unchanged and the hunk is still one line.
>> - Not guarding against pci_irq_vector()'s INTx fallback for vector 0, which
>>   it returns when neither MSI nor MSI-X is enabled. A v3 draft added a
>>   pci_dev_msi_enabled() check for that, but a modern CXL device wiring up
>>   INTx is not a realistic prospect, and the consequence otherwise is a PMU
>>   that counts nothing rather than anything unsafe. Left alone to keep this
>>   a one-liner.
>> ---
>>  drivers/perf/cxl_pmu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
>> index 56e6ae7bebf7..c9e30cb149df 100644
>> --- a/drivers/perf/cxl_pmu.c
>> +++ b/drivers/perf/cxl_pmu.c
>> @@ -875,7 +875,7 @@ static int cxl_pmu_probe(struct device *dev)
>>  		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
>>  	};
>>  
>> -	if (info->msi_vec <= 0)
>> +	if (info->msi_vec < 0)
>>  		return -EINVAL;
>>
> 
> Hi Dave,
> 
> I agree that 0 is a legal message number, but do we need to check whether
> MSI is actually enabled ?

I actually dropped the check and added notes so sashiko doesn't freak out. I don't think it's necessary given there's not likely to have devices with INTX support.


> 
> something like
> """
> if (info->msi_vec < 0 || (!pdev->msi_enabled && !pdev->msix_enabled))
>     return -EINVAL;
> """

I can add that if you still think it's needed. The one thing I can think of is someone pass in no_msi at the kernel commandline.  

> 
> Best regards,
> Richard Cheng
> 
> 
> 
> 
>>  	rc = pci_irq_vector(pdev, info->msi_vec);
>> -- 
>> 2.55.0
>>
>>

