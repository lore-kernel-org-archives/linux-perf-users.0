Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE3F11CAF;
	Tue, 24 Sep 2024 03:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727147806; cv=none; b=uDs91RUtdPZtvZqpNAFJ9BncCuhNb7Saii5GH2dQ1y6VkYqk6svtW9PgAeTQ70Bh+ooaI/RTj4hIL8RCY/79bCizkb2+HISI4fV71uwYU4f475xuBqB+Ohd2KtYIEy2F/bWFeJmaOuFRNwMrXF7KMho7ZKViMn9vMUrwaZb2bOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727147806; c=relaxed/simple;
	bh=2mDjUtYT3nhH15SjrQEMq299lS31ef3rK5oxMVeP7TE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpbcSYSkUSckbjctVKPG+Mo9kaXNfQDTd4JHrG3nH6bAcaopbqYkOpfTrlKA6Q8Gt+Pv5cjhc82PMlNJ/0JgSDONrP/prWOs+n2BlNQfpXoLzaMRRKnVapmXNkE8ySd9N2lgft4qCAHDU5iAuyznHrCgjW9mG7kPdwtwKJrR15M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bDx8Xax7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bDx8Xax7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727147805; x=1758683805;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2mDjUtYT3nhH15SjrQEMq299lS31ef3rK5oxMVeP7TE=;
  b=bDx8Xax7/hK6Ipx/8Um5kPA+BuBx1eh4ng2JO4MhXvCvzh7RyhtLPy7i
   doz7bM/OEqZXE8phCHWXXLfAA/nKXta9nfgDM5eilQiKK8JFl/HplpS0L
   yUe/LYf3ZWKZsc+Mz7UjZX0rB52yTRyXZSYzrbuTNHt5YJFzZL8DIf2Zo
   Irahfnz+HK+AvHMTKociXNAH3n1PyyKsnPRpOtGhiVf0AsPWJyVBVMgOz
   i5+IfxUO9c23hq1kqVAZNA1FADXQyah4yH/EHC2l8yR1Vgt0JkYpHUb32
   BCeMzLx/OEsjF8GdybY9RJ+ZfepRCwg7UGupROpEWxDpEQMcHwE6JMy8T
   Q==;
X-CSE-ConnectionGUID: mtV7pZYZSnW5sugM2gfzaA==
X-CSE-MsgGUID: RsFnxDj3RiGWAsb5/tXVNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26314452"
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="26314452"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 20:16:44 -0700
X-CSE-ConnectionGUID: ITs2l1jZRYi57OHlh3J7uw==
X-CSE-MsgGUID: uhM6XM67SuSAGBtpL5iqIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,253,1719903600"; 
   d="scan'208";a="71707538"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 20:16:41 -0700
Message-ID: <625485ea-d76c-4d27-b72b-f3d4c6f484b1@linux.intel.com>
Date: Tue, 24 Sep 2024 11:16:39 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [perf/x86/intel] 25dfc9e357:
 kvm-unit-tests-qemu.pmu.fail
To: Oliver Sang <oliver.sang@intel.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Li Huafei <lihuafei1@huawei.com>,
 linux-perf-users@vger.kernel.org
References: <202409201525.4877023e-oliver.sang@intel.com>
 <f272389f-8565-4bdc-8727-8b37eaa82821@linux.intel.com>
 <ZvDvB98DW10Au8lo@xsang-OptiPlex-9020>
 <196706e4-e892-4e73-8ba7-1fa939d8998b@linux.intel.com>
 <ZvIoDCpLW6kX8pFw@xsang-OptiPlex-9020>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <ZvIoDCpLW6kX8pFw@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/24/2024 10:46 AM, Oliver Sang wrote:
> hi, Dapeng Mi,
>
> On Tue, Sep 24, 2024 at 10:17:17AM +0800, Mi, Dapeng wrote:
>> On 9/23/2024 12:31 PM, Oliver Sang wrote:
>>> hi, Kan,
>>>
>>> On Fri, Sep 20, 2024 at 09:27:06AM -0400, Liang, Kan wrote:
>>>
>>>>> ...
>>>>> [32mPASS[0m msr (1836 tests)
>>>>> [31mFAIL[0m pmu (143 tests, 24 unexpected failures, 14 skipped)  <---
>>>> Is there a list to show which checks are failed?
>>> I attached a pmu.log.
>>>
>>> below failed which can pass on parent (v6.11-rc5)
>>>
>>> FAIL: Intel: overflow: cntr-0
>>> FAIL: Intel: overflow: status-0
>>> FAIL: Intel: overflow: cntr-1
>>> FAIL: Intel: overflow: status-1
>>> FAIL: Intel: overflow: irq-1
>>> FAIL: Intel: overflow: cntr-2
>>> FAIL: Intel: overflow: status-2
>>> FAIL: Intel: overflow: cntr-3
>>> FAIL: Intel: overflow: status-3
>>> FAIL: Intel: overflow: irq-3
>>> FAIL: Intel: overflow: cntr-4
>>> FAIL: Intel: overflow: status-4
>>> FAIL: Intel: full-width writes: overflow: cntr-0
>>> FAIL: Intel: full-width writes: overflow: status-0
>>> FAIL: Intel: full-width writes: overflow: cntr-1
>>> FAIL: Intel: full-width writes: overflow: status-1
>>> FAIL: Intel: full-width writes: overflow: irq-1
>>> FAIL: Intel: full-width writes: overflow: cntr-2
>>> FAIL: Intel: full-width writes: overflow: status-2
>>> FAIL: Intel: full-width writes: overflow: cntr-3
>>> FAIL: Intel: full-width writes: overflow: status-3
>>> FAIL: Intel: full-width writes: overflow: irq-3
>>> FAIL: Intel: full-width writes: overflow: cntr-4
>>> FAIL: Intel: full-width writes: overflow: status-4
>> Hi Oliver,
>>
>> What HW platform do you see this error on? 
> it's on a Haswell desktop
> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 16G memory
>
>> If possible, could you please
>> apply the previously mentioned KUT/pmu patchset and check if the issue can
>> be fixed? Thanks.
> do you have a repo/branch? unfortunately, our bot failed to fetch this
> patch-set.

Please try this branch.
https://github.com/intel-sandbox/dapengmi-kvm-unit-tests/commits/main/


>
>> Dapeng Mi
>>
>>>
>>>> Thanks,
>>>> Kan
>>>>
>>>>> [32mPASS[0m pmu_lbr (3 tests)
>>>>> [33mSKIP[0m pmu_pebs (1 tests, 1 skipped)
>>>>> ...
>>>>>
>>>>>
>>>>>
>>>>> The kernel config and materials to reproduce are available at:
>>>>> https://download.01.org/0day-ci/archive/20240920/202409201525.4877023e-oliver.sang@intel.com
>>>>>
>>>>>
>>>>>
