Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3BE27B4E6;
	Tue,  6 May 2025 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746533459; cv=none; b=fl0jQxcR09wz4xo4KjH2ANjxkDGviNoKQnSq+sZgIUpN+9sTt13tZBImxtTcYi9K3//QbHDKBLMLz/lN8rAVvAoGMaj7aEhWZgDsle2DgQSyZUpbevrJzvQ+fAw73uHdYnX2zhRgQxKWFmXtiQHuHfuEIhQKFoEMn4PAq2klVxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746533459; c=relaxed/simple;
	bh=O8b3ztoFUdULp4SG8U82Lu4JcNoNvzm1FjL5T2RuwUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzeRNGW6ISw0fOxumZcUBdh2PITVV3JN62L4LWEAVeicMFlLxay1GYIF2CxnIIGcKhiaxxYMcBw6BKaPCugz1+t3JZ+Hxmc0KpEklDWS3yh8fC31Nbl08NkTysElJ+n3mXYvf3IfLu5g6jMV5Oj/snMH/OQNFW8WvcDbNDILRoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XB5dyTBP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XB5dyTBP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746533458; x=1778069458;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O8b3ztoFUdULp4SG8U82Lu4JcNoNvzm1FjL5T2RuwUw=;
  b=XB5dyTBPdztecBfeAulxivXt9myVjPBgUsxjnXht9jm06QcFVddu6/6X
   Ax2495vCYjzN2m9aQb8qv8uChThyhP6Zy9zFhL1ie0Rn58zKNDIHLQgwr
   a0XEdHSoXyWu+gBH+MOxMMC/61he2k9Xln/hEyJZZSzehyGUYSE2rzhRQ
   2Z/+kFVD+pPlsV66tEpd52yEX5M2RtaLee9NbaPVGikWAHRVFdQCcRyyg
   w2JxFROpsjcH2LHKMltXM7i1vSFxUAYHiygIW4d0BzcpcoN7rKR7hqLiQ
   OvSPKw1uS5o6kFJQVsQht6PaYxLjfIg8wUP/XwhN+v9JSCM2b15OiiLLN
   A==;
X-CSE-ConnectionGUID: 9xc4DkdGRbuE/WDmPeeFfA==
X-CSE-MsgGUID: Q0Oee5O5TuCpU4fWTTEwBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47908424"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="47908424"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 05:10:57 -0700
X-CSE-ConnectionGUID: 0+nKG90oQb2H+Alv/k4fwA==
X-CSE-MsgGUID: 77eKNQZsQj6df/iW6KRJaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="140783989"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 05:10:53 -0700
Message-ID: <d78cd913-69eb-415f-ac30-1677642a5f1a@linux.intel.com>
Date: Tue, 6 May 2025 20:10:49 +0800
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
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <aBTe6dpaQs6bmFwh@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/2/2025 11:04 PM, Sean Christopherson wrote:
> On Sun, Apr 27, 2025, Dapeng Mi wrote:
>> On 4/26/2025 8:13 AM, Sean Christopherson wrote:
>> Currently we have this Sean's fix, only the guest PEBS event bits of
>> IA32_PEBS_ENABLE MSR are enabled in non-root mode, suppose we can simply
>> change global_ctrl guest value calculation to this.
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 09d2d66c9f21..5bc56bb616ec 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -4342,9 +4342,12 @@ static struct perf_guest_switch_msr
>> *intel_guest_get_msrs(int *nr, void *data)
>>         arr[global_ctrl] = (struct perf_guest_switch_msr){
>>                 .msr = MSR_CORE_PERF_GLOBAL_CTRL,
>>                 .host = intel_ctrl & ~cpuc->intel_ctrl_guest_mask,
>> -               .guest = intel_ctrl & ~cpuc->intel_ctrl_host_mask & ~pebs_mask,
>> +               .guest = intel_ctrl & ~cpuc->intel_ctrl_host_mask,
>>         };
> Hmm, that's not as clear cut.  PEBS needs to be disabled because leaving it enabled
> will crash the guest.  For the counter itself, unless leaving it enabled breaks
> perf and/or degrades the sampling, I don't think there's an obvious right/wrong
> approach.
>
> E.g. if the host wants to profile host and guest, then keeping the count running
> while the guest is active might be a good thing.  It's still far, far from
> perfect, as a counter that overflows when the guest is active won't generate a
> PEBS record, but without digging further, it's not obvious that even that flaw
> is overall worse than always disabling the counter.

Hmm, if the host PEBS event only samples host side, whether the HW counter
or the PEBS engine would be disabled once VM enters non-root mode, the KVM
PEBS implementation is correct. But for the host PEBS events which sampling
both host and guest, the implementation seems incorrect.

As the below code shows, as long as there are host PEBS events regardless
of the host PEBS events only sample guest or both host and guest, the host
PEBS events would be disabled on both HW counters and PEBS engine once VM
enters non-root mode.

    arr[global_ctrl] = (struct perf_guest_switch_msr){
        .msr = MSR_CORE_PERF_GLOBAL_CTRL,
        .host = intel_ctrl & ~cpuc->intel_ctrl_guest_mask,
        .guest = intel_ctrl & ~cpuc->intel_ctrl_host_mask & ~pebs_mask,
    };

    if (arr[pebs_enable].host) {
        /* Disable guest PEBS if host PEBS is enabled. */
        arr[pebs_enable].guest = 0;

    }

So the host PEBS events which hopes to sample both host and guest only
samples host side in fact. This is unexpected.

I agree it's not enough to just remove the "~pebs_mask" for guest
global_ctrl, a simple way to fix this issue could be to skip all PEBS
related MSR switch at VM-exit/VM-entry and always keep the host vlaue in
these PEBS MSRS regardless of in root or non-root mode.


