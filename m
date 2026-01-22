Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A497385538
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099618; cv=none; b=BLSGq3/Hl5FvsNxFGPSJcvSD4xLEW/ciMdMMVr02UoeqMTi5EBuBNgEQyEd5rJHH163vGdqsGbtWDhtZbdTOsCdGOyarxj01rgKPUiCrUTA3Me+7eYV/oOQmn5Kmyu3QSdGBF/LbsXWzFTe6ENOUCW5MW8h+TyzDFZtwNG7+yOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099618; c=relaxed/simple;
	bh=Y/DxrZLydpwmmz0Syms0uR2pI10+1mDz4PNBLrDgRbk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CDwd6fMcmZgR5K0BVEUovjMSu6rP+OUUaSKaAQSsll2dFIi9nBOes98Z/6yKI1TPVwriweLJNPHhjVxjaGhLCrNyKic3qfOrnUhUq7d0i8H9RNBbqD4yj5D/zOLaNTP31TgwHBk+GqiyHiEf0NEVEPrywRUegr3/VU3MR54jqcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2NmUl2eb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2NmUl2eb"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29f25e494c2so12974715ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 08:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769099613; x=1769704413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0DHre52zcfUG5Dlxo0L5XhBtVLSt791ZQgqxsuF7FrM=;
        b=2NmUl2ebtpbENV5/kQCF9lDFfIlwJxVRZRFZ4XBnM4FljWw2fb3jLrLNixAV6e6Opb
         FYYcMYpvLz9uL6atZjY6b+i8VZCX8S18Lf0RnQTAYLqQUtevx4hiPi652YnR+1iQ/RLV
         WTxXfBBOQnT4i+MrsuNQCOCCGd4qBj7CLqBc8houpnuZ4ob+9SNcY4TRe5Tbar1jp6Iu
         KU2sdpMWKjjeJv3iReueDihV9ykZAQo6AEj+lRbtEVPmJ/YohdOJ0vvyMimBaylbYCj/
         GGrd4lneZLrVlL4xkRl9ojdU0eC/q+gCKklwsN8WxlyiST7tbz+Wcl1RFhCS81JFbhPb
         1mGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769099613; x=1769704413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DHre52zcfUG5Dlxo0L5XhBtVLSt791ZQgqxsuF7FrM=;
        b=kw5m4WoUWN9bwSbIcqYs3U+0JSZ/DwVexLdI4mTkdVH4HLpduXS+RA7+C6nj/8gYMk
         +T/YB3mKWDTt8bJbETa7+HaKFG0+MUS7iCWrovZNziMX0PaIaR9wdjgcVwPVxoMcYrsz
         QzlDy+cQKXG6o7nV+mYZAoHooFthbJzHVESNCrkMfy/Ld5MJ0S0BLri/ydnf2KB8nEDJ
         hbpz5b4f01DhTfUYv3TZA4KRliZ1pkkOZfeviKqq9xErwSg/l13M/XFB9Nycr2/MPE6h
         rnHjan+9VjwMYQXsShJ30fCLMUdRrAv391QXXhDVgzgY/5ITPNHZMtQ1bzSl1ZKnHK9A
         rSzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0QYGnMZ9HP9qr0Ojl0IdGMEsPgyDf7FKBzm0gAnF4fmzs0GFy3eyMjEuzbXfep1RN7dqsQKEGCV653jQlrREV@vger.kernel.org
X-Gm-Message-State: AOJu0YzFna54It7Pq3o2xsJ/ZNI4pNoIGxARZIms1GVR3GigX+7LFdr+
	7snTI4vf98+eGoN0Btu3w2w8FGQkAX41pw1skep+QU1cDHvVxG7H/IS5GjlVHvsaxLtwus2hS71
	5x5fOsQ==
X-Received: from plbkm11.prod.google.com ([2002:a17:903:27cb:b0:2a0:9570:8e5b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aa7:b0:2a0:b432:4a6
 with SMTP id d9443c01a7336-2a7d2f34befmr38192235ad.15.1769099612668; Thu, 22
 Jan 2026 08:33:32 -0800 (PST)
Date: Thu, 22 Jan 2026 08:33:30 -0800
In-Reply-To: <20260121225438.3908422-3-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260121225438.3908422-1-jmattson@google.com> <20260121225438.3908422-3-jmattson@google.com>
Message-ID: <aXJRWtdzjcb8_APA@google.com>
Subject: Re: [PATCH 2/6] KVM: x86/pmu: Disable HG_ONLY events as appropriate
 for current vCPU state
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
> Introduce amd_pmu_dormant_hg_event(), which determines whether an AMD PMC
> should be dormant (i.e. not count) based on the guest's Host-Only and
> Guest-Only event selector bits and the current vCPU state.
> 
> Update amd_pmu_set_eventsel_hw() to clear the event selector's enable bit
> when the event is dormant.
> 
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/include/asm/perf_event.h |  2 ++
>  arch/x86/kvm/svm/pmu.c            | 23 +++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index 0d9af4135e0a..7649d79d91a6 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -58,6 +58,8 @@
>  #define AMD64_EVENTSEL_INT_CORE_ENABLE			(1ULL << 36)
>  #define AMD64_EVENTSEL_GUESTONLY			(1ULL << 40)
>  #define AMD64_EVENTSEL_HOSTONLY				(1ULL << 41)
> +#define AMD64_EVENTSEL_HG_ONLY				\

I would strongly prefer to avoid the HG acronym, as it's not immediately obvious
that it's HOST_GUEST, and avoiding long lines even with the full HOST_GUEST is
pretty easy.

The name should also have "MASK" at the end to make it more obvious this is a
multi-flag macro, i.e. not a single-flag value.  Otherwise the intent and thus
correctness of code like this isn't obvious:

	if (eventsel & AMD64_EVENTSEL_HG_ONLY)

How about AMD64_EVENTSEL_HOST_GUEST_MASK?

> +	(AMD64_EVENTSEL_HOSTONLY | AMD64_EVENTSEL_GUESTONLY)
>  
>  #define AMD64_EVENTSEL_INT_CORE_SEL_SHIFT		37
>  #define AMD64_EVENTSEL_INT_CORE_SEL_MASK		\
> diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> index 33c139b23a9e..f619417557f9 100644
> --- a/arch/x86/kvm/svm/pmu.c
> +++ b/arch/x86/kvm/svm/pmu.c
> @@ -147,10 +147,33 @@ static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	return 1;
>  }
>  
> +static bool amd_pmu_dormant_hg_event(struct kvm_pmc *pmc)

I think I would prefer to flip the polarity, even though the only caller would
then need to invert the return value.  Partly because I think we can come up with
a more intuitive name, partly because it'll make the last check in particular
more intutive, i.e. IMO, checking "guest == guest"

	return !!(hg_only & AMD64_EVENTSEL_GUESTONLY) == is_guest_mode(vcpu);

is more obvious than checking "host == guest":

	return !!(hg_only & AMD64_EVENTSEL_GUESTONLY) == is_guest_mode(vcpu);

Maybe amd_pmc_is_active() or amd_pmc_counts_in_current_mode()?

> +{
> +	u64 hg_only = pmc->eventsel & AMD64_EVENTSEL_HG_ONLY;
> +	struct kvm_vcpu *vcpu = pmc->vcpu;
> +
> +	if (hg_only == 0)

!hg_only

In the spirit of avoiding the "hg" acronym, what if we do something like this?

	const u64 HOST_GUEST_MASK = AMD64_EVENTSEL_HOST_GUEST_MASK;
	struct kvm_vcpu *vcpu = pmc->vcpu;
	u64 eventsel = pmc->eventsel;

	/*
	 * PMCs count in both host and guest if neither {HOST,GUEST}_ONLY flags
	 * are set, or if both flags are set.
	 */
	if (!(eventsel & HOST_GUEST_MASK) ||
	    ((eventsel & HOST_GUEST_MASK) == HOST_GUEST_MASK))
		return true;

	/* {HOST,GUEST}_ONLY bits are ignored when SVME is clear. */
	if (!(vcpu->arch.efer & EFER_SVME))
		return true;

	return !!(eventsel & AMD64_EVENTSEL_GUESTONLY) == is_guest_mode(vcpu);

> +		/* Not an HG_ONLY event */

Please don't put comments inside single-line if-statements.  99% of the time
it's easy to put the comment outside of the if-statement, and doing so encourages
a more verbose comment and avoids a "does this if-statement need curly-braces"
debate.

> +		return false;
> +
> +	if (!(vcpu->arch.efer & EFER_SVME))
> +		/* HG_ONLY bits are ignored when SVME is clear */
> +		return false;
> +
> +	/* Always active if both HG_ONLY bits are set */
> +	if (hg_only == AMD64_EVENTSEL_HG_ONLY)

I vote to check this condition at the same time !hg_only is checked.  From a
*very* pedantic perspective, one could argue it's "wrong" to check the bits when
SVME=0, but the purpose of the helper is to detect if the PMC is active or not.
Precisely following the architectural behavior is unnecessary.

> +		return false;
> +
> +	return !!(hg_only & AMD64_EVENTSEL_HOSTONLY) == is_guest_mode(vcpu);
> +}
> +
>  static void amd_pmu_set_eventsel_hw(struct kvm_pmc *pmc)
>  {
>  	pmc->eventsel_hw = (pmc->eventsel & ~AMD64_EVENTSEL_HOSTONLY) |
>  		AMD64_EVENTSEL_GUESTONLY;
> +
> +	if (amd_pmu_dormant_hg_event(pmc))
> +		pmc->eventsel_hw &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
>  }
>  
>  static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> -- 
> 2.52.0.457.g6b5491de43-goog
> 
