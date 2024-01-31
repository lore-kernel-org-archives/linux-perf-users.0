Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C301272C2
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713310; cv=none; b=kbIj7XfaZeqe3bh3Wvhr0UfFaGIb3HOnMJTFIXSzNwh9yytpDmZSEtiBd7CaTYYgEgJvPJzrzswFz/0lXCFqst1jkCy8yA3NEm7Q8F0uYoUSJlrYEixOpa2xGny08ArIj0p1Sr7cHLkTj2vi/xOvf5LbsnPLeIe/UlclszH/aB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713310; c=relaxed/simple;
	bh=tEsrLmmVfTcxf/vA79DCGfUYsi1mcf02sZ2SB6iBMBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFppNpk3cgqj6OxxnLnNu/yssMviwho3voF2XbrBFdDx1QSmAGi1Q4D2RZ5Cd4+JL3CGk25T6CCt4LK2MsVmpQnwTYUIhjRYTMwbwE1KTzlwcc0qARGByDHpww46Hm3tXoZriP3MoYK2zTDGPQmapJwmY1M8IxMExH69QbCZ5IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ioeO+7ek; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ioeO+7ek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706713308; x=1738249308;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tEsrLmmVfTcxf/vA79DCGfUYsi1mcf02sZ2SB6iBMBo=;
  b=ioeO+7ekpON/Oevt83tdgGxpbToSiaIQNg1A2NkvPxbmq+xGaqeA/iDN
   hoLsFdsu6Od/aUENjuOVgfXp8qhxdX+vz6hLJ4k+cO2PNTUSockjIocSK
   06xtQVMqSrGa17x/QeYcqG3DaiUTSmPH0aLZ3Z9Xxq7XgVQDNr6iffjaW
   yLv8IuMaoel3cwHChKvcXMQ0fBnFiGqwAzCbRrLLRDNpuY44Z+I+IR9mM
   GshUqYvBDvwxF0Usqk4XTJP4YHrWSJqC1jtQ2aMkCicrfiPcxf+lBqr9K
   8miQ3jl8+0tROf1uRTlrUsBb2VG+T090iGIttXSd0VD5KZFwpRoYArhUC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10283049"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10283049"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 07:01:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="4085195"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 07:01:39 -0800
Received: from [10.212.91.97] (kliang2-mobl1.ccr.corp.intel.com [10.212.91.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id E4B8D580D25;
	Wed, 31 Jan 2024 07:01:38 -0800 (PST)
Message-ID: <285ee22e-7908-4486-95eb-474b30b7cc8b@linux.intel.com>
Date: Wed, 31 Jan 2024 10:01:37 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel Alderlake CPUID issue]
Content-Language: en-US
To: Ian Rogers <irogers@google.com>, Tingrun Chen <tchen168@asu.edu>,
 Kan Liang <kan.liang@intel.com>
Cc: linux-perf-users@vger.kernel.org, Ian Rogers <rogers.email@gmail.com>
References: <CAGjhMsg_bVKJ_zfsLUR32+oZwGDr3OiBHV_BJ3QtFjyKAs7Sgg@mail.gmail.com>
 <CAP-5=fW9M3U2U5UXd3QfTjMe=kSe=x1_GC3DW3Mg7HTyHy1atg@mail.gmail.com>
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fW9M3U2U5UXd3QfTjMe=kSe=x1_GC3DW3Mg7HTyHy1atg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-01-30 7:58 p.m., Ian Rogers wrote:
> On Tue, Jan 30, 2024 at 4:35 PM Tingrun Chen <tchen168@asu.edu> wrote:
>>
>> `perf test 7` fail on Alderlake virtual machine, The test is failing
>> as #system_tsc_freq has a zero value.Below is the output of `./perf
>> test 7 -vv`:
>> ```
>> Couldn't bump rlimit(MEMLOCK), failures may take place when creating
>> BPF maps, etc
>>   7: Simple expression parser                                        :
>> --- start ---
>> test child forked, pid 82095
>> Using CPUID GenuineIntel-6-BA-2
>> parsing metric: 1+1
>> parsing metric: FOO+BAR
>> lookup(FOO): val 1.000000
>> lookup(BAR): val 2.000000
>> parsing metric: (BAR/2)%2
>> lookup(BAR): val 2.000000
>> parsing metric: 1 - -4
>> parsing metric: (FOO-1)*2 + (BAR/2)%2 - -4
>> lookup(FOO): val 1.000000
>> lookup(BAR): val 2.000000
>> parsing metric: 1-1 | 1
>> parsing metric: 1-1 & 1
>> parsing metric: min(1,2) + 1
>> parsing metric: max(1,2) + 1
>> parsing metric: 1+1 if 3*4 else 0
>> parsing metric: 100 if 1 else 200 if 1 else 300
>> parsing metric: 100 if 0 else 200 if 1 else 300
>> parsing metric: 100 if 1 else 200 if 0 else 300
>> parsing metric: 100 if 0 else 200 if 0 else 300
>> parsing metric: 1.1 + 2.1
>> parsing metric: .1 + 2.
>> parsing metric: d_ratio(1, 2)
>> parsing metric: d_ratio(2.5, 0)
>> parsing metric: 1.1 < 2.2
>> parsing metric: 2.2 > 1.1
>> parsing metric: 1.1 < 1.1
>> parsing metric: 2.2 > 2.2
>> parsing metric: 2.2 < 1.1
>> parsing metric: 1.1 > 2.2
>> parsing metric: 1.1e10 < 1.1e100
>> parsing metric: 1.1e2 > 1.1e-2
>> parsing metric: FOO/0
>> lookup(FOO): val 1.000000
>> division by zero
>> parsing metric: BAR/
>> lookup(BAR): val 2.000000
>> syntax error
>> parsing metric: FOO + BAR + BAZ + BOZO
>> parsing metric: EVENT1\,param\=?@ + EVENT2\,param\=?@
>> parsing metric: dash\-event1 - dash\-event2
>> parsing metric: EVENT1 if #smt_on else EVENT2
>> literal: #smt_on = 0.000000
>> parsing metric: EVENT1 if #core_wide else EVENT2
>> literal: #core_wide = 0.000000
>> parsing metric: 1.0 if EVENT1 > 100.0 else 1.0
>> parsing metric: 0 & EVENT1 > 0
>> parsing metric: EVENT1 > 0 & 0
>> parsing metric: 1 & EVENT1 > 0
>> parsing metric: EVENT1 > 0 & 1
>> parsing metric: 1 | EVENT1 > 0
>> parsing metric: EVENT1 > 0 | 1
>> parsing metric: 0 | EVENT1 > 0
>> parsing metric: EVENT1 > 0 | 0
>> parsing metric: #num_cpus_online
>> literal: #num_cpus_online = 8.000000
>> parsing metric: #num_cpus
>> literal: #num_cpus = 8.000000
>> parsing metric: #num_cores
>> literal: #num_cores = 8.000000
>> parsing metric: #num_dies
>> literal: #num_dies = 1.000000
>> parsing metric: #num_packages
>> literal: #num_packages = 1.000000
>> parsing metric: #system_tsc_freq
>> Failed to find TSC frequency in /proc/cpuinfoliteral: #system_tsc_freq
>> = 0.000000
>> FAILED tests/expr.c:249 #system_tsc_freq > 0
>> test child finished with -1
>> ---- end ----
>> Simple expression parser: FAILED!
>> ```
>> The test can pass in my AlderLakephysical machine. So, in my physical
>> machine it seems that in the `arch_get_tsc_freq`
>> (https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/arch/x86/util/tsc.c?h=perf-tools-next)
>> function, the call to `get_cpuid_0` will read a valid value for lvl,
>> then it will calculate the tsc using the information directly from the
>> intel instruction `cpuid`; however, in the virtual machine, the lvl
>> will be less than 0x15, then it will fall back to read `/proc/cpuinfo`
>> and it does not contain something like `@ 3.0GHz`. Interestingly, the
>> `model name` entry of `/proc/cpuinfo` in both my physical machine and
>> the virtual machine does not contain the frequency information like `@
>> 3.0GHz`.
> 
> +Kan Liang
> 
> Thanks Tingrun,
> 
> IIRC the "@ 3.0GHz" parsing approach was for older machines that
> lacked the information in the cpuid. Could there be anything special
> in your virtual machine set up that will cause the cpuid to look older
> than it is? Kan, any thoughts and can we work around this?
> 

I don't have other way to get an accurate frequency.

Do you think it is worth introducing a way (e.g. terms) to let the end
user provide such information?
For this case, the freq information is not available.
In Weilin's TPEBS support, I think she is also looking for a way to set
the period.

Thanks,
Kan
