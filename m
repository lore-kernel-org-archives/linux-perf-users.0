Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8A0635;
	Mon, 23 Sep 2024 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727059805; cv=none; b=GzZ6NFPLfrtSQ1YZZV0d0CwsgtgAQMII1cvu0vmq+Es8L/70pWY0dG5lz3b6cgJtBqLscgnAtUcnXz9fBdtb07eya46heBGIpWZHYDKfCCjJ2oWtYA9Jgo47SV59CaXoq8hEngu2Jd44Dxh772XZth5i5c+v8MSf8dS8CIF4dSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727059805; c=relaxed/simple;
	bh=AbIUhT1ZYYeN9aZe2dqiL8aSYxV9m/x9TOPe0ZPOAmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7KThnrHXKgKxGszSF1TBVODEV/BwBLZPeVhycVAcV7ysyv4PYvC4CXbUl6u9vWjT97RLt2xtX/3O45Lc0kCoVwC58aEevU7gJ1jSNfpU4hCRadvAS42k8wmyY0gQzvRyt9vrMY9OYZ0afq7KQyxb6SJJWPk5aMQiugcYu/KsiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cf2rPPzG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cf2rPPzG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727059803; x=1758595803;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AbIUhT1ZYYeN9aZe2dqiL8aSYxV9m/x9TOPe0ZPOAmk=;
  b=Cf2rPPzG/xU6UXvreQZEvLbpSXFikrH5mqbIHJIFjayA+it1YBvyi5ky
   jv7B1ioja1Ruv87lFYL76eG8R1munzr2lVIdL9xCj1mO21Wvdt+DL3G65
   28u3n29a2JbHhllkrQ9rsaLymX1BwZe/3ucTbpB6iddbYAQs1y1HYX91q
   jlpI8pKE4fB//DJ3N0EzVG7HLV7T43l4dxApVG3YUQ3PJ/NdcPhd9rTZw
   PsSAwk+wqxFdjXApVFKrq2y4JEwJ+NhCacFOVL31LnS3N349kLzuXM4FY
   6DvjMq9qa2Zzoa6sptM3910Sxe8qymslxGrAvnAzNii0YrP7C84zfN8Su
   g==;
X-CSE-ConnectionGUID: XJmRGypeQ2mfXPxI6cAyIA==
X-CSE-MsgGUID: Z6a7SmZkRVeXP/aPmXKSfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="36653083"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="36653083"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 19:50:03 -0700
X-CSE-ConnectionGUID: ZC1uPhShSxes3TqMIof39g==
X-CSE-MsgGUID: fegKci+3T1a7PzGCwm6lVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="70956908"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.231.84]) ([10.124.231.84])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 19:50:01 -0700
Message-ID: <61d6d709-209a-432a-94ee-e999c50c847e@linux.intel.com>
Date: Mon, 23 Sep 2024 10:49:58 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [perf/x86/intel] 25dfc9e357:
 kvm-unit-tests-qemu.pmu.fail
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Li Huafei <lihuafei1@huawei.com>,
 linux-perf-users@vger.kernel.org
References: <202409201525.4877023e-oliver.sang@intel.com>
 <f272389f-8565-4bdc-8727-8b37eaa82821@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <f272389f-8565-4bdc-8727-8b37eaa82821@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/20/2024 9:27 PM, Liang, Kan wrote:
>
> On 2024-09-20 3:50 a.m., kernel test robot wrote:
>>
>> Hello,
>>
>> kernel test robot noticed "kvm-unit-tests-qemu.pmu.fail" on:
>>
>> commit: 25dfc9e357af8aed1ca79b318a73f2c59c1f0b2b ("perf/x86/intel: Limit the period on Haswell")
> This should only impact the period wrote to a counter.
> There is no functional change.
>
> As far as I know, the kvm-unit-tests-qemu.pmu directly manipulates the
> counters. It should not be impacted by the perf changes. That's weird.

We found KUT/pmu test cases could cause many false positives, especially on
some new Platforms, like SPR/EMR. We already have a patch series to fix
these false positives, but unfortunately it's still not merged.

Here is the patch series link. Thanks.

https://lore.kernel.org/all/20240914101728.33148-1-dapeng1.mi@linux.intel.com/


>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> [test failed on linus/master      3352633ce6b221d64bf40644d412d9670e7d56e3]
>> [test failed on linux-next/master 5acd9952f95fb4b7da6d09a3be39195a80845eb6]
>>
>> in testcase: kvm-unit-tests-qemu
>> version: 
>> with following parameters:
>>
>>
>>
>>
>> compiler: gcc-12
>> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 16G memory
>>
>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>
>>
>>
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>> | Closes: https://lore.kernel.org/oe-lkp/202409201525.4877023e-oliver.sang@intel.com
>>
>>
>> ...
>> [32mPASS[0m msr (1836 tests)
>> [31mFAIL[0m pmu (143 tests, 24 unexpected failures, 14 skipped)  <---
> Is there a list to show which checks are failed?
>
> Thanks,
> Kan
>
>> [32mPASS[0m pmu_lbr (3 tests)
>> [33mSKIP[0m pmu_pebs (1 tests, 1 skipped)
>> ...
>>
>>
>>
>> The kernel config and materials to reproduce are available at:
>> https://download.01.org/0day-ci/archive/20240920/202409201525.4877023e-oliver.sang@intel.com
>>
>>
>>
