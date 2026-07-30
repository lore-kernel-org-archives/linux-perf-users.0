Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A6F369985;
	Thu, 30 Jul 2026 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785431991; cv=none; b=IQTjdwQXePQDSjvi30i2ged6dYc63UJxjm/zJoDiWdt/zZ8aB0tzP/Pny0N++byUO+2GVdfkKQRAt2x2YEqZvwze5i1ZZimQhlI4R+zGajhlA+j3orxvAqQK7WBEMHP+Hf74+gqHBIEmQnCTDsOJDd0GxSfshsCUhajSFEki/jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785431991; c=relaxed/simple;
	bh=ViQWE/f6mt9esMrkIl54egjxeviF7jxXItG5Isil0Cg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JB0nOgsSTy4IwBJLbWR/rtUwp4FP8DBvMgI1AUJzkm5+Vz5f5Z8Xy/H2R5AqgNceD3vQZDqYIINPxc8/V09IcxQL91IUM//KnzHdttBntf9FnILYiG6W6qEstd2wYqj76hLcKY4gUWanJDFMu6ilYVMElPttvGCFMxasjbWSvrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c8EC+kUG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c8EC+kUG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785431989; x=1816967989;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=ViQWE/f6mt9esMrkIl54egjxeviF7jxXItG5Isil0Cg=;
  b=c8EC+kUGhWp9xizF0ozPCd+Qzlf6tOIq4m1UNyem0uF75wHvEgAaWLol
   JLQUTXIttfxRZfu095fxcKrLZIHshyBSCIRUpwsoohfXsYQm5vXxwT8T/
   WRG0mwGr9x9X8dkAjbIa0/WxFFQgYIaL6ruI2OmmEhtosJqNvFbhX4vQh
   oLUg3TYPpAfNL9RCLVpuXxsHO3cqR5SFirRknBNHeDnPPRzv3AfS04r8q
   uGp0ryrghs7iEalkdLOEMTVlQFhc302N+3ag6pCxBdPbaY1E3KY4tf3No
   IL04CRcUDDU3vtY0v5FjnMLDdCfN4UwLeqEi91RE2UaTrC260jUwKozlG
   A==;
X-CSE-ConnectionGUID: tJek0L4KQ1CBm29e7RKP7g==
X-CSE-MsgGUID: L0/MAAGmSGS8xAUJcemKTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="86249027"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="86249027"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 10:19:49 -0700
X-CSE-ConnectionGUID: OT6jGRnnRcKLq64jP2vYzw==
X-CSE-MsgGUID: 0TpfASWIR+26RAmqcS5tFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="264628952"
Received: from rfrazer-mobl3.amr.corp.intel.com (HELO [10.125.111.248]) ([10.125.111.248])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 10:19:48 -0700
Message-ID: <fd6701db-82b7-4a94-a223-b0d051035dc7@intel.com>
Date: Thu, 30 Jul 2026 10:19:47 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] perf/cxl: Fix the counter overflow delta fixup
From: Dave Jiang <dave.jiang@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org,
 will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net,
 sashiko-bot@kernel.org
References: <20260729145555.3919550-1-dave.jiang@intel.com>
 <20260729145555.3919550-4-dave.jiang@intel.com>
 <20260729232142.050ed34c@jic23-huawei>
 <51728f3b-e75d-4b63-a355-7d0b0398d0dc@intel.com>
Content-Language: en-US
In-Reply-To: <51728f3b-e75d-4b63-a355-7d0b0398d0dc@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/26 9:56 AM, Dave Jiang wrote:
> 
> 
> On 7/29/26 3:21 PM, Jonathan Cameron wrote:
>> On Wed, 29 Jul 2026 07:55:49 -0700
>> Dave Jiang <dave.jiang@intel.com> wrote:
>>
>>> Counters are configured with Freeze on Overflow and are never reloaded: on
>>> overflow the counter wraps to 0, counts on until the CPMU freezes, and
>> Hi Dave,
>>
>> Thanks for looking at these.
>>
>> Why would it count on if it froze?  I think the bot is tripping over the
>> fact we don't yet implement free running counters (and the other bug
>> about not unfreezing) for currently the ability to freeze on only some
>> counters (to do periodic sampling for instance).
>>
>> The CXL CPMU spec is incredibly broad in what is supported, so maybe
>> we want to harden things anyway but I'm not sure the condition described
>> by most of this is real.
>>
>>> retains that residual (CXL r4.0 8.2.7.2.3). So the masked subtraction in
>>> __cxl_pmu_read() only spans the wrap when new_cnt < prev_cnt.
>>
>> It's been a long time so maybe I have how this was meant to work wrong.
>>
>> There are two paths to __cxl_pmu_read()
>>
>> 1. We have freeze on overflow enabled so any counter that overflows results
>> in an interrupt. At that point all counters are frozen.
>> We then read only the counter that overflowed (which is 0) and that
>> will update the prev_cnt storage.  No chance of hitting the full wrap
>> around seen here.
>>
>> 2. An on demand read (polling) In this case the counter may
>> take any value, but because we have freeze on overflow it can't have
>> wrapped (as otherwise we'd have taken path 1).
>>
>> So slightly fun question of why we have any wrapping control and I think
>> the answer is because the freeze on overflow isn't very specific in the
>> spec for whether it freezes on max value or 0.
> 
> Vague enough that hardware can freeze on overflow but leave greater than 0 value? Or is it always either max value or 0? If you don't think this patch is needed I can drop.

Actually the spec does defines it to be 0 on overflow (8.2.7.2.3). Although there isn't clear language that indicates with the freeze, if any chance of any additional events being counted before freeze take effect.


