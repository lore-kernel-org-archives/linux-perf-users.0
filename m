Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97EC27B32C;
	Thu, 16 Jul 2026 06:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784183397; cv=none; b=AxcyXr+x/FvhVFjtxadsYPd12fNzLY7X3mSYPAOsJD3QKjHldINFRGp3PLQPlnLqLwt5HUsvZV/Cb8u4vXV4eysV4mhSmK6meN+VO591YA0GTl9q5z6fXG2qAZCi6BKfWzvSJItqEuIZclyHSprz2y8l1oY4wRNnXuCgBQwPHi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784183397; c=relaxed/simple;
	bh=Ppg24Av3CVkqljIMwWSrDncgZ+24ul6xWu7dLksDBaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yemj696aCaSwcGt4rRKf4IFTv09P1o7e8Gcn/mYGNje7LnfWsFRg1qjBMbD8OAksETa4aSFoUXLD+gQ7Y64VU6kLHi7HHXWs/70qOt6ZzWGxo0ljc46/d8hz4KLOX9g0a0qxpHDOyYY09ZpTm1y9auOfDQ6mLF9xrJBImxScpBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHmy7hus; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHmy7hus"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784183396; x=1815719396;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ppg24Av3CVkqljIMwWSrDncgZ+24ul6xWu7dLksDBaE=;
  b=NHmy7husy4RlVb1kT/0SOm96RhufAA1bLGc1C2J+SPzKA4nr0k+IpIRN
   AC010abqWTB+Yo7nzgHLNZoefY4PUZFRPZYj9uwLB6goAY6akViE1g7at
   qoyyzAiCIB2DfUueZPLz3ESaw6vDMjPhwnXjYy61Z04CJGtIewSOGtL7i
   kcSOLAim+M3KWt8elYm320RuLYNIuHDjMIH/jbwPD+/ADYR7WUadNEOuU
   Dh07mpm2n7HMJKl11NEA7nrA62wamhy/ISTS2zE27W1VPCdPn6KMfDuNL
   tcKPC4HUDLyHlHsBI2ih4CAk2cEGpPvnQYQm+/MBJ6fnxk7VdEj3og8Uj
   w==;
X-CSE-ConnectionGUID: E88pDKTTQLOOmpT2pvR/bQ==
X-CSE-MsgGUID: 1k59ZzvDS6eU9KcOrCP1Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="110381481"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="110381481"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 23:29:55 -0700
X-CSE-ConnectionGUID: lWiLUVFdQYmCHOtDxyr9OA==
X-CSE-MsgGUID: 2INgkqReTiu+mgY7g+HXDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="251984828"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 23:29:53 -0700
Message-ID: <803bfea9-b16c-44d5-8004-096a92e90017@linux.intel.com>
Date: Thu, 16 Jul 2026 14:29:49 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:perf/core] [perf/core] 166f10836a:
 perf-sanity-tests.Object_code_reading.fail
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 linux-perf-users@vger.kernel.org
References: <202607091054.7c96d6c6-lkp@intel.com>
 <56069e78-7006-4569-add0-6ccdf88c746b@linux.intel.com>
 <alCwJew7UgGb+EQV@xsang-OptiPlex-9020>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <alCwJew7UgGb+EQV@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/10/2026 4:41 PM, Oliver Sang wrote:
> hi, Dapeng,
>
> On Thu, Jul 09, 2026 at 05:04:11PM +0800, Mi, Dapeng wrote:
>> Hi Oliver,
>>
>> It looks the direct reason causing the test case failure is the "0" sampled
>> IP. This is expected. The commit 166f10836a653dfa280d4335603b52f685b8b1ef
>> ("perf/core: Fix kernel register info leak via hardware skid") mitigates a
>> security hole and may lead to the sampled IP could be 0. 
>>
>> What user right is used to run this command, root or normal user? If it's a
> root user. as 'sudo' in attached:
>
> "2026-07-10 15:38:50 sudo ASAN_OPTIONS=fast_unwind_on_malloc=0 /usr/src/linux-perf-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf test 23 -vvv"
>
>> root user, suppose it should not generate such kind of error. Could you
>> please add "-vvv" option and rerun this test? The "-vvv" option would print
>> more  verbose log.
> as attached, thanks

"

  disabled                         1
  inherit                          1
  *exclude_kernel                   1*
  exclude_hv                       1
  mmap                             1

"

The event "exclude_kernel" attribute is set in the test case,  so it's
possible that perf overwrites the kernel IP to 0 to prevent kernel IP
leakage if PMI hits into kernel space. 

In general, the "exclude_kernel" attribute should not be set for root user,
I have no idea why "exclude_kernel" is set in this case.

Anyway, we could have to improve this test case and skip these "0" sample IPs.

Thanks.


>
>
>> Thanks!
>>
>> -Dapeng
>>
>>
>> On 7/9/2026 12:36 PM, kernel test robot wrote:
>>> Hello,
>>>
>>> kernel test robot noticed "perf-sanity-tests.Object_code_reading.fail" on:
>>>
>>> commit: 166f10836a653dfa280d4335603b52f685b8b1ef ("perf/core: Fix kernel register info leak via hardware skid")
>>> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git perf/core
>>>
>>>
>>> in testcase: perf-sanity-tests
>>> version: 
>>> with following parameters:
>>>
>>> 	perf_compiler: clang
>>> 	group: group-00
>>>
>>>
>>>
>>> config: x86_64-rhel-9.4-bpf
>>> compiler: gcc-14
>>> test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
>>>
>>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>>
>>>
>>>
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>>> | Closes: https://lore.kernel.org/oe-lkp/202607091054.7c96d6c6-lkp@intel.com
>>>
>>>
>>> 2026-07-07 00:10:32 sudo ASAN_OPTIONS=fast_unwind_on_malloc=0 /usr/src/linux-perf-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf test 23 -v
>>>  23: Object code reading                                 : Running (1 active)
>>> ---- start ----
>>> ...
>>> Bytes read match those read by objdump
>>> Reading object code for memory address: 0x7feb8f2134fa
>>> File is: /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
>>> On file address is: 0x204fa
>>> Objdump command is: objdump -z -d --start-address=0x204fa --stop-address=0x2057a /usr/lib/x86_64-linux-gnu/libgcc_s.so.1
>>> Bytes read match those read by objdump
>>> Reading object code for memory address: 0
>>> thread__find_map failed
>>> ---- end(-1) ----
>>>  23: Object code reading                                 : FAILED!
>>>
>>> === Test Summary ===
>>> Passed main tests : 0
>>> Passed subtests   : 0
>>> Skipped tests     : 0
>>> Failed tests      : 1
>>> List of failed tests:
>>>    23: Object code reading
>>>
>>>
>>>
>>> The kernel config and materials to reproduce are available at:
>>> https://download.01.org/0day-ci/archive/20260709/202607091054.7c96d6c6-lkp@intel.com
>>>
>>>
>>>
