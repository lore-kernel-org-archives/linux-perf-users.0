Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3616540FDBE
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695880; cv=none; b=o6fyLjwRZJWfZcP1I7QIlmkgMNh0WcOG4oAM4XlLgp4AxZs6tDd0GcBw/qbG8i5bs2nRnSVTEfznjeeCXg81TikldqMcKVH58Dx+SxHxkrrHFU+Ts4nRsaXMVW2uCY3YrE/VJ9FcFdsvIfiwU/8ECGld2uR3T0UjbOPCGgH61qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695880; c=relaxed/simple;
	bh=K1wZov1t/gkoA9v3IOyz5ZysXGAZxCDPHIjGItZ+ld8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6WBLwkrC1DiNJmiMFg1LdcrvgGDjrPWD2TIYJIJzCdb8YWWxNdCwgvhp6YXY+IPHV1iOH/iqAqW/XJkTs/Bw2+kUw+c6iNabj9AcmGSgemnMiUbnCajpmYtN2m7Re//VACERVXPBgP/yCRWszivEA++F804oDKFM46cGptbs4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J9JDuyLF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9JDuyLF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778695879; x=1810231879;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K1wZov1t/gkoA9v3IOyz5ZysXGAZxCDPHIjGItZ+ld8=;
  b=J9JDuyLFsU8TxjyJP7hvmmHKNSNkiZh21Sz7N+GhbBXCjeroWWqWwFws
   wB9H5yrXAYiUxsbau0IBqA9D6FEdbCGg//6ygJmSgu0otCaOEg5AZwE0E
   YXCkdrzEf3nIkQwUh41BFHulKzN7H7HZYDI9yUAWB/j9qJsnM9HIWPnKI
   C8OnduZzjBpv7fQB2HSH3AnKafuIddlMglaxvzy++lQH+DSYFGWgmynkB
   I2R8XDOAoRKs3puunaMGuDhrfisk37By1VcQoXo+1YxA/OJ6/eBN6BLEw
   XOrjIHSLO66HIgQUjcItQDqIZiOx7A6GksJgDxb+HgZ0Tmyo1o6TzIpwf
   w==;
X-CSE-ConnectionGUID: b9r35TW5Q5myXsJ6WJx4DA==
X-CSE-MsgGUID: H6w373fFRmeu8CguEF/c9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="82199009"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="82199009"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 11:11:18 -0700
X-CSE-ConnectionGUID: ttVBAJfTTxipJ728fjRvPQ==
X-CSE-MsgGUID: aO0DGt8FTnWDsurqlNoigw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="231757781"
Received: from unknown (HELO [10.241.241.90]) ([10.241.241.90])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 11:11:18 -0700
Message-ID: <aefcf357-e0d8-46af-841d-be3e7742374b@intel.com>
Date: Wed, 13 May 2026 11:11:18 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] perf/x86/intel/uncore: Move die_to_cpu() to uncore.c
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260511230527.26096-5-zide.chen@intel.com>
 <20260513025843.939F7C2BCB0@smtp.kernel.org>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260513025843.939F7C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/2026 7:58 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Recursive `cpus_read_lock()` acquisition leads to deadlock when used by the planned initialization callback.
> --
> 
> commit d8b9d983f61a73e17f268ae570b5186a67f1a6ae
> Author: Zide Chen <zide.chen@intel.com>
> 
> perf/x86/intel/uncore: Move die_to_cpu() to uncore.c
> 
> This commit moves die_to_cpu() into uncore.c and renames it to
> uncore_die_to_cpu(). This change prepares the function to be reused by a
> planned MSR global initialization callback.
> 
>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>> index e9cc1ba921c5e..2bbe4cc1df3e2 100644
>> --- a/arch/x86/events/intel/uncore.c
>> +++ b/arch/x86/events/intel/uncore.c
> [ ... ]
>> @@ -83,6 +83,25 @@ int uncore_device_to_die(struct pci_dev *dev)
>>  	return -1;
>>  }
>>  
>> +int uncore_die_to_cpu(int die)
>> +{
>> +	int res = 0, cpu;
>> +
>> +	/*
>> +	 * Using cpus_read_lock() to ensure cpu is not going down between
>> +	 * looking at cpu_online_mask.
>> +	 */
>> +	cpus_read_lock();
> 
> Will the planned MSR global initialization callback already hold
> cpus_read_lock() when it calls this function?
> 
> If the initialization path (such as uncore_discovery_msr() calling into
> __parse_discovery_table()) already holds the lock, does acquiring it a
> second time here risk a lockdep warning or a deadlock?
> 
> Since cpus_read_lock() is backed by a percpu rwsem, a second read lock by
> the same thread can block if a writer (like CPU hotplug) is pending. Does
> this API need an unlocked variant for initialization paths, or should it
> rely on the caller to manage the lock entirely?

Yes, you are right. Seems the best option would be to remove the lock
from uncore_die_to_cpu(), and rely on callers to manage the lock.


> 
>> +	for_each_online_cpu(cpu) {
>> +		if (topology_logical_die_id(cpu) == die) {
>> +			res = cpu;
>> +			break;
>> +		}
>> +	}
>> +	cpus_read_unlock();
>> +	return res;
>> +}
> 

