Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816084483A6;
	Thu, 30 Jul 2026 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785434249; cv=none; b=nI9xHZYRTFSpoNHGRbTphBvDIqiD2e1JbE8De8HJ3D6NnYSltJVXHwZt1u4nefo2QW8BOi8UOHVDySX0brrrePDZqBhfEbCgfP1SoLz2grarLiNdh7kwXGiOsMwReDTsMp8Rwb5ONsMh77HOzfb8H4NpwisYUJNZG+pty1FixjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785434249; c=relaxed/simple;
	bh=5yUx3xf9dCQoSx5kOdbmIk1BcwJMFu3Myu7XNWB5DCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUgLm4hhJHh3xTSR4SBYwDR+OuUM+wzM++tMrwBXc5VPT8mmiWoC0n0rHaupiKyLe5uxwws2xtPJLDh4uaQe5utkCQH6wKYGmz3IXa78QEqEUNOaA4ndJs6wRTAlMWxdURxA5e5Tp1rSb8sdVgpiF2tTz3NkdnFIY9GPFBwOgxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JiC858Sb; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JiC858Sb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785434248; x=1816970248;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5yUx3xf9dCQoSx5kOdbmIk1BcwJMFu3Myu7XNWB5DCw=;
  b=JiC858SbExKoJqrID5hxElHYWxlVSEOSEhEJRLEeaWjtXn6+TsIRvI7t
   31dnlumgMvOtKSkNQdMJg6iy/wuSi9FNazopTNLv/PelffeqvAm12cStL
   zmfH+gfj7T/xvTmrawfsNG1iNI+ItSvTZjLOv+BIziv6r5iODM/cOspuE
   nSX7DnGAfMllIabrQviHVo8yx7JmniieqRb6WDBaCJfqVvpVezJoV6InY
   9vP87PUCm6lOLJn0lvlOtA3DGVWDqvBVAMCow4XFDYI/ajw2pJ43z7sTQ
   NVIBIfLHUFRx6SIHjfA4AT/0JitDM5kszwqB0Ic6Pg2kKkXbQntBabZ6a
   g==;
X-CSE-ConnectionGUID: xNlww0PGQCmJgktU8exLWQ==
X-CSE-MsgGUID: hrbAX80ISgicaZUF67AJBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="85036931"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="85036931"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 10:57:27 -0700
X-CSE-ConnectionGUID: akzqjswMTrqP2aoYfyh+OA==
X-CSE-MsgGUID: Fsxmg3lgR3CPEc7R5V7Wtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="257682985"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.111.248]) ([10.125.111.248])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 10:57:26 -0700
Message-ID: <8b665956-773f-439e-ad9e-f09a3ba88b79@intel.com>
Date: Thu, 30 Jul 2026 10:57:25 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] perf/cxl: Accept an overflow interrupt on MSI
 message number 0
To: Robin Murphy <robin.murphy@arm.com>, linux-cxl@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: jic23@kernel.org, will@kernel.org, mark.rutland@arm.com,
 dave@stgolabs.net, sashiko-bot@kernel.org
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-5-dave.jiang@intel.com>
 <5196c172-9ef3-43ae-98df-57a95427a00a@arm.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <5196c172-9ef3-43ae-98df-57a95427a00a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/30/26 5:18 AM, Robin Murphy wrote:
> On 29/07/2026 3:55 pm, Dave Jiang wrote:
>> cxl_pmu_probe() rejects the PMU with -EINVAL when info->irq <= 0, but
>> info->irq holds the MSI/MSI-X message number the device signals overflow
>> on (CXL_PMU_CAP_MSI_N_MSK, a 0-based 4-bit field), with -1 meaning "no
>> interrupt support". Message number 0 is valid and pci_irq_vector() takes
>> a 0-based index, so a compliant device signalling on the first vector is
>> wrongly refused and fails to probe.
> 
> If info->irq is a PCI MSI vector index, not the Linux vIRQ number, then surely that means the irq_set_affinity() calls are wrong as well?

So info->irq reverts back to Linux vIRQ after the irq is requested. It's kind of messy. Maybe we should split it into two fields to remove the confusion? I can create a patch for that before this patch change.

DJ

> 
> Thanks,
> Robin.
> 
>> Reject only the no-interrupt case (info->irq < 0), matching the sibling
>> CXL mailbox and event IRQ handling.
>>
>> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
>> Reported-by: sashiko-bot@kernel.org
>> Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolabs.net?part=1
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/perf/cxl_pmu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
>> index 956da8202551..d1e810601e36 100644
>> --- a/drivers/perf/cxl_pmu.c
>> +++ b/drivers/perf/cxl_pmu.c
>> @@ -876,7 +876,7 @@ static int cxl_pmu_probe(struct device *dev)
>>           .capabilities = PERF_PMU_CAP_NO_EXCLUDE,
>>       };
>>   -    if (info->irq <= 0)
>> +    if (info->irq < 0)
>>           return -EINVAL;
>>         rc = pci_irq_vector(pdev, info->irq);
> 

