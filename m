Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6F21494C3;
	Tue, 13 Jan 2026 02:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768272579; cv=none; b=nRHB29+GKRK+hKXA+Czk1NeCgF4AxJBBXa7sJAtpfZUMSXv033fm+eSDts6uLueML4S1t+/szXniBCQhcwn3RrKpRfMTTYyEXGpP/If3QUESaDzhOEy9+3wLgA6m3z4FHxYcQcOKT7E3ms6023Q28WqvIsrROQm/U7eii78DOak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768272579; c=relaxed/simple;
	bh=LziKRr1HyWSNxER+lVNHIduaygVqbX3NGCXHDdZrxrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRa39RroDIoGh/AHnaieRJvbJ8KMIhzDAwdCz3j5c2Hb6W2XetFuEY/tUgtZETt+L3PPNaLKM2pMcQcLWqMlMfwdsZ5gd6b5Whmnr7aqOSM2WERNF0WVbGhEa4Jy30sZR/LbeVfQR75b96dhpIdD9EuM1Ark6J7+ARnMYU9Gs3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTftyDKS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTftyDKS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768272577; x=1799808577;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LziKRr1HyWSNxER+lVNHIduaygVqbX3NGCXHDdZrxrA=;
  b=UTftyDKS9grMbnTHUq3yc2Xyuap9JZ4/bP7tlhtj21ozJDOi6Ikpqbhx
   9OWEZPvcVZGL/XzmdEGYSIGG6/7AjdouBR3ywaqQwlw/pjQdKgWiHuPeM
   YOnlqXmcHqjhdCZbvJ0Z9Oy+wGkW/p2GnKs1IBd6vwCSduTUALHP7N2hU
   /IcVLfhu2R0twtYbkYQh0DEbTTO1IH10cy7djf3/rLXbgpQ0MreOtyAv+
   HSsaQ0NVgMMmAdJV4F4QW/ihbWebQ2bLbM7oexJ1U0vqDZwTufGuPmpdY
   49wdjILEzJcq9sR7/hi6jn2+N2TKbb0UjUhQJLimNadOyr1NxdIH1aGVt
   Q==;
X-CSE-ConnectionGUID: 09b5ryUtRbSZ0b74yIDQmg==
X-CSE-MsgGUID: CMAZ0xVpRrOwdVe+G/FwvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="95030196"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="95030196"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 18:49:36 -0800
X-CSE-ConnectionGUID: U/2AT/pFQN6hc4OqQ3uEHg==
X-CSE-MsgGUID: ckmVKKnwQ/Ojhigiy8k3Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="235503305"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 18:49:32 -0800
Message-ID: <a7367c65-9289-4abb-8836-f0705bc12df4@linux.intel.com>
Date: Tue, 13 Jan 2026 10:49:30 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 7/7] perf/x86/intel: Add support for rdpmc user disable
 feature
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260112051649.1113435-1-dapeng1.mi@linux.intel.com>
 <20260112051649.1113435-8-dapeng1.mi@linux.intel.com>
 <CAP-5=fXE02soq4z0ZjuPYQZTH9bkfrMXqe1nT9A7EcgG0cH6yw@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fXE02soq4z0ZjuPYQZTH9bkfrMXqe1nT9A7EcgG0cH6yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/13/2026 9:49 AM, Ian Rogers wrote:
> On Sun, Jan 11, 2026 at 9:20 PM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
>> Starting with Panther Cove, the rdpmc user disable feature is supported.
>> This feature allows the perf system to disable user space rdpmc reads at
>> the counter level.
>>
>> Currently, when a global counter is active, any user with rdpmc rights
>> can read it, even if perf access permissions forbid it (e.g., disallow
>> reading ring 0 counters). The rdpmc user disable feature mitigates this
>> security concern.
>>
>> Details:
>>
>> - A new RDPMC_USR_DISABLE bit (bit 37) in each EVNTSELx MSR indicates
>>   that the GP counter cannot be read by RDPMC in ring 3.
>> - New RDPMC_USR_DISABLE bits in IA32_FIXED_CTR_CTRL MSR (bits 33, 37,
>>   41, 45, etc.) for fixed counters 0, 1, 2, 3, etc.
>> - When calling rdpmc instruction for counter x, the following pseudo
>>   code demonstrates how the counter value is obtained:
>>         If (!CPL0 && RDPMC_USR_DISABLE[x] == 1) ? 0 : counter_value;
>> - RDPMC_USR_DISABLE is enumerated by CPUID.0x23.0.EBX[2].
>>
>> This patch extends the current global user space rdpmc control logic via
>> the sysfs interface (/sys/devices/cpu/rdpmc) as follows:
>>
>> - rdpmc = 0:
>>   Global user space rdpmc and counter-level user space rdpmc for all
>>   counters are both disabled.
>> - rdpmc = 1:
>>   Global user space rdpmc is enabled during the mmap-enabled time window,
>>   and counter-level user space rdpmc is enabled only for non-system-wide
>>   events. This prevents counter data leaks as count data is cleared
>>   during context switches.
>> - rdpmc = 2:
>>   Global user space rdpmc and counter-level user space rdpmc for all
>>   counters are enabled unconditionally.
>>
>> The new rdpmc settings only affect newly activated perf events; currently
>> active perf events remain unaffected. This simplifies and cleans up the
>> code. The default value of rdpmc remains unchanged at 1.
>>
>> For more details about rdpmc user disable, please refer to chapter 15
>> "RDPMC USER DISABLE" in ISE documentation.
>>
>> ISE: https://www.intel.com/content/www/us/en/content-details/869288/intel-architecture-instruction-set-extensions-programming-reference.html
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  .../sysfs-bus-event_source-devices-rdpmc      | 40 +++++++++++++++++++
>>  arch/x86/events/core.c                        | 21 ++++++++++
>>  arch/x86/events/intel/core.c                  | 26 ++++++++++++
>>  arch/x86/events/perf_event.h                  |  6 +++
>>  arch/x86/include/asm/perf_event.h             |  8 +++-
>>  5 files changed, 99 insertions(+), 2 deletions(-)
>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc b/Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc
>> new file mode 100644
>> index 000000000000..d004527ab13e
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-rdpmc
>> @@ -0,0 +1,40 @@
>> +What:           /sys/bus/event_source/devices/cpu.../rdpmc
>> +Date:           November 2011
>> +KernelVersion:  3.10
>> +Contact:        Linux kernel mailing list linux-kernel@vger.kernel.org
>> +Description:    The /sys/bus/event_source/devices/cpu.../rdpmc attribute
>> +                is used to show/manage if rdpmc instruction can be
>> +                executed in user space. This attribute supports 3 numbers.
>> +                - rdpmc = 0
>> +                user space rdpmc is globally disabled for all PMU
>> +                counters.
>> +                - rdpmc = 1
>> +                user space rdpmc is globally enabled only in event mmap
>> +                ioctl called time window. If the mmap region is unmapped,
>> +                user space rdpmc is disabled again.
>> +                - rdpmc = 2
>> +                user space rdpmc is globally enabled for all PMU
>> +                counters.
> Fwiw, I found it surprising in the test:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/tests/mmap-basic.c?h=perf-tools-next#n375
> that the enable/disable of rdpmc on cpu_atom affected cpu_core and
> vice-versa. Perhaps the docs could mention this.

Yes, currently the rdpmc attribute is implemented as global attribute in
x86 PMU driver even for the hybrid platform. I suppose it's fine and
reasonable since there could be no such real requirement to set different
rdpmc attribute on hybrid platforms.

Sure. I would add words to mention this.


>
> Also fwiw, I remember Peter's proposal to improve rdpmc so that
> restartable sequences or CPU affinities aren't necessary on hybrid
> machines by handling faults in the kernel:
> https://lore.kernel.org/linux-perf-users/20250618084522.GE1613376@noisy.programming.kicks-ass.net/
> which imo would be a welcome addition. Perhaps without that fix we can
> document the affinity/rseq needs.

I would create an independent patch for Peter's proposal and post it to
upstream for review. Actually it has been in my to-do list, I'm just always
interrupted by other higher priority things. Thanks.


>
> Thanks,
> Ian
>
>> +
>> +                In the Intel platforms supporting counter level's user
>> +                space rdpmc disable feature (CPUID.23H.EBX[2] = 1), the
>> +                meaning of 3 numbers is extended to
>> +                - rdpmc = 0
>> +                global user space rdpmc and counter level's user space
>> +                rdpmc of all counters are both disabled.
>> +                - rdpmc = 1
>> +                No changes on behavior of global user space rdpmc.
>> +                counter level's rdpmc of system-wide events is disabled
>> +                but counter level's rdpmc of non-system-wide events is
>> +                enabled.
>> +                - rdpmc = 2
>> +                global user space rdpmc and counter level's user space
>> +                rdpmc of all counters are both enabled unconditionally.
>> +
>> +                The default value of rdpmc is 1.
>> +
>> +                Please notice global user space rdpmc's behavior would
>> +                change immediately along with the rdpmc value's change,
>> +                but the behavior of counter level's user space rdpmc
>> +                won't take effect immediately until the event is
>> +                reactivated or recreated.
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index c2717cb5034f..6df73e8398cd 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -2616,6 +2616,27 @@ static ssize_t get_attr_rdpmc(struct device *cdev,
>>         return snprintf(buf, 40, "%d\n", x86_pmu.attr_rdpmc);
>>  }
>>
>> +/*
>> + * Behaviors of rdpmc value:
>> + * - rdpmc = 0
>> + *    global user space rdpmc and counter level's user space rdpmc of all
>> + *    counters are both disabled.
>> + * - rdpmc = 1
>> + *    global user space rdpmc is enabled in mmap enabled time window and
>> + *    counter level's user space rdpmc is enabled for only non system-wide
>> + *    events. Counter level's user space rdpmc of system-wide events is
>> + *    still disabled by default. This won't introduce counter data leak for
>> + *    non system-wide events since their count data would be cleared when
>> + *    context switches.
>> + * - rdpmc = 2
>> + *    global user space rdpmc and counter level's user space rdpmc of all
>> + *    counters are enabled unconditionally.
>> + *
>> + * Suppose the rdpmc value won't be changed frequently, don't dynamically
>> + * reschedule events to make the new rpdmc value take effect on active perf
>> + * events immediately, the new rdpmc value would only impact the new
>> + * activated perf events. This makes code simpler and cleaner.
>> + */
>>  static ssize_t set_attr_rdpmc(struct device *cdev,
>>                               struct device_attribute *attr,
>>                               const char *buf, size_t count)
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index dd488a095f33..77cf849a1381 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -3128,6 +3128,8 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
>>                 bits |= INTEL_FIXED_0_USER;
>>         if (hwc->config & ARCH_PERFMON_EVENTSEL_OS)
>>                 bits |= INTEL_FIXED_0_KERNEL;
>> +       if (hwc->config & ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE)
>> +               bits |= INTEL_FIXED_0_RDPMC_USER_DISABLE;
>>
>>         /*
>>          * ANY bit is supported in v3 and up
>> @@ -3263,6 +3265,26 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
>>                 __intel_pmu_update_event_ext(hwc->idx, ext);
>>  }
>>
>> +static void intel_pmu_update_rdpmc_user_disable(struct perf_event *event)
>> +{
>> +       /*
>> +        * Counter scope's user-space rdpmc is disabled by default
>> +        * except two cases.
>> +        * a. rdpmc = 2 (user space rdpmc enabled unconditionally)
>> +        * b. rdpmc = 1 and the event is not a system-wide event.
>> +        *    The count of non-system-wide events would be cleared when
>> +        *    context switches, so no count data is leaked.
>> +        */
>> +       if (x86_pmu_has_rdpmc_user_disable(event->pmu)) {
>> +               if (x86_pmu.attr_rdpmc == X86_USER_RDPMC_ALWAYS_ENABLE ||
>> +                   (x86_pmu.attr_rdpmc == X86_USER_RDPMC_CONDITIONAL_ENABLE &&
>> +                    event->ctx->task))
>> +                       event->hw.config &= ~ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
>> +               else
>> +                       event->hw.config |= ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
>> +       }
>> +}
>> +
>>  DEFINE_STATIC_CALL_NULL(intel_pmu_enable_event_ext, intel_pmu_enable_event_ext);
>>
>>  static void intel_pmu_enable_event(struct perf_event *event)
>> @@ -3271,6 +3293,8 @@ static void intel_pmu_enable_event(struct perf_event *event)
>>         struct hw_perf_event *hwc = &event->hw;
>>         int idx = hwc->idx;
>>
>> +       intel_pmu_update_rdpmc_user_disable(event);
>> +
>>         if (unlikely(event->attr.precise_ip))
>>                 static_call(x86_pmu_pebs_enable)(event);
>>
>> @@ -5863,6 +5887,8 @@ static void update_pmu_cap(struct pmu *pmu)
>>                 hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_UMASK2;
>>         if (ebx_0.split.eq)
>>                 hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_EQ;
>> +       if (ebx_0.split.rdpmc_user_disable)
>> +               hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE;
>>
>>         if (eax_0.split.cntr_subleaf) {
>>                 cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
>> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
>> index 24a81d2916e9..cd337f3ffd01 100644
>> --- a/arch/x86/events/perf_event.h
>> +++ b/arch/x86/events/perf_event.h
>> @@ -1333,6 +1333,12 @@ static inline u64 x86_pmu_get_event_config(struct perf_event *event)
>>         return event->attr.config & hybrid(event->pmu, config_mask);
>>  }
>>
>> +static inline bool x86_pmu_has_rdpmc_user_disable(struct pmu *pmu)
>> +{
>> +       return !!(hybrid(pmu, config_mask) &
>> +                ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE);
>> +}
>> +
>>  extern struct event_constraint emptyconstraint;
>>
>>  extern struct event_constraint unconstrained;
>> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
>> index 0d9af4135e0a..ff5acb8b199b 100644
>> --- a/arch/x86/include/asm/perf_event.h
>> +++ b/arch/x86/include/asm/perf_event.h
>> @@ -33,6 +33,7 @@
>>  #define ARCH_PERFMON_EVENTSEL_CMASK                    0xFF000000ULL
>>  #define ARCH_PERFMON_EVENTSEL_BR_CNTR                  (1ULL << 35)
>>  #define ARCH_PERFMON_EVENTSEL_EQ                       (1ULL << 36)
>> +#define ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE       (1ULL << 37)
>>  #define ARCH_PERFMON_EVENTSEL_UMASK2                   (0xFFULL << 40)
>>
>>  #define INTEL_FIXED_BITS_STRIDE                        4
>> @@ -40,6 +41,7 @@
>>  #define INTEL_FIXED_0_USER                             (1ULL << 1)
>>  #define INTEL_FIXED_0_ANYTHREAD                        (1ULL << 2)
>>  #define INTEL_FIXED_0_ENABLE_PMI                       (1ULL << 3)
>> +#define INTEL_FIXED_0_RDPMC_USER_DISABLE               (1ULL << 33)
>>  #define INTEL_FIXED_3_METRICS_CLEAR                    (1ULL << 2)
>>
>>  #define HSW_IN_TX                                      (1ULL << 32)
>> @@ -50,7 +52,7 @@
>>  #define INTEL_FIXED_BITS_MASK                                  \
>>         (INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER |            \
>>          INTEL_FIXED_0_ANYTHREAD | INTEL_FIXED_0_ENABLE_PMI |   \
>> -        ICL_FIXED_0_ADAPTIVE)
>> +        ICL_FIXED_0_ADAPTIVE | INTEL_FIXED_0_RDPMC_USER_DISABLE)
>>
>>  #define intel_fixed_bits_by_idx(_idx, _bits)                   \
>>         ((_bits) << ((_idx) * INTEL_FIXED_BITS_STRIDE))
>> @@ -226,7 +228,9 @@ union cpuid35_ebx {
>>                 unsigned int    umask2:1;
>>                 /* EQ-bit Supported */
>>                 unsigned int    eq:1;
>> -               unsigned int    reserved:30;
>> +               /* rdpmc user disable Supported */
>> +               unsigned int    rdpmc_user_disable:1;
>> +               unsigned int    reserved:29;
>>         } split;
>>         unsigned int            full;
>>  };
>> --
>> 2.34.1
>>
