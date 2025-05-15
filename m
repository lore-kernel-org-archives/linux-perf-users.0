Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97E433E1
	for <linux-perf-users@vger.kernel.org>; Thu, 15 May 2025 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747269221; cv=none; b=c+LdWPd80MD3mHmqnfSt+boPjmqyABIoxK2fD4HGdp9Y1qXU1ucgGdXq+9aRQNFTx+KaHryq+LC9EmlC72JqTExxbZ9eHrmXv4UT9fWl+E3sC66JD8hJOWlvOCFbZ6EpZL1tKsWgCiWxhd7LtGIphtrj1iIq3gXIjXfEsfviEEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747269221; c=relaxed/simple;
	bh=kWsTqq0lhBMvBNJ0ZtIHiTgXO8OwzpD8p2bSnfGsB4c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AQcHG98l7BbbGbLgOrgCWk85Wa0SQwb2lgkIlJ5SdlmOevE5y7WUNKZmTF5AmYrEbDKE597rzVU/J3r+p8rAG/dSI0w2AKIs8C+c9kcIbBTYbGM/EmfG2K4/XnVRknebz+rhtuv8tGolajpurrSo3dHFBJwyoyFX1NyDrfqCOTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dVQ9JN6W; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dVQ9JN6W"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b25dda2f585so325185a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 May 2025 17:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747269218; x=1747874018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rglF/R5KGMHdjiJ2t6dRwR5H/A5Ey37gucnisvzxi0s=;
        b=dVQ9JN6WuOjMcxel8aEUJzlHkH6MCVPTDm7b18SyF/CwUChE49fMCr1C8I48ag/PwH
         Is2mL3EBGGsbm2GvJpL1qS5PlZ8wfMi8fnvNmSLsow05W5hIAaemnpLqgTinOMO1IH4Z
         Y56ysH++uvrZ/3qlgLjiC+MHJTFb2aYH/WzrbOL4FH7G5cpBp/TkI9Eq9RwmlVSzIbun
         RJkREqPM703c6y82wFRmNEFFPjZaPzsH+R0fwCQK/xbwqxiJ/8nClSu4+6rBVOLChMzC
         1/DKKnQub04X1NCsb9bBitytLdYxhzOqZ/OOL744aqhbGtCz+9M20nKH0QP+Ee7144NX
         Hc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747269218; x=1747874018;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rglF/R5KGMHdjiJ2t6dRwR5H/A5Ey37gucnisvzxi0s=;
        b=UZcI3LGmbtPcjOwRAkhUu6tIe9XG4XiEd+rUAWdNY4+Sfb63FK0NtQ61Bhy3Dz1SxW
         l0P2M3vOSl04jkCuGlQUx3iyzAnmqtN/BcX4b+BxzemZWtyvP3kgeRgRaesetmfmzzMT
         BO/A5MstFp1qPQBMaiujUk7iDs+Y0ixh1qfcjidknz4kWwd7PGHA1U0/74mDQCP2fk9x
         5eR8NabZbgfs9XeWF1T/0QA7hBixZLUrq9pwYUmZWizWIWYcodhzpdqIj+gqjm2DUMzQ
         +sFmkPfYNs0pq3Zr5LZblPDdCp6qPq6fJWgYTS18Ldo28z+sj9M5NfhZsyt44a4y6j97
         ypKg==
X-Forwarded-Encrypted: i=1; AJvYcCWF7TgNf13ucBsYTYzaz64hS3HahDl3TSzxBs2HCpQptjjXTBzT58jmBktgdP87beImB5t3sgzDmcT3x36G+Uaq@vger.kernel.org
X-Gm-Message-State: AOJu0YwwUkdKOT6y4fC922M66JmuyXMFcsMYsrEbYVc29qvZqsr3aE9t
	RiSakmvTOrUnjDOIYvsnJEUdSEikc4aEs3GvIyZvZ96yhtR8jN/ZIFdNzc3EhavDXeSPFadVeeQ
	PQw==
X-Google-Smtp-Source: AGHT+IFk5amrAydk8MqHTBzn+9OeH6tHjtTovD4ZDO0wIQz+gLvtk/uGbMGbdXJBPpjYoOvEfN2C4N4FPJ8=
X-Received: from plblm5.prod.google.com ([2002:a17:903:2985:b0:223:fb3a:ac08])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4cf:b0:220:e5be:29c7
 with SMTP id d9443c01a7336-231981a2d5fmr72176585ad.39.1747269218174; Wed, 14
 May 2025 17:33:38 -0700 (PDT)
Date: Wed, 14 May 2025 17:33:36 -0700
In-Reply-To: <CAL715WLfr5k=Rz0cQ08xS=eHEyRn83PBTiqQ5H7iX4qH=jiS8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-22-mizhang@google.com>
 <4d55c919-92ab-4bfe-a8c2-c0a756546f7c@intel.com> <CAL715WLfr5k=Rz0cQ08xS=eHEyRn83PBTiqQ5H7iX4qH=jiS8A@mail.gmail.com>
Message-ID: <aCU2YEpU0dOk7RTk@google.com>
Subject: Re: [PATCH v4 21/38] KVM: x86/pmu/vmx: Save/load guest
 IA32_PERF_GLOBAL_CTRL with vm_exit/entry_ctrl
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Sandipan Das <sandipan.das@amd.com>, Eranian Stephane <eranian@google.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025, Mingwei Zhang wrote:
> On Wed, Mar 26, 2025 at 9:51=E2=80=AFAM Chen, Zide <zide.chen@intel.com> =
wrote:
> > > diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> > > index 6ad71752be4b..4e8cefcce7ab 100644
> > > --- a/arch/x86/kvm/pmu.c
> > > +++ b/arch/x86/kvm/pmu.c
> > > @@ -646,6 +646,30 @@ void kvm_pmu_deliver_pmi(struct kvm_vcpu *vcpu)
> > >       }
> > >  }
> > >
> > > +static void kvm_pmu_sync_global_ctrl_from_vmcs(struct kvm_vcpu *vcpu=
)
> > > +{
> > > +     struct msr_data msr_info =3D { .index =3D MSR_CORE_PERF_GLOBAL_=
CTRL };
> > > +
> > > +     if (!kvm_mediated_pmu_enabled(vcpu))
> > > +             return;
> > > +
> > > +     /* Sync pmu->global_ctrl from GUEST_IA32_PERF_GLOBAL_CTRL. */
> > > +     kvm_pmu_call(get_msr)(vcpu, &msr_info);
> > > +}
> > > +
> > > +static void kvm_pmu_sync_global_ctrl_to_vmcs(struct kvm_vcpu *vcpu, =
u64 global_ctrl)
> > > +{
> > > +     struct msr_data msr_info =3D {
> > > +             .index =3D MSR_CORE_PERF_GLOBAL_CTRL,
> > > +             .data =3D global_ctrl };
> > > +
> > > +     if (!kvm_mediated_pmu_enabled(vcpu))
> > > +             return;
> > > +
> > > +     /* Sync pmu->global_ctrl to GUEST_IA32_PERF_GLOBAL_CTRL. */
> > > +     kvm_pmu_call(set_msr)(vcpu, &msr_info);

Eh, just add a dedicated kvm_pmu_ops hook.  Feeding this through set_msr() =
avoids
adding another hook, but makes the code hard to follow and requires the abo=
ve
ugly boilerplate.

> > > +}
> > > +
> > >  bool kvm_pmu_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
> > >  {
> > >       switch (msr) {
> > > @@ -680,7 +704,6 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct=
 msr_data *msr_info)
> > >               msr_info->data =3D pmu->global_status;
> > >               break;
> > >       case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
> > > -     case MSR_CORE_PERF_GLOBAL_CTRL:
> > >               msr_info->data =3D pmu->global_ctrl;
> > >               break;
> > >       case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
> > > @@ -731,6 +754,9 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct=
 msr_data *msr_info)
> >
> >
> > pmu->global_ctrl doesn't always have the up-to-date guest value, need t=
o
> > sync from vmcs/vmbc before comparing it against 'data'.
> >
> > +               kvm_pmu_sync_global_ctrl_from_vmcs(vcpu);
> >                 if (pmu->global_ctrl !=3D data) {
>=20
> Good catch. Thanks!
>=20
> This is why I really prefer just unconditionally syncing the global
> ctrl from VMCS to pmu->global_ctrl and vice versa.
>=20
> We might get into similar problems as well in the future.

The problem isn't conditional synchronization, it's that y'all reinvented t=
he
wheel, poorly.  This is a solved problem via EXREG and wrappers.

That said, I went through the exercise of adding a PERF_GLOBAL_CTRL EXREG a=
nd
associated wrappers, and didn't love the result.  Host writes should be rar=
e, so
the dirty tracking is overkill.  For reads, the cost of VMREAD is lower tha=
n
VMWRITE (doesn't trigger consistency check re-evaluation on VM-Enter), and =
is
dwarfed by the cost of switching all other PMU state.

So I think for the initial implementation, it makes sense to propagated wri=
tes
to the VMCS on demand, but do VMREAD after VM-Exit (if VM-Enter was success=
ful).
We can always revisit the optimization if/when we optimize the PMU world sw=
itches,
e.g. to defer them if there are no active host events.

> > > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > > index 8a7af02d466e..ecf72394684d 100644
> > > --- a/arch/x86/kvm/vmx/nested.c
> > > +++ b/arch/x86/kvm/vmx/nested.c
> > > @@ -7004,7 +7004,8 @@ static void nested_vmx_setup_exit_ctls(struct v=
mcs_config *vmcs_conf,
> > >               VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR |
> > >               VM_EXIT_LOAD_IA32_EFER | VM_EXIT_SAVE_IA32_EFER |
> > >               VM_EXIT_SAVE_VMX_PREEMPTION_TIMER | VM_EXIT_ACK_INTR_ON=
_EXIT |
> > > -             VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
> > > +             VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
> > > +             VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL;

This is completely wrong.  Stuffing VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL here
advertises support for KVM emulation of the control, and that support is no=
n-existent
in this patch (and series).

Just drop this, emulation of VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL can be done
separately.

> > > +     mediated =3D kvm_mediated_pmu_enabled(vcpu);
> > > +     if (cpu_has_load_perf_global_ctrl()) {
> > > +             vm_entry_controls_changebit(vmx,
> > > +                     VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL, mediated);
> > > +             /*
> > > +              * Initialize guest PERF_GLOBAL_CTRL to reset value as =
SDM rules.
> > > +              *
> > > +              * Note: GUEST_IA32_PERF_GLOBAL_CTRL must be initialize=
d to
> > > +              * "BIT_ULL(pmu->nr_arch_gp_counters) - 1" instead of p=
mu->global_ctrl
> > > +              * since pmu->global_ctrl is only be initialized when g=
uest
> > > +              * pmu->version > 1. Otherwise if pmu->version is 1, pm=
u->global_ctrl
> > > +              * is 0 and guest counters are never really enabled.
> > > +              */
> > > +             if (mediated)
> > > +                     vmcs_write64(GUEST_IA32_PERF_GLOBAL_CTRL,
> > > +                                  BIT_ULL(pmu->nr_arch_gp_counters) =
- 1);

This belongs in common code, as a call to the aforementioned hook to propag=
ate
PERF_GLOBAL_CTRL to hardware.

> > > +     }
> > > +
> > > +     if (cpu_has_save_perf_global_ctrl())
> > > +             vm_exit_controls_changebit(vmx,
> > > +                     VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL |
> > > +                     VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL, mediated);
> > >  }
> > >
> > >  static void intel_pmu_init(struct kvm_vcpu *vcpu)
> > > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > > index ff66f17d6358..38ecf3c116bd 100644
> > > --- a/arch/x86/kvm/vmx/vmx.c
> > > +++ b/arch/x86/kvm/vmx/vmx.c
> > > @@ -4390,6 +4390,13 @@ void vmx_set_constant_host_state(struct vcpu_v=
mx *vmx)
> > >
> > >       if (cpu_has_load_ia32_efer())
> > >               vmcs_write64(HOST_IA32_EFER, kvm_host.efer);
> > > +
> > > +     /*
> > > +      * Initialize host PERF_GLOBAL_CTRL to 0 to disable all counter=
s
> > > +      * immediately once VM exits. Mediated vPMU then call perf_gues=
t_exit()
> > > +      * to re-enable host perf events.
> > > +      */
> > > +     vmcs_write64(HOST_IA32_PERF_GLOBAL_CTRL, 0);

This needs to be conditioned on the mediated PMU being enabled, because thi=
s field
is not constant when using the emulated PMU (or no vPMU).

> > > @@ -8451,6 +8462,15 @@ __init int vmx_hardware_setup(void)
> > >               enable_sgx =3D false;
> > >  #endif
> > >
> > > +     /*
> > > +      * All CPUs that support a mediated PMU are expected to support=
 loading
> > > +      * and saving PERF_GLOBAL_CTRL via dedicated VMCS fields.
> > > +      */
> > > +     if (enable_mediated_pmu &&
> > > +         (WARN_ON_ONCE(!cpu_has_load_perf_global_ctrl() ||
> > > +                       !cpu_has_save_perf_global_ctrl())))

This needs to be conditioned on !HYPERVISOR, or it *will* fire.

And placing this check here, without *any* mention of *why* you did so, is =
evil
and made me very grumpy.  I had to discover the hard way that you checked t=
he
VMCS fields here, instead of in kvm_init_pmu_capability() where it logicall=
y
belongs, because the VMCS configuration isn't yet initialized.

Grumpiness aside, I don't like this late clear of enable_mediated_pmu, as i=
t risks
a variation of the problem you're trying to avoid, i.e. risks consuming the=
 variable
between kvm_init_pmu_capability() and here.

I don't see any reason why setup_vmcs_config() can't be called before
kvm_x86_vendor_init(), so unless I'm missing/forgetting something, let's ju=
st do
that, and move these checks where they belong.
