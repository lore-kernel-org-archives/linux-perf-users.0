Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BA91E7C18;
	Thu, 15 Jan 2026 00:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768438647; cv=none; b=Qxyr2kT1VZ+qBXGTWtw3mt5N19x91Ui19nAbLs9vxHvAOMB54fO4oYwKwa8t9FyW6faoyKRx2gKorqpJm3daS6e3fvztyDxjWPZphYdqXbiOd4ibc87SAaWxHj+a4t5WdL6GhZkMa5xTsEIPu1Al6lYCOXcOujPWsGxOFmKRcFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768438647; c=relaxed/simple;
	bh=zEASgpzMnTBOx5k5qb7inlLX6bpS4I2vBZeS+Zmhr7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1EsantnRnmSFRBOhK6fZLthdcygHeJEIVFYL51u/PqKUF7ej+M3QXmtn5WT1gv+tTkBh08mrx+72WdAfqOMu5RkB8vL9T3L8UZPdr9KxTn3adNdsNN3sBEhrBMPqt/7nS1XEJAhWji5VbUbgJ0sewFlyaGNLdmOMHPY5o59W/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TyQA+yeV; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TyQA+yeV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768438646; x=1799974646;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zEASgpzMnTBOx5k5qb7inlLX6bpS4I2vBZeS+Zmhr7w=;
  b=TyQA+yeVqr5u/mawt2kxjcAvBq+f7+NdJNXIROlamioux/36BTMQylMk
   dMRGEYjpRQykbuSX6lxM1eItxp/5VG0niWxYsj3BUbx8ZZONVNCyJOC25
   qYCsEPCX89wLBi6rTYUJHNGsRvK+DhHTPR3peD7PvOCNZ4+CT49p7MgGd
   PqWxKp7d5qTWDR5siFeooQogjl7ZFsyuUgpxSEYmuilah82Ao6Wo7E/jY
   1YyLHXA+r1LGxnBNoV53yI73ayobWdb2BfwI7wNooyu45nkGejNp9i9V+
   1OS4iu0fNI1R/Gd8Mppkng3L6+7HDKEqzO4PBb4T2oq0ncqOSgcC7O73S
   w==;
X-CSE-ConnectionGUID: XDW4vSK+TKGoLtd5uowOog==
X-CSE-MsgGUID: dIaImfVTR7Wfuzk23FuFrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69722761"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="69722761"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 16:57:25 -0800
X-CSE-ConnectionGUID: 49UBJqk5RfOd0rHlv9r9GQ==
X-CSE-MsgGUID: T7MqZkWLSHChHJdshgMJnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="235542721"
Received: from fhuang-mobl1.amr.corp.intel.com (HELO [10.125.38.93]) ([10.125.38.93])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 16:57:25 -0800
Message-ID: <32386e0a-09d9-4f13-a5e1-c6f9dd3afdfd@intel.com>
Date: Wed, 14 Jan 2026 16:57:24 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] perf/x86/intel/uncore: Fix iounmap() leak on
 global_init failure
To: Markus Elfring <Markus.Elfring@web.de>, linux-perf-users@vger.kernel.org,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, Stephane Eranian <eranian@google.com>
Cc: lkp@intel.com, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Thomas Falcon <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260114193825.17973-1-zide.chen@intel.com>
 <cda9ab9b-4581-409f-a9bb-0e8a67ad3530@web.de>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <cda9ab9b-4581-409f-a9bb-0e8a67ad3530@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/14/2026 12:57 PM, Markus Elfring wrote:
>> Kernel test robot reported:
> 
> Is this duplicate information according to a known tag?

I was trying to follow some examples of how test robot reports are shown
in commit messages, for example:

https://lore.kernel.org/all/20240626151131.550535-2-torvalds@linux-foundation.org/

https://lore.kernel.org/all/173058261037.3137.8690137124888546964.tip-bot2@tip-bot2/


>> Unverified Error/Warning (likely false positive, kindly check if
>> interested):
>>     arch/x86/events/intel/uncore_discovery.c:293:2-8:
>>     ERROR: missing iounmap; ioremap on line 288 and execution via
>>     conditional on line 292
> 
> See also:
> https://elixir.bootlin.com/linux/v6.19-rc5/source/scripts/coccinelle/free/iounmap.cocci#L2-L8
> 
> 
>> If domain->global_init() fails in __parse_discovery_table(), the
>> ioremap'ed MMIO region is not released before returning, resulting
>> in an MMIO mapping leak.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> See also once more:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc5#n94
> 
> Will another imperative wording approach become helpful for an improved change description?

My apologies — I did try to address the feedback, but I may still be
missing something.  Could you please point out what specifically could
be improved?


> …
>> ---
>>  arch/x86/events/intel/uncore_discovery.c | 15 ++++++++++-----
> …
> 
> Some contributors would appreciate patch version descriptions.
> https://lore.kernel.org/all/?q=%22This+looks+like+a+new+version+of+a+previously+submitted+patch%22
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc5#n310

Yes, that was the intention for v2.

V2:
- As suggested by Markus, add an `out` label and use goto-based error
  handling to reduce duplicated iounmap() code.
- Add the original warning from the kernel test robot to the commit message.
- Trivial rewording of the commit message.

> 
> Is there a need to perform desirable changes by a small patch series?
> 
> * Specific fix
> * Related refinements

It seems to me that the changes in this patch are small and closely
related, so I wondered whether splitting it might be unnecessary.

> 
>> +++ b/arch/x86/events/intel/uncore_discovery.c
>> @@ -264,6 +264,7 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
>>  	struct uncore_unit_discovery unit;
>>  	void __iomem *io_addr;
>>  	unsigned long size;
>> +	int ret = 0;
>>  	int i;
> 
> Would scope adjustments become helpful for any of these local variables?

As mentioned in my earlier reply, my suggestion was to avoid doing other
unrelated optimizations in this patch.

https://lore.kernel.org/all/e7d74d9d-cb45-4f5f-8e44-502dd7c4bcff@intel.com/T/#t



>> @@ -273,21 +274,23 @@ static int __parse_discovery_table(struct uncore_discovery_domain *domain,
>>  
>>  	/* Read Global Discovery State */
>>  	memcpy_fromio(&global, io_addr, sizeof(struct uncore_global_discovery));
>> +	iounmap(io_addr);
>> +
>>  	if (uncore_discovery_invalid_unit(global)) {
> …
>>  	}
>> -	iounmap(io_addr);
> 
> Can this modification part be interpreted as an optimisation?

Yes, this is technically an optimization. Since the patch is already
refactoring the iounmap() handling, my thinking was that it would be
reasonable to include it in the same patch.

> …
>> -	if (domain->global_init && domain->global_init(global.ctl))
>> -		return -ENODEV;
>> +	if (domain->global_init && domain->global_init(global.ctl)) {
>> +		ret = -ENODEV;
>> +		goto out;
>> +	}
> …
>>  	*parsed = true;
>> +
>> +out:
> 
> Would an other label be a bit clearer here?

I’d suggest keeping the label name out for style consistency, as
mentioned in my earlier reply.

https://lore.kernel.org/all/e7d74d9d-cb45-4f5f-8e44-502dd7c4bcff@intel.com/T/#t

> 
> unmap_io:
> 
>>  	iounmap(io_addr);
>> -	return 0;
>> +	return ret;
>>  }
> …
> 
> 
> Regards,
> Markus

