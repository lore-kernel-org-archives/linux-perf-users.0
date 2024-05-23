Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6997F21362
	for <linux-perf-users@vger.kernel.org>; Thu, 23 May 2024 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716485534; cv=none; b=D5OvVj/qqObtv3HkE0yzhqZVHmB+BzwBQ8LnOFZ+2GdN7iL+94ifNoJJ+Db4d68e+SZc4HmSqS7NMtcHfpIcbQIyrpQ57dbPn4q1satkCY2lXHO6HMz61AA0KnOkqJi6HlglPm0OkH9zoYoqhiNL2z9vA9QhQf0WtsG6vcQT9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716485534; c=relaxed/simple;
	bh=JGELT4GAlvIGoSXcSJObuP1ej3kWqRB9sPzBM0PZdU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMzm3C3TH446Np2qyyFFEaQpsF0zdLrM0XISb7S/mhRkxs72WlrUY4wj46/r80xSE2SdSwZ2+Ip/5twcIHPzH1zHnZUVo0HCuFP2oy45jbdXEtN8cH4nwCEErcXNWjF5H3KLheoA2cuR8NmO+S76telXkFFGs9THvFSb5TXOS6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kq+rAnt5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kq+rAnt5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716485532; x=1748021532;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JGELT4GAlvIGoSXcSJObuP1ej3kWqRB9sPzBM0PZdU0=;
  b=kq+rAnt55qd5FKQHN8I9tfKKRTk4SD1vUS3UlM7kw9NvxD5x8I9N/s12
   u6b55K8dXPRwwtQJBcyQY9xMFGs8O+7fj+3ZGmJ0CPxYB1ORvpxP5x7Ce
   oIVuOvpb784N6IIYKWupaa5edJ0TWQWwUAhKBXaYrfM3+tlGUXOrvPyEW
   m7DyXzoRrVLRtIoI9oErL3ZrgdaTM+2FjxCSLWAs+Mf5qFa6rdEp+Hh1X
   uKKKq6913WlE/9cCA1A4BDIpwydxHTyh7A9IJ5HgJX4nHX7TH13HfVJz8
   LTOmBCPFd5eE58XSsZBkNCyNIxfGIklgV2cdRc0qY9DdETzX9QCKSx+Ou
   Q==;
X-CSE-ConnectionGUID: XfgGif0vTnyQz1jdBSQdmA==
X-CSE-MsgGUID: gpVw7pn3QcG2V5c/e0z4iA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12699105"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="12699105"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 10:31:59 -0700
X-CSE-ConnectionGUID: VSNfZtJdSBO7Zy531S1N+g==
X-CSE-MsgGUID: 1pPcFfpRSlyOgLNAMAzSbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="33805707"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 10:31:50 -0700
Received: from [10.212.23.66] (kliang2-mobl1.ccr.corp.intel.com [10.212.23.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 71E5F20BF42F;
	Thu, 23 May 2024 10:31:49 -0700 (PDT)
Message-ID: <a7674df8-4597-4797-8a0d-30f183ddfa49@linux.intel.com>
Date: Thu, 23 May 2024 13:31:48 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: perf stat VERSUS perf stat report :: TopDown Metrics
To: Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org
Cc: vmolnaro@redhat.com, irogers@google.com, acme@redhat.com,
 ak@linux.intel.com, alexander.shishkin@linux.intel.com
References: <alpine.LRH.2.20.2405211842450.4040@Diego>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <alpine.LRH.2.20.2405211842450.4040@Diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-05-21 12:54 p.m., Michael Petlan wrote:
> Hello!
> 
> I have a test for perf-stat record/report functionality, which compares the outputs,
> basically whether `perf stat report` is able to reconstruct the same results as
> printed by `perf stat`. In the Intel environments with TopDown events/metrics, the
> test started failing on the fact that perf-stat-report has a different approach to
> handle the metrics:
> 
> ================================ perf stat ================================
>  Performance counter stats for 'ls':
> 
>               0.69 msec task-clock                   #    0.477 CPUs utilized
>                  0      context-switches             #    0.000 /sec
>                  0      cpu-migrations               #    0.000 /sec
>                 97      page-faults                  #  139.648 K/sec
>          1,776,212      cycles                       #    2.557 GHz
>          1,970,435      instructions                 #    1.11  insn per cycle
>            403,140      branches                     #  580.389 M/sec
>             11,837      branch-misses                #    2.94% of all branches
>                         TopdownL1             #     30.0 %  tma_backend_bound
>                                               #     13.0 %  tma_bad_speculation
>                                               #     37.5 %  tma_frontend_bound
>                                               #     19.5 %  tma_retiring
>                         TopdownL2             #     12.1 %  tma_branch_mispredicts
>                                               #     11.7 %  tma_core_bound
>                                               #     13.2 %  tma_fetch_bandwidth
>                                               #     24.3 %  tma_fetch_latency
>                                               #      3.1 %  tma_heavy_operations
>                                               #     16.3 %  tma_light_operations
>                                               #      1.0 %  tma_machine_clears
>                                               #     18.3 %  tma_memory_bound
> 
>        0.001456908 seconds time elapsed
> 
>        0.000000000 seconds user
>        0.001647000 seconds sys
> 
> ================================ perf stat report ================================
>  Performance counter stats for '/usr/bin/perf stat record ls':
> 
>               0.69 msec task-clock                   #    0.477 CPUs utilized
>                  0      context-switches             #    0.000 /sec
>                  0      cpu-migrations               #    0.000 /sec
>                 97      page-faults                  #  139.648 K/sec
>          1,776,212      cycles                       #    2.557 GHz
>          1,970,435      instructions                 #    1.11  insn per cycle
>            403,140      branches                     #  580.389 M/sec
>             11,837      branch-misses                #    2.94% of all branches
>         10,657,272      TOPDOWN.SLOTS
>          2,089,661      topdown-retiring
>          4,053,942      topdown-fe-bound
>          1,964,281      topdown-mem-bound
>          3,218,078      topdown-be-bound
>            334,345      topdown-heavy-ops
>          1,295,589      topdown-br-mispredict
>          2,632,973      topdown-fetch-lat
>          1,379,176      topdown-bad-spec
>             21,248      INT_MISC.UOP_DROPPING        #   30.590 M/sec
> 
>        0.001456908 seconds time elapsed
> 
> While perf-stat (and perf-stat-record) calculates the percentages, perf-stat-report
> just prints the raw numbers. Thinking about it, it might be useful to know the raw
> numbers too, but rather via an option, while by default, both should behave the same,
> shouldn't they? Is perf-stat-report missing some metric postprocessing?

The perf-stat-record/report doesn't support the metrics well. It only
records the value based on the events. So all the metrics lost.


$ ./perf stat record -M cpi sleep 1

 Performance counter stats for 'sleep 1':

           183,590      INST_RETIRED.ANY:u               #      2.3
per_instr  cpi
           429,375      CPU_CLK_UNHALTED.THREAD:u


$ ./perf stat report

 Performance counter stats for 'perf stat record -M cpi sleep 1':

           183,590      INST_RETIRED.ANY:u
           429,375      CPU_CLK_UNHALTED.THREAD:u


To fix it, we need to record the metrics information as well. I will
take a look.

Thanks,
Kan
