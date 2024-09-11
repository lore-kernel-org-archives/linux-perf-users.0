Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134A31A76D2;
	Wed, 11 Sep 2024 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065323; cv=none; b=OE7UYFka9cEE0mcfKriOJytoSpj9BbloFiugGsdXnlzTFaNE8krNDe2x2tK07KTAuF7UmOEBaxGaN3FeOqzgWi4jkdJFOZ/KOWBeYXVq2KmDwKHGGRv21DvdAHI8eMo9RL0ASH1M7L0XIuqNGh4Wi25DbzipawIMFOW5wmQXjLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065323; c=relaxed/simple;
	bh=zZVJ/jn55FdYP64LtELXOS80f+yzBjWduO1V5u3oLxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqBFKVMX6DZWGV3ij6RWJtIp/66rpkqtj02P7QdEi6R5zW1UuHYGMQ5aPR0NtWm0vIbpiwIIr2Mb2/DU4gemncRD58rVsOHEdX7UPtVYYCO0MqH1SNfkimZn3uwdnOad2tNqJAJg5xFvHcY9ZUxtRLK3OaxUlR8cRUdy/1yBF4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGrHBvHW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGrHBvHW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726065322; x=1757601322;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zZVJ/jn55FdYP64LtELXOS80f+yzBjWduO1V5u3oLxk=;
  b=mGrHBvHWqTW1Klm/iS0SzIaEATh33WObPAwKyL0SpFMxyZzmPRe4kNNe
   csGzswMih8HG5X578/P56KDkV8svqogNWn03R2nkXHuowCpQAXEN5OKeX
   Mtb4t+ftu+kQ1gxtw9FFrF99X/vgaSgDUzSJ1gHmoaACdHvL00Ui2rUQu
   9FDtuElGAdRNLE98UQnqxzRkcuswTD/p/moFql495mv+fln9Lrci+kd1T
   04UQ6yUsib+yDNUH2XZVX7G/TaPrMZ0wKYysYG05bPhLMe0H7jXENv2+C
   t5JMQc58UJCgFpER/C4YFtE2LSP13U0IYIeqTbWh+fjPaEk1n9w7z1rOT
   A==;
X-CSE-ConnectionGUID: oLixXibFTp+abo+Vn2wPfw==
X-CSE-MsgGUID: ibbiAeM7SXumME4jPZT/1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="42384881"
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="42384881"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 07:35:21 -0700
X-CSE-ConnectionGUID: 9NB8H6ayTn6Q2ECakrgXog==
X-CSE-MsgGUID: WVpFtfsPR6CVhSVVGDJIEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="67327019"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 07:35:21 -0700
Received: from [10.212.119.193] (kliang2-mobl1.ccr.corp.intel.com [10.212.119.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 8698620CFED7;
	Wed, 11 Sep 2024 07:35:20 -0700 (PDT)
Message-ID: <7730b925-eb2c-4908-9c48-e016701f2901@linux.intel.com>
Date: Wed, 11 Sep 2024 10:35:19 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [peterz-queue:perf/core] [perf/x86/rapl] 90942140bb:
 UBSAN:array-index-out-of-bounds_in_arch/x86/events/rapl.c
To: Peter Zijlstra <peterz@infradead.org>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <202409111521.c7c6d56f-lkp@intel.com>
 <20240911094536.GP4723@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240911094536.GP4723@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-11 5:45 a.m., Peter Zijlstra wrote:
> On Wed, Sep 11, 2024 at 04:32:13PM +0800, kernel test robot wrote:
>>
>>
>> Hello,
>>
>> kernel test robot noticed "UBSAN:array-index-out-of-bounds_in_arch/x86/events/rapl.c" on:
>>
>> commit: 90942140bb6cc7e9a41d5927c7617ee522896f7a ("perf/x86/rapl: Move the pmu allocation out of CPU hotplug")
>> https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git perf/core
>>
>> in testcase: boot
>>
>> compiler: clang-18
>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>>
>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>
>>
>> +-----------------------------------------------------------+------------+------------+
>> |                                                           | c206df6d69 | 90942140bb |
>> +-----------------------------------------------------------+------------+------------+
>> | UBSAN:array-index-out-of-bounds_in_arch/x86/events/rapl.c | 0          | 12         |
>> +-----------------------------------------------------------+------------+------------+
>>
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>> | Closes: https://lore.kernel.org/oe-lkp/202409111521.c7c6d56f-lkp@intel.com
>>
>>
>> [   22.115286][    T1] ------------[ cut here ]------------
>> [   22.115957][    T1] UBSAN: array-index-out-of-bounds in arch/x86/events/rapl.c:685:3
> 
> That is:
> 
> 		rapl_pmus->pmus[topology_logical_die_id(cpu)] = pmu;
> 
> Which is scaled like:
> 
> 	int nr_rapl_pmu = topology_max_packages() * topology_max_dies_per_package();
> 
> And that isn't new in that patch, just moved around.
>

The error commit is still the old one which doesn't include the fix of
the issue reported by Dhananjay.
https://lore.kernel.org/lkml/88fa2064-c054-4833-872c-0cf5ff1e3609@amd.com/

I think it should be the same issue.

> Kan, as it happens these two patches got zapped by Ingo because they
> conflict with that rapl patch from perf/urgent and he merged perf/urgent
> into perf/core.
> 
> I was going to rebase these two patches on top, but given the above, can
> you have a look instead?
> 
> 

Sure, I will work with Oliver on the issue, and resend the patch to
support rapl.

Thanks,
Kan
