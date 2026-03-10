Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D23385501;
	Tue, 10 Mar 2026 03:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773112507; cv=none; b=uULLJidsDGptd3v9qGVaxYXepJJqbE2Holeuk66EEBt8jsZW3q5AdnxMb42aETvmVElwqosUefGeLBxkpKwhy61GZqwDIakDorVU0T+arrSm5ml2/wNYDneI5fdJyf3dpy68u254LRFbFcQKtex59rvG5ysFeEUXs6VSjOL/WX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773112507; c=relaxed/simple;
	bh=86ARgFq2p56WQNTTnEAZrjZzVach4hbNI1Uvn+qifhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqQl4qV24w2iGLeGhYgC/FQNc3fiIXUP1xtMGNLvlwNM+JH/a3hQALykZN6KtM4oNoHBCnnhQEwg1X0tkVtrBkIpjMLitlVzQ1ksPGfRRZfKk4/We80ygsRteYvUSPsb78fPcaTDJneNDccPaVJBf6crSYrFaYz+HlvWjisDuuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=miGhnOvX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="miGhnOvX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773112506; x=1804648506;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=86ARgFq2p56WQNTTnEAZrjZzVach4hbNI1Uvn+qifhs=;
  b=miGhnOvXixfdecHuS53v1DuTVGUo4w2/+aWnwvz0ASqKg0wbg3vS223R
   xXnUuel++rll2Rlkg0weToIM67lhxD6k7WUSyJKTGyZMCaYucq6MegES2
   kwkvGh5aXJ2V3n2TJ6XrgpwmllC6A6zYyzXPrzGg6Py6LGKjyjAKaCDaD
   0G8O1K/U14gzDazQ2Q5O1VgFuxgm8OKrPBvxVOpPsz1giv1KCtrBc8skP
   FyR4P/YBS+zzFAzsgntSYHz0T9bdoqd3SBx6zGwh4gpGwp/L+EwEKAoFE
   lsYMh0REgUX/N+ecgoE6rYYf4Wj+Ovu4QzSMctxCaL54h67Qfi/qTq3tQ
   w==;
X-CSE-ConnectionGUID: 4tH5OujBSYufRQHzyAw9ew==
X-CSE-MsgGUID: p4UfW6jSSjG/6VVi6CEJ1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="99618354"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="99618354"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 20:15:05 -0700
X-CSE-ConnectionGUID: TlNsJQJMQK2DAEs4n/dIpg==
X-CSE-MsgGUID: FqM43x2WSuKGbutTyqLOtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="250421441"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 20:15:02 -0700
Message-ID: <d8069f73-594c-46da-8c8a-5f7a13731057@linux.intel.com>
Date: Tue, 10 Mar 2026 11:14:58 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 6/7] perf/x86: Use macros to replace magic numbers in
 attr_rdpmc
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260114011750.350569-1-dapeng1.mi@linux.intel.com>
 <20260114011750.350569-7-dapeng1.mi@linux.intel.com>
 <CAP-5=fVSbYX9qV7NOrfkH7GyFRBXjkfgc34sv8FkioPgY9xQ4Q@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fVSbYX9qV7NOrfkH7GyFRBXjkfgc34sv8FkioPgY9xQ4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/10/2026 7:56 AM, Ian Rogers wrote:
> On Tue, Jan 13, 2026 at 5:22 PM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>> Replace magic numbers in attr_rdpmc with macros to improve readability
>> and make their meanings clearer for users.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/core.c       | 7 ++++---
>>  arch/x86/events/intel/p6.c   | 2 +-
>>  arch/x86/events/perf_event.h | 7 +++++++
>>  3 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 0ecac9495d74..c2717cb5034f 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -2163,7 +2163,8 @@ static int __init init_hw_perf_events(void)
>>
>>         pr_cont("%s PMU driver.\n", x86_pmu.name);
>>
>> -       x86_pmu.attr_rdpmc = 1; /* enable userspace RDPMC usage by default */
>> +       /* enable userspace RDPMC usage by default */
>> +       x86_pmu.attr_rdpmc = X86_USER_RDPMC_CONDITIONAL_ENABLE;
>>
>>         for (quirk = x86_pmu.quirks; quirk; quirk = quirk->next)
>>                 quirk->func();
>> @@ -2643,12 +2644,12 @@ static ssize_t set_attr_rdpmc(struct device *cdev,
>>                  */
>>                 if (val == 0)
> nit: Could 0 here be X86_USER_RDPMC_NEVER_ENABLE to eliminate even
> more magic numbers?

IMO, the "val" directly comes from user, we'd better keep it as the hard
coded number, then readers would be easy to know which values would be
mapped to "X86_USER_RDPMC_NEVER_ENABLE",  "X86_USER_RDPMC_ALWAYS_ENABLE" or
"X86_USER_RDPMC_CONDITIONAL_ENABLE". They are not 1:1 mapped. Thanks.


>
>>                         static_branch_inc(&rdpmc_never_available_key);
>> -               else if (x86_pmu.attr_rdpmc == 0)
>> +               else if (x86_pmu.attr_rdpmc == X86_USER_RDPMC_NEVER_ENABLE)
>>                         static_branch_dec(&rdpmc_never_available_key);
>>
>>                 if (val == 2)
> Similarly could 2 be X86_USER_RDPMC_ALWAYS_ENABLE ?
>
> Thanks,
> Ian
>
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
