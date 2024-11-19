Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667581D0157
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030680; cv=none; b=ippffzFHYmrgXWwSH4qO0UY7HqoFmQQDsJAnJn/sZVTUW0FXw/mL3hTLxHQ3kpAjNN/8EB49Ar/rqg9aQxBQDPKsqyU+4Zoicr/oroqRrNIsLha3inFhyhkcJC0xoDHQ5xjqudp5PDHs1DUiEiXv88B01TS+JCrguom6S3GXPos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030680; c=relaxed/simple;
	bh=cTwjzGqKUpqGH8nA7SsQ+OktimoPQfVv87Z1DfG8K7c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bZFTd8Y+Lh9p30l+gtA8uDuZfl4SK5lLpt/7PUW4Y3Bhx4IvPUV/5EW3iF3VaNXUVoUrF2rgAvN7BJFS7ItjEY1I/KrzqzW/3menR/R8Xa472/1ADM+w+JaBuJ5zYdMfbOJ9QVi0zJK0AviIAxwRI3gKb6qhBJtXxKpag9AuydM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pqaDuSKN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pqaDuSKN"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ea4291c177so2813780a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 07:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732030679; x=1732635479; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fPN8/Su0I+qo2YHY6QxpzBdT5jWaWm8vD60kZIe4g6A=;
        b=pqaDuSKN/2LOomFpubFz5IR5F12zaNa+Xn69+SH2CXi97ITGCzXakkZHX3zxJHC6d1
         zSD3t6KGhFJnT6cHMd85Gk3p0+Z4pdu//3/pg8RoiPUuF0Ps0G92cSkjrO1T4n64hO0l
         Hqzv39baIouKwPOmx0H/vPfo+jBfvJgFI8JfWtBmveaxFFE1PyHIpuoqkH0eb3K2omyF
         KhU9oyRW1isyGNemA/t/Q0OqLkVeIIjZ3w+vG08N6pvBSceqNuXr6M/asvFBiDPQcQat
         qQfs8hcs7uE9NWE4jV+f0WPFPesURikRbsoLvu65dDoRoR6+zVpAnLQbILd0o0mCck8p
         N0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732030679; x=1732635479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPN8/Su0I+qo2YHY6QxpzBdT5jWaWm8vD60kZIe4g6A=;
        b=jfFuYL/NvK40NUeSrOtn7ueT3OxNAlePSD+Ckg6SLABPxEPhq3HFJufsT4MKKJjZLU
         LNj/MY/XBFExDuCXskquaicTT9tyekK1HmVzzxjiXKvVkVHpcU1rwz1fMJ/jdoDG8tgl
         Y6pG9mHMOS4wxKQOdVBCD2t6NILr33JPtMgN7oEAEANXCw42KIOZ3Oraf7g+WH/KXxMG
         s/LiwmQQjRPPpyCg42+muJm06sMBhHVsw+bnBBl1Uug4IY0qEaN0sEyiQsGBWTYOBar4
         VAKYLPZreIy4ne6kIH8uHJKNDcGP6QZv7x0J1PcCDbwsckribEcGtnHDUTGXPpVeMeFQ
         9Mig==
X-Forwarded-Encrypted: i=1; AJvYcCXdjvDwWsULicLLkVx4BC2y+7eEYCOILNTw+/oqTA+HY0/V4UmeuTo/CDW4kM04nvg+h5tH+cX6UCa/XMu1hp2w@vger.kernel.org
X-Gm-Message-State: AOJu0YyPcz+PQ5jTprd52TCdfD398SOl5j4MUN31pKiAeM0CEOF8rPec
	Aa8qDz9509wawzh+2rS11Z5zEMB2T7RJzZpQSXG+tNQCyewl7L/Jex5hajC2HBAdioT2t8uRsks
	a4w==
X-Google-Smtp-Source: AGHT+IEtTpRNnYoRrw3+3gI3YR2Wbbv0fwFuzSmYLC46Hb5WA9M4JELz/5AzVoE3pfqrSuz8dF5FBhgy5Dg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90a:8d0a:b0:2ea:31f3:d646 with SMTP id
 98e67ed59e1d1-2ea31f3d76amr20660a91.7.1732030678733; Tue, 19 Nov 2024
 07:37:58 -0800 (PST)
Date: Tue, 19 Nov 2024 07:37:57 -0800
In-Reply-To: <20240801045907.4010984-21-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com> <20240801045907.4010984-21-mizhang@google.com>
Message-ID: <Zzyw1UyapXDNpc-c@google.com>
Subject: Re: [RFC PATCH v3 20/58] KVM: x86/pmu: Always set global enable bits
 in passthrough mode
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
> From: Sandipan Das <sandipan.das@amd.com>
> 
> Currently, the global control bits for a vcpu are restored to the reset
> state only if the guest PMU version is less than 2. This works for
> emulated PMU as the MSRs are intercepted and backing events are created
> for and managed by the host PMU [1].
> 
> If such a guest in run with passthrough PMU, the counters no longer work
> because the global enable bits are cleared. Hence, set the global enable
> bits to their reset state if passthrough PMU is used.
> 
> A passthrough-capable host may not necessarily support PMU version 2 and
> it can choose to restore or save the global control state from struct
> kvm_pmu in the PMU context save and restore helpers depending on the
> availability of the global control register.
> 
> [1] 7b46b733bdb4 ("KVM: x86/pmu: Set enable bits for GP counters in PERF_GLOBAL_CTRL at "RESET"");
> 
> Reported-by: Mingwei Zhang <mizhang@google.com>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> [removed the fixes tag]
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/kvm/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 5768ea2935e9..e656f72fdace 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -787,7 +787,7 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
>  	 * in the global controls).  Emulate that behavior when refreshing the
>  	 * PMU so that userspace doesn't need to manually set PERF_GLOBAL_CTRL.
>  	 */
> -	if (kvm_pmu_has_perf_global_ctrl(pmu) && pmu->nr_arch_gp_counters)
> +	if ((pmu->passthrough || kvm_pmu_has_perf_global_ctrl(pmu)) && pmu->nr_arch_gp_counters)
>  		pmu->global_ctrl = GENMASK_ULL(pmu->nr_arch_gp_counters - 1, 0);

This is wrong and confusing.  From the guest's perspective, and therefore from
host userspace's perspective, PERF_GLOBAL_CTRL does not exist.  Therefore, the
value that is tracked for the guest must be '0'.

I see that intel_passthrough_pmu_msrs() and amd_passthrough_pmu_msrs() intercept
accesses to PERF_GLOBAL_CTRL if "pmu->version > 1" (which, by the by, needs to be
kvm_pmu_has_perf_global_ctrl()), so there's no weirdness with the guest being able
to access MSRs that shouldn't exist.

But KVM shouldn't stuff pmu->global_ctrl, and doing so is a symptom of another
flaw.  Unless I'm missing something, KVM stuffs pmu->global_ctrl so that the
correct value is loaded on VM-Enter, but loading and saving PERF_GLOBAL_CTRL on
entry/exit is unnecessary and confusing, as is loading the associated MSRs when
restoring (loading) the guest context.

For PERF_GLOBAL_CTRL on Intel, KVM needs to ensure all GP counters are enabled in
VMCS.GUEST_IA32_PERF_GLOBAL_CTRL, but that's a "set once and forget" operation,
not something that needs to be done on every entry and exit.  Of course, loading
and saving PERF_GLOBAL_CTRL on every entry/exit is unnecessary for other reasons,
but that's largely orthogonal.

On AMD, amd_restore_pmu_context()[*] needs to enable a maximal value for
PERF_GLOBAL_CTRL, but I don't think there's any need to load the other MSRs,
and the maximal value should come from the above logic, not pmu->global_ctrl.

[*] Side topic, in case I forget later, that API should be "load", not "restore".
    There is no assumption or guarantee that KVM is exactly restoring anything,
    e.g. if PERF_GLOBAL_CTRL doesn't exist in the guest PMU and on the first load.
