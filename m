Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE4B8F68
	for <linux-perf-users@vger.kernel.org>; Wed,  8 May 2024 04:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715143017; cv=none; b=M++AaN6ibYM+JJQ6K4yrsSsBk15tse4uWoeX0fgFlfK2MIK4Dl/ljS2p0C4FGpa5yR7FIKXKZ/6e5ceeuu8uyuQpp6Z0n4NpSNTGK4Xjb5PLWnre0+PaR/T6VV5ibH5VvSjyyqWkgLfJCToAvGQhtrZ0euAZAWVnTKYwMaGOIDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715143017; c=relaxed/simple;
	bh=Phq+qnbq/jzX/hzG7WpHAWxncVFl+OzG+PbZTNYers8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmZkcIDjHBnSjU0aTcIVOSqxn69UBIRpVF1uQWOaDKWHRzVfYqUZeAVw0w2dhEtVe8AdDA3zzj08RFn+QeLmd+/y9CTzhR1deHk23TyLhnJw2BGlGVZ5/VUEt68u16JdfQPyEunf9sCXryHbzedoZtQMUOLD/211LcwHpXcKZ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D5IgeFsS; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D5IgeFsS"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51f4d2676d1so4300574e87.3
        for <linux-perf-users@vger.kernel.org>; Tue, 07 May 2024 21:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715143012; x=1715747812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvW6bcW5/9H572n3jcZ+QuQeXteJDuCr/aawtkwSyO8=;
        b=D5IgeFsSnX+KIZDZfc5dp6IKLb2ryUP4sCiggrMcfzNavIxm76KkeVBgJuTFMePYSP
         avgfmIY4bQXQPQxyXSPjcwAFwqRBBm0ayPJ8py+orRT+NZaxqh7vPV7r2sOmbx0xAc5i
         4XijNXb+9DoLcO2PgnlBf+sbboc0piRqrxbJAq6urz7bMLirnSf47XvNWt5y/UVAU/UD
         ZntIFqFvbrPCDgFscasRnNSK/iNhcvIENZKgG+dy9ePLXwvSWHyqK9Yq2h5cogkq6rlL
         Q4XdFLsUvQR47DQJ0enesyKXtNwUiKTZuRrZmc1hkb1GEJ3tC54ZxzglUteigTL3tA+h
         PKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715143012; x=1715747812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvW6bcW5/9H572n3jcZ+QuQeXteJDuCr/aawtkwSyO8=;
        b=S/LpzswPjOu+PkaEFkQJZjoAanND1Ec5gEzNfAoKyjlmA7g1oXTERIxTM8QWB0t6xM
         IEveX26pbZSIA6R8p32EtMTUzyhyfWSB5vnzkjxiFlffuzRCT6i0vp1TGerGH3z+LTUf
         zckuQUXZTFM0pmsP+4q5LitjpQljDvWiUbguuhJitkMyFYVi2zbyacRjWWTLRVdiP7Pm
         2kQSG+zzvvUfNSXuH9fotLyV/bpEyxPDX4hC/wpTsircU+nOpC1kH+Pt6ikNSJfM/4Kz
         0mQsxFaGR5g59Hl0Ghu4oSYJfkwHnQiyns7eBE/3VjkbZDXlMzOZ9fjbaF4bmMAGI269
         zM0w==
X-Forwarded-Encrypted: i=1; AJvYcCUbf1/qCYstbrEPhxwECls2nnl049U0t+0RaMjNgDP3/O7GsoA2wwGc8Xq2IRLL8CSqQv69AFOvXalgtzrHUK97Dcb8XB8pswPhGV+od4PCKw==
X-Gm-Message-State: AOJu0Yw9Mq4tG3FfFeOrIWQX3FA8w30clAZF4KoP59Rj7jla/Ny+2c4E
	fsjdUI71gendpt1vJW6N0FQIplf8/CjlOom8GES2yRM/tzgcjh23ISrfJiYSfRUifOzlh8VbDCb
	bx0QHU2IauhXZ1f7yJBsCQaGpu8gTUmLWkKl8
X-Google-Smtp-Source: AGHT+IGWYn3HLbtQAK6lcVfTSgk1K+GOPDLZAVrOEc/jGdjisZ86hcy3tMqrqi3XNn981JUfLi/I5uOTbU1go+gvgcY=
X-Received: by 2002:ac2:5291:0:b0:51d:5e16:517a with SMTP id
 2adb3069b0e04-5217cd49804mr728024e87.48.1715143012176; Tue, 07 May 2024
 21:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506053020.3911940-1-mizhang@google.com> <20240506053020.3911940-18-mizhang@google.com>
 <3eb01add-3776-46a8-87f7-54144692d7d7@linux.intel.com>
In-Reply-To: <3eb01add-3776-46a8-87f7-54144692d7d7@linux.intel.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Tue, 7 May 2024 21:36:15 -0700
Message-ID: <CAL715WL80ZOtAo2mT95_zW9Xhv-qOqnPjLGPMp1bJKZ1dOxhTg@mail.gmail.com>
Subject: Re: [PATCH v2 17/54] KVM: x86/pmu: Always set global enable bits in
 passthrough mode
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Xiong Zhang <xiong.y.zhang@intel.com>, Kan Liang <kan.liang@intel.com>, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Manali Shukla <manali.shukla@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Jim Mattson <jmattson@google.com>, 
	Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>, 
	Namhyung Kim <namhyung@kernel.org>, gce-passthrou-pmu-dev@google.com, 
	Samantha Alt <samantha.alt@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>, 
	Yanfei Xu <yanfei.xu@intel.com>, maobibo <maobibo@loongson.cn>, 
	Like Xu <like.xu.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 9:19=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.c=
om> wrote:
>
>
> On 5/6/2024 1:29 PM, Mingwei Zhang wrote:
> > From: Sandipan Das <sandipan.das@amd.com>
> >
> > Currently, the global control bits for a vcpu are restored to the reset
> > state only if the guest PMU version is less than 2. This works for
> > emulated PMU as the MSRs are intercepted and backing events are created
> > for and managed by the host PMU [1].
> >
> > If such a guest in run with passthrough PMU, the counters no longer wor=
k
> > because the global enable bits are cleared. Hence, set the global enabl=
e
> > bits to their reset state if passthrough PMU is used.
> >
> > A passthrough-capable host may not necessarily support PMU version 2 an=
d
> > it can choose to restore or save the global control state from struct
> > kvm_pmu in the PMU context save and restore helpers depending on the
> > availability of the global control register.
> >
> > [1] 7b46b733bdb4 ("KVM: x86/pmu: Set enable bits for GP counters in PER=
F_GLOBAL_CTRL at "RESET"");
> > Reported-by: Mingwei Zhang <mizhang@google.com>
> > Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> > [removed the fixes tag]
> > ---
> >  arch/x86/kvm/pmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> > index 5768ea2935e9..e656f72fdace 100644
> > --- a/arch/x86/kvm/pmu.c
> > +++ b/arch/x86/kvm/pmu.c
> > @@ -787,7 +787,7 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
> >        * in the global controls).  Emulate that behavior when refreshin=
g the
> >        * PMU so that userspace doesn't need to manually set PERF_GLOBAL=
_CTRL.
> >        */
> > -     if (kvm_pmu_has_perf_global_ctrl(pmu) && pmu->nr_arch_gp_counters=
)
> > +     if ((pmu->passthrough || kvm_pmu_has_perf_global_ctrl(pmu)) && pm=
u->nr_arch_gp_counters)
>
> The logic seems not correct. we could support perfmon version 1 for
> meidated vPMU (passthrough vPMU) as well in the future.  pmu->passthrough
> is ture doesn't guarantee GLOBAL_CTRL MSR always exists.

heh, the logic is correct here. However, I would say the code change
may not reflect that clearly.

The if condition combines the handling of global ctrl registers for
both the legacy vPMU and the mediated passthrough vPMU.

In legacy pmu, the logic should be this:

if (kvm_pmu_has_perf_global_ctrl(pmu) && pmu->nr_arch_gp_counters)

Because, since KVM emulates the MSR, if the global ctrl register does
not exist, then there is no point resetting it to any value. However,
if it does exist, there are non-zero number of GP counters, we should
reset it to some value (all enabling bits are set for GP counters)
according to SDM.

The logic for mediated passthrough PMU is different as follows:

if (pmu->passthrough && pmu->nr_arch_gp_counters)

Since mediated passthrough PMU requires PerfMon v4 in Intel (PerfMon
v2 in AMD), once it is enabled (pmu->passthrough =3D true), then global
ctrl _must_ exist phyiscally. Regardless of whether we expose it to
the guest VM, at reset time, we need to ensure enabling bits for GP
counters are set (behind the screen). This is critical for AMD, since
most of the guests are usually in (AMD) PerfMon v1 in which global
ctrl MSR is inaccessible, but does exist and is operating in HW.

Yes, if we eliminate that requirement (pmu->passthrough -> Perfmon v4
Intel / Perfmon v2 AMD), then this code will have to change. However,
that is currently not in our RFCv2.

Thanks.
-Mingwei







>
>
> >               pmu->global_ctrl =3D GENMASK_ULL(pmu->nr_arch_gp_counters=
 - 1, 0);
> >  }
> >
