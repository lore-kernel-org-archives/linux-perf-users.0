Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF15346A05
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769122073; cv=pass; b=P/CtFixam9YG3bwE59epBYxdj7cqbqRaHEaxRkH4tbw9CVCqFPfvGRkFj8l2PLUzctfJ1rrPQsoQ5RLi66fku//iSUzbKv2IANWQKMnOIfWT7gFb1Dbl/pAEL6OwPxYBK8znQsLE+4JcJ7b5WCRusUntBtUw3FG8O/BI5lcisWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769122073; c=relaxed/simple;
	bh=TND/Si/DRcSfUhMVT1qeEyIBuM6pXmd6mhIdRalzdww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pwtlx407vnNJD5yXWljC+1iftIOiDgRoByAurTD9ZW06InthDHBZkUZqW4MKY66vw+88bareXuKwLIaGDparNNHZ+kEGfxrgGgm1uKmRUur0mxttwXbnXjBzxE4ZL0AtSh0jRpu4dqhtkxyK4Cx/443SGWz/vVQpv+ypeseKv+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oTc4FjNs; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTc4FjNs"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6581551aa88so5139a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 14:47:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769122057; cv=none;
        d=google.com; s=arc-20240605;
        b=hToduMJnxF27mHLdyNFadXIDX5ihsuS/ct7cEPkStgkV0gmvXPEDpts0c6A/LWi7vn
         1HSFoRwAysSCaeArI2jlHSd0gELmiDBJVO2CK/OF+b3IDNdqpsMwdnOjbLp0UoWvYB9A
         QjhoGd3p/8MCxsIJ8azJkVyul9d0fHfz1MYeKtkV5osYfZUdD9sKlFCfv9MVMRp8UNaD
         +bQP+S2iGAbF//CGgucgkxoi9ZX4iKLTkF3UopSUYGYU3soX07/mLyAkSnySl2t9H4xE
         XlV+XoZcHqyAJfLzfqy88SuTcncH+ZuSYQo9ioHEjOVifbWdbmMmfk4P58B7CdUM8SRn
         hiOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=73p/P7bLELYiLT0M410lIGTK80iJQLNo9oAfsXMKpaQ=;
        fh=VWirV18gtA+gwnB4Y3SKK53oBX5pSwSMjBoxrKMfKsM=;
        b=KiaH1hk7uoSEg5uzpwYA+o9Bnwoq/zTl/cvRHXmc0u8gfvBm8rehQ1Sw+bdk6kMTnM
         anCup7VyGH7gRgCzzPmcoDZRTD/N8DBEu1AEEtPBpLXlEjw5IGCyBXSMdXF/swPiue80
         OIJ5sR3kjkpGMu67sMSid3Sc6xghQu2ub2mwinP1fVMVhM/QfQTuTOFe7a8oZJmnnhDn
         PiYlt4jrd14tW8OcRSmMWaYYPQ/36k74yr0tX4wPm6ABDthCPKgGIFkw9yhHP455NXyF
         fKBeCeJDcTirSY1CSzg92Xb2p50jHTw9kaXooruOQhgVEujSTzo0sfWCWG29LIX7+7Ys
         8Uvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769122057; x=1769726857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73p/P7bLELYiLT0M410lIGTK80iJQLNo9oAfsXMKpaQ=;
        b=oTc4FjNsVXElVl6/m5w70zuzsF/zfCyadF3V/eeM2FNDZHKfjCq8gScaWvQDvnCq3y
         XfnA+qNAljNJrdyDS8EQDu5VO8ZrP9FwhhwYb94lxU+hEyhbnlvRqrPK1n8fydaqIaWx
         fmDAigGuNYm26BgIMB4cT5k6Cj2V2SMjKwghDE8NA7hDkPXahHklom8zthGgtAoF3plZ
         Ac7tcIWpayyQqJ8aZpecrdmD2vxBAt5n4/ep7CrXYMs2iSB2Dj8gGsBMgFPnbavc67+d
         IvEVD2udYxbeDP8D3P9Z1Z2PymoC2zgyZxIIlxBMWAUfvN2kSH0opbH/GKNPAgVz677Q
         lu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769122057; x=1769726857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=73p/P7bLELYiLT0M410lIGTK80iJQLNo9oAfsXMKpaQ=;
        b=AmlEbThuc1v3HXLw98KHNsq+kJ6DuOHrOXQhTjMIPNKR4/e8WLmivTEnohD2zXm4vC
         z9Htn6LBrNCOSfP4o4SGQYqTt4kds3P0XLa0U/BkaZNT6eVAyJM8eauZc05JipQp5dea
         Q76pxAFggJOd68SwLFjvWipF5y4tPcdLcSUiXkNuUMedMu3vNVf9whLqqcOPr1N99RM5
         HoRuoDKpUOqeTJeE4QfJ9FiuZOGuP1CYqYUnIIKMjyn4TxScMS610Gi7FeRXJagfw3q7
         QHzYy6GKMEgezUkxSlxoPfwLysYvEZLJRYm0eXMXVaCweW3YreQ1kizytYkVmB8bm9FT
         9mzA==
X-Forwarded-Encrypted: i=1; AJvYcCUfu8PfqXpVshaDQdAQDIpLxXmn9Xyj14F+gXuk7c/ykWAKlYsnqhLOw2syiPTrzgwXrmPCiloJ16/BARi/E52X@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4pPsdrw/AFPRTXvr7DVQuhmS5B96FBo8LHvqKyDcbtkCtD2jc
	3C7JtKPCdsNkd2iftVssoJIlDJjlGLTdjg7yteI9B+oUAf3qxJDJptYVFfCm7S1W3EhgfqlU8N5
	FDvHwiwvhaR5k4mYojgffJJxBEbuRUnDlHZmfT8Eo
X-Gm-Gg: AZuq6aKisF9+T3iliZQeAm0CxUFcTiV7PsDzZ2WzCoOg4694b0xDxX4LBHUKVIzzXjV
	cPH7SOhBaQhjFkHf0ObfocVZTlOMuBOla6tMErFgSZlsO781bLoE+eK+Er/n8ECUYsEnINLAhas
	DCgC0yW3xs2KI3X9QbxFkKADg+PTWkA0ccLCWl6UUiC3mfdu7mVOcL5lbhotzLEPvSRKEq05D7g
	AuBhXV/E4V9vzhQRIwG66Y8KIQak5yBQcjy4/krpq0/UGJ5cAOj1FqzLrqvhrAy9F6Azb6cVDuQ
	aZvM+X/5sl5Sb0UT2Pl3HeU=
X-Received: by 2002:aa7:c74f:0:b0:658:909:511 with SMTP id 4fb4d7f45d1cf-6584eaa7e3dmr3822a12.3.1769122057232;
 Thu, 22 Jan 2026 14:47:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121225438.3908422-1-jmattson@google.com> <20260121225438.3908422-3-jmattson@google.com>
 <aXJRWtdzjcb8_APA@google.com>
In-Reply-To: <aXJRWtdzjcb8_APA@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 22 Jan 2026 14:47:25 -0800
X-Gm-Features: AZwV_QgLJNlpwnESIOnJyOjuyzAXTUsC4-1Gsi8ldMfpGFY9pFyZtqFYo2yuOLw
Message-ID: <CALMp9eRGj3rNeNN82H12f=XO5iXi5s2ri2K71CnjoVp9eKzz1w@mail.gmail.com>
Subject: Re: [PATCH 2/6] KVM: x86/pmu: Disable HG_ONLY events as appropriate
 for current vCPU state
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

On Thu, Jan 22, 2026 at 8:33=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Jan 21, 2026, Jim Mattson wrote:
> > Introduce amd_pmu_dormant_hg_event(), which determines whether an AMD P=
MC
> > should be dormant (i.e. not count) based on the guest's Host-Only and
> > Guest-Only event selector bits and the current vCPU state.
> >
> > Update amd_pmu_set_eventsel_hw() to clear the event selector's enable b=
it
> > when the event is dormant.
> >
> > Signed-off-by: Jim Mattson <jmattson@google.com>
> > ---
> >  arch/x86/include/asm/perf_event.h |  2 ++
> >  arch/x86/kvm/svm/pmu.c            | 23 +++++++++++++++++++++++
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/p=
erf_event.h
> > index 0d9af4135e0a..7649d79d91a6 100644
> > --- a/arch/x86/include/asm/perf_event.h
> > +++ b/arch/x86/include/asm/perf_event.h
> > @@ -58,6 +58,8 @@
> >  #define AMD64_EVENTSEL_INT_CORE_ENABLE                       (1ULL << =
36)
> >  #define AMD64_EVENTSEL_GUESTONLY                     (1ULL << 40)
> >  #define AMD64_EVENTSEL_HOSTONLY                              (1ULL << =
41)
> > +#define AMD64_EVENTSEL_HG_ONLY                               \
>
> I would strongly prefer to avoid the HG acronym, as it's not immediately =
obvious
> that it's HOST_GUEST, and avoiding long lines even with the full HOST_GUE=
ST is
> pretty easy.

In this instance, I'm happy to make the suggested change, but I think
your overall distaste for HG_ONLY is unwarranted.
These bits are documented in the APM as:

> HG_ONLY (Host/Guest Only)=E2=80=94Bits 41:40, read/write

> The name should also have "MASK" at the end to make it more obvious this =
is a
> multi-flag macro, i.e. not a single-flag value.  Otherwise the intent and=
 thus
> correctness of code like this isn't obvious:
>
>         if (eventsel & AMD64_EVENTSEL_HG_ONLY)
>
> How about AMD64_EVENTSEL_HOST_GUEST_MASK?

Sure.

> > +     (AMD64_EVENTSEL_HOSTONLY | AMD64_EVENTSEL_GUESTONLY)
> >
> >  #define AMD64_EVENTSEL_INT_CORE_SEL_SHIFT            37
> >  #define AMD64_EVENTSEL_INT_CORE_SEL_MASK             \
> > diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> > index 33c139b23a9e..f619417557f9 100644
> > --- a/arch/x86/kvm/svm/pmu.c
> > +++ b/arch/x86/kvm/svm/pmu.c
> > @@ -147,10 +147,33 @@ static int amd_pmu_get_msr(struct kvm_vcpu *vcpu,=
 struct msr_data *msr_info)
> >       return 1;
> >  }
> >
> > +static bool amd_pmu_dormant_hg_event(struct kvm_pmc *pmc)
>
> I think I would prefer to flip the polarity, even though the only caller =
would
> then need to invert the return value.  Partly because I think we can come=
 up with
> a more intuitive name, partly because it'll make the last check in partic=
ular
> more intutive, i.e. IMO, checking "guest =3D=3D guest"
>
>         return !!(hg_only & AMD64_EVENTSEL_GUESTONLY) =3D=3D is_guest_mod=
e(vcpu);
>
> is more obvious than checking "host =3D=3D guest":
>
>         return !!(hg_only & AMD64_EVENTSEL_GUESTONLY) =3D=3D is_guest_mod=
e(vcpu);
>
> Maybe amd_pmc_is_active() or amd_pmc_counts_in_current_mode()?

I think amd_pmc_is_active() is a much stronger statement, implying
that both enable bits are also set.

Similarly, amd_pmc_counts_in_current_mode() sounds like it looks at
OS/USR bits as well.

I'll see if I can think of a better name that isn't misleading. I
actually went with this polarity because of the naming problem. But, I
agree that the reverse polarity is marginally better.

> > +{
> > +     u64 hg_only =3D pmc->eventsel & AMD64_EVENTSEL_HG_ONLY;
> > +     struct kvm_vcpu *vcpu =3D pmc->vcpu;
> > +
> > +     if (hg_only =3D=3D 0)
>
> !hg_only

Now, you're just being petty. But, okay.

> In the spirit of avoiding the "hg" acronym, what if we do something like =
this?
>
>         const u64 HOST_GUEST_MASK =3D AMD64_EVENTSEL_HOST_GUEST_MASK;

Ugh. No. You can't both prefer the longer name and yet avoid it like
the plague. If you need to introduce a shorter alias, the longer name
is a bad choice.

>         struct kvm_vcpu *vcpu =3D pmc->vcpu;
>         u64 eventsel =3D pmc->eventsel;
>
>         /*
>          * PMCs count in both host and guest if neither {HOST,GUEST}_ONLY=
 flags
>          * are set, or if both flags are set.
>          */
>         if (!(eventsel & HOST_GUEST_MASK) ||
>             ((eventsel & HOST_GUEST_MASK) =3D=3D HOST_GUEST_MASK))
>                 return true;
>
>         /* {HOST,GUEST}_ONLY bits are ignored when SVME is clear. */
>         if (!(vcpu->arch.efer & EFER_SVME))
>                 return true;
>
>         return !!(eventsel & AMD64_EVENTSEL_GUESTONLY) =3D=3D is_guest_mo=
de(vcpu);
>
> > +             /* Not an HG_ONLY event */
>
> Please don't put comments inside single-line if-statements.  99% of the t=
ime
> it's easy to put the comment outside of the if-statement, and doing so en=
courages
> a more verbose comment and avoids a "does this if-statement need curly-br=
aces"
> debate.

There is no debate. A comment is not a statement. But, okay.

> > +             return false;
> > +
> > +     if (!(vcpu->arch.efer & EFER_SVME))
> > +             /* HG_ONLY bits are ignored when SVME is clear */
> > +             return false;
> > +
> > +     /* Always active if both HG_ONLY bits are set */
> > +     if (hg_only =3D=3D AMD64_EVENTSEL_HG_ONLY)
>
> I vote to check this condition at the same time !hg_only is checked.  Fro=
m a
> *very* pedantic perspective, one could argue it's "wrong" to check the bi=
ts when
> SVME=3D0, but the purpose of the helper is to detect if the PMC is active=
 or not.
> Precisely following the architectural behavior is unnecessary.

Even I am not that pedantic.

> > +             return false;
> > +
> > +     return !!(hg_only & AMD64_EVENTSEL_HOSTONLY) =3D=3D is_guest_mode=
(vcpu);
> > +}
> > +
> >  static void amd_pmu_set_eventsel_hw(struct kvm_pmc *pmc)
> >  {
> >       pmc->eventsel_hw =3D (pmc->eventsel & ~AMD64_EVENTSEL_HOSTONLY) |
> >               AMD64_EVENTSEL_GUESTONLY;
> > +
> > +     if (amd_pmu_dormant_hg_event(pmc))
> > +             pmc->eventsel_hw &=3D ~ARCH_PERFMON_EVENTSEL_ENABLE;
> >  }
> >
> >  static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr=
_info)
> > --
> > 2.52.0.457.g6b5491de43-goog
> >
