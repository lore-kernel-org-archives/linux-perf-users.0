Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDEA1B85C1
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732133642; cv=none; b=H0UqYah66/WiQJ/K25xeO7zZWSqLtPeeRaY/O9pxtf/b+n75SBpJlt3NEleV0L+hP9c9jjYSgfKiJY/L+vPE04yBXjlCVG0uT9swl2orsC60d9kMM3hTzln2506cRV+XZRVeH6ejnl6ScAoLFzQ1/ehlAPcMfiwcraz3Prnjp+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732133642; c=relaxed/simple;
	bh=7/tmP2qjKgFF20QZwVEwP4ZEW9Xxx0bIlFbiNjdoJDY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fp/GXomsFgd7Y2axqmZ6GMCjPpJN6f9PATKcPOqihP5+bmtmEeTuLmbDRN3C6YmKzK1aRbsPEAcT67ESfWXpUl1wxV4AcKbB+rGUSd42wRfVd6LLy90Nl4o7yTGK4PLUi4jBcDz5MnqQmbc7MsMM1sQwMIR6QErSpCavmWoCppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=umxLZAEy; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="umxLZAEy"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30df8dbfd4so197641276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Nov 2024 12:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732133639; x=1732738439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fQXhlcI+fX2VZsDVWRBG4zypgR5vJIisUrtk//M1xtk=;
        b=umxLZAEynYZLq/yc36Zl16KylsjDoQZW67WHw8bu/HLBZ+bFKbcpPCpdfneDK8khEQ
         3WFOoc9xX7+NpAE36GEKid1uURlfgRDpJdGpD5pLjpqlzaaaVuPVPPMj20izqH1U4dtt
         8bCwlrIWjSYmgjTCvILmgiPLNorikj1cZFHk/gG3U0AXcawNavO1oSGxpOOWkSgXS5c1
         SO+GRt3UKHjn6mlnVqf7ZTyoOUS5D7qmCtxrYFItmiQCsJII2BrdouOmV7CQx7Qk/AHx
         CG+Q592kGNkD6ut0+9akUgIY3PXXAbicanjmynPhG3etYteH40bnWaUkmj9DqpxfJKp7
         60VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732133639; x=1732738439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQXhlcI+fX2VZsDVWRBG4zypgR5vJIisUrtk//M1xtk=;
        b=Y3EGkaVAnLbp11xRNjNStjhtue6Y9B0OOrAqhDKy1WkgtZtYoyTkYBfjsKwEdOR1k6
         pKLLyuZNsQDeDYPiC7uljw4TygQAO2xsHVIUu1SBCC1X2huf+7aDyJ6v4zDovtfYlr7D
         CJJ3C8UnwpQ4Si2F7d65Rn8isiJR4aMTiMaDGdE3GAXdT22bFq8x2vT1U17aQrvm7cmp
         pRVA6W454aec9xpeHnLA6awZFhM8XqSUZNAt4us7xK984/YKavOgjoaxHCg7bDLKOiTp
         /Mom1IWVLv5N1oG2ah2l87OLq5MRX/1gYJ7nz7vY2WCIjwfzVVrDKRzqA+u/Oji6ofue
         dNag==
X-Forwarded-Encrypted: i=1; AJvYcCX7i48+AZy+eDCNlfuSdK5KSnV+G4ijpCM/jOySJC6lOhp++cDY0XJ9ogzxeQ7O+2H6gwFQrmax38FK4w527trL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0yRcDF7OnxeBoqy/U3xzqE4jTPDKJ/ypbAl44xoRGR+c2FuHY
	GZRmu0LFr2D3pAXcsSw7GoY4/JtEdILD7/U6Nl4gSNjyop1YCG2tVIAPsDoOWEKMr2ARmG6WUdG
	Pig==
X-Google-Smtp-Source: AGHT+IFGnuTWPc8YjcN2pYJHZ/jB6q9wO8qkwId5OwEDOjE8XIZ7lJt6bN1DeWDPUL38suZBHVzP2a9nBeQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:d647:0:b0:e38:20b8:29 with SMTP id
 3f1490d57ef6-e38cb601a03mr2998276.6.1732133639355; Wed, 20 Nov 2024 12:13:59
 -0800 (PST)
Date: Wed, 20 Nov 2024 12:13:57 -0800
In-Reply-To: <20240801045907.4010984-45-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com> <20240801045907.4010984-45-mizhang@google.com>
Message-ID: <Zz5DBddNFb-gZra1@google.com>
Subject: Re: [RFC PATCH v3 44/58] KVM: x86/pmu: Implement emulated counter
 increment for passthrough PMU
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

On Thu, Aug 01, 2024, Mingwei Zhang wrote:
> Implement emulated counter increment for passthrough PMU under KVM_REQ_PMU.
> Defer the counter increment to KVM_REQ_PMU handler because counter
> increment requests come from kvm_pmu_trigger_event() which can be triggered
> within the KVM_RUN inner loop or outside of the inner loop. This means the
> counter increment could happen before or after PMU context switch.
> 
> So process counter increment in one place makes the implementation simple.
> 
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/kvm/pmu.c | 41 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 5cc539bdcc7e..41057d0122bd 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -510,6 +510,18 @@ static int reprogram_counter(struct kvm_pmc *pmc)
>  				     eventsel & ARCH_PERFMON_EVENTSEL_INT);
>  }
>  
> +static void kvm_pmu_handle_event_in_passthrough_pmu(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> +
> +	static_call_cond(kvm_x86_pmu_set_overflow)(vcpu);
> +
> +	if (atomic64_read(&pmu->__reprogram_pmi)) {
> +		kvm_make_request(KVM_REQ_PMI, vcpu);
> +		atomic64_set(&pmu->__reprogram_pmi, 0ull);
> +	}
> +}
> +
>  void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
>  {
>  	DECLARE_BITMAP(bitmap, X86_PMC_IDX_MAX);
> @@ -517,6 +529,9 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
>  	struct kvm_pmc *pmc;
>  	int bit;
>  
> +	if (is_passthrough_pmu_enabled(vcpu))
> +		return kvm_pmu_handle_event_in_passthrough_pmu(vcpu);
> +
>  	bitmap_copy(bitmap, pmu->reprogram_pmi, X86_PMC_IDX_MAX);
>  
>  	/*
> @@ -848,6 +863,17 @@ void kvm_pmu_destroy(struct kvm_vcpu *vcpu)
>  	kvm_pmu_reset(vcpu);
>  }
>  
> +static void kvm_passthrough_pmu_incr_counter(struct kvm_vcpu *vcpu, struct kvm_pmc *pmc)
> +{
> +	if (static_call(kvm_x86_pmu_incr_counter)(pmc)) {

This is absurd.  It's the same ugly code in both Intel and AMD.

static bool intel_incr_counter(struct kvm_pmc *pmc)
{
	pmc->counter += 1;
	pmc->counter &= pmc_bitmask(pmc);

	if (!pmc->counter)
		return true;

	return false;
}

static bool amd_incr_counter(struct kvm_pmc *pmc)
{
	pmc->counter += 1;
	pmc->counter &= pmc_bitmask(pmc);

	if (!pmc->counter)
		return true;

	return false;
}

> +		__set_bit(pmc->idx, (unsigned long *)&pmc_to_pmu(pmc)->global_status);

Using __set_bit() is unnecessary, ugly, and dangerous.  KVM uses set_bit(), no
underscores, for things like reprogram_pmi because the updates need to be atomic.

The downside of __set_bit() and friends is that if pmc->idx is garbage, KVM will
clobber memory, whereas BIT_ULL(pmc->idx) is "just" undefined behavior.  But
dropping the update is far better than clobbering memory, and can be detected by
UBSAN (though I doubt anyone is hitting this code with UBSAN).

For this code, a regular ol' bitwise-OR will suffice.  

> +		kvm_make_request(KVM_REQ_PMU, vcpu);
> +
> +		if (pmc->eventsel & ARCH_PERFMON_EVENTSEL_INT)
> +			set_bit(pmc->idx, (unsigned long *)&pmc_to_pmu(pmc)->reprogram_pmi);

This is badly in need of a comment, and the ordering is unnecessarily weird.
Set bits in reprogram_pmi *before* making the request.  It doesn't matter here
since this is all on the same vCPU, but it's good practice since KVM_REQ_XXX
provides the necessary barriers to allow for safe, correct cross-CPU updates.

That said, why on earth is the mediated PMU using KVM_REQ_PMU?  Set global_status
and KVM_REQ_PMI, done.

> +	}
> +}
> +
>  static void kvm_pmu_incr_counter(struct kvm_pmc *pmc)
>  {
>  	pmc->emulated_counter++;
> @@ -880,7 +906,8 @@ static inline bool cpl_is_matched(struct kvm_pmc *pmc)
>  	return (static_call(kvm_x86_get_cpl)(pmc->vcpu) == 0) ? select_os : select_user;
>  }
>  
> -void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel)
> +static void __kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel,
> +				    bool is_passthrough)
>  {
>  	DECLARE_BITMAP(bitmap, X86_PMC_IDX_MAX);
>  	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
> @@ -914,9 +941,19 @@ void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel)
>  		    !pmc_event_is_allowed(pmc) || !cpl_is_matched(pmc))
>  			continue;
>  
> -		kvm_pmu_incr_counter(pmc);
> +		if (is_passthrough)
> +			kvm_passthrough_pmu_incr_counter(vcpu, pmc);
> +		else
> +			kvm_pmu_incr_counter(pmc);
>  	}
>  }
> +
> +void kvm_pmu_trigger_event(struct kvm_vcpu *vcpu, u64 eventsel)
> +{
> +	bool is_passthrough = is_passthrough_pmu_enabled(vcpu);
> +
> +	__kvm_pmu_trigger_event(vcpu, eventsel, is_passthrough);

Using an inner helper for this is silly, even if the mediated information were
snapshot per-vCPU.  Just grab the snapshot in a local variable.  Using a param
adds no value and unnecessarily obfuscates the code.

That's all a moot point though, because (a) KVM can check enable_mediated_pmu
directy and (b) pivoting on behavior belongs in kvm_pmu_incr_counter(), not here.

And I am leaning towards having the mediated vs. perf-based code live in the same
function, unless one or both is "huge", so that it's easier to understand and
appreciate the differences in the implementations.

Not an action item for y'all, but this is also a great time to add comments, which
are sorely lacking in the code.  I am more than happy to do that, as it helps me
understand (and thus review) the code.  I'll throw in suggestions here and there
as I review.

Anyways, this?

static void kvm_pmu_incr_counter(struct kvm_pmc *pmc)
{
	/*
	 * For perf-based PMUs, accumulate software-emulated events separately
	 * from pmc->counter, as pmc->counter is offset by the count of the
	 * associated perf event.  Request reprogramming, which will consult
	 * both emulated and hardware-generated events to detect overflow.
	 */
	if (!enable_mediated_pmu) {
		pmc->emulated_counter++;
		kvm_pmu_request_counter_reprogram(pmc);
		return;
	}

	/*
	 * For mediated PMUs, pmc->counter is updated when the vCPU's PMU is
	 * put, and will be loaded into hardware when the PMU is loaded.  Simply
	 * increment the counter and signal overflow if it wraps to zero.
	 */
	pmc->counter = (pmc->counter + 1) & pmc_bitmask(pmc);
	if (!pmc->counter) {
		pmc_to_pmu(pmc)->global_status) |= BIT_ULL(pmc->idx);
		kvm_make_request(KVM_REQ_PMI, vcpu);
	}
}
