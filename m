Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E29632939C
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 22:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769726079; cv=none; b=YYFbWVksrduMrNfhAlAI5V6LkCre+oAfi0Kk5n/tKrOsahk0zYxFn8ilBO+MCH28sBfEVjTQ1Lo/Z1OH/c/lvLpiROuSM4COuNlaotbplG92Nl8V3UA+m+Bp9LtzFNj+ziTmN8e4Jzd2sXA2EvYwewCakwoQjAHw6LS1U3CcuoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769726079; c=relaxed/simple;
	bh=43Ly5LWavxsYLv7+7HKrp2ONar5UElIvRsFu7sD3WhA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lUMZR294Wp0kaHpD1va1V0Hc9UoLTPI/i4mS7rPPqBCCqdOZS/H6SO78JCnikBERoSDwQpa4dYIBjJCGeLngyoEarksFlfiFnOkXy4KCTxTzFmjZ6jkkYKJ3tzhWCqwr4lvqH+6y0ctReVSKEUGUX5O+8/4jypZd0mMWBqyTrWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EJR+5PkT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJR+5PkT"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a78c094ad6so15787145ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Jan 2026 14:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769726078; x=1770330878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifjZWXm6aQNqPteQIXl3MjOTMh03FfJVJJb/Dejs7KQ=;
        b=EJR+5PkTP3o+HAh5EwpAqIioY+7+swZsKiEEWLEuUj+T7Co0a0wtotANZzidFOOoUl
         PfOAChSW8iAVBW96YoPvHY6fVjacQt94S0axQXbPFthYh/5Xg3Vdis6gfYbZiEqv0aYn
         /i4jZXQ9A6b8k5U4u2gE7CQGIdcH/TybXbfO7TJXCBpUY+eEVryltx1KbxBFZP/vYfln
         VcpSfeowWdKbW9MgAsiXLHEPrgTWaJW/t2dnnUwBiaQeawJXznHvWkXZxpKr00Fz+FwH
         tu1mJRaS2gWmD527PQI5suc7vR7FyVGFpEeg/7C8tmvvDqZBcnCOpezRI9R6FH5uEH6F
         6RvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769726078; x=1770330878;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ifjZWXm6aQNqPteQIXl3MjOTMh03FfJVJJb/Dejs7KQ=;
        b=tLQkkKHs8qMZuy1Wk1lHx2oZSCamx29I+caeDv3Xvq2+E7ncwJ5Dhe3NTT/kklaDYn
         x4vF379TNNR4KKEaPrr4JFVh73sIo5rQbhprYjb1DX1GQJ2+SW1N13H/VohnC4VBkE0e
         tbtn8yNsY/uORlGMYSbUuaFLl/K9cK2rbRqPwjJYfilWbE7m76LF/F3lN9JyRnnVKx+t
         Mgebujs2+5GIHr5BB2Thncft/l4kmSU4e06yJQGsUg5a5QRu1jfA2isbIvMWaKYpKaAY
         5j6IiiphBHo670ls8R537PoxDAqQWJUSlxPlSaKyWzSt6ndLvM+PpBVcltsp4njYDe7O
         hrkg==
X-Forwarded-Encrypted: i=1; AJvYcCUZZyV/U7EsTrlLwUKK8y91KMD92pFdyy/1r14kNC0mhp+eRLmy4bZk73lqkkcGd3nyU2+ms0Ak87YHH+sKJMd3@vger.kernel.org
X-Gm-Message-State: AOJu0YymV2fglcU5ga403EZHRh+EcAJIEfNT5tQ+FmEyWvPtL9zSS+V6
	9JLnCEWWsWwkPJ0dfjmV2h/9epuTOkHpRk4sixE2OBOo0+uIsgAaqYNPl1tAZmhkd+AuTQgidvN
	Dxpw9Cg==
X-Received: from plbba3.prod.google.com ([2002:a17:902:7203:b0:298:465f:129])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d504:b0:2a0:92a6:955
 with SMTP id d9443c01a7336-2a8d7ee71f3mr8272895ad.23.1769726077924; Thu, 29
 Jan 2026 14:34:37 -0800 (PST)
Date: Thu, 29 Jan 2026 14:34:36 -0800
In-Reply-To: <CALMp9eSryGLaHfH0fWeQco1rTY57q=pskB5H50u2z4nxBuPqYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260121225438.3908422-1-jmattson@google.com> <20260121225438.3908422-5-jmattson@google.com>
 <aXJWkIw0oSzOmxLS@google.com> <CALMp9eSryGLaHfH0fWeQco1rTY57q=pskB5H50u2z4nxBuPqYA@mail.gmail.com>
Message-ID: <aXvgfM_rPNmmXDwn@google.com>
Subject: Re: [PATCH 4/6] KVM: x86/pmu: [De]activate HG_ONLY PMCs at SVME
 changes and nested transitions
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026, Jim Mattson wrote:
> On Thu, Jan 22, 2026 at 8:55=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Wed, Jan 21, 2026, Jim Mattson wrote:
> > > diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/includ=
e/asm/kvm-x86-pmu-ops.h
> > > index f0aa6996811f..7b32796213a0 100644
> > > --- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
> > > +++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
> > > @@ -26,6 +26,7 @@ KVM_X86_PMU_OP_OPTIONAL(cleanup)
> > >  KVM_X86_PMU_OP_OPTIONAL(write_global_ctrl)
> > >  KVM_X86_PMU_OP(mediated_load)
> > >  KVM_X86_PMU_OP(mediated_put)
> > > +KVM_X86_PMU_OP_OPTIONAL(set_pmc_eventsel_hw_enable)
> > >
> > >  #undef KVM_X86_PMU_OP
> > >  #undef KVM_X86_PMU_OP_OPTIONAL
> > > diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> > > index 833ee2ecd43f..1541c201285b 100644
> > > --- a/arch/x86/kvm/pmu.c
> > > +++ b/arch/x86/kvm/pmu.c
> > > @@ -1142,6 +1142,13 @@ void kvm_pmu_branch_retired(struct kvm_vcpu *v=
cpu)
> > >  }
> > >  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_pmu_branch_retired);
> > >
> > > +void kvm_pmu_set_pmc_eventsel_hw_enable(struct kvm_vcpu *vcpu,
> > > +                                    unsigned long *bitmap, bool enab=
le)
> > > +{
> > > +     kvm_pmu_call(set_pmc_eventsel_hw_enable)(vcpu, bitmap, enable);
> > > +}
> > > +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_pmu_set_pmc_eventsel_hw_enable);
> >
> > Why bounce through a PMU op just to go from nested.c to pmu.c?  AFAICT,=
 common
> > x86 code never calls kvm_pmu_set_pmc_eventsel_hw_enable(), just wire up=
 calls
> > directly to amd_pmu_refresh_host_guest_eventsels().
>=20
> It seemed that pmu.c deliberately didn't export anything. All accesses
> were via virtual function table. But maybe that was just happenstance.

Probably just happenstance?

> Should I create a separate pmu.h, or just throw the prototype into
> svm.h?

I say just throw it in svm.h.  We've had pmu_intel.h for a long time, and t=
here's
hardly anything in there.  And somewhat surprisingly, only two things in vm=
x.h
that obviously could go in pmu_intel.h.

  void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu);
  int intel_pmu_create_guest_lbr_event(struct kvm_vcpu *vcpu);
