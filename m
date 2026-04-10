Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EF32512DE;
	Fri, 10 Apr 2026 02:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775787867; cv=none; b=uY+paFozPSBkN3CF3/Tljv4LBGJJoKgO0tJ9DO9qG/dcK1qUsvmGWvRoy9LxtCDjoPOLgr0qRCwzzpzL68oltnL1qatVNtXqI8yeJFNV+x4XXoErPLwp00vaws++hArWMGCmTyS9d0aeLVm1YK7gHfsO+7hKVBnAUKyLiciH/n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775787867; c=relaxed/simple;
	bh=y+4VSElaJ1TZCntzJsyVuay2NBcRgx3/d9EbLO8mbWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gg+F3uMWIR1oGjjwZCbiHsjtvbiKJbD/4uOIE7Y55dzvJ0MZGV2zBPDvgdkQlapp2A8Y0VLyN0KNLJPLUxTm5NlEmSolj+OSSeiE4lPX7oIvFfsoIzu2R8T+2iJuNtlLWozXdUfWcH7tUem27ett45XZ8yujMvO25xChnWOI9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mumbh1c3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mumbh1c3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775787865; x=1807323865;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=y+4VSElaJ1TZCntzJsyVuay2NBcRgx3/d9EbLO8mbWA=;
  b=Mumbh1c3v0tOy0+79KmnAGHFQEHSNTvukCUBsOcaoegxTuNjXbaDQdsC
   eD+4ceHK57XRw5t61GPnoGUJnkWrsa4nGea2PDHWOiZxZgaXIjitjUY4w
   g1erGRDKVhxTFzwAuxyP4xMKumYJPxB3vcIYlETekn7LAt3z6LFTMKDz7
   Wa7yX6VhO7y/np9i+ArWepoAtoh7nFtGubmxjIVnOLxAHqj4cp9IrlgKD
   90U2eWccOH3JEX9nim7Q0g7c2wHACAasT0Z+6Y8VXf8TdAXFzmjX3GHJh
   87usPZTUXD1NLTaPmZUuDZpmdSn6m1Uc7Gr+2C55Tr8pVF+QlHfwsK44s
   A==;
X-CSE-ConnectionGUID: +FrxKgZkRcCHrDrZy6xbUQ==
X-CSE-MsgGUID: d7wON5lhTVK6DDF9uV9Dug==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76681258"
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="76681258"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 19:24:24 -0700
X-CSE-ConnectionGUID: CaFQWVfHT7WrUiecIvXP0g==
X-CSE-MsgGUID: YxJ0XffQR4+g0jj+D5we+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,170,1770624000"; 
   d="scan'208";a="233035295"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 19:24:19 -0700
Message-ID: <3824da20-f3e5-4db2-bfb8-b49d57ed38cc@linux.intel.com>
Date: Fri, 10 Apr 2026 10:24:15 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: Don't update PEBS_ENABLE MSR in NMI
 context
To: Jim Mattson <jmattson@google.com>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, Mingwei Zhang <mizhang@google.com>,
 Peter Zijlstra <peterz@infradead.org>
References: <20260320152928.1916447-1-jmattson@google.com>
 <CALMp9eQh37Mxb3qvFWnYNTUiUBdSnRMsPdqgMdQD3XpC1HOs+w@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CALMp9eQh37Mxb3qvFWnYNTUiUBdSnRMsPdqgMdQD3XpC1HOs+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/21/2026 2:58 AM, Jim Mattson wrote:
> On Fri, Mar 20, 2026 at 8:29 AM Jim Mattson <jmattson@google.com> wrote:
>> Writing MSR_IA32_PEBS_ENABLE in handle_pmi_common() when a PEBS event is
>> throttled is problematic for KVM, which may have an older value for the MSR
>> (previously obtained via perf_guest_get_msrs()) stored in the VM-exit
>> MSR-load list.
>>
>> It isn't necessary to update the MSR in the PMI handler, because the
>> throttled counter's PerfEvtSel ENABLE bit has been cleared, so its
>> PEBS_ENABLE bit is irrelevant. However, the MSR must be updated before the
>> stale bit becomes relevant again (i.e. when the PMC starts counting a new
>> perf event).
>>
>> When the PEBS_ENABLE MSR is rendered stale in the PMI handler, just record
>> that fact in a new cpu_hw_events boolean, pebs_stale.  Extend
>> intel_pmu_pebs_enable_all() to write MSR_IA32_PEBS_ENABLE when pebs_stale
>> is set and to clear pebs_stale.  This ensures stale bits are cleared
>> during the normal PMU enable path, before PERF_GLOBAL_CTRL is restored and
>> any new event can start counting.
>>
>> Signed-off-by: Jim Mattson <jmattson@google.com>
>> ---
>>  arch/x86/events/intel/core.c | 28 ++++++++++++++++++++++------
>>  arch/x86/events/intel/ds.c   |  4 +++-
>>  arch/x86/events/perf_event.h |  1 +
>>  3 files changed, 26 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index cf3a4fe06ff2..3b0173d25232 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -3548,14 +3548,26 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>>                 static_call(x86_pmu_drain_pebs)(regs, &data);
>>
>>                 /*
>> -                * PMI throttle may be triggered, which stops the PEBS event.
>> -                * Although cpuc->pebs_enabled is updated accordingly, the
>> -                * MSR_IA32_PEBS_ENABLE is not updated. Because the
>> -                * cpuc->enabled has been forced to 0 in PMI.
>> -                * Update the MSR if pebs_enabled is changed.
>> +                * PMI throttling may be triggered, which stops the PEBS
>> +                * event.  Although cpuc->pebs_enabled was updated
>> +                * accordingly, MSR_IA32_PEBS_ENABLE has not been updated.
>> +                *
>> +                * The MSR must not be updated in NMI context, because KVM
>> +                * may be in a critical region on its way to VM-entry, with
>> +                * the now-stale MSR value stored in the VM-exit MSR-load
>> +                * list.  On VM-exit, the CPU will restore the stale value.

Hmm, that looks like a race condition between KVM and PMI handler. Suppose
the issue could only happen in the legacy perf-based vPMU enabled case,
right? For the mediated vPMU, the host events would be rescheduled on each
VM-exit and the MSR_IA32_PEBS_ENABLE MSR would be always written. 


>> +                *
>> +                * Deferring the MSR update is harmless because the
>> +                * throttled event's PerfEvtSel ENABLE bit has been
>> +                * cleared, so the stale PEBS_ENABLE bit is irrelevant for
>> +                * now.
>> +                *
>> +                * Track when MSR_IA32_PEBS_ENABLE is stale, so that
>> +                * pebs_enable_all() will write cpuc->pebs_enabled to the
>> +                * MSR, even when cpuc->pebs_enabled is 0.
>>                  */
>>                 if (pebs_enabled != cpuc->pebs_enabled)
>> -                       wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
>> +                       cpuc->pebs_stale = true;

Deferring the MSR_IA32_PEBS_ENABLE writing would cause a mismatch between
the value of MSR_IA32_PEBS_ENABLE and cpuc->pebs_enabled until
intel_pmu_pebs_enable_all() is called again. But suppose it would be fine
since the event has been stopped and intel_pmu_pebs_enable_all() would be
called in next unthrottle.


>>
>>                 /*
>>                  * Above PEBS handler (PEBS counters snapshotting) has updated fixed
>> @@ -4978,6 +4990,10 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>   * These values have nothing to do with the emulated values the guest sees
>>   * when it uses {RD,WR}MSR, which should be handled by the KVM context,
>>   * specifically in the intel_pmu_{get,set}_msr().
>> + *
>> + * Note that MSRs returned from this function must not be modified in NMI
>> + * context. Doing so could result in a stale host value being restored at
>> + * the next VM-exit.
>>   */
>>  static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>>  {
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index 5027afc97b65..852baf6a05e9 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -1982,8 +1982,10 @@ void intel_pmu_pebs_enable_all(void)
>>  {
>>         struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>
>> -       if (cpuc->pebs_enabled)
>> +       if (cpuc->pebs_enabled || cpuc->pebs_stale)
>>                 wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
>> +
>> +       cpuc->pebs_stale = false;

Sashiko comments

"

Can this race with an NMI?
If a PMI fires exactly between wrmsrq() and cpuc->pebs_stale = false:
CPU0
intel_pmu_pebs_enable_all()
    wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
    
    <--- NMI (PMI) fires here
    handle_pmi_common()
        ... throttles event ...
        cpuc->pebs_stale = true;
    <--- NMI returns
    
    cpuc->pebs_stale = false;
Would this clobber the pebs_stale flag set by the NMI, leaving the software
state desynchronized from the hardware MSR and potentially causing the PMU
to skip the MSR update on the next enable?

"

It looks reasonable.
https://sashiko.dev/#/patchset/20260320152928.1916447-1-jmattson%40google.com

Thanks.


>>  }
>>
>>  void intel_pmu_pebs_disable_all(void)
>> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
>> index fad87d3c8b2c..22102296e31b 100644
>> --- a/arch/x86/events/perf_event.h
>> +++ b/arch/x86/events/perf_event.h
>> @@ -298,6 +298,7 @@ struct cpu_hw_events {
>>         /* DS based PEBS or arch-PEBS buffer address */
>>         void                    *pebs_vaddr;
>>         u64                     pebs_enabled;
>> +       bool                    pebs_stale;
>>         int                     n_pebs;
>>         int                     n_large_pebs;
>>         int                     n_pebs_via_pt;
>> --
>> 2.53.0.959.g497ff81fa9-goog
>>
> Apologies. Resend to fix Peter Zijlstra's address.
>
