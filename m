Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E62C1C84DE
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Mar 2026 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772741736; cv=none; b=FBio7Artiynz7yctY/Wl8ACcwW6NnKl/kUHnbnsZfUDoonyyN4KhnTohhe5QToRxSPGeE9v0l2/GNe7x3yoF61M1mcHLoN2saCYuBtfm7Jb9vaW4hWag7m4zI8b6IbQLZe7ZarqMW2satvRPGHAl1wIbeYoz5jxn/T9nm7OLA68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772741736; c=relaxed/simple;
	bh=UNkfBWoKxhoF1oDNewD87BNjfD5wAIKwW/8SEt4F0KU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YWACmsq773p1Y60AQ4ky5qHWgg+1TGmcmCrLwKlZbAbLZ6+GdoYGOZC/lJnaIi3Wj1wlXQDPVGlLDKOx5PSasDO4Wc24iVV5lWb4rIV6WMDKu2BXUfbcg7J3H/QOXnMw7NMiX0VlEZO/FuA9AGtqzwEDmHGVMTF4/J6B4RotUyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jch17xj+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jch17xj+"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35641c14663so8833975a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Mar 2026 12:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772741733; x=1773346533; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q5GQ+iLBA7Lk6r8UZZlNI7qBsJqloLBwP6g5inHdZV0=;
        b=jch17xj+YowXAg2YA4xFUQQqHcEaiTIL3zrX6XrKIXsGaMaLSiigUJDIl5NR0U+SuD
         b7iKZkT58UbbkzdxTgHwTAeTOsDdIM7ZD/eimTYiMf3LYi81WO0C8Q/qpEKps97MHcmo
         nwsN/h3aoDlOT5/GUqpQmWCmm+cXM4smW33sqsU9gCB5pBn3aB8J7t5uAptMt/THssKW
         6RNtgXv2pDYOihAyHYYEsosBgEtGR8PKRQHGVwPeIeISk7kl5oDraNzaOnyQuAnDxWLo
         P1io4ItBli450ESVh1a7y4FmJrcX0qsjVflKmHf+Ehg42oiaidPGFByYqQRa5HvYZN6J
         3NbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772741733; x=1773346533;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5GQ+iLBA7Lk6r8UZZlNI7qBsJqloLBwP6g5inHdZV0=;
        b=FWnQ+UhQkoKkh3v0Sk+KYfWNeDhu/L+1D5iljSq5JEiGWB5YIxJuggmG4wi8Eng6I2
         A1KjxWPAfMQ7xGPWHLJlP5G1VfBRLZ9Nu9nMWnmoeBeaxEQzqxEfRRO0m2mmPfuo6Bwy
         2iIdZ15Ez4dbklLxvYFJM9JGz73lpGmtolxlQgDDlU+xCkFBPusAC7nnrMvNDz9kOhma
         WCV6ojQxk+RX3HVBRAqQ4TBRu/VAKhA+Uo0IVRUiZPjNL2+DNZkJzFAKjy74mAGA539w
         u19vdaI/bg+ucWeAKlqSC60VkHI4Lntkp0VHtS7QUdD5b+TS8h8lwdGQjkWING6BXSGd
         kKmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5vdIzqvc35JRa5a1KaC6ghHVCAEy7sqmFHV54vjMUYRzcRGE/OMEzfZEbFr0sO6TOD2XBe//jDh57k7ZFdq2t@vger.kernel.org
X-Gm-Message-State: AOJu0YzWQpsumnoQ9WzieZljbAxCJ+TVon/TwbOoBNV3f+xqDSJ752BQ
	S/MR+aFFqAYV1q1lsTeSJPKdrpyL0WyAFLU+BYYoWZGOfbIM9wMfga+ZAGQ7HtM2vSKx6Zh4ofl
	XzD0p0g==
X-Received: from pjwx4.prod.google.com ([2002:a17:90a:c2c4:b0:358:e87a:c86b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:518e:b0:359:9cb8:db5
 with SMTP id 98e67ed59e1d1-359a6a6f4fdmr5719092a91.26.1772741733417; Thu, 05
 Mar 2026 12:15:33 -0800 (PST)
Date: Thu, 5 Mar 2026 12:15:32 -0800
In-Reply-To: <20260207012339.2646196-4-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260207012339.2646196-1-jmattson@google.com> <20260207012339.2646196-4-jmattson@google.com>
Message-ID: <aankZK5IAdB6GmDy@google.com>
Subject: Re: [PATCH v3 3/5] KVM: x86/pmu: Refresh Host-Only/Guest-Only
 eventsel at nested transitions
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>, Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 06, 2026, Jim Mattson wrote:
> Add amd_pmu_refresh_host_guest_eventsel_hw() to recalculate eventsel_hw for
> all PMCs based on the current vCPU state. This is needed because Host-Only
> and Guest-Only counters must be enabled/disabled at:
> 
>   - SVME changes: When EFER.SVME is modified, counters with Guest-Only bits
>     need their hardware enable state updated.
> 
>   - Nested transitions: When entering or leaving guest mode, Host-Only
>     counters should be disabled/enabled and Guest-Only counters should be
>     enabled/disabled accordingly.
> 
> Add a nested_transition() callback to kvm_x86_ops and call it from
> enter_guest_mode() and leave_guest_mode() to ensure the PMU state stays
> synchronized with guest mode transitions.

Blech, I'm not a fan of this kvm_x86_ops hook.  I especially don't like calling
out to vendor code from {enter,leave}_guest_mode().  The subtle dependency on
vcpu-arch.efer being up-to-date in svm_set_efer() is a little nasty too.

More importantly, I think this series is actively buggy, as I don't see anything
in amd_pmu_refresh_host_guest_eventsel_hw() that restricts it to the mediated
PMU.  And I'm pretty sure that path will bypass the PMU event filter.  And I
believe kvm_pmu_recalc_pmc_emulation() also needs to be invoked so that emulated
instructions are counted correctly.

To avoid ordering issues and bugs where event filtering and guest/host handling
clobber each other, I think we should funnel all processing through KVM_REQ_PMU,
and then do something like this:

diff --git a/arch/x86/kvm/kvm_cache_regs.h b/arch/x86/kvm/kvm_cache_regs.h
index 14e2cbab8312..a2a9492063f7 100644
--- a/arch/x86/kvm/kvm_cache_regs.h
+++ b/arch/x86/kvm/kvm_cache_regs.h
@@ -227,7 +227,8 @@ static inline void enter_guest_mode(struct kvm_vcpu *vcpu)
 {
        vcpu->arch.hflags |= HF_GUEST_MASK;
        vcpu->stat.guest_mode = 1;
-       kvm_x86_call(nested_transition)(vcpu);
+
+       kvm_pmu_handle_nested_transition();
 }
 
 static inline void leave_guest_mode(struct kvm_vcpu *vcpu)
@@ -240,7 +241,8 @@ static inline void leave_guest_mode(struct kvm_vcpu *vcpu)
        }
 
        vcpu->stat.guest_mode = 0;
-       kvm_x86_call(nested_transition)(vcpu);
+
+       kvm_pmu_handle_nested_transition();
 }
 
 static inline bool is_guest_mode(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index 0925246731cb..098dae2d45b4 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -244,6 +244,18 @@ static inline bool kvm_pmu_is_fastpath_emulation_allowed(struct kvm_vcpu *vcpu)
                                  X86_PMC_IDX_MAX);
 }
 
+static inline void kvm_pmu_handle_nested_transition(struct kvm_vcpu *vcpu)
+{
+       if (!kvm_vcpu_has_mediated_pmu(vcpu))
+               return;
+
+       if (vcpu_to_pmu(vcpu)->reserved_bits & AMD64_EVENTSEL_HOST_GUEST_MASK)
+               return;
+
+       atomic64_set(&vcpu_to_pmu(vcpu)->__reprogram_pmi, -1ull);
+       kvm_make_request(KVM_REQ_PMU, vcpu);
+}
+
 void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu);
 void kvm_pmu_handle_event(struct kvm_vcpu *vcpu);
 int kvm_pmu_rdpmc(struct kvm_vcpu *vcpu, unsigned pmc, u64 *data);
