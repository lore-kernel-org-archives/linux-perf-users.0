Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E5639A063;
	Fri, 24 Apr 2026 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777033070; cv=none; b=Qn0xKdCqx290c2MJd3jSqlMhHDTPLaShTiNBcQXmdiHFDV0gnKdI267PfSHRz0Hm/gCPH5OHkCwqhco4JVuNYpQheuF0Js3dP9FeOooD+SmL7lmHZaBm12oPHQKP7ICr3pyPNcqunytcpa446mtmgoI5ui++49Vy2uoeVTMLOpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777033070; c=relaxed/simple;
	bh=FHatZV0vxTbMFsegeFsT8M9akO6TeF8HXnisWmSZQOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIo6P/s3gMpGLeO/UZ4B6W7OCrdpCACWxdU5YH7S5T/CyMcuezX3IaA5KlDJgaBammPivpwUofkvoDeIXQamyZwwqV0zuXEIvWUoqO3CYWGith5WtEbDuBop3J2h8n4FsA+ploMlNESwjulZ4K/eTsP2ek5vmKzLgGzbTF1IQ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eqyqzNIL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eqyqzNIL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777033070; x=1808569070;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FHatZV0vxTbMFsegeFsT8M9akO6TeF8HXnisWmSZQOw=;
  b=eqyqzNILYyMYj2q3hdxiLvYqRuzFODQGHDB9z92N2OFJmiIg+VczSzDJ
   Sc5TH9qNpamJchlkEAgIXuER3PNBVC67a/Thz3ak/yGcueMNdPoPi1GNr
   2ZF4sW4YSxwo/xAVKAkbj6CwxFePlQqDiIYbnatCAhi4KcPwY18aVDtjJ
   +15fDWuOAMEsxg86caqQh9Hlk+L1H2Ok7uPrmbVO0qgjuaCjHwBSv5SxB
   3282ShDVbs3iHevTcLJWsosRlUKKB+2/GMCCKv2LJdaGLyC97aWz4TpM2
   OzBQyHadgFnVhYoGT4RU4b/88tFmkHmYFCAgNCh2Ty+qMRWkoN6edoUwZ
   g==;
X-CSE-ConnectionGUID: 5Aw6N5xdSZC9avfkiXCQFA==
X-CSE-MsgGUID: SdfUeMJ2Qau8Goy4ojz6bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="77898124"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="77898124"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 05:17:49 -0700
X-CSE-ConnectionGUID: 1ZBKnFo2RFGUiwRkHrAqoA==
X-CSE-MsgGUID: Hv2gsVGWT56JkD/4uWUTGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="232846618"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 05:17:45 -0700
Message-ID: <3585d823-00f3-46ae-a799-b62a95743e76@linux.intel.com>
Date: Fri, 24 Apr 2026 20:17:42 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] perf/x86: Don't write PEBS_ENABLED on KVM
 transitions
To: Peter Zijlstra <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Jim Mattson <jmattson@google.com>, Mingwei Zhang <mizhang@google.com>,
 Stephane Eranian <eranian@google.com>
References: <20260423150340.463896-1-seanjc@google.com>
 <20260423161641.GA641209@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260423161641.GA641209@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/24/2026 12:16 AM, Peter Zijlstra wrote:
> On Thu, Apr 23, 2026 at 08:03:36AM -0700, Sean Christopherson wrote:
>> Testing this against our "PEBS_ENABLED is stuck" reproducer is (still) a work
>> in-progress (largely because the "reproducer" is currently "throw the kernel in
>> a big test pool"), i.e. I don't know if this actually resolves the problems we
>> are seeing.  But even if it doesn't fully resolve our woes, it seems like a
>> no-brainer improvement, and if we're missing something with respect to "stuck"
>> PEBS_ENABLED, it'd be nice to get feedback/input asap.
>>
>> Note, if the throttling theory is correct (which is looking unlikely at the
>> moment), then there are likely more fixes that need to be done, e.g. for CPUs
>> without isolation, and/or if PERF_GLOBAL_CTRL can be modified from NMI context
>> too.
> Throttle does: pmu->stop() := x86_pmu_stop() -> intel_pmu_disable_event()
>
> Which in turn should:
>
>   x86_pmu_disable_event()
>     wrmsrq(config_base, config & ~EN);
>   x86_pmu_pebs_disable() := intel_pmu_pebs_disable()
>     wrmsr(PEBS_ENABLE, pebs_enabled & ~(1<<idx));
>
> So that's just the counter EN bit and PEBS_ENABLED cleared. However, if
> this is from PMI, then the PMI handler should also update GLOBAL_CTRL --
> provided it wasn't 0.
>
> See intel_pmu_handle_irq():
>
>   if (pmu_enabled)
>   	__intel_pmu_enable_all()
> 	  wrmsrq(GLOBAL_CTRL, intel_ctrl);
>
Yes, currently all valid bits in GLOBAL_CTRL would be set by default on
Intel platforms. IIUC, this issue looks more like a race condition between
Perf and KVM.

1. KVM saves the value of host PEBS_ENABLE before VM-entry.

2. PMI is triggered and interrupts the upcoming VM-entry. PEBS events are
throttled and PEBS_ENABLE MSR is updated in the PMI handler, then the KVM
saved host PEBS_ENABLE value gets stale. 

3. VM entry continues and then the next VM-exit occurs, the stale
PEBS_ENABLE value is restored. 

4. The PEBS_ENABLE MSR keeps the stale value until next write.

Seems an alternative way to fix this issue is to disable the PMU (Clearing
GLOBAL_CTRL) before KVM saving the PMU MSRs?

Thanks.


