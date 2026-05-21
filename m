Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A81425CF4
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779395442; cv=none; b=DtozYHcePqkMemc1LdUdtER9GN+qWyiOPXFbucK8iviLqxtwE9eG0gPKz6hVpdWs5Qsgyavwy8JwER0sHqONh3qqKyRy1PW1aUL2rpRsKReuqXAH28o/PnRQKuYOmTbAOSxEk0Ovl0PWUpKhav4z+H1AYbT593mE7xs/4fU76s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779395442; c=relaxed/simple;
	bh=/f/DZWyR3jpTWe9voYXRG1i/YRupvHo463AvYQhmpiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZmAPH6bJQyEdSYuTa56+Irr9fpmQa+7gtQiGthhVKQXFYe6LUbB2JVYdGnHk099CSwOVgAeZ1PttnDiNwaXRjNZCPPOu1/SpmmpQuJKtEDdIXKEbuhyW5zn+DrRJq190bxo5YZvuyZay8HF1Ay2f33Nbwx6HuJuJuDyBuFT1RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZPGQqbT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZPGQqbT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779395441; x=1810931441;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/f/DZWyR3jpTWe9voYXRG1i/YRupvHo463AvYQhmpiI=;
  b=DZPGQqbTnZ4S8iPu547ksyFHV5wTXT69KnDQhuSFO5f9N//LHiHNPp6e
   PDNsns4kGUi+ys4l+YEbOtzAJYPvDONsu5hkNflVqd8FenFceaER/eROI
   buqmYTxMW1KAG18Gfm5lPkSgTAuY2IQKP87Ml44HrmQwzX7TiPDZpBrAP
   o6l/W0VY6Y/EcjA/xkroTS7hMCPVH3AGtSeAXqI0DiQeIxU5ez0/y5FEu
   1qDh7espJxg51L9CUoGfh7+aARoHPKXMY9lAqXnYQU39+9W12yuXb3ruM
   EDcjKFdxz3H19SbjrpO3q8CxR9DyAyE7oyuE6JSBqASq8GCtBE1q7ZiV4
   Q==;
X-CSE-ConnectionGUID: qXzSzIDsTVyNfHTGTHShkA==
X-CSE-MsgGUID: q9E0+31yRSao7Ce6AuzOew==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="105786621"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="105786621"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 13:29:29 -0700
X-CSE-ConnectionGUID: tRDb45jJQJuE0T2Fhq+LDw==
X-CSE-MsgGUID: GFldvvZnR4qf1lkyJwfJbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="239626178"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 13:29:29 -0700
Message-ID: <b71ad1df-775c-47a8-9390-738c31a4cf72@intel.com>
Date: Thu, 21 May 2026 15:29:27 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] perf/x86/intel/uncore: Let init_box() callback report
 failures
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260512233048.9577-3-zide.chen@intel.com>
 <20260514021424.821EEC19425@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260514021424.821EEC19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/2026 9:14 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The adl_uncore_msr_init_box callback was missed during the return type conversion and still returns void, causing a build failure and a runtime functional regression.
> --
> 
> commit 9d842c01126a1db0940fbdd8cefa558fa67a3758
> Author: Zide Chen <zide.chen@intel.com>
> 
> perf/x86/intel/uncore: Let init_box() callback report failures
> 
> The init_box() callback currently returns void, so initialization
> failures are silently ignored and the box is still marked initialized.
> Change the callback to return int so platform code can report errors
> back to the common uncore layer.
> 
>> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
>> index 2e41a66f00551..25a44d3de6e7d 100644
>> --- a/arch/x86/events/intel/uncore.h
>> +++ b/arch/x86/events/intel/uncore.h
>> @@ -129,7 +129,7 @@ struct intel_uncore_type {
>>  #define events_group attr_groups[2]
>>  
>>  struct intel_uncore_ops {
>> -	void (*init_box)(struct intel_uncore_box *);
>> +	int (*init_box)(struct intel_uncore_box *);
> 
> It appears the return type for the init_box callback was changed here, but
> adl_uncore_msr_init_box() in arch/x86/events/intel/uncore_snb.c was missed
> and still returns void:

This callback will be removed in another patch set:
https://lore.kernel.org/lkml/20260511230527.26096-1-zide.chen@intel.com/

Updating the signature here would cause a merge conflict with that
series, so it was intentionally left as-is.

> static void adl_uncore_msr_init_box(struct intel_uncore_box *box)
> {
> 	if (box->pmu->pmu_idx == 0)
> 		wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
> }
> 
> Could this cause a build warning or failure (e.g., incompatible pointer
> type)?
> 
> Also, at runtime, uncore_box_init() expects an int return value. Would it
> end up reading an uninitialized return value from the eax register?
> 
> If the last operation in adl_uncore_msr_init_box() is wrmsrq(), which
> loads SNB_UNC_GLOBAL_CTL_EN into eax, could this residual non-zero value
> cause uncore_box_init() to incorrectly treat the initialization as a failure?
> 
> If the initialization failure marks the PMU as broken, would this render the
> Alder Lake (ADL) MSR uncore PMU inaccessible to userspace?
> 
>>  	void (*exit_box)(struct intel_uncore_box *);
>>  	void (*disable_box)(struct intel_uncore_box *);
>>  	void (*enable_box)(struct intel_uncore_box *);
> 

