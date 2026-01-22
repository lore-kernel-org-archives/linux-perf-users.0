Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCC023314B
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101007; cv=none; b=IvKFAyHVds2923mK3+ato68qrq+8CbvwhTLM6yQlYIWzH4fQ1er7Np1odqlWuMixx14NN10qO3TYvs8CPLQgWoHmWw9ir2rdKKYwKuTQqZJX6QYhPewkpwVQKueoNN6kPAAD2WStFNFZJNWWQwN/qVG8a6aD0V8NqT+y9TzJIUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101007; c=relaxed/simple;
	bh=Yf+igg/0T/SpQYPavLQMecLpXEeSCNSZYUcGUDrvzCY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fznNvGy2LkIQZaQ9leywyAZ9EPqXa1AQh8i6henTT/iw2RY3UbUZ8Ws+c5nF+MQTR4baYU84lKVCIkyzp5fIL+yAwB9nXONf3IPLjllDLaqXzWiXnH6N2PssZzM+TiOUVuvmgK2BFPd9x0LkLwf0XkOkqS3WC6Di5JTP3Ggbm8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oiwTiO4P; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oiwTiO4P"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34ab459c051so2297872a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 08:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769100997; x=1769705797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+IiM9zxRKuZ+6sYf4z2FhEzx3BA+tRZU19IyCToaTCc=;
        b=oiwTiO4PbzdYKQxlU3BoDVMEUp2RymOy2wrZ8tKcNIjZxXC+tiAPsQ972SYK8Qjoht
         t26+kP7RBI5i+MmJVShlWeBFdipbsWwdz8To48ib/fE2iWls5PfPN0OvFz8QmV0mnYKL
         E9sFcvC8SOh4dwtUgQ4aBln3PcbRhtcNO8HERI29Winj+t9vAT6ioCS2FsL6xJIbC/vK
         Olc8jwry6UfMnmqMXozjccI5bL3sDt7xPwMdMMEum4YSyinVT+mARADqFlNa0yqLCmuS
         PzK1/Iqs++r2BmackYerl8BQlaVhGWE43ZWENd0bRDFxu/Tmvw/e40ywGkdLBu6hYerU
         n0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769100997; x=1769705797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+IiM9zxRKuZ+6sYf4z2FhEzx3BA+tRZU19IyCToaTCc=;
        b=OGle8mTkD6+tadaUpJHREqxPCCWZqBe/KxoX1Gfq3cB1QoDeKIATd8TG+y6+6E6b4A
         Fyqckq/GsfmojPCun9u7Jtcf1UOEVG0AHEGNdCiH/tf+MDNw1+TWAOpqIHaIbBwEKVQ5
         QKn6hXrVPC/FvNHIPwrIcAeklm9+1cRBRfvX02+O9pjDWKxftew7NvtOGpv7LBC2GfFa
         ih67trsYL5p8YJJJ1kT15EaqBBcqAw9Yjm26HoDxxr4VUT0DtU/9yZexcJTtELCxsAf2
         Kjez/5cBm/9JgQHXn2aCcphEQ3p0bkIWq+1vCAzL9aQ6oiwxxU9VQjtUjM6yESbPFYTa
         3WnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcuzcXkszhAoPhfjBdN/1kGT34t3MlSH8Fj8KFK1O3Y/JS6sKDIVtSffzZPmlWVCO1dCxkknLAohOgRzdbvIiq@vger.kernel.org
X-Gm-Message-State: AOJu0YxQm6V0qlOh7MAG86q4lMntKyaytCSzs7OQnZ+KB1JJA4U7q/M+
	S6ccLQkEKOuuZ29nqPLJWXi9qrhIVJfAHanzDeTuoRX2XBpdr14CZ/j8Az2lA3KJ2m9t7VVOhfZ
	5qj780A==
X-Received: from pjbmj3.prod.google.com ([2002:a17:90b:3683:b0:352:b687:3b20])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b07:b0:32e:38b0:15f4
 with SMTP id 98e67ed59e1d1-35367015637mr155901a91.7.1769100997358; Thu, 22
 Jan 2026 08:56:37 -0800 (PST)
Date: Thu, 22 Jan 2026 08:56:36 -0800
In-Reply-To: <20260121225438.3908422-6-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260121225438.3908422-1-jmattson@google.com> <20260121225438.3908422-6-jmattson@google.com>
Message-ID: <aXJWxIzxf8nLTPSB@google.com>
Subject: Re: [PATCH 5/6] KVM: x86/pmu: Allow HG_ONLY bits with nSVM and
 mediated PMU
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jan 21, 2026, Jim Mattson wrote:
> If the vCPU advertises SVM and uses the mediated PMU, allow the guest to
> set the Host-Only and Guest-Only bits in the event selector MSRs.
> 
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/kvm/svm/pmu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index 85155d65fa38..a1eeb7b38219 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -262,8 +262,13 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
>  		pmu->global_status_rsvd = pmu->global_ctrl_rsvd;
>  	}
>  
> -	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(48) - 1;
>  	pmu->reserved_bits = 0xfffffff000280000ull;
> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SVM) &&
> +	    kvm_vcpu_has_mediated_pmu(vcpu))
> +		/* Allow Host-Only and Guest-Only bits */

Meh, no comment needed if the macro is more descriptive.

> +		pmu->reserved_bits &= ~AMD64_EVENTSEL_HG_ONLY;
> +
> +	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(48) - 1;

Spurious code movement?

>  	pmu->raw_event_mask = AMD64_RAW_EVENT_MASK;
>  	/* not applicable to AMD; but clean them to prevent any fall out */
>  	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
> -- 
> 2.52.0.457.g6b5491de43-goog
> 
