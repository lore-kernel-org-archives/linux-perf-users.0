Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E39A3FE5F
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712873998; cv=none; b=vD9IgazED3bp9TyivDERjgYqJ2vRUU7OLRfblXN2AQuHXClOE/7MaK7ySRWNhzx+ZInkyqkH9q64I2uDEAjvXElTB/q91D75yqEsr0pnmGPlZ/nNhkHkiROvmpSxah3zTP4ijAkTqYv6NTUQ1ePwjgoE/tbkWV8VTXLTXURJHwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712873998; c=relaxed/simple;
	bh=X6RbBcdB0SCCujrPb4Yr3xBtRmMZEnD1Kca1/Iv40h0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JRF66T4XrsRm24/vSyYMJ7mmZ5YpTgIt4OTGtjNeShtgthgZCqxMi1gDR9koFxfOl7X8Ucc4+VTaucN9aNDMd/4l+h0aYTmvApjt7OdDEioCVhuNJk/spJ5FBmeH8uQ7E2+AOemeCytWnOw8cIu0YMLtB5f7y4NX76HKIrOPmD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DME4ufkk; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DME4ufkk"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so1931a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 15:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712873994; x=1713478794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7leSu9jkQ4XwLuSXA3Sr1F8VUoujnomr8MHpVmJwno0=;
        b=DME4ufkkBcapiUMVYp4l/nDCo1uHIrCqEEL9R2xsGXI1ItLjv3ZyaBGMt3nM8tUGAK
         5w2Mgti8+5RZDcwEdWD2ySebSiaQJGP3dwbcgE3jrjEZ74wRYLttg7uDDtEcO67JNSc0
         nfNXaXbKG2GW4YpF/ueap4Ewa4OUtRrPgJNvY7QnJ+SHtv3Kn2U8ml0g9yWy82rocQqC
         NP40lj30I0GT4RFLfEckq0znW1AjhaZGS19ivAEjDB9xqS/Sj44bVdyrrM15pcRjyMJ5
         EHqxkfWD0tMVpsG7reBcSU0KlPAzlbL2QsBqQlEDCtdlerEDRGikV8J/YgeeYqmE6jgW
         fHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712873994; x=1713478794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7leSu9jkQ4XwLuSXA3Sr1F8VUoujnomr8MHpVmJwno0=;
        b=FbyJs6ric8RHk1FEbrUDPtY3ZpDVE9DL4vVO1dzWfxRoaGneadMfdY+agaWIavudJ5
         WgnzWGqlut5gG6IToJQ2Jl5Cc8DQLjy07BChlNtVK+O1t7SmVSPNscJMTabd1vjPVHAV
         6DdzYaHbSkEDTQO/NK06kyptjEND7egQ0EHVSkdLWXBcsV6izKQW6InXvWIB61ooYUzM
         8VlY1DI8yVHGFbw8YiCpOZwtCqx80lpLLKzZcSULH9plJVgXLOun/TSHP/p9PM+QN4j0
         fXM4kcRqeY/m6ie3WwNjQBb1L8ogh3QU6vujfIkgw00+Nl6z+I8lFzfFKPGUhqMwCGOq
         5Plw==
X-Forwarded-Encrypted: i=1; AJvYcCVfDNoaW08RLs5Zdj6z1ZrrI8r4S7JO5nm8Uvv/VkjDB+LL9xDqP0z/2GGTa8+RK4QN0OQLlhH8EDMbkg0IIO42uwYd7hOeTj8ekPUri6/dKg==
X-Gm-Message-State: AOJu0YyTtkxg2WIL6xZZLE4bvcBC4e/iBVA5uMRPlG9bplBbj9HblnEf
	muT/41FGPVtE5R1XKuVCPQJilO/R8HEk4RCa8DKCe62q5XUkE19GVSaAa3lqNEr3igx7d27u6Xz
	U9kZGqfqwAq8hIYZBrx7XEwS2Qf/MDOdNh2n2
X-Google-Smtp-Source: AGHT+IETDb+J1nsSc2scCFKEt691wN+Ak46hJjOjHK2LzkT7GTL5przS/xPK1Li7l8sPkqLx0ArjwPs5/iNeBTa4eIY=
X-Received: by 2002:a05:6402:3592:b0:56f:d6ef:b61 with SMTP id
 y18-20020a056402359200b0056fd6ef0b61mr24663edc.5.1712873993575; Thu, 11 Apr
 2024 15:19:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com>
 <20240126085444.324918-24-xiong.y.zhang@linux.intel.com> <ZhhZush_VOEnimuw@google.com>
In-Reply-To: <ZhhZush_VOEnimuw@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 11 Apr 2024 15:19:41 -0700
Message-ID: <CALMp9eS4H-WZXRCrp+6aAgwAp+qP2BgJx5ik5kA7vdyQ9qzARg@mail.gmail.com>
Subject: Re: [RFC PATCH 23/41] KVM: x86/pmu: Implement the save/restore of PMU
 state for Intel CPU
To: Sean Christopherson <seanjc@google.com>
Cc: Xiong Zhang <xiong.y.zhang@linux.intel.com>, pbonzini@redhat.com, 
	peterz@infradead.org, mizhang@google.com, kan.liang@intel.com, 
	zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhiyuan.lv@intel.com, eranian@google.com, irogers@google.com, 
	samantha.alt@intel.com, like.xu.linux@gmail.com, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 2:44=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Jan 26, 2024, Xiong Zhang wrote:
> > From: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >
> > Implement the save/restore of PMU state for pasthrough PMU in Intel. In
> > passthrough mode, KVM owns exclusively the PMU HW when control flow goe=
s to
> > the scope of passthrough PMU. Thus, KVM needs to save the host PMU stat=
e
> > and gains the full HW PMU ownership. On the contrary, host regains the
> > ownership of PMU HW from KVM when control flow leaves the scope of
> > passthrough PMU.
> >
> > Implement PMU context switches for Intel CPUs and opptunistically use
> > rdpmcl() instead of rdmsrl() when reading counters since the former has
> > lower latency in Intel CPUs.
> >
> > Co-developed-by: Mingwei Zhang <mizhang@google.com>
> > Signed-off-by: Mingwei Zhang <mizhang@google.com>
> > Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > ---
> >  arch/x86/kvm/vmx/pmu_intel.c | 73 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >
> > diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.=
c
> > index 0d58fe7d243e..f79bebe7093d 100644
> > --- a/arch/x86/kvm/vmx/pmu_intel.c
> > +++ b/arch/x86/kvm/vmx/pmu_intel.c
> > @@ -823,10 +823,83 @@ void intel_passthrough_pmu_msrs(struct kvm_vcpu *=
vcpu)
> >
> >  static void intel_save_pmu_context(struct kvm_vcpu *vcpu)
>
> I would prefer there be a "guest" in there somewhere, e.g. intel_save_gue=
st_pmu_context().
>
> >  {
> > +     struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
> > +     struct kvm_pmc *pmc;
> > +     u32 i;
> > +
> > +     if (pmu->version !=3D 2) {
> > +             pr_warn("only PerfMon v2 is supported for passthrough PMU=
");
> > +             return;
> > +     }
> > +
> > +     /* Global ctrl register is already saved at VM-exit. */
> > +     rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, pmu->global_status);
> > +     /* Clear hardware MSR_CORE_PERF_GLOBAL_STATUS MSR, if non-zero. *=
/
> > +     if (pmu->global_status)
> > +             wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, pmu->global_status)=
;
> > +
> > +     for (i =3D 0; i < pmu->nr_arch_gp_counters; i++) {
> > +             pmc =3D &pmu->gp_counters[i];
> > +             rdpmcl(i, pmc->counter);
> > +             rdmsrl(i + MSR_ARCH_PERFMON_EVENTSEL0, pmc->eventsel);
> > +             /*
> > +              * Clear hardware PERFMON_EVENTSELx and its counter to av=
oid
> > +              * leakage and also avoid this guest GP counter get accid=
entally
> > +              * enabled during host running when host enable global ct=
rl.
> > +              */
> > +             if (pmc->eventsel)
> > +                     wrmsrl(MSR_ARCH_PERFMON_EVENTSEL0 + i, 0);
> > +             if (pmc->counter)
> > +                     wrmsrl(MSR_IA32_PMC0 + i, 0);
>
> This doesn't make much sense.  The kernel already has full access to the =
guest,
> I don't see what is gained by zeroing out the MSRs just to hide them from=
 perf.
>
> Similarly, if perf enables a counter if PERF_GLOBAL_CTRL without first re=
storing
> the event selector, we gots problems.
>
> Same thing for the fixed counters below.  Can't this just be?
>
>         for (i =3D 0; i < pmu->nr_arch_gp_counters; i++)
>                 rdpmcl(i, pmu->gp_counters[i].counter);
>
>         for (i =3D 0; i < pmu->nr_arch_fixed_counters; i++)
>                 rdpmcl(INTEL_PMC_FIXED_RDPMC_BASE | i,
>                        pmu->fixed_counters[i].counter);
>
> > +     }
> > +
> > +     rdmsrl(MSR_CORE_PERF_FIXED_CTR_CTRL, pmu->fixed_ctr_ctrl);
> > +     /*
> > +      * Clear hardware FIXED_CTR_CTRL MSR to avoid information leakage=
 and
> > +      * also avoid these guest fixed counters get accidentially enable=
d
> > +      * during host running when host enable global ctrl.
> > +      */
> > +     if (pmu->fixed_ctr_ctrl)
> > +             wrmsrl(MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
> > +     for (i =3D 0; i < pmu->nr_arch_fixed_counters; i++) {
> > +             pmc =3D &pmu->fixed_counters[i];
> > +             rdpmcl(INTEL_PMC_FIXED_RDPMC_BASE | i, pmc->counter);
> > +             if (pmc->counter)
> > +                     wrmsrl(MSR_CORE_PERF_FIXED_CTR0 + i, 0);
> > +     }
> >  }
> >
> >  static void intel_restore_pmu_context(struct kvm_vcpu *vcpu)
> >  {
> > +     struct kvm_pmu *pmu =3D vcpu_to_pmu(vcpu);
> > +     struct kvm_pmc *pmc;
> > +     u64 global_status;
> > +     int i;
> > +
> > +     if (pmu->version !=3D 2) {
> > +             pr_warn("only PerfMon v2 is supported for passthrough PMU=
");
> > +             return;
> > +     }
> > +
> > +     /* Clear host global_ctrl and global_status MSR if non-zero. */
> > +     wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL, 0);
>
> Why?  PERF_GLOBAL_CTRL will be auto-loaded at VM-Enter, why do it now?
>
> > +     rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, global_status);
> > +     if (global_status)
> > +             wrmsrl(MSR_CORE_PERF_GLOBAL_OVF_CTRL, global_status);
>
> This seems especially silly, isn't the full MSR being written below?  Or =
am I
> misunderstanding how these things work?

LOL! You expect CPU design to follow basic logic?!?

Writing a 1 to a bit in IA32_PERF_GLOBAL_STATUS_SET sets the
corresponding bit in IA32_PERF_GLOBAL_STATUS to 1.

Writing a 0 to a bit in to IA32_PERF_GLOBAL_STATUS_SET is a nop.

To clear a bit in IA32_PERF_GLOBAL_STATUS, you need to write a 1 to
the corresponding bit in IA32_PERF_GLOBAL_STATUS_RESET (aka
IA32_PERF_GLOBAL_OVF_CTRL).

> > +     wrmsrl(MSR_CORE_PERF_GLOBAL_STATUS_SET, pmu->global_status);
> > +
> > +     for (i =3D 0; i < pmu->nr_arch_gp_counters; i++) {
> > +             pmc =3D &pmu->gp_counters[i];
> > +             wrmsrl(MSR_IA32_PMC0 + i, pmc->counter);
> > +             wrmsrl(MSR_ARCH_PERFMON_EVENTSEL0 + i, pmc->eventsel);
> > +     }
> > +
> > +     wrmsrl(MSR_CORE_PERF_FIXED_CTR_CTRL, pmu->fixed_ctr_ctrl);
> > +     for (i =3D 0; i < pmu->nr_arch_fixed_counters; i++) {
> > +             pmc =3D &pmu->fixed_counters[i];
> > +             wrmsrl(MSR_CORE_PERF_FIXED_CTR0 + i, pmc->counter);
> > +     }
> >  }
> >
> >  struct kvm_pmu_ops intel_pmu_ops __initdata =3D {
> > --
> > 2.34.1
> >
