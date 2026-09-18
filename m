Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7B151614B
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748181; cv=none; b=i6zFKJX0tMBxHBanKywIOxGnh0lHxjaMReNk0Am2kJ+ufbhTbOeBUxCs74KTGf1oiabzaVmHZ6ZVmyP6pYro3lk8vvHRUZOfEf/TPqAi9B7OzMaTLZaPmTzKSgddAXBCDbFlE7Rp3doR+ti30XFs/3wLY7mYVFTkpxX5Yxwxjp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748181; c=relaxed/simple;
	bh=RVsUQU/Ro7R2F4xpGYXv0UWITAgZwghcEwzYUcts//o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BqxsxK/7ygOa/2/N4hOC3BA4LcpFSHbhjl6GgAQV9yd2pfvMUY76Oqhmg96YsnjTHSuXpTcn8f9t+D5Qhjbbfw67luqJoR6sP+rC8bZpCzpUjMQJZY9Pr3NsLektZRWTeFI78j+vZriEeSQcohcmg7brPmnB7qjV+J9Pt23TMbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o0w/Xvls; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o0w/Xvls"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39b77130a7fso1794659a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789748179; x=1790352979; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GRTs38TMbxGOFAG8NUirRaUDwmENku4BcrpfCubKTX8=;
        b=o0w/Xvls2Fx6cnvUxr3muRO2BR/rjtrybIlG2kxL71F3AddNHRGD5cdJNR51DSNP10
         YbQzVgIqQZMt36grV9xGeNDB/1RipWwsT2b0Cp9xkJoeF8mNCrTMSJtMLA4vPq7wPfRE
         j8I60BIhFP88PKe7uiEvGlCpchCaY0nRMWMZH/4J+K7NZ/r9ipmjdYJxs6+CtRF+TbW0
         3YUrAouyM6PN9NAjlf9KnPEnhPF+oDNqCxYar/mAMVgzifL/O7PNIsmQ5G+sHjWMjH5z
         Yp3M99Y0ets7daTuEyhyS77CBJmyr9eq24XMau2Coa964dSYxIBnaJjJWF7+d77S+8WE
         lk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789748179; x=1790352979;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GRTs38TMbxGOFAG8NUirRaUDwmENku4BcrpfCubKTX8=;
        b=GQZpSLOKfvHuOGYTrHdO6Qjdn2MUJzIgrBX7rth55eVrfoPJQgmfJSjt7tfVTY10e4
         DOI3IM095qA2qmjuSn/oydnYjEUZAu2riaPoWh0y596zTOGWrRvGOf+PY/8AE7CPnGMW
         TI0V6qdQ5iuEU7Rx8aNTMB7RxlcbSfHmYW1vwq908Q/EWQNeZumA3r1zQ18PJKYh8FsT
         qbGwDIOtosE0QdsoU385OFi8CvHKTaSYNRYiEAERvaH+eLummCxAC0HldHm9D6luZoOB
         uTIz3D36evKHqnTLyyj7jM/JTf3wxQjxhDiM/HDZsN2sc3YVctKbGk5IJ4LSL1hFcf8t
         p8WA==
X-Forwarded-Encrypted: i=1; AKwUvBz2IDWGtWgqPMZTqHFoi9oOXoGx7RA57mhEfZvwk3FRVIL3V+GuX/Y3hjpPif4EHBwbD8BCa7E4xwATWWIiQSer@vger.kernel.org
X-Gm-Message-State: AFuF++kVpCsHA/Ops6sp8KUQ6RADP5pABBiYSFegT8z1P7r3KKtXZskA
	/aSoA1RnGyXV7Hh8B9GHMtfs1G7+QMq4q5JwRLk/oJWETRtj2MQYkWajDvtTfG/PEc9uvUZB015
	QH8ocDA==
X-Received: from pjbmg8.prod.google.com ([2002:a17:90b:3708:b0:39d:b566:bcb6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2243:b0:39d:f770:774
 with SMTP id 98e67ed59e1d1-39e54c9c1bamr6325374a91.20.1789748178634; Fri, 18
 Sep 2026 09:16:18 -0700 (PDT)
Date: Fri, 18 Sep 2026 09:16:17 -0700
In-Reply-To: <20260918160006.61816-1-absandze@amazon.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918160006.61816-1-absandze@amazon.de>
Message-ID: <aq1j0aUKpr15AiqS@google.com>
Subject: Re: [PATCH] KVM: x86/pmu: Don't retry a counter whose config was rejected
From: Sean Christopherson <seanjc@google.com>
To: Luka Absandze <absandze@amazon.de>
Cc: pbonzini@redhat.com, sandipan.das@amd.com, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, dwmw2@infradead.org, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Sep 18, 2026, Luka Absandze wrote:
> kvm_pmu_handle_event() re-arms the reprogram bit for every failed
> reprogram, on the assumption that the failure is transient and a later
> refresh will succeed.  That is true for contention, e.g. the -EBUSY from
> x86_reserve_hardware(), but not for a configuration the host PMU driver
> rejects outright.  A rejected config can never succeed on retry, so the
> counter is reprogrammed on every PMU refresh for as long as the guest
> leaves it enabled, and every attempt fails the same way.
> 
> Skip the re-arm for -EINVAL, one of the errnos the x86 PMU drivers use
> for a config they will never accept.  Note this becomes reachable on AMD
> only with the patch linked below, which starts rejecting the Merge event
> (PMCxFFF) a guest programs as part of a Large Increment per Cycle pair;
> on Intel it is already reachable today via the INTEL_FIXED_VLBR_EVENT
> check in intel_pmu_hw_config(), where the config is likewise a function
> of fixed guest state and can never start being accepted.
> 
> Link: https://lore.kernel.org/all/20260916123315.89042-1-absandze@amazon.de/
> Signed-off-by: Luka Absandze <absandze@amazon.de>
> ---
>  arch/x86/kvm/pmu.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index a7d60c8785cd..b9945a6256ed 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -680,8 +680,14 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
>  		 * reprogram bit, i.e. opportunistically try again on the next
>  		 * PMU refresh.  Don't make a new request as doing so can stall
>  		 * the guest if reprogramming repeatedly fails.
> +		 *
> +		 * -EINVAL means the event's config was rejected outright and
> +		 * can never succeed on retry, so don't re-arm; the guest can
> +		 * still do so itself by rewriting the event selector.
>  		 */
> -		if (reprogram_counter(pmc))
> +		int r = reprogram_counter(pmc);
> +
> +		if (r && r != -EINVAL)
>  			set_bit(pmc->idx, pmu->reprogram_pmi);

Hmm, would it instead make more sense to explicitly check for -EBUSY?  -EINVAL
isn't the only fatal error code.

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index a7d60c8785cd..5296ee8f32af 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -681,7 +681,7 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 		 * PMU refresh.  Don't make a new request as doing so can stall
 		 * the guest if reprogramming repeatedly fails.
 		 */
-		if (reprogram_counter(pmc))
+		if (reprogram_counter(pmc) == -EBUSY)
 			set_bit(pmc->idx, pmu->reprogram_pmi);
 	}
 
Though I guess one could argue -ENOMEM is also transient?  I definitely prefer
an "allow"-list though.  And I find it easier to read if 'r' is declared outside
the loop (and less of a chance of variable shadowing; the odds of returning a
stale value are quite low given there is no return value, and probably never will
be a return value).

E.g. this? (completely untested)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index a7d60c8785cd..03a470c49a74 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -662,7 +662,7 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 	DECLARE_BITMAP(bitmap, X86_PMC_IDX_MAX);
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
 	struct kvm_pmc *pmc;
-	int bit;
+	int bit, r;
 
 	bitmap_copy(bitmap, pmu->reprogram_pmi, X86_PMC_IDX_MAX);
 
@@ -676,12 +676,14 @@ void kvm_pmu_handle_event(struct kvm_vcpu *vcpu)
 
 	kvm_for_each_pmc(pmu, pmc, bit, bitmap) {
 		/*
-		 * If reprogramming fails, e.g. due to contention, re-set the
-		 * reprogram bit, i.e. opportunistically try again on the next
-		 * PMU refresh.  Don't make a new request as doing so can stall
-		 * the guest if reprogramming repeatedly fails.
+		 * If reprogramming fails on a transient condition, e.g. due to
+		 * contention, re-set the reprogram bit, i.e. opportunistically
+		 * try again on the next PMU refresh.  Don't make a new request
+		 * as doing so can stall the guest if reprogramming repeatedly
+		 * fails.
 		 */
-		if (reprogram_counter(pmc))
+		r = reprogram_counter(pmc);
+		if (r == -EBUSY || r == -ENOMEM)
 			set_bit(pmc->idx, pmu->reprogram_pmi);
 	}
 
