Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B5A41754;
	Wed, 16 Sep 2026 00:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789517702; cv=none; b=rSkU2O2uw6gGYwnwNupraALxZFrgEZf65xRwINX+Z2wd+r0v1amyoh0p74hhgfstAkze/ilg/ZWPoaiMA7dzyXAck13Gakju258CtlqeuTrfSu0IgeSpmZW5QeJwtUz8UYqifn09MruoZ9wG6HBGB+SKdXtIjsnHqIc35FAqaJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789517702; c=relaxed/simple;
	bh=6wkzB37WCFKiZHUr29tzMDp7rsArxV0EsXrovr3/xAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AuFKO0Z0DvkZq9w4Xs8/7gFZalc4tKVqzI9NPGBvK2hZyziJF9mCFT7g2g/aORxNNq4Qzzo7E4j9OdVyJvXDiXRe7SscoAtrb/+L6ysHnyXiZVY38ha8t3y28pZdgEZMlE8G2xEUyjtN1PT3vyQkRamMaEI2tDNDbR/2RvEcF1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m3X7B1Da; arc=none smtp.client-ip=192.198.163.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3X7B1Da"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789517701; x=1821053701;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6wkzB37WCFKiZHUr29tzMDp7rsArxV0EsXrovr3/xAw=;
  b=m3X7B1DacrFYsMFof5eMqwWSDyFxFNY6+0AA+P90oZPFaVEPtkT6t/dy
   wHj+Zd7fHBp2nVrXrMa3Fc/wx2QcQJz6IIIZZgsOAYiGtn+cnmk0y530R
   knRHhSIFuOIVAGkTzX6ec20QiIFUrYgvEnsUDAPtVYGRCZ3imZadqvnZP
   J2y9lYW8lRnvNcSqf5+UgD2a15DIMRO9jq93HUSE+AV/FslQNDum1V0hF
   Gz4nUAnL6E1cd/KHNV7vUQndIApwtVzW2hJZam32LtZjJRx1N0BGuUQ5T
   f51g3aausJeEnVs1o5HIqWOU1plSM85hB5n8xMfbROfGpoHYkIAOP44Fq
   w==;
X-CSE-ConnectionGUID: FxtPbHw3QV+gkJwqLjuymg==
X-CSE-MsgGUID: 9VJ4PSBDT3y9PLq1O5E0Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="398264"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="398264"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 17:15:00 -0700
X-CSE-ConnectionGUID: aNMzMdNOSCC+JCU+KgCHrA==
X-CSE-MsgGUID: aNhXg/LeQWySfg1qHaCtvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1405878"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 17:14:56 -0700
Message-ID: <e812551f-8323-461e-a8ce-34551988f7c5@linux.intel.com>
Date: Wed, 16 Sep 2026 08:14:53 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/amd/uncore: turn amd_uncore_ctx events into a
 flexible array
To: Ian Rogers <irogers@google.com>, Rosen Penev <rosenp@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
References: <20260523011904.101720-1-rosenp@gmail.com>
 <CAP-5=fXyyj6w1mR71B6e+j7sV9GA-Gs1ibfp5pCuY6T+W+xWjQ@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fXyyj6w1mR71B6e+j7sV9GA-Gs1ibfp5pCuY6T+W+xWjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/16/2026 4:58 AM, Ian Rogers wrote:
> On Fri, May 22, 2026 at 6:19 PM Rosen Penev <rosenp@gmail.com> wrote:
>> The events pointer was kzalloc_node()'d immediately after the parent
>> struct allocation, with the count (pmu->num_counters) trivially
>> available beforehand.  Move events to the struct tail as a flexible
>> array member and fold the two allocations into a single kzalloc_node()
>> with struct_size(), dropping the separate kfree(ctx->events) in the
>> free path.
>>
>> Assisted-by: Claude:Opus-4.7
>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>> ---
>>  arch/x86/events/amd/uncore.c | 15 +++------------
>>  1 file changed, 3 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
>> index 05cff39968ec..0e265fc1fef8 100644
>> --- a/arch/x86/events/amd/uncore.c
>> +++ b/arch/x86/events/amd/uncore.c
>> @@ -39,11 +39,11 @@ static int pmu_version;
>>  struct amd_uncore_ctx {
>>         int refcnt;
>>         int cpu;
>> -       struct perf_event **events;
>>         unsigned long active_mask[BITS_TO_LONGS(NUM_COUNTERS_MAX)];
>>         int nr_active;
>>         struct hrtimer hrtimer;
>>         u64 hrtimer_duration;
>> +       struct perf_event *events[];
> As the number of counters is fixed and events doesn't grow, this makes
> sense to me. Dapeng, what do you think?
It looks good to me. But it seems there is no Sashikio review, so better
resend to trigger Sashiko review for double check. Thanks.


>
> Thanks,
> Ian
>
>>  };
>>
>>  struct amd_uncore_pmu {
>> @@ -488,10 +488,8 @@ static void amd_uncore_ctx_free(struct amd_uncore *uncore, unsigned int cpu)
>>                 if (cpu == ctx->cpu)
>>                         cpumask_clear_cpu(cpu, &pmu->active_mask);
>>
>> -               if (!--ctx->refcnt) {
>> -                       kfree(ctx->events);
>> +               if (!--ctx->refcnt)
>>                         kfree(ctx);
>> -               }
>>
>>                 *per_cpu_ptr(pmu->ctx, cpu) = NULL;
>>         }
>> @@ -536,18 +534,11 @@ static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
>>                 /* Allocate context if sibling does not exist */
>>                 if (!curr) {
>>                         node = cpu_to_node(cpu);
>> -                       curr = kzalloc_node(sizeof(*curr), GFP_KERNEL, node);
>> +                       curr = kzalloc_node(struct_size(curr, events, pmu->num_counters), GFP_KERNEL, node);
>>                         if (!curr)
>>                                 goto fail;
>>
>>                         curr->cpu = cpu;
>> -                       curr->events = kzalloc_node(sizeof(*curr->events) *
>> -                                                   pmu->num_counters,
>> -                                                   GFP_KERNEL, node);
>> -                       if (!curr->events) {
>> -                               kfree(curr);
>> -                               goto fail;
>> -                       }
>>
>>                         amd_uncore_init_hrtimer(curr);
>>                         curr->hrtimer_duration = (u64)update_interval * NSEC_PER_MSEC;
>> --
>> 2.54.0
>>
