Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDB32F90C4
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100609; cv=none; b=kgDjfHTvrJnplrs3cwzxI7MpX7MVsJ5vCedAJfmOB6nJ9DmeIVSlSSL+/tD+7TZcWtcpRO6P2+m1vaefrj5+GbpdC2IP3AWtzur9VkcwBuiW3XiMsRD7XlaKqw7nPbNHOGru7wjLc/yGmhE8uWf+IL6HxcYh82G64pTVyzi1Zf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100609; c=relaxed/simple;
	bh=w3tyOVuN8FQUsemqueqs7+KcZYp9hKV/p0FncAPIIMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TUymQvdBcZvv9xG/S9BdYsE9GS2oZpfg4268QpH/4TWZPUgI5bzRF9LsVTgNDYiw9LrOMZ4IYZBED0hngWnydMdOZqcGzUzszT06UlQbDDTbRMmOdhzKxAiQ6LcqSXpT12SNHJAN6k/msl9o+Mp9MurTGsIKXlEKnxiphSWHaAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NxvW/Fz5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NxvW/Fz5"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34c48a76e75so1183630a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 08:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769100593; x=1769705393; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BWFocFVTKOU7XXlm8Mgwvdw60IDe+g00em82J1zaTlc=;
        b=NxvW/Fz5eNMTIBrHtTudISubFlf9ClQ0hiLKefYQ3+s69HC12o3NBFmEPxzYR0ZY0Y
         31YDqv2iNd5rVtnzcq/0IxEVTnrkZcu1aXT/0+glS/g4HwPISM/84RGuVbtF/gSFzdEJ
         L5X2cRXPviwCxV4dA4tZZMnlYSYUx2c0OcZ2OByfvoye0NrbVB6iUcCqhF3/OegBTU22
         ja5HZDciQGZpQHalV08hlUPQ74WAf2FmlTaazJv5E2JuGGXxFyuHkZo6FRNCrDhzL00T
         hXsGNtOKyovIQStaY3uRT6NKvmQeaTCHFObElU+m/aEhBuVbPVDC4hO4dB7B9BXpYMeE
         6KsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769100593; x=1769705393;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BWFocFVTKOU7XXlm8Mgwvdw60IDe+g00em82J1zaTlc=;
        b=mzNqm/m23r/cYn8qiiTNwuDXgtqmsUWWlSgoVzv8N12yux3N92P8zwMoQ1OGXV5L7I
         JdYlzEQ0jEZE9imr97euNnhFCcrGPuu76Crybulib+b+SOzLhVFuQ0og6/ivp+/ADEOg
         x/fL0fVUQEnBgPXfJ3/EknFdnu3Lio1oA5KWpcE8GzwO4+/TJqkzyZNYUuM4DGCh5ArW
         V1lpQ92scgS52X6/x0a2/8BdVGLyBCXPGq3tCtvIvpFzSy4Yutwq9wk3yY9DRNgy022V
         To92r1IcTqFxjXqS07RkoxEzmpedu2Rx7uy4eIcS4BrmkkZZMOy2C26x9TuD8JNhskCa
         HGqA==
X-Forwarded-Encrypted: i=1; AJvYcCV7o990yN80PVapmppJDGS+HrYZ2ywvAtc7IJhzdzjGUuZXKRQZBU8ghbM0Gk3H688EzqLZiVYQuFAgB18kB1aP@vger.kernel.org
X-Gm-Message-State: AOJu0YyM+V5c8At/WzBuYf9AAuO3HHhXhMdmMCGjX/Vga0NtzrnU3rbS
	OTz5taxLk6D+SqXCig1dhTE8Z9gEKCXo4qEMEZYgm0vUdnKlDpZXGSteMNmZQjZXuD8zFURHQmZ
	s1l2pkA==
X-Received: from pjbbg10.prod.google.com ([2002:a17:90b:d8a:b0:34c:1d76:2fe9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:582f:b0:343:e461:9022
 with SMTP id 98e67ed59e1d1-353688502bemr107887a91.24.1769100592593; Thu, 22
 Jan 2026 08:49:52 -0800 (PST)
Date: Thu, 22 Jan 2026 08:49:44 -0800
In-Reply-To: <20260121225438.3908422-4-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260121225438.3908422-1-jmattson@google.com> <20260121225438.3908422-4-jmattson@google.com>
Message-ID: <aXJVKFs54eVI1Mjo@google.com>
Subject: Re: [PATCH 3/6] KVM: x86/pmu: Track enabled AMD PMCs with Host-Only
 xor Guest-Only bits set
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
> Add pmc_hostonly and pmc_guestonly bitmaps to struct kvm_pmu to track which
> guest-enabled performance counters have just one of the Host-Only and
> Guest-Only event selector bits set. PMCs that are disabled, have neither
> HG_ONLY bit set, or have both HG_ONLY bits set are not tracked, because
> they don't require special handling at vCPU state transitions.

Why bother with bitmaps?  The bitmaps are basically just eliding the checks in
amd_pmc_is_active() (my name), and those checks are super fast compared to
emulating transitions between L1 and L2.

Can't we simply do:

  void amd_pmu_refresh_host_guest_eventsels(struct kvm_vcpu *vcpu)
  {
	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
	struct kvm_pmc *pmc;
	int i;

	kvm_for_each_pmc(pmu, pmc, i, pmu->all_valid_pmc_idx)
		amd_pmu_set_eventsel_hw(pmc);

  }

And then call that helper on all transitions?

> +static void amd_pmu_update_hg_bitmaps(struct kvm_pmc *pmc)
> +{
> +	struct kvm_pmu *pmu = pmc_to_pmu(pmc);
> +	u64 eventsel = pmc->eventsel;
> +
> +	if (!(eventsel & ARCH_PERFMON_EVENTSEL_ENABLE)) {
> +		bitmap_clear(pmu->pmc_hostonly, pmc->idx, 1);
> +		bitmap_clear(pmu->pmc_guestonly, pmc->idx, 1);
> +		return;
> +	}
> +
> +	switch (eventsel & AMD64_EVENTSEL_HG_ONLY) {
> +	case AMD64_EVENTSEL_HOSTONLY:
> +		bitmap_set(pmu->pmc_hostonly, pmc->idx, 1);
> +		bitmap_clear(pmu->pmc_guestonly, pmc->idx, 1);
> +		break;
> +	case AMD64_EVENTSEL_GUESTONLY:
> +		bitmap_clear(pmu->pmc_hostonly, pmc->idx, 1);
> +		bitmap_set(pmu->pmc_guestonly, pmc->idx, 1);
> +		break;
> +	default:
> +		bitmap_clear(pmu->pmc_hostonly, pmc->idx, 1);
> +		bitmap_clear(pmu->pmc_guestonly, pmc->idx, 1);
> +		break;
> +	}
> +}
> +
>  static bool amd_pmu_dormant_hg_event(struct kvm_pmc *pmc)
>  {
>  	u64 hg_only = pmc->eventsel & AMD64_EVENTSEL_HG_ONLY;
> @@ -196,6 +223,7 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		if (data != pmc->eventsel) {
>  			pmc->eventsel = data;
>  			amd_pmu_set_eventsel_hw(pmc);
> +			amd_pmu_update_hg_bitmaps(pmc);

If we're going to bother adding amd_pmu_set_eventsel_hw(), and not reuse it as
suggested above, then it amd_pmu_set_eventsel_hw() should be renamed to just
amd_pmu_set_eventsel() and it should be the one configuring the bitmaps.  Because
KVM should never write to an eventsel without updating the bitmaps.  That would
also better capture the relationship between the bitmaps and eventsel_hw, e.g.

	pmc->eventsel_hw = (pmc->eventsel & ~AMD64_EVENTSEL_HOSTONLY) |
			   AMD64_EVENTSEL_GUESTONLY;

	if (!amd_pmc_is_active(pmc))
		pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;

	/*
	 * Update the host/guest bitmaps used to reconfigure eventsel_hw on
	 * transitions to/from an L2 guest, so that KVM can quickly refresh
	 * the event selectors programmed into hardware, e.g. without having
	 * to 
	 */
	if (!(eventsel & ARCH_PERFMON_EVENTSEL_ENABLE)) {
		bitmap_clear(pmu->pmc_hostonly, pmc->idx, 1);
		bitmap_clear(pmu->pmc_guestonly, pmc->idx, 1);
		return;
	}

	switch (eventsel & AMD64_EVENTSEL_HG_ONLY) {
	case AMD64_EVENTSEL_HOSTONLY:
		bitmap_set(pmu->pmc_hostonly, pmc->idx, 1);
		bitmap_clear(pmu->pmc_guestonly, pmc->idx, 1);
		break;
	case AMD64_EVENTSEL_GUESTONLY:
		bitmap_clear(pmu->pmc_hostonly, pmc->idx, 1);
		bitmap_set(pmu->pmc_guestonly, pmc->idx, 1);
		break;
	default:
		bitmap_clear(pmu->pmc_hostonly, pmc->idx, 1);
		bitmap_clear(pmu->pmc_guestonly, pmc->idx, 1);
		break;
	}

But I still don't see any point in the bitmaps.

>  			kvm_pmu_request_counter_reprogram(pmc);
>  		}
>  		return 0;
> -- 
> 2.52.0.457.g6b5491de43-goog
> 
