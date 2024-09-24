Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8993D3D68;
	Tue, 24 Sep 2024 02:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727144244; cv=none; b=VnBh61Xa1I4+NFHFASWetXBy1HANqqnlKG5TEERf4q+tQB1YKXL6Dh7pBgdiIiFxYh2VoEqtjK/QbXFfpHs3x/6odyAi8V1SvtPbyPsy4+FzHGvSKegO58myXq95ddaJzX8kc7mpqw3cNBZxOAW21LTy3YmHxUPRnE50pHmZcrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727144244; c=relaxed/simple;
	bh=A9Q7hnJsM3BUZjx0Y/8Kn9zSr7BbMf6xzZ7JNzV46JI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=igOLhuysuH1yVUs2oVzwaLQMWEiWjfJmTDMXcAxPO/evz+zIY6h4X1GhY5Ck+fHxIg5fK9JB6dkZedKe3zr04tgKLXaCNLJnbUf27jx3GITZw1uqurps+i1uOkum8i5fzOxSHPrRmihFu6++OMu/6L+iSOkiSw/r++iESbwKKqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6OkBVZR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6OkBVZR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727144242; x=1758680242;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A9Q7hnJsM3BUZjx0Y/8Kn9zSr7BbMf6xzZ7JNzV46JI=;
  b=c6OkBVZRj20VXxeeVMd5MMNUvILIBOp0TOdY6XdWpdYX11z7kGlTU1Nk
   PBVpdbcgPLStpSU4cNLrI1aWKDCny4uxKBKD/LzswP9enRFYqWDdvKDGp
   8ie+/h3KIXLCPDqyxZGxPXTLHWYI5CGBW6CY+Zn/6Oo0V8pI4ItVnPIF8
   XxZ8uH1A7zTE7Sk9HMJBEGxgV8SPs7x49WDBRKoWV6Jk+eBj7s+SRDnKu
   7UZ8iLRXJZhzhQABmxRma7UlfCUxOQHukPINqBgP+dhKxVbgrkxEJkEmr
   B1q8CSPagwMKGwjtzLmBGtvSCPsyyqzWxuEyq9NrD+m+x3RbUgKcdgqCR
   A==;
X-CSE-ConnectionGUID: C2OzaIAMRDuzP6jNy9tHww==
X-CSE-MsgGUID: dGDyrmoRTYCVW88Twu22Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="36706068"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="36706068"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 19:17:22 -0700
X-CSE-ConnectionGUID: qvXSTN78RwixqbkWGpi0Iw==
X-CSE-MsgGUID: 24QI5H8aTZO6rEb6t3ZREQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="76034566"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 19:17:20 -0700
Message-ID: <196706e4-e892-4e73-8ba7-1fa939d8998b@linux.intel.com>
Date: Tue, 24 Sep 2024 10:17:17 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [perf/x86/intel] 25dfc9e357:
 kvm-unit-tests-qemu.pmu.fail
To: Oliver Sang <oliver.sang@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Li Huafei <lihuafei1@huawei.com>,
 linux-perf-users@vger.kernel.org
References: <202409201525.4877023e-oliver.sang@intel.com>
 <f272389f-8565-4bdc-8727-8b37eaa82821@linux.intel.com>
 <ZvDvB98DW10Au8lo@xsang-OptiPlex-9020>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <ZvDvB98DW10Au8lo@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/23/2024 12:31 PM, Oliver Sang wrote:
> hi, Kan,
>
> On Fri, Sep 20, 2024 at 09:27:06AM -0400, Liang, Kan wrote:
>
>>> ...
>>> [32mPASS[0m msr (1836 tests)
>>> [31mFAIL[0m pmu (143 tests, 24 unexpected failures, 14 skipped)  <---
>> Is there a list to show which checks are failed?
> I attached a pmu.log.
>
> below failed which can pass on parent (v6.11-rc5)
>
> FAIL: Intel: overflow: cntr-0
> FAIL: Intel: overflow: status-0
> FAIL: Intel: overflow: cntr-1
> FAIL: Intel: overflow: status-1
> FAIL: Intel: overflow: irq-1
> FAIL: Intel: overflow: cntr-2
> FAIL: Intel: overflow: status-2
> FAIL: Intel: overflow: cntr-3
> FAIL: Intel: overflow: status-3
> FAIL: Intel: overflow: irq-3
> FAIL: Intel: overflow: cntr-4
> FAIL: Intel: overflow: status-4
> FAIL: Intel: full-width writes: overflow: cntr-0
> FAIL: Intel: full-width writes: overflow: status-0
> FAIL: Intel: full-width writes: overflow: cntr-1
> FAIL: Intel: full-width writes: overflow: status-1
> FAIL: Intel: full-width writes: overflow: irq-1
> FAIL: Intel: full-width writes: overflow: cntr-2
> FAIL: Intel: full-width writes: overflow: status-2
> FAIL: Intel: full-width writes: overflow: cntr-3
> FAIL: Intel: full-width writes: overflow: status-3
> FAIL: Intel: full-width writes: overflow: irq-3
> FAIL: Intel: full-width writes: overflow: cntr-4
> FAIL: Intel: full-width writes: overflow: status-4

Hi Oliver,

What HW platform do you see this error on? If possible, could you please
apply the previously mentioned KUT/pmu patchset and check if the issue can
be fixed? Thanks.

Dapeng Mi

>
>
>> Thanks,
>> Kan
>>
>>> [32mPASS[0m pmu_lbr (3 tests)
>>> [33mSKIP[0m pmu_pebs (1 tests, 1 skipped)
>>> ...
>>>
>>>
>>>
>>> The kernel config and materials to reproduce are available at:
>>> https://download.01.org/0day-ci/archive/20240920/202409201525.4877023e-oliver.sang@intel.com
>>>
>>>
>>>
