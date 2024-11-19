Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0901CF7B7
	for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732037556; cv=none; b=TTXim3R6kAfpRTaIX0fCYDN0EM6qi7e3E+BI1UgKZESU0QtBtlqHACnjXUXkt+xAauBj4YytlXOAESKtH8kNrAsfHPMhboYNd0UhkaRaMyxCIvQtP38JFGKNX19IRKg1FqI6R0b8B5mQi7o1z2DEV045iCxe8PslcHdwdZdtxNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732037556; c=relaxed/simple;
	bh=1WrQ+zgab3hG/h+7G1Prd1RtR8sy51prU3LGZoGbG0k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e5L+++cdU9q0asQikl2Q6YsSPxtbpbFWQf6gg/u3I967+o0cUz7vSLTHhH34hoSBFDzZFcerXUaUR//lSNCBAWKmNNr+5UrbhQOq2mN9aduV1QCxdWuz9Sg2RB2vSLIFo/NVwXMwajIoRlqqlpftxMDoeGCgJYOyXJ+oYq+mFwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uUOZmhKV; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uUOZmhKV"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-20cb3d9f5eeso42915ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Nov 2024 09:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732037554; x=1732642354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jWbC/fZ7wTzsJNsqDVHTfCZk7/WZnnCCSq7uKfUPNpY=;
        b=uUOZmhKVtmBBWwM4MyZuc3Rr09NhcR1KjlmphcGFejWfnzlS782SyJAp+iuniajadj
         dR4cRaDNtEl2jnkcQIKO/GSBORhKyFFeq2JBn14O0J2wQEZ1eBAN7EiirHvzZ1vznH+a
         EQcopD5N9vPZVUNStw/DGNp0dYsLWPhqziNgiXatcRVFnISsQGmg1HqES2gNLFlbHdVo
         iHr9LXJEw1qj6MmZ2mEVwnrTUADx2TKbAt4GtDRhr/2kkOOrBcviMR1Kx1r/Xe6nZvN2
         YWvLiUjFM1NuxMielgihUGXm6Xo1JZecVMDC0ieGIf5+wYyMm9N4l6VkrMBa5Dsfl5Vz
         YxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732037554; x=1732642354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWbC/fZ7wTzsJNsqDVHTfCZk7/WZnnCCSq7uKfUPNpY=;
        b=sgQTILcQkXvwx1Q+FbuZRbCdEhNB7FaRtJM5KQUJNDF6/UcDaxm2mfRaXEh2BPsn87
         P1lGZx242Xknv944xo1UE78c6RkvKlwWpS7MwJ4cb6LpOqlfizBls5SEBp2cWAgGv1V1
         tVz9o6jCwa2z8zdldvOi2R2RBfvQz+hr0MyVQEj8lVrEZn2ENoRvhSxOzDIC35dco3/N
         ZmtNt06h+V4sd62sLAfC0h0OF6W1ZdqQuaUgUr/yPUltWtbANcBV3gPaJZAFd6O8Vi6H
         RS8LVF4gKGkv2QC9WfJPwNYQN3QIajSG53KQOuXAD4mRFbx1ujdBDdJxpjAOSy65l6f5
         KfpA==
X-Forwarded-Encrypted: i=1; AJvYcCX6b92PJfHXRcD9I7jnYfDFGaCxN7H9qJoMCVzGox4/sW+zWEM3CNe/zoh8cwT/BCbut0qDHLqJzlVHqMsOSHV6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx3rQvtfBZHWwuNL9Hsrw95OI8j95P8Cm49okgUzBqJr7FdrPY
	hLYOAzLcAJUAoNMXZ2oWrZeR1qg87AhU6x6H/i0d6DrV36o3JvlZwNdNMtYIe9xn2OgGtwK9Rek
	0tw==
X-Google-Smtp-Source: AGHT+IHt0cviA4CjNoaA2xaQQtrrvRdF865/qj4o5zsRbEpZ0OPIg/1JCWX3P5YE+B7c70W5J/wd/B1omGU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:903:2386:b0:211:e4c4:9739 with SMTP id
 d9443c01a7336-2124b605591mr66635ad.3.1732037554021; Tue, 19 Nov 2024 09:32:34
 -0800 (PST)
Date: Tue, 19 Nov 2024 09:32:32 -0800
In-Reply-To: <20240801045907.4010984-26-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801045907.4010984-1-mizhang@google.com> <20240801045907.4010984-26-mizhang@google.com>
Message-ID: <ZzzLsLE-BmzVAXF0@google.com>
Subject: Re: [RFC PATCH v3 25/58] KVM: x86/pmu: Introduce PMU operator to
 check if rdpmc passthrough allowed
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
> Introduce a vendor specific API to check if rdpmc passthrough allowed.
> RDPMC passthrough requires guest VM have the full ownership of all
> counters. These include general purpose counters and fixed counters and
> some vendor specific MSRs such as PERF_METRICS. Since PERF_METRICS MSR is
> Intel specific, putting the check into vendor specific code.
> 
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> ---
>  arch/x86/include/asm/kvm-x86-pmu-ops.h |  1 +
>  arch/x86/kvm/pmu.c                     |  1 +
>  arch/x86/kvm/pmu.h                     |  1 +
>  arch/x86/kvm/svm/pmu.c                 |  6 ++++++
>  arch/x86/kvm/vmx/pmu_intel.c           | 16 ++++++++++++++++
>  5 files changed, 25 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/asm/kvm-x86-pmu-ops.h
> index f852b13aeefe..fd986d5146e4 100644
> --- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
> @@ -20,6 +20,7 @@ KVM_X86_PMU_OP(get_msr)
>  KVM_X86_PMU_OP(set_msr)
>  KVM_X86_PMU_OP(refresh)
>  KVM_X86_PMU_OP(init)
> +KVM_X86_PMU_OP(is_rdpmc_passthru_allowed)
>  KVM_X86_PMU_OP_OPTIONAL(reset)
>  KVM_X86_PMU_OP_OPTIONAL(deliver_pmi)
>  KVM_X86_PMU_OP_OPTIONAL(cleanup)
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 19104e16a986..3afefe4cf6e2 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -102,6 +102,7 @@ bool kvm_pmu_check_rdpmc_passthrough(struct kvm_vcpu *vcpu)
>  
>  	if (is_passthrough_pmu_enabled(vcpu) &&
>  	    !enable_vmware_backdoor &&
> +	    static_call(kvm_x86_pmu_is_rdpmc_passthru_allowed)(vcpu) &&

If the polarity is inverted, the callback can be OPTIONAL_RET0 on AMD.  E.g.

	if (kvm_pmu_call(rdpmc_needs_intercept(vcpu)))
		return false;

> +static bool intel_is_rdpmc_passthru_allowed(struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * Per Intel SDM vol. 2 for RDPMC, 


Please don't reference specific sections in the comments.  For changelogs it's
ok, because changelogs are a snapshot in time.  But comments are living things
and will become stale in almost every case.  And I don't see any reason to reference
the SDM, just state the behavior; it's implied that that's the architectural
behavior, otherwise KVM is buggy.

> MSR_PERF_METRICS is accessible by

This is technically wrong, the SDM states that the RDPMC behavior is implementation
specific.  That matters to some extent, because if it was _just_ one MSR and was
guaranteed to always be that one MSR, it might be worth creating a virtualization
hole.

	/*
	 * Intercept RDPMC if the host supports PERF_METRICS, but the guest
	 * does not, as RDPMC with type 0x2000 accesses implementation specific
	 * metrics.
	 */


All that said, isn't this redundant with the number of fixed counters?  I'm having
a hell of a time finding anything concrete in the SDM, but IIUC fixed counter 3
is tightly coupled to perf metrics.  E.g. rather than add a vendor hook just for
this, rely on the fixed counters and refuse to enable the mediated PMU if the
underlying CPU model is nonsensical, i.e. perf metrics exists without ctr3.

And I kinda think we have to go that route, because enabling RDPMC interception
based on future features is doomed from the start.  E.g. if this code had been
written prior to PERF_METRICS, older KVMs would have zero clue that RDPMC needs
to be intercepted on newer hardware.
