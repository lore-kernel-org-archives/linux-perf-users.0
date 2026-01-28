Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16B03382D2
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769643813; cv=pass; b=OlWvRvoqBAkcY6CncNncDxB0GvR3/g6t6Q5JwQbpy5t1lIddL1/Qc5Wljm6kZcP9edFhygf6WKsvTckxj68sC+RdaNhe7FAqAgDihvAzZmBEdv4CSrNgBVNqoH8u+aB/tKfkdYuno12hmuFXtx6b5ImnKXU4//TlYGNFkUDu+A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769643813; c=relaxed/simple;
	bh=3eKMB8/N0MTev+99HlBTlmZD4BLsN9uhauxq9iekQUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYZQt46QlLqKNTBNXv34HEaPQSv3MpLg6Bd3plkOkrCDQ0/O1QzEOwDNeJRcrz2jV/s4VHmq+g7K0J9ltCCpRyLK01hcUnSratYVgrPvutD+5QZcC1KIoHHvTIFCBOSgvQ4Q0a4qCK6lQi/NYNwZZhHnZgHKKjTYUdPbAg1hho8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fN6DU6gp; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fN6DU6gp"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5033b64256dso77561cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Jan 2026 15:43:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769643811; cv=none;
        d=google.com; s=arc-20240605;
        b=hWIkh+Znd0U4xXRakHJotgpxWNq+I79aWzRjSHhHHRNOlqBe8rNfSi1p+mOrD7FUJn
         9XR1X+ExwGkugVgT7pjMOzqaO32i8S3y8glsuMy7KzFtiLXhxEu+Fi7L3HN8G5zdlbgG
         Cd5aBD1Mv+kqdh1x/obfI7zLFkFgpCXVt81SxfxnhKWmqhL0V9qvW5jNbwosM/mpcpBk
         SdGk5tdUZWjc/NuGaClofK3QhMKCPXPdFmtLodz85Kh/k05YlDXFto63jXqTbUUll+8O
         tSW/Yx8ni0FopP1r8KXK9NyaGvqegkuL8ccfK4ncL26gHpFRpnknohjHKjPJUIls8GN2
         NKZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cbg9Q5eQVZakHpCjsYsySo/U1zRKnpzshKoOs5i9/fo=;
        fh=ezTSOZQX7RuFP2MkpdX0hl6meOzpv/fCAiT08K61J2A=;
        b=Aq9LsrECvP4rEm+EHkBf+nDYNn/mvjjhUjPZ00E5mpGI2Q772ee9HwwgXoPN2wt5L1
         oG9aZyNkCOtNcMCeuteM7TGxaHJvjz+hIkMwrh3GiQsDfe7Nunym1of6mBT6eY2Xs5wb
         ELTRbLrnNj4oEHB8bHmGYv30RFUtEOcX3kN+cSp4tYXT+TGqeCyXi1DdVM3u5IQ+8sh4
         HB6SW68X2+Et4/SlQVKCYeiOtwYtnrThAto9ajQNSW4AH8N72QnfyVeixVRDPtFcjdZG
         xMT7oUQ1+0W3SmB5fHpKeXUhBvJIBvzTyph5/J4LtwLEEj05zRSFSkK1N454LS5PuV/T
         SwiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769643811; x=1770248611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cbg9Q5eQVZakHpCjsYsySo/U1zRKnpzshKoOs5i9/fo=;
        b=fN6DU6gp2U3nktsx+h/gFgsRp0VKOYG0EKaGA3MvxbUh/RrPsHS51zNjT+52tbMv4m
         yxYwt/EPYPb2LnyVO4YDk/LRcly1tKbhCZC5qCLkaq7/cgwi64r5sM5U3gLip02DnukD
         RmVDQvIoaMHYc1u0frAdxEkAz3tNZGEnTb6nTSjTCX5QIqXcfoSFakLzPjbZ4MXdHYM2
         RRExj+lC9aQvts2u5Oyy4Ern+DWdmd//VeB2PlhPB9ZH10R3GFfbJROwmiIynAoYGo7V
         2Lt2Xr786ZXFcl8FfVExazmSDWE+h26vt7HthmtNpfLhrfy+rRERsvR4gxzJ1Y37vko1
         6oJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769643811; x=1770248611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cbg9Q5eQVZakHpCjsYsySo/U1zRKnpzshKoOs5i9/fo=;
        b=JP4xlE17+WSsApaKKDlMqpaN8X3MnwZpTR7Tn7FRepwpsXM5NqnXdmHpolw8HOU6Tj
         rmEPzhYZ0CbJEoYcsKmYSutVtF/OgT8kktxvLgxBG9vo28+oK8fC5t8wFgdXEQfY9bu5
         WtO0ErmRsXpyz1vu2MoNxxk8s0RvoD8X618yb0nXYuzTmHkj5AochW8FLMI4IvhuPB3G
         AfThMF7N7m4WdFQSIUDAZ7PagyIZg5wMTz3aVrJ4Zn3ae53tCxIsJ+DVWY93jd2aK/IB
         lZQwGRpWXa+TNYAkd4aO6gAvn9XzGJFf5K5M2x8IFqjld2uSPQwLyWOHMoYo3OS78+eZ
         V/kw==
X-Forwarded-Encrypted: i=1; AJvYcCXSOWadUsTT0JN6CCfC+FvFSQd1BjO6/Y9F1iyHXXQ9TdP2U9Jp+4fg0eaGvLNjogueriQNZHX66mmHV0pVf91a@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdbx+cQGmx1FJLmi5ZUXdHZ+dsTV3EQelGyXzOgFKO2+TJkNti
	QDS8OcTlUTdyFUn92o2yOzGNliZwygKyXclBe7889Fhoj+Rlu06F9HOv6lOFiNhw15q+myXXyr3
	DDcxchu24rGmiD5hy0Gk9wr2veEP1zZ0SUOPOrOqm
X-Gm-Gg: AZuq6aIXBgcekYUX0/5R9dYOna7SfQgBid9H94Fuy0AR92TG79lgGHZMJATN4MefS7O
	CRZm1CC++IQ5ZuXvFZ7iyZ102H+wiRfVE20JmvjoCRNCYsBN0QJn5wvid/JfaH48mNB7Ra5bIl1
	+JLU+vqiP74gXo6G9y1FXyGKkDVMlYAVLMP+yYmlmLSp4gbqv5cxJmxAeWJOYKJBV1u5z7zpy8S
	QNpzqXmgJKWtG4cR56H+PuQ/Shmey61ktwqn1/Fn2o5sewnOfhrJ9Jegbi9GDHobU8aKvk=
X-Received: by 2002:ac8:5845:0:b0:4f3:5475:6b10 with SMTP id
 d75a77b69052e-503b670708bmr4368881cf.8.1769643810455; Wed, 28 Jan 2026
 15:43:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121225438.3908422-1-jmattson@google.com> <20260121225438.3908422-5-jmattson@google.com>
 <aXJWkIw0oSzOmxLS@google.com>
In-Reply-To: <aXJWkIw0oSzOmxLS@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 28 Jan 2026 15:43:17 -0800
X-Gm-Features: AZwV_Qg3cPvdxu5JjE3L9etXDIim1laTDylrUrWKJZNk6kMLsMV9S1LQ51Qci3M
Message-ID: <CALMp9eSryGLaHfH0fWeQco1rTY57q=pskB5H50u2z4nxBuPqYA@mail.gmail.com>
Subject: Re: [PATCH 4/6] KVM: x86/pmu: [De]activate HG_ONLY PMCs at SVME
 changes and nested transitions
To: Sean Christopherson <seanjc@google.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 8:55=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Jan 21, 2026, Jim Mattson wrote:
> > diff --git a/arch/x86/include/asm/kvm-x86-pmu-ops.h b/arch/x86/include/=
asm/kvm-x86-pmu-ops.h
> > index f0aa6996811f..7b32796213a0 100644
> > --- a/arch/x86/include/asm/kvm-x86-pmu-ops.h
> > +++ b/arch/x86/include/asm/kvm-x86-pmu-ops.h
> > @@ -26,6 +26,7 @@ KVM_X86_PMU_OP_OPTIONAL(cleanup)
> >  KVM_X86_PMU_OP_OPTIONAL(write_global_ctrl)
> >  KVM_X86_PMU_OP(mediated_load)
> >  KVM_X86_PMU_OP(mediated_put)
> > +KVM_X86_PMU_OP_OPTIONAL(set_pmc_eventsel_hw_enable)
> >
> >  #undef KVM_X86_PMU_OP
> >  #undef KVM_X86_PMU_OP_OPTIONAL
> > diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> > index 833ee2ecd43f..1541c201285b 100644
> > --- a/arch/x86/kvm/pmu.c
> > +++ b/arch/x86/kvm/pmu.c
> > @@ -1142,6 +1142,13 @@ void kvm_pmu_branch_retired(struct kvm_vcpu *vcp=
u)
> >  }
> >  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_pmu_branch_retired);
> >
> > +void kvm_pmu_set_pmc_eventsel_hw_enable(struct kvm_vcpu *vcpu,
> > +                                    unsigned long *bitmap, bool enable=
)
> > +{
> > +     kvm_pmu_call(set_pmc_eventsel_hw_enable)(vcpu, bitmap, enable);
> > +}
> > +EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_pmu_set_pmc_eventsel_hw_enable);
>
> Why bounce through a PMU op just to go from nested.c to pmu.c?  AFAICT, c=
ommon
> x86 code never calls kvm_pmu_set_pmc_eventsel_hw_enable(), just wire up c=
alls
> directly to amd_pmu_refresh_host_guest_eventsels().

It seemed that pmu.c deliberately didn't export anything. All accesses
were via virtual function table. But maybe that was just happenstance.
Should I create a separate pmu.h, or just throw the prototype into
svm.h?

> > @@ -1054,6 +1055,11 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
> >       if (enter_svm_guest_mode(vcpu, vmcb12_gpa, vmcb12, true))
> >               goto out_exit_err;
> >
> > +     kvm_pmu_set_pmc_eventsel_hw_enable(vcpu,
> > +             vcpu_to_pmu(vcpu)->pmc_hostonly, false);
> > +     kvm_pmu_set_pmc_eventsel_hw_enable(vcpu,
> > +             vcpu_to_pmu(vcpu)->pmc_guestonly, true);
> > +
> >       if (nested_svm_merge_msrpm(vcpu))
> >               goto out;
> >
> > @@ -1137,6 +1143,10 @@ int nested_svm_vmexit(struct vcpu_svm *svm)
> >
> >       /* Exit Guest-Mode */
> >       leave_guest_mode(vcpu);
> > +     kvm_pmu_set_pmc_eventsel_hw_enable(vcpu,
> > +             vcpu_to_pmu(vcpu)->pmc_hostonly, true);
> > +     kvm_pmu_set_pmc_eventsel_hw_enable(vcpu,
> > +             vcpu_to_pmu(vcpu)->pmc_guestonly, false);
> >       svm->nested.vmcb12_gpa =3D 0;
> >       WARN_ON_ONCE(svm->nested.nested_run_pending);
>
> I don't think these are the right places to hook.  Shouldn't KVM update t=
he
> event selectors on _all_ transitions, whether they're architectural or no=
t?  E.g.
> by wrapping {enter,leave}_guest_mode()?

You are so right! I will fix this in the next version.

> static void svm_enter_guest_mode(struct kvm_vcpu *vcpu)
> {
>         enter_guest_mode(vcpu);
>         amd_pmu_refresh_host_guest_eventsels(vcpu);
> }
>
> static void svm_leave_guest_mode(struct kvm_vcpu *vcpu)
> {
>         leave_guest_mode(vcpu);
>         amd_pmu_refresh_host_guest_eventsels(vcpu);
> }
