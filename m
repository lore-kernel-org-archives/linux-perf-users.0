Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C02B15443F
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732042692; cv=none; b=UM6x4DBcxo0Zy5A+6jKW1ZFVmmLBvX917o+W6iJCBBE4FaVo25yblDSkndq+OjGmbycbdFBngAAm8TNEgOncOGtXgToroU2oQVHJbTFhArqugl/mnjxHe8MScF9kIF1gTOHYgyxB51YYIdBEgbh/fWPyWNdzoEQOOVOsCud6q1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732042692; c=relaxed/simple;
	bh=CaYHRLlMx9K3LpAcOJBVj9TCZ1ssxrlQJHunKlqrLME=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C5F2e13n0PJEqfszslCaxsCTaEPwxMwjhk4xBSP5yO2Qjzom7iHtNDPPfGC0FQ6EH1WHFukqNZMCVBEzDpE7Yfnba2WJL1JJ6l5Ce0yJyEDt5/Z7oUq7dphi0nAmh4pCg8O0oFkfrwyR4izZ3hWd27QSkJNMytMf3WLvO8IFODk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EXMYaDS8; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EXMYaDS8"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7202dfaa53fso5827390b3a.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 10:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732042691; x=1732647491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JG7IW976n3LuBX649AhgR5w6x9Lne3c1qlRCMTLNQN4=;
        b=EXMYaDS8IIljAcsoUxuHJEMhkoS190+ofWY82ilvULcC0b1VNuQTFo1C6At5VhSXhx
         kvTa1EDgTlQ2Cm5tct5o4IX6sBdJKzxP6iUs2bXrBt1yQn3/vlaGHCvMNxE+dCqucidW
         d53sTI9WIzZWGYkhR9HjIC0QMuSzHKRfGjQ5slvDn3pEMS2xxb2fYHtluoyFj19dvfj0
         tAeKQDqGpCF/FThwCRoQwPYY9aY3n4Ck13Drc0rHjL5G5WPnbfAUZNmHnDpC9CqC1Kqn
         vBEiaeH+muRa62vzwgeaMD9HRX01JQQGC96pItWY7/D66A3xN1S+91oFujsDZSCAcfCT
         fwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732042691; x=1732647491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JG7IW976n3LuBX649AhgR5w6x9Lne3c1qlRCMTLNQN4=;
        b=aPNvBeNVTiSofzh71R72BJjN1NZGDp9p/Nz93OpIPS4ReZfiBRVU68cO5yazfIKvlt
         asvpQt8JB/rMkJO67HRg8UPw7YQf9Z9O5ZF3dNe8OQQIo+CAaVfFKaxURdfIH8RCf/GG
         Ot0yHAAJeh7N1hsk3c3RtU6mjxBQ1AOK7x65nsj5a/ztgPjWuP8eCcKM1WPcNwvo8rFK
         P6YwB46k7anSZHJovgoMqt4qXfjKavzUM0Y093557Akk2Qa0bW6mJZZHtDvbZj5WUQ7Z
         /snGAn9v1GSKrUpDfPmzrFc/0UAHiz6OMK6L0/oEAXWdDYhHl/D34J9v0BCuDpaSNSco
         UJ9A==
X-Forwarded-Encrypted: i=1; AJvYcCUht/CabEpehj0XenFLioULWOiImZlseLl48gyKhUDy+dZfSfn5Hool17UjuRp9iN9i7r+/zuuiHGQEwgtWRS2u@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv5OAg5IdAPYDwXYZE/gPX2rxpqF5kcezUpCkwOfejhME35JC6
	H4CK4ISAONBGFbFLw3yJKf6E4zDH++Bt5CukFIMiSMjGEbv7lXXu5FGdE1ny4zpLj0Du4poSVr5
	G1w==
X-Google-Smtp-Source: AGHT+IGh3uwc4FqgofMvnZ95XtOkh7u8u7xHwAaxoNHCP5bZH7ShLaMyJ8JrAlCfywT8H8d0O+ZA7pn99Tg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:903:2311:b0:212:475e:2e8f with SMTP id
 d9443c01a7336-212475e37camr121295ad.9.1732042690706; Tue, 19 Nov 2024
 10:58:10 -0800 (PST)
Date: Tue, 19 Nov 2024 10:58:09 -0800
In-Reply-To: <20240801045907.4010984-32-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com> <20240801045907.4010984-32-mizhang@google.com>
Message-ID: <ZzzfwXefHP7SG-Vy@google.com>
Subject: Re: [RFC PATCH v3 31/58] KVM: x86/pmu: Add counter MSR and selector
 MSR index into struct kvm_pmc
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Xiong Zhang <xiong.y.zhang@intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kan Liang <kan.liang@intel.com>, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Manali Shukla <manali.shukla@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Jim Mattson <jmattson@google.com>, 
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, 
	Namhyung Kim <namhyung@kernel.org>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, Like Xu <like.xu.linux@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

Please squash this with the patch that does the actual save/load.  Hmm, maybe it
should be put/load, now that I think about it more?  That's more consitent with
existing KVM terminology.

Anyways, please squash them together, it's very difficult to review them separately.

On Thu, Aug 01, 2024, Mingwei Zhang wrote:
> Add the MSR indices for both selector and counter in each kvm_pmc. Giving
> convenience to mediated passthrough vPMU in scenarios of querying MSR from
> a given pmc. Note that legacy vPMU does not need this because it never
> directly accesses PMU MSRs, instead each kvm_pmc is bound to a perf_event.
> 
> For actual Zen 4 and later hardware, it will never be the case that the
> PerfMonV2 CPUID bit is set but the PerfCtrCore bit is not. However, a
> guest can be booted with PerfMonV2 enabled and PerfCtrCore disabled.
> KVM does not clear the PerfMonV2 bit from guest CPUID as long as the
> host has the PerfCtrCore capability.
> 
> In this case, passthrough mode will use the K7 legacy MSRs to program
> events but with the incorrect assumption that there are 6 such counters
> instead of 4 as advertised by CPUID leaf 0x80000022 EBX. The host kernel
> will also report unchecked MSR accesses for the absent counters while
> saving or restoring guest PMU contexts.
> 
> Ensure that K7 legacy MSRs are not used as long as the guest CPUID has
> either PerfCtrCore or PerfMonV2 set.
> 
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  2 ++
>  arch/x86/kvm/svm/pmu.c          | 13 +++++++++++++
>  arch/x86/kvm/vmx/pmu_intel.c    | 13 +++++++++++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 4b3ce6194bdb..603727312f9c 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -522,6 +522,8 @@ struct kvm_pmc {
>  	 */
>  	u64 emulated_counter;
>  	u64 eventsel;
> +	u64 msr_counter;
> +	u64 msr_eventsel;

There's no need to track these per PMC, the tracking can be per PMU, e.g.

	u64 gp_eventsel_base;
	u64 gp_counter_base;
	u64 gp_shift;
	u64 fixed_base;

Actually, there's no need for a per-PMU fixed base, as that can be shoved into
kvm_pmu_ops.  LOL, and the upcoming patch hardcodes INTEL_PMC_FIXED_RDPMC_BASE.
Naughty, naughty ;-)

It's not pretty, but 16 bytes per PMC isn't trivial. 

Hmm, actually, scratch all that.  A better alternative would be to provide a
helper to put/load counter/selector MSRs, and call that from vendor code.  Ooh,
I think there's a bug here.  On AMD, the guest event selector MSRs need to be
loaded _before_ PERF_GLOBAL_CTRL, no?  I.e. enable the guest's counters only
after all selectors have been switched AMD64_EVENTSEL_GUESTONLY.  Otherwise there
would be a brief window where KVM could incorrectly enable counters in the host.
And the reverse that for put().

But Intel has the opposite ordering, because MSR_CORE_PERF_GLOBAL_CTRL needs to
be cleared before changing event selectors.

And so trying to handle this entirely in common code, while noble, is at best
fragile and at worst buggy.

The common helper can take the bases and shift, and if we want to have it handle
fixed counters, the base for that too.
