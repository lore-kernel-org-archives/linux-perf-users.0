Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE4C288C0E;
	Thu, 20 Nov 2025 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763623863; cv=none; b=oVBkvApKI8+AiXF1DXWgyBMEzcEUYYgWJk4zrfag0H/LFtHv459TmRY5w+OTpUQE0O/gdchf4fZUW0hW+zo67X8FfyMA4Fsaw4J9+AJfsDbibKLTLQEPSI1hzP5g2GinP2Fu4E93JMHoil99e+ulUG7yWSvqqJ0vUpNAqy339pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763623863; c=relaxed/simple;
	bh=c4KmVSZfsFjqWHXfRbCp+0XrAXpO71IKASgpNLREERc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXmNfX0+xMpxsT1yLz7EmffhTN/yV9Vw5qnDzTzeAGkwmbtxW0Psr6AVAOybENk3n/yoT81r/02feav744xJMz1Jk9g2ct1Pu42B4suXwUpy3Gzp1WrUzQj6hOlmaGePXdwwZKKeXDptomucRbXXcCALMliW4QQlL4FHShQYa90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EIAhbaE8; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EIAhbaE8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763623861; x=1795159861;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c4KmVSZfsFjqWHXfRbCp+0XrAXpO71IKASgpNLREERc=;
  b=EIAhbaE8qevXFP/01HYPgiID49UrTFsETfU3kikJfta4UW61m3K3yozA
   4kcUn0++GQ6XSRNy7OvUeaN2fZo52BXBqUsW1hfhm56H7FabIo6ubZ7GA
   2usc6IR8jip5KIRJNwfwQHIOibT+G85ou6g4blmA9GWhwWgWQ2Y/n/yPP
   awKY0VngUh3zuugEPDmJfE+Jd5P/wj3ocB7WiIZjXJriJJVPAmeOrnOtF
   nFCQ3uWo7f5c/z+PXX2L4V3M9LmMA4o3CY/cPWl/18Gqy9jALtXyoCFcJ
   hFJWfECGPSLKq/OLVes/GduI2xv2UlwzcMyoHaquNabFPix57na7AEbMW
   A==;
X-CSE-ConnectionGUID: yqZsBa3IQ4O8CZHoWyl7Lg==
X-CSE-MsgGUID: /4pXC7Y6T9Ku4fPvjQnpPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="76290320"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="76290320"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 23:31:00 -0800
X-CSE-ConnectionGUID: mWg18Z9VSw25VoOHR4SVUw==
X-CSE-MsgGUID: dsP4cDp2QqKTeCZnFbwNlQ==
X-ExtLoop1: 1
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.213]) ([10.124.240.213])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 23:30:57 -0800
Message-ID: <24bc287a-a3e0-45f6-a8f1-20a34e2f9af2@linux.intel.com>
Date: Thu, 20 Nov 2025 15:30:54 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] perf/x86: Replace magic numbers with macros for
 attr_rdpmc
To: Ian Rogers <irogers@google.com>, Falcon Thomas <thomas.falcon@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20251120053431.491677-1-dapeng1.mi@linux.intel.com>
 <20251120053431.491677-7-dapeng1.mi@linux.intel.com>
 <CAP-5=fWOhG8XJwcyT1tYtVhLxp0m2kWG1oSeX6gKOmyJ=kOSpA@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fWOhG8XJwcyT1tYtVhLxp0m2kWG1oSeX6gKOmyJ=kOSpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 11/20/2025 2:19 PM, Ian Rogers wrote:
> On Wed, Nov 19, 2025 at 9:37 PM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>> Use macros to replace these attr_rdpmc magic numbers, so users are easy
>> to know their meaning.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> I'm reminded that we were having issues with rdpmc on hybrid:
> https://lore.kernel.org/lkml/20250614004528.1652860-1-irogers@google.com/
> like the enable/disable rdpmc flag being shared across the cpu_core
> and cpu_atom PMUs, and needing to force the thread doing the rdpmc to
> have affinity matching the CPUs of the PMU it is reading from, as
> otherwise things like struct perf_event_mmap_page's index could do
> interesting things:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/mmap-basic.c?h=perf-tools-next#n208
> Others required the rdpmc to be in a restartable sequence and Peter
> proposed fixing this in the kernel:
> https://lore.kernel.org/linux-perf-users/20250618084522.GE1613376@noisy.programming.kicks-ass.net/
>
> Also looks like we never merged fixing the documentation:
> https://lore.kernel.org/lkml/20220817174909.877139-1-irogers@google.com/
>
> Not specifically a DMR issue but this is reminding me of a bunch of
> tech debt - I also wonder if this patch requires the test being
> updated.

Thanks for reminding. This patch doesn't involve any functional change for
the "rdpmc" attribute, but along with the introduction of per-counter
"rdpmc user disable" in patch 7/7, the rdpmc test can definitely be
enhanced. I would enhance the rpdmc test in next version. 


>
> Thanks,
> Ian
>
>> ---
>>  arch/x86/events/core.c       | 7 ++++---
>>  arch/x86/events/intel/p6.c   | 2 +-
>>  arch/x86/events/perf_event.h | 7 +++++++
>>  3 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 5d0d5e466c62..3d9cc1d7fcfa 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -2129,7 +2129,8 @@ static int __init init_hw_perf_events(void)
>>
>>         pr_cont("%s PMU driver.\n", x86_pmu.name);
>>
>> -       x86_pmu.attr_rdpmc = 1; /* enable userspace RDPMC usage by default */
>> +       /* enable userspace RDPMC usage by default */
>> +       x86_pmu.attr_rdpmc = X86_USER_RDPMC_CONDITIONAL_ENABLE;
>>
>>         for (quirk = x86_pmu.quirks; quirk; quirk = quirk->next)
>>                 quirk->func();
>> @@ -2609,12 +2610,12 @@ static ssize_t set_attr_rdpmc(struct device *cdev,
>>                  */
>>                 if (val == 0)
>>                         static_branch_inc(&rdpmc_never_available_key);
>> -               else if (x86_pmu.attr_rdpmc == 0)
>> +               else if (x86_pmu.attr_rdpmc == X86_USER_RDPMC_NEVER_ENABLE)
>>                         static_branch_dec(&rdpmc_never_available_key);
>>
>>                 if (val == 2)
>>                         static_branch_inc(&rdpmc_always_available_key);
>> -               else if (x86_pmu.attr_rdpmc == 2)
>> +               else if (x86_pmu.attr_rdpmc == X86_USER_RDPMC_ALWAYS_ENABLE)
>>                         static_branch_dec(&rdpmc_always_available_key);
>>
>>                 on_each_cpu(cr4_update_pce, NULL, 1);
>> diff --git a/arch/x86/events/intel/p6.c b/arch/x86/events/intel/p6.c
>> index 6e41de355bd8..fb991e0ac614 100644
>> --- a/arch/x86/events/intel/p6.c
>> +++ b/arch/x86/events/intel/p6.c
>> @@ -243,7 +243,7 @@ static __init void p6_pmu_rdpmc_quirk(void)
>>                  */
>>                 pr_warn("Userspace RDPMC support disabled due to a CPU erratum\n");
>>                 x86_pmu.attr_rdpmc_broken = 1;
>> -               x86_pmu.attr_rdpmc = 0;
>> +               x86_pmu.attr_rdpmc = X86_USER_RDPMC_NEVER_ENABLE;
>>         }
>>  }
>>
>> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
>> index f7caabc5d487..24a81d2916e9 100644
>> --- a/arch/x86/events/perf_event.h
>> +++ b/arch/x86/events/perf_event.h
>> @@ -187,6 +187,13 @@ struct amd_nb {
>>          (1ULL << PERF_REG_X86_R14)   | \
>>          (1ULL << PERF_REG_X86_R15))
>>
>> +/* user space rdpmc control values */
>> +enum {
>> +       X86_USER_RDPMC_NEVER_ENABLE             = 0,
>> +       X86_USER_RDPMC_CONDITIONAL_ENABLE       = 1,
>> +       X86_USER_RDPMC_ALWAYS_ENABLE            = 2,
>> +};
>> +
>>  /*
>>   * Per register state.
>>   */
>> --
>> 2.34.1
>>
