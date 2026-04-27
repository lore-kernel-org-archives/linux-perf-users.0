Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5C62DF701;
	Mon, 27 Apr 2026 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777255837; cv=none; b=X0II83NFpRqXLPLNcmACluA+tsf4TBpWfE+SK5MJo6fjZ9ZkOfbuK9So36Fo+5LBXB3EdVrIt3qmFomKQPhuUBwzOkUz4w/3TpWY5SCIz4cdllfRZxeQr8DgGlpMPVfjM08qzn0ZeFrnrck8uyz2kDKipM8TK1LuawTvBMe4UjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777255837; c=relaxed/simple;
	bh=DR5pMDkSCapO1aeFcDbRHkg8YcDCImWpoJpxEP0aM7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEGlesabV6FJBGtaaSkwX7yzVZHmMuH+8fhT3eQxdgiecgZy1hw0u1lwHqz94BCXxGLlWdZHXub+g3Szu8w3b+r207u0cjQ77AjeAChowMyPt5wfOeh7qLDaMCd7Fv3vlEqOo4pR9bUS+ZEDlX6RG2jHk2m81XkuD9wTJfMS5r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BlJ4/1Uj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlJ4/1Uj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777255835; x=1808791835;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DR5pMDkSCapO1aeFcDbRHkg8YcDCImWpoJpxEP0aM7k=;
  b=BlJ4/1UjRoxvlteUmzjFIkMT/cLBB9iSy51leLQo1zmPRsVdhe8B6n9a
   keBqYuGTNV7CAQJWKBReD97eGrKT792AUH0aFEUCtox8ehLOg6XI0TOXN
   FhPxcvA3zARI414hOQ1+PxHGcwPAeqA8NLSzcPqUcezM9o91QL2rysWaz
   y+CBlK7fInY7SbWfDucL0vMk7K1NvVIFHsc1zAaSWe6Kj8WgdAQkV3QUU
   kB6iYDjNtTd/jq4axHl2COOfRNt4ZTKP5TlUV1SmYYfS6OdOnKwdcGngC
   xcxfv1XnT2fdXrJbcWkXAZfPcE+rcEsxMZyu3J5yvhTE+WcGz5WYAaKnS
   Q==;
X-CSE-ConnectionGUID: 6vKmCvRZQG+YObZ44uOuGw==
X-CSE-MsgGUID: umuY/mTcRXO85T26ThKz6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="78011937"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="78011937"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2026 19:10:34 -0700
X-CSE-ConnectionGUID: ZN7Gr5/8T5eZXJHZdxsJYA==
X-CSE-MsgGUID: TcyEp+m0SISUS4aJcLrZYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="237822438"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2026 19:10:30 -0700
Message-ID: <435241c3-20a7-4214-9f54-5ca82678dc3d@linux.intel.com>
Date: Mon, 27 Apr 2026 10:10:27 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] perf/x86/intel: Don't write PEBS_ENABLED on
 host<=>guest xfers if CPU has isolation
To: Jim Mattson <jmattson@google.com>, Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Stephane Eranian <eranian@google.com>
References: <20260423150340.463896-1-seanjc@google.com>
 <20260423150340.463896-2-seanjc@google.com>
 <CALMp9eSivf0oDdbgfLSY0zcvtMAV__da8ENCJk=QpEkEeUC1PQ@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CALMp9eSivf0oDdbgfLSY0zcvtMAV__da8ENCJk=QpEkEeUC1PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/24/2026 1:59 AM, Jim Mattson wrote:
> On Thu, Apr 23, 2026 at 8:03 AM Sean Christopherson <seanjc@google.com> wrote:
>> When filling the list of MSRs to be loaded by KVM on VM-Enter and VM-Exit,
>> *never* insert an entry for PEBS_ENABLED if the CPU properly isolates PEBS
>> events, in which case disabling counters via PERF_GLOBAL_CTRL is sufficient
>> to prevent unwanted PEBS events in the guest (or host).  Because perf loads
>> PEBS_ENABLE with the unfiltered cpu_hw_events.pebs_enabled, i.e. with both
>> host and guest masks, there is no need to load different values for the
>> guest versus host, perf+KVM can and should simply control which counters
>> are enabled/disabled via PERF_GLOBAL_CTRL.
>>
>> Avoiding touching PEBS_ENABLED fixes a theorized bug where PEBS_ENABLED can
>> end up with "stuck" bits if a PEBS event is throttled better generating the
>> list and actually entering the guest (Intel CPUs can't arbtitrarily block
>> NMIs). And stating the obvious, leaving PEBS_ENABLED as-is avoids three MSR
>> writes on every VMX transition: one each on entry/exit, and one more
>> explicit WRMSR to zero PEBS_ENABLED before VM-Entry (KVM assumes the only
>> reason PEBS_ENABLED is in the load list is if the CPU lacks isolation and
>> thus needs a quiescent period).
>>
>> Fixes: c59a1f106f5c ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR emulation for extended PEBS")
>> Cc: Jim Mattson <jmattson@google.com>
>> Cc: Mingwei Zhang <mizhang@google.com>
>> Cc: Stephane Eranian <eranian@google.com>
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> ---
>>  arch/x86/events/intel/core.c | 42 ++++++++++++++++++++----------------
>>  1 file changed, 23 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 793335c3ce78..002d809f82ef 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -4999,12 +4999,15 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>>         struct kvm_pmu *kvm_pmu = (struct kvm_pmu *)data;
>>         u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
>>         u64 pebs_mask = cpuc->pebs_enabled & x86_pmu.pebs_capable;
>> -       int global_ctrl, pebs_enable;
>> +       u64 guest_pebs_mask = pebs_mask & ~cpuc->intel_ctrl_host_mask;
>> +       int global_ctrl;
> Is it worth noting somewhere that pebs_ept is not supported on any
> CPUs with PMU version < 5, where a single event can set two
> PEBS_ENABLE bits (cf. intel_pmu_pebs_enable)?
>
>>         /*
>>          * In addition to obeying exclude_guest/exclude_host, remove bits being
>>          * used for PEBS when running a guest, because PEBS writes to virtual
>> -        * addresses (not physical addresses).
>> +        * addresses (not physical addresses).  If the guest wants to utilize
>> +        * PEBS, and PEBS can safely enabled in the guest, bits for the guest's
>> +        * PEBS-enabled counters will be OR'd back in as appropriate.
>>          */
>>         *nr = 0;
>>         global_ctrl = (*nr)++;
>> @@ -5051,24 +5054,25 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>>                 };
>>         }
>>
>> -       pebs_enable = (*nr)++;
>> -       arr[pebs_enable] = (struct perf_guest_switch_msr){
>> -               .msr = MSR_IA32_PEBS_ENABLE,
>> -               .host = cpuc->pebs_enabled & ~cpuc->intel_ctrl_guest_mask,
>> -               .guest = pebs_mask & ~cpuc->intel_ctrl_host_mask & kvm_pmu->pebs_enable,
>> -       };
>> -
>> -       if (arr[pebs_enable].host) {
>> -               /* Disable guest PEBS if host PEBS is enabled. */
>> -               arr[pebs_enable].guest = 0;
>> -       } else {
>> -               /* Disable guest PEBS thoroughly for cross-mapped PEBS counters. */
>> -               arr[pebs_enable].guest &= ~kvm_pmu->host_cross_mapped_mask;
>> -               arr[global_ctrl].guest &= ~kvm_pmu->host_cross_mapped_mask;
>> -               /* Set hw GLOBAL_CTRL bits for PEBS counter when it runs for guest */
>> -               arr[global_ctrl].guest |= arr[pebs_enable].guest;
>> -       }
>> +       /*
>> +        * Disable counters where the guest PMC is different than the host PMC
>> +        * being used on behalf of the guest, as the PEBS record includes
>> +        * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
>> +        * wrong counter(s).  Similarly, disallow PEBS in the guest if the host
>> +        * is using PEBS, to avoid bleeding host state into PEBS records.
>> +        */
>> +       guest_pebs_mask &= kvm_pmu->pebs_enable & ~kvm_pmu->host_cross_mapped_mask;
>> +       if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
>> +               guest_pebs_mask = 0;
> I don't understand this clause. IIUC, it says that if we don't have
> any exclude-host PEBS events, then clear PEBS_ENABLE for the guest.

I suppose it says all guest PEBS events need to be disabled if there is any
event using PEBS on host side, and it's clearing GLOBAL_CTRL instead of
PEBS_ENABLE to disable guest PEBS events. 


>
> Yes, any guest-programmed PEBS event should be exclude-host, but if
> there is an inconsistency, shouldn't we apply a mask? What if there is
> only one exclude-host PEBS event, but there are two bits set in
> guest_pebs_mask?
>
>> +       /*
>> +        * Do NOT mess with PEBS_ENABLED.  As above, disabling counters via
>> +        * PERF_GLOBAL_CTRL is sufficient, and loading a stale PEBS_ENABLED,
>> +        * e.g. on VM-Exit, can put the system in a bad state.  Simply enable
>> +        * counters in PERF_GLOBAL_CTRL, as perf load PEBS_ENABLED with the
>> +        * full value, i.e. perf *also* relies on PERF_GLOBAL_CTRL.
>> +        */
>> +       arr[global_ctrl].guest |= guest_pebs_mask;
>>         return arr;
>>  }
>>
>> --
>> 2.54.0.545.g6539524ca2-goog
>>
