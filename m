Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5997846F;
	Fri,  9 May 2025 02:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746757174; cv=none; b=th9OhFoGDmCbAPIp2LlnLy+XoiKgsQKrqBBHhNrwZcdIl9zk4je3XQGKngVDaimJD/UBB2JNVKwsPP/amELttiihL3+wXfR1QZIWP/BTWuH9gLWOETrGuGL8AVjDhrw9HP+TfzQyOS2qyqtxua7Ue1bvi7+eGTG/ngacSejkoj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746757174; c=relaxed/simple;
	bh=WnBpkQV0yq9AWdCpThVf6GUnM7PgMoyjUXtRXm1i0ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9k/oySPLN6fFsv9UDO6IyJbvoV0ccufjLDi2ZO6aklJgMOW1JHUU5xh+iQHxmaq8U2BNeKdMxNaza0HeanZ4l7LZ2Ds1Gpa1aPIxx1q7iGW2b/cT/WU2mqCRjZkV1X8/v0ZouAWzqw/ss2G3Fz2Wc8/kIUatOQVjJ7wt+C3kI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N3kKUNXo; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N3kKUNXo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746757173; x=1778293173;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WnBpkQV0yq9AWdCpThVf6GUnM7PgMoyjUXtRXm1i0ms=;
  b=N3kKUNXob5pkND0wfrS03DWdQqSPD+RLFiDeJmy+p5AxX5M9+CJ+OrwK
   rWSRhUDo2V0cTfndvlyK9aIhFaPEd5560u2S8JlkQoB+Qyw4kdU9eH0P1
   JDuAR2Z0fMqOPUB101ceV6cHbX8b3AI51fWf9gD2MGPL/+05qEJHpoOA9
   MCjTyFMXHKOrNCjI3gOOSW+rHG5Symwf2AZSmLzFBxs5XVgYaMSvcGl8I
   rtTawMe86+CCE90D30dp5GsioOmkBBtrmpYF1Ac+orHPNMD1Hdu568wDO
   k1wJmVqan8okVlEZ4Uw2X1ATfIrtvokNdNDmyl99fsNqds8jm6GygLFLx
   w==;
X-CSE-ConnectionGUID: h9vo4ckqSQeev56iy+z+yw==
X-CSE-MsgGUID: beakdVgpRdmSseV4tHfDKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48479313"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="48479313"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 19:19:32 -0700
X-CSE-ConnectionGUID: hTWXd3trQomq2TdVOhkBlA==
X-CSE-MsgGUID: 38jSYgSFQSeRnsD7WpelPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="136360142"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.231.84]) ([10.124.231.84])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 19:19:29 -0700
Message-ID: <a08c7053-26b8-43ae-a036-05ae2c132e4f@linux.intel.com>
Date: Fri, 9 May 2025 10:19:25 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for guest
 with vCPU's value.
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>
References: <20250426001355.1026530-1-seanjc@google.com>
 <701a94eb-feac-4578-850c-5b1f015877af@linux.intel.com>
 <aBTe6dpaQs6bmFwh@google.com>
 <d78cd913-69eb-415f-ac30-1677642a5f1a@linux.intel.com>
 <aBy2AGIFi34q031x@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aBy2AGIFi34q031x@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/8/2025 9:47 PM, Sean Christopherson wrote:
> On Tue, May 06, 2025, Dapeng Mi wrote:
>> On 5/2/2025 11:04 PM, Sean Christopherson wrote:
>>> On Sun, Apr 27, 2025, Dapeng Mi wrote:
>>>> On 4/26/2025 8:13 AM, Sean Christopherson wrote:
>>>> Currently we have this Sean's fix, only the guest PEBS event bits of
>>>> IA32_PEBS_ENABLE MSR are enabled in non-root mode, suppose we can simply
>>>> change global_ctrl guest value calculation to this.
>>>>
>>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>>> index 09d2d66c9f21..5bc56bb616ec 100644
>>>> --- a/arch/x86/events/intel/core.c
>>>> +++ b/arch/x86/events/intel/core.c
>>>> @@ -4342,9 +4342,12 @@ static struct perf_guest_switch_msr
>>>> *intel_guest_get_msrs(int *nr, void *data)
>>>>         arr[global_ctrl] = (struct perf_guest_switch_msr){
>>>>                 .msr = MSR_CORE_PERF_GLOBAL_CTRL,
>>>>                 .host = intel_ctrl & ~cpuc->intel_ctrl_guest_mask,
>>>> -               .guest = intel_ctrl & ~cpuc->intel_ctrl_host_mask & ~pebs_mask,
>>>> +               .guest = intel_ctrl & ~cpuc->intel_ctrl_host_mask,
>>>>         };
>>> Hmm, that's not as clear cut.  PEBS needs to be disabled because leaving it enabled
>>> will crash the guest.  For the counter itself, unless leaving it enabled breaks
>>> perf and/or degrades the sampling, I don't think there's an obvious right/wrong
>>> approach.
>>>
>>> E.g. if the host wants to profile host and guest, then keeping the count running
>>> while the guest is active might be a good thing.  It's still far, far from
>>> perfect, as a counter that overflows when the guest is active won't generate a
>>> PEBS record, but without digging further, it's not obvious that even that flaw
>>> is overall worse than always disabling the counter.
>> Hmm, if the host PEBS event only samples host side, whether the HW counter
>> or the PEBS engine would be disabled once VM enters non-root mode, the KVM
>> PEBS implementation is correct. But for the host PEBS events which sampling
>> both host and guest, the implementation seems incorrect.
> Well, yeah, because there is no correct implementation.
>
>> As the below code shows, as long as there are host PEBS events regardless
>> of the host PEBS events only sample guest or both host and guest, the host
>> PEBS events would be disabled on both HW counters and PEBS engine once VM
>> enters non-root mode.
>>
>>     arr[global_ctrl] = (struct perf_guest_switch_msr){
>>         .msr = MSR_CORE_PERF_GLOBAL_CTRL,
>>         .host = intel_ctrl & ~cpuc->intel_ctrl_guest_mask,
>>         .guest = intel_ctrl & ~cpuc->intel_ctrl_host_mask & ~pebs_mask,
>>     };
>>
>>     if (arr[pebs_enable].host) {
>>         /* Disable guest PEBS if host PEBS is enabled. */
>>         arr[pebs_enable].guest = 0;
>>
>>     }
>>
>> So the host PEBS events which hopes to sample both host and guest only
>> samples host side in fact. This is unexpected.
> It's only unexpected in the sense that it's probably not well documented.  Because
> the DS buffer is virtually address, there simply isn't a sane way to enable PEBS
> (or any feature that utizies the DS buffer) while running a KVM guest that isn't
> enlightened to explicitly allow profiling via host PEBS (and AFAIK, no such guest
> exists).
>
> Even when KVM is using shadowing paging, i.e. fully controls the page tables used
> while the guest is running, enabling PEBS isn't feasible as KVM has no way to
> prevent the guest from using the virtual address.  E.g. KVM could shove in mappings
> for the DS buffer, but that DoS the guest if the guest wants to use the same
> virtual address range for its own purposes, and would be a massive data leak to
> the guest since the guest could read host data from the buffer.

Yeah, that's true. Thanks for the explanation.


>
