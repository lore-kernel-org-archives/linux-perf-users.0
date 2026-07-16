Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB72383C8F;
	Thu, 16 Jul 2026 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221559; cv=none; b=en+v/a0bzTyxhfNYq10fTvUDE1qUtI/pJmEzXEE9kTne/fAJ8pV0hNGMp5z4gR1VR1j3Hi0EVvA8yHeg2z1njvL2uEEUSFQXBl8B9NoDEgImLOFN1SxQVZOB1TkfpLGJAY1XW/d9hP+3S/ZnHJn0E25BMua2iDVV5tiB96TFiLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221559; c=relaxed/simple;
	bh=v9/QglZ/XTe9SIECMjV1lI0wjD2dEQADkG0X/NO1slo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLMTlnOQcCgi2RkyySf1VNkmG5NaiZiHym8343K3eFdyt70sN6hbCq9Z5uQpGFa/UXl7d/PoCfGw6+xaH1ZfrBvLAwbpPtrOQw5aAITWb7M31KOS2DkDvFYdpAVSgBuhdWW87WSIkLirhUIwwn3qmj+XRCQokEqnYMUSThYvumI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPiu/OHP; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPiu/OHP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784221558; x=1815757558;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v9/QglZ/XTe9SIECMjV1lI0wjD2dEQADkG0X/NO1slo=;
  b=RPiu/OHPFvtXE1cNfdT48d03TwlHZ0Wqoi/FzKvcasezwpBiq019kpYZ
   HGL4Q88b3rSHbVzodcYmXnGtkqRNGY/CojqdiGtFmfP7XNzruVH4kO64b
   W+MYmOxGsWB+NBM0d1wDF/JGfipwUFQHl9+SgOCLKOIj0IJxmfUaBZULr
   aWhunLAWhhXD9xRD+vlIcCXkfwu2LN0p1EZI446XURw5HS9tkQwaiG8NZ
   xXBRt67/ZI/sz2HIf1upyopNnOXqG1AgGW3mQmHgk6aJW74EmtpPOuq2b
   0cL2fZO9gpW8SNNZaVEHKUoA9RNESYaE86uxy5eg6K/YUkqzbUs16wlad
   g==;
X-CSE-ConnectionGUID: BPR6HDyxRIukcJg6Q4Z7eQ==
X-CSE-MsgGUID: jFuCJUqJTG2PLOaY9qeWkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84915144"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="84915144"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 10:05:57 -0700
X-CSE-ConnectionGUID: zJKqblL7T+SuWhw9U9Rqcg==
X-CSE-MsgGUID: 4cW507ZMQWC/RHCv3En6Xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="260152856"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.15]) ([10.125.109.15])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 10:05:55 -0700
Message-ID: <f7dfe837-a044-4d2e-bdb6-599157063eef@intel.com>
Date: Thu, 16 Jul 2026 10:05:54 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] perf/cxlpmu: Misc updates
To: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, jic23@kernel.org,
 mark.rutland@arm.com, harshal.t@samsung.com, icheng@nvidia.com,
 linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260715191454.459673-1-dave@stgolabs.net>
 <ecd7aea3-88c0-4f1c-8130-c3c9ef9e6869@intel.com>
 <alkLGe4PfVK12lbQ@willie-the-truck>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <alkLGe4PfVK12lbQ@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/16/26 9:47 AM, Will Deacon wrote:
> On Thu, Jul 16, 2026 at 09:46:05AM -0700, Dave Jiang wrote:
>>
>>
>> On 7/15/26 12:14 PM, Davidlohr Bueso wrote:
>>> Hello,
>>>
>>> Changes from v3 (https://lore.kernel.org/all/20260713061112.105419-1-dave@stgolabs.net/):
>>>  - Validate the event vendor ID for CRB filtering, the Table 13-5
>>>    event groups are scoped by the CXL VID in patch 3 (Richard).
>>>  - Add Richard's Reviewed-by tag to patch 1.
>>>
>>> Three patches for the CXL PMU driver.
>>>
>>> Patch 1 is a standalone fix.
>>>
>>> Patch 2 adds the CXL 4.0 events that hardware exposes but the
>>> driver did not. It now precedes the filter work as the latter
>>> refers to the new event group IDs.
>>>
>>> Patch 3 implements Channel/Rank/Bank (CRB) filtering, now permitted
>>> for all event groups that CXL 4.0 Table 13-5 allows Filter ID 1 on.
>>>
>>> v2 was tested on real hardware. The v4 changes have been exercised
>>> under qemu CPMU emulation (jic23 tree) + changes for the new events/Filter=1:
>>>
>>>     https://lore.kernel.org/all/20260715190050.458288-1-dave@stgolabs.net/
>>>
>>> Thanks!
>>>
>>> Davidlohr Bueso (1):
>>>   perf/cxlpmu: Fix 64-bit write to 32-bit HDM filter register
>>>
>>> Harshal Thakkar (2):
>>>   perf/cxlpmu: Add missing CXL 4.0 events
>>>   perf/cxlpmu: Support Channel/Rank/Bank filter
>>>
>>>  drivers/perf/cxl_pmu.c | 119 +++++++++++++++++++++++++++++++++++++++--
>>>  1 file changed, 116 insertions(+), 3 deletions(-)
>>>
>>>
>>> base-commit: d60ec36cab338dfe2ae40d73e9c8d6c4af70d2b8
>>
>> For the series
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>
>>
>> This is being picked up by the perf maintainer right?
> 
> Yeah, I'll grab it eventually. Just a bit swamped atm.

Thanks Will! Wasn't trying to rush you. Just checking to see which acceptance path the series is going through.

> 
> Will

