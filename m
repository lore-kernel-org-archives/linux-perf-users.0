Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04F2154425;
	Tue, 28 Apr 2026 02:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777343569; cv=none; b=cTrCblQ3Rn+8fHToiUG698qEIlJLc1XWQxfwJCA4rxHwhMddMm5+fLT49RpJs8hHxtH9RPf5Pfx/uZf1peYWiuyDXIpQQqxcFY6wPgfZXvh0nxgFJ87owSb/scncWfljitqk2vCgoYJfwhJuaMzTDhj1oh25nzGm5qh/DjAdNBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777343569; c=relaxed/simple;
	bh=X+cZAby3kS0wPxEJU7xPLDAt8SG1IxUg3o4gJuK7ZUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hWchFKI7in89TlA2h5ZritdalvBoF3PVJWl2ccJPfAxw5vVg9Z2FGIvLZhf/2YT0ydI51OK5f/jmQPEcjsimemqeWzz8uYeWCejTotLWE67i9QYeIp8FbWKgBt1F1g4/eRZU8rwH8dO/Rt0uRRmsNUjVIrqXOuLxlWAKBTEdomA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CxwK9rTC; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CxwK9rTC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777343568; x=1808879568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X+cZAby3kS0wPxEJU7xPLDAt8SG1IxUg3o4gJuK7ZUk=;
  b=CxwK9rTCP0ixes+r3Q/3f5E0fl8bi2sy9xBPG/+Zc+0SMbDa6sDeBDss
   K1hVd548dIWVA1xKuAOHq4boBUqyLXTpWPnL5J+I3TZT8PwJqbf0+uSoC
   w6DTVSJAg7PdspSfNqaxCwNO+SLQxXwEgxB6Tbg9fhNqn7k2d+nU3TVst
   4/DXKK8gfbFuxfpRgU3fV3flsnlTZoy4dGzl0AEPEtxM1roVZ3SKLgx8t
   W/f8DIc1lIcI+uVbsGRjyAaxJ7+xzBEEI+dIcvMCBYeQ6QPVUFZaV7u88
   qBWz9SstxP70/SuJiwls1OeDGEHJYBHSylTiSh7b2625UKdo0Ziet4+j/
   g==;
X-CSE-ConnectionGUID: hHLNuf6oTQKyMDixA00k6A==
X-CSE-MsgGUID: zE3R/Jt2R0a7CFdG45S8Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="88555212"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="88555212"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 19:32:47 -0700
X-CSE-ConnectionGUID: wtU6pI2tSGWZ/hXTZU8UWQ==
X-CSE-MsgGUID: 40ZOg+htScGI1isCBUlQHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="235566916"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 19:32:43 -0700
Message-ID: <cc700a57-4620-4059-b4bc-4c132048605b@linux.intel.com>
Date: Tue, 28 Apr 2026 10:32:40 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] perf/x86/intel: Don't write PEBS_ENABLED on
 host<=>guest xfers if CPU has isolation
To: Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
 Stephane Eranian <eranian@google.com>
References: <20260423150340.463896-1-seanjc@google.com>
 <20260423150340.463896-2-seanjc@google.com>
 <CALMp9eSivf0oDdbgfLSY0zcvtMAV__da8ENCJk=QpEkEeUC1PQ@mail.gmail.com>
 <435241c3-20a7-4214-9f54-5ca82678dc3d@linux.intel.com>
 <ae-l9qDd4Qnvq752@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <ae-l9qDd4Qnvq752@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/28/2026 2:07 AM, Sean Christopherson wrote:
> On Mon, Apr 27, 2026, Dapeng Mi wrote:
>> On 4/24/2026 1:59 AM, Jim Mattson wrote:
>>>>  arch/x86/events/intel/core.c | 42 ++++++++++++++++++++----------------
>>>>  1 file changed, 23 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>>> index 793335c3ce78..002d809f82ef 100644
>>>> --- a/arch/x86/events/intel/core.c
>>>> +++ b/arch/x86/events/intel/core.c
>>>> @@ -4999,12 +4999,15 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>>>>         struct kvm_pmu *kvm_pmu = (struct kvm_pmu *)data;
>>>>         u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
>>>>         u64 pebs_mask = cpuc->pebs_enabled & x86_pmu.pebs_capable;
>>>> -       int global_ctrl, pebs_enable;
>>>> +       u64 guest_pebs_mask = pebs_mask & ~cpuc->intel_ctrl_host_mask;
>>>> +       int global_ctrl;
>>> Is it worth noting somewhere that pebs_ept is not supported on any
>>> CPUs with PMU version < 5, where a single event can set two
>>> PEBS_ENABLE bits (cf. intel_pmu_pebs_enable)?
> Is that a hardware limitation, or a "perf hasn't added pebs_ept for PMU v5 yet"
> thing?  I assume it's the latter?
>
>>>> +       /*
>>>> +        * Disable counters where the guest PMC is different than the host PMC
>>>> +        * being used on behalf of the guest, as the PEBS record includes
>>>> +        * PERF_GLOBAL_STATUS, i.e. the guest will see overflow status for the
>>>> +        * wrong counter(s).  Similarly, disallow PEBS in the guest if the host
>>>> +        * is using PEBS, to avoid bleeding host state into PEBS records.
>>>> +        */
>>>> +       guest_pebs_mask &= kvm_pmu->pebs_enable & ~kvm_pmu->host_cross_mapped_mask;
>>>> +       if (pebs_mask & ~cpuc->intel_ctrl_guest_mask)
>>>> +               guest_pebs_mask = 0;
>>> I don't understand this clause. IIUC, it says that if we don't have
>>> any exclude-host PEBS events, then clear PEBS_ENABLE for the guest.
>> I suppose it says all guest PEBS events need to be disabled if there is any
>> event using PEBS on host side, and it's clearing GLOBAL_CTRL instead of
>> PEBS_ENABLE to disable guest PEBS events. 
> Yeah, but why disable _everything_?
>
>>> Yes, any guest-programmed PEBS event should be exclude-host, but if
>>> there is an inconsistency, shouldn't we apply a mask? What if there is
>>> only one exclude-host PEBS event, but there are two bits set in
>>> guest_pebs_mask?
> I'm confused about this as well.  The comment above about not bleeding host state
> into the PEBS records is my best guess (and it's probably not a very good guess)
> as to why the code does what it does.  The changelog from commit 854250329c02
> ("KVM: x86/pmu: Disable guest PEBS temporarily in two rare situations") just says:
>     
>     The guest PEBS will be disabled when some users try to perf KVM and
>     its user-space through the same PEBS facility 
>
> That doesn't entirely make sense to me though, because I would think disabling
> the host counters iva GLOBAL_CTRL would suffice.  I.e. there's no need to disallow
> PEBS in the guest just because the host is also using PEBS.  But I can't think of
> any other reason to fully disable PEBS.
>
> FWIW, I was going off the previous code which effectively did:
>
> 	if (cpuc->pebs_enabled & ~cpuc->intel_ctrl_guest_mask) {
> 		/* Disable guest PEBS if host PEBS is enabled. */
> 		arr[pebs_enable].guest = 0;
> 	}
>
> One idea would be to add a FIXME, and then address the FIXME in a follow-up patch
> (in the same series)?  And then see what breaks? :-)

I'm confused with this. does this go back to manipulate PEBS_ENABLE again? 

I suppose what Jim mentioned is that the PEBS_LDLAT or PEBS_ST events could
set multiple bits in PEBS_ENABLE MSR before Perfmon v5 as below code shows.

```

void intel_pmu_pebs_enable(struct perf_event *event)
{

......

if ((event->hw.flags & PERF_X86_EVENT_PEBS_LDLAT) && (x86_pmu.version < 5))
        cpuc->pebs_enabled |= 1ULL << (hwc->idx + 32);
    else if (event->hw.flags & PERF_X86_EVENT_PEBS_ST)
        cpuc->pebs_enabled |= 1ULL << 63;

......

```

This would lead to multiple bits set in pebs_mask and may cause incorrect
results.

If so, maybe we can bit-and the pebs_mask with intel_ctrl to filter out
these extra bits? 


