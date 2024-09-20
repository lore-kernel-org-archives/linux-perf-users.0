Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B006178389;
	Fri, 20 Sep 2024 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726838844; cv=none; b=HJqbTFsoTghCh3lyqxPKk6OuH1dKKAR2U06z+OUidyKFKAVV59t5JhDC4u1zZmUYZp9Q/uRBW1qJ1crdBzltXsPH73au7zN8xgC0WVojyWcULXsYJxsaAmNXdm4KslXT8PNNxYv6aUd59nLr8IZRmFrPajUP1SK+q/IenHhp+uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726838844; c=relaxed/simple;
	bh=LYEE/zr6wLjOcu2JkhVIn/gWreP6z04OK3f05Gg5LVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnhcYYMysLD80ZZ5W0xOyuSgM0qJTN+lbCrCfOPXQDBDMvqt2qWksoO6uUpWu/Miz+HeQyRZxiu3QovPeGwhcZuZFOryFhYwkFOz6Fo6f8FlZeYwICD+XCVQLAELALCIwZxGxaiYlEEOQl9+HNqXghzr3B0iZHelBpaaC4aQc5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJJr55ah; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJJr55ah"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726838844; x=1758374844;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LYEE/zr6wLjOcu2JkhVIn/gWreP6z04OK3f05Gg5LVA=;
  b=FJJr55ahxYhiCQiMaNkK18FVYh+PgXjl1Jn+YH84yCR4G9I58jgf9uSe
   SfAF75Q7S2wI9k4SqO9D9I2/S4vxlwpwO8API58sNo7/HQAE4vyg0fmzf
   9j8+dFvo8NMR5vuV1Txnb0H9manR8g2w7kvDMqh/2wRNbL5F+PmAHaP/A
   JemrkpUBMBOYDdqHbg1trZgToJIl60hUEeI46KvmyovJzCoOhcE2QiBLe
   /AVPEBmy4Z2Mvw/DMUhuYKV+XYS1NKa1Fb0J4FheYVDqgUEDmnPBakEoi
   0I4GHE0YKqiYeGxkrFWvtpRaBANPKuBmWiurODLmYtXv/gK8YAlcKgJVy
   w==;
X-CSE-ConnectionGUID: drsqKVkzS0qNXNe7QhZC/A==
X-CSE-MsgGUID: fijCuG3gReSoJh6RdS8CAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="36413058"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="36413058"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 06:27:23 -0700
X-CSE-ConnectionGUID: CWckwsKtSyei4zvUz2uf7A==
X-CSE-MsgGUID: eWmXfWp9QW62WLDPy1KeYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="101128249"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 06:27:09 -0700
Received: from [10.212.23.107] (kliang2-mobl1.ccr.corp.intel.com [10.212.23.107])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 200A820CFEE3;
	Fri, 20 Sep 2024 06:27:08 -0700 (PDT)
Message-ID: <f272389f-8565-4bdc-8727-8b37eaa82821@linux.intel.com>
Date: Fri, 20 Sep 2024 09:27:06 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [perf/x86/intel] 25dfc9e357:
 kvm-unit-tests-qemu.pmu.fail
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Li Huafei <lihuafei1@huawei.com>,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <202409201525.4877023e-oliver.sang@intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <202409201525.4877023e-oliver.sang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-20 3:50 a.m., kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "kvm-unit-tests-qemu.pmu.fail" on:
> 
> commit: 25dfc9e357af8aed1ca79b318a73f2c59c1f0b2b ("perf/x86/intel: Limit the period on Haswell")

This should only impact the period wrote to a counter.
There is no functional change.

As far as I know, the kvm-unit-tests-qemu.pmu directly manipulates the
counters. It should not be impacted by the perf changes. That's weird.

> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master      3352633ce6b221d64bf40644d412d9670e7d56e3]
> [test failed on linux-next/master 5acd9952f95fb4b7da6d09a3be39195a80845eb6]
> 
> in testcase: kvm-unit-tests-qemu
> version: 
> with following parameters:
> 
> 
> 
> 
> compiler: gcc-12
> test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz (Haswell) with 16G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202409201525.4877023e-oliver.sang@intel.com
> 
> 
> ...
> [32mPASS[0m msr (1836 tests)
> [31mFAIL[0m pmu (143 tests, 24 unexpected failures, 14 skipped)  <---

Is there a list to show which checks are failed?

Thanks,
Kan

> [32mPASS[0m pmu_lbr (3 tests)
> [33mSKIP[0m pmu_pebs (1 tests, 1 skipped)
> ...
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240920/202409201525.4877023e-oliver.sang@intel.com
> 
> 
> 
