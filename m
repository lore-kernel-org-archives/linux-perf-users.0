Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299413D16F1
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777923789; cv=pass; b=DS7kgGLAcC1663DzFuQNrl1wOWb/2trNa3o6nAwH2zl7fSBs2QAnxybsl/Nl8ccN7di9XkSBc/jfTPTOBbwjZOar6nOr6wci8s44amSYfNNWD0oWksvMBWkufKjD9uQTCxttwWVQIygGriaIC+4UN9uaex/GG9XSgaVCA89n74s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777923789; c=relaxed/simple;
	bh=r9Tc8+D8AinjziQ4OFrUbBHEoIMfVWrL6WKwzmW7VEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBBuFargtkBX1vKlTe0USIphSDuDNyhdQJHqxYZOcpTKNrU5FezCgB1yTu/siFRNkAKitQzAwSaGEIRuW1g/DEpdZrtEaMKy8GfllMcJeVitF/XBON+fHQ/U/Xa4Z91G1MtDsrJ31aSV4i9cfX3ek/rxj76hMp3WI7noW2DnydI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YN45o/Dx; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YN45o/Dx"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso496a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 12:43:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777923786; cv=none;
        d=google.com; s=arc-20240605;
        b=cv5dm/q1OZj0B1sk9QQ8rVeh7UypsvCtCt4fBtt44TOk3hlMSAwWAcOI4cqg+Eb6AD
         jY4BpGiLrhMjIGlDnqlgLL6DZYrh9jj7LtsUZ3xAMB7UojCcD3JMgL1AR8ABmf7VhKgv
         LHzHYquCKAND/qrAZV859vN965MtCzqNlFvXQVBKyO628hXTUR+a5f7MX5IHIM91u6wp
         tEFsr/ETqcPUDLI4YM/MfThOaHp7AC/4rVQfYJcIMSgM4XDDDIOXFbgrlyjp9NDZ4Ypi
         b/iJDH4m27TXIV2mhpuo5QDV9ehRWD587w9QauvTLaiJXvPB4ObopaFgt7nmjYUfWHpj
         mNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fVo9WZIwpblsiv1wQ6q4YKWmAXmautadgAuM0akTBn4=;
        fh=hG4F7gjUQQbtskSooJX802AI+hlHfzVBSKkVqrDjXKs=;
        b=kUCPhNzPPxVy6rB9NmMJT5oqaolMl8k03/DVU1abN+TsCp25re6WefM8ugm20/zuMr
         S4dyVU73EN7/HEXjikhzhdQeQkOWQhA1ULlz7izQY6+iEglCuoIUnvwz/AR4bfX8wEMs
         /esTjac2zQzajHHApzPz0OoM+zdab6Wk1DsmUltHp+dTqBAwnLwUwHeUZI+MNe/ufqT2
         Xx9N5fwgAd/aHXGG8SUnOvjWJ/fAWjbgrYcRMDu4+vsyfFUeQ1+cShP9xfeZk3GdOXN2
         DeXNxEFPCS5Ni3Wxb875hmOcoltczz2nBQ/Hc6n+lnJtchW+72dUcyU9Y64OZjTL3qNU
         mPaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777923786; x=1778528586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVo9WZIwpblsiv1wQ6q4YKWmAXmautadgAuM0akTBn4=;
        b=YN45o/Dx1v/U2Fdnmwi+pfDMiXtKcUQqBDsfgnfg4CYOtYQwRVyTor1M4bqpLeVunI
         nHPsERWfhdOyOcPYF2clvp4ZlKxyvJlI6DNuS3KqyZ9vL5mn8FnLdLpG835gjUQB9nhF
         0duYcOdjFkshsnJb0PqjBhLbEokbStnt5RTZmguK2qIEJJuvGfJBCU9c86kVp2EDYJVM
         S7rv5SPn9odmgm4nBgSiE6Qw5c73V2IBc875fW9wjDTVMFQBFZCEGZmaG38tfFAhf28S
         LqyS2xnkRkrhHWxyhd3oF6t8t9gD1KCdQF60zdSGtcBryyvuGGuSDb9x93R/vGWTE4kL
         HpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777923786; x=1778528586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fVo9WZIwpblsiv1wQ6q4YKWmAXmautadgAuM0akTBn4=;
        b=c/TY57IK9mgfTz63mMLM2yRqZY9wlRHtMCrJFEfENe8T5sTrj6N3nF1YIZnVzkvsGT
         4vj2jj12Fa0na1NUCFwDhjRX/QyteZ70pGiDqHcs577iIOUvQxASrg+pUNLI66aUDGqD
         ohYKvgd0QysYWUyWmAm0f9+A1ih5gfpFwK8xHSjQm2U2LlJVJwK5PWLyjQZRWjyAOvyl
         jbkvW4UH7Vt4MlxHL3xypLSRLupQIRtcWS6QOZFq4X6u6tk40AlQNBOrEBKGb5vZOzfn
         ejPMNwgY5qo29ysycyS7hM8+D1VjyziQ2gzrnkMHJb0qBqoQXsIwTM0/Z8k57Di8of0B
         Fx/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/bFONdABAuhdBOX4WGv1KGt4EixfXbzMZqroKm4v2SUrSIUMljVHWksUFrGIrbvabRSBIWbbpZFa8N/mjkYBf8@vger.kernel.org
X-Gm-Message-State: AOJu0YzweNv5thWm1Krc5FVs+3Wqvqan9WBK38spUSi8yaAFx2TiqyjJ
	o7YLVUGRJlaHZe7x4LY/qGF0p7Qw8PbHVT9jw5SI3VG9F9uhzhDEHi2jP4EsK+6+yWlMsF5kBkR
	A5a74eGqtLNOe6pl2ivIZTvTLFwuKE2XZ2eD3czvT
X-Gm-Gg: AeBDievx+W+1EJQC/X0aDdHCHPd8ctUrD00VbW4o8NyB25QZlTDzCFumbA/ca53eJrC
	yfXUZPezPvXM/r5BA13gyqDgJ5QMAtitZ4TNF/JSrsWjybOciXMuMLGtBf0pWXuemN5Zjqg+Fzt
	BM7l4nFqJwU5F0PzB8VwjCm3pbpUo7ASq9aFiSI10X+t713jXd5ensuMjL7sEX9vHb+LQJouWKI
	MXbYBs207WljkDTE53xOySnAmE/jCbIbapkl/c7aMjG00jjjI74tSAMPl0pp8t7AUVsws7s9LtR
	+PyjCub3wgEaevZ3KZTH16ICxa40
X-Received: by 2002:aa7:c7c4:0:b0:660:efc9:900a with SMTP id
 4fb4d7f45d1cf-67cc44de9a7mr10687a12.10.1777923786071; Mon, 04 May 2026
 12:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423150340.463896-1-seanjc@google.com> <20260423150340.463896-5-seanjc@google.com>
 <CALMp9eSt-ZDCxhyVjEiov2475ToZ7M_94HSpKg6hqrh=m3iZAg@mail.gmail.com> <afjU2ZbwRq7Jig0w@google.com>
In-Reply-To: <afjU2ZbwRq7Jig0w@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 4 May 2026 12:42:54 -0700
X-Gm-Features: AVHnY4KBRrG6P6Ug3x2co3Is7udBMHdxYXoEqBKCo9xlDUqBrgoanrcIb0zRhzA
Message-ID: <CALMp9eRBcyLZJrcK+RqpSn3efPP62kuD00pDzQv7kRDBjkbqJQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf/x86: KVM: Have perf define a dedicated struct
 for getting guest PEBS data
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Stephane Eranian <eranian@google.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 10:19=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, May 01, 2026, Jim Mattson wrote:
> > On Thu, Apr 23, 2026 at 8:03=E2=80=AFAM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/cor=
e.c
> > > index 7403ca721b6a..04d9c51335d7 100644
> > > --- a/arch/x86/events/intel/core.c
> > > +++ b/arch/x86/events/intel/core.c
> > > @@ -14,7 +14,6 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/export.h>
> > >  #include <linux/nmi.h>
> > > -#include <linux/kvm_host.h>
> > >
> > >  #include <asm/cpufeature.h>
> > >  #include <asm/debugreg.h>
> > > @@ -4992,11 +4991,11 @@ static int intel_pmu_hw_config(struct perf_ev=
ent *event)
> > >   * when it uses {RD,WR}MSR, which should be handled by the KVM conte=
xt,
> > >   * specifically in the intel_pmu_{get,set}_msr().
> > >   */
> > > -static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, v=
oid *data)
> > > +static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr,
> > > +                                                         struct x86_=
guest_pebs *guest_pebs)
> > >  {
> > >         struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> > >         struct perf_guest_switch_msr *arr =3D cpuc->guest_switch_msrs=
;
> > > -       struct kvm_pmu *kvm_pmu =3D (struct kvm_pmu *)data;
> > >         u64 intel_ctrl =3D hybrid(cpuc->pmu, intel_ctrl);
> > >         u64 pebs_mask =3D cpuc->pebs_enabled & x86_pmu.pebs_capable;
> > >         u64 guest_pebs_mask =3D pebs_mask & ~cpuc->intel_ctrl_host_ma=
sk;
> > > @@ -5052,7 +5051,7 @@ static struct perf_guest_switch_msr *intel_gues=
t_get_msrs(int *nr, void *data)
> > >          * wrong counter(s).  Similarly, disallow PEBS in the guest i=
f the host
> > >          * is using PEBS, to avoid bleeding host state into PEBS reco=
rds.
> > >          */
> > > -       guest_pebs_mask &=3D kvm_pmu->pebs_enable & ~kvm_pmu->host_cr=
oss_mapped_mask;
> > > +       guest_pebs_mask &=3D guest_pebs->enable & ~guest_pebs->cross_=
mapped_mask;
> >
> > It would be helpful to save this mask somewhere, so that it can be
> > used when calculating guest_pebs_idxs in x86_pmu_handle_guest_pebs().
> > I think that code needs a fix similar to the one in commit
> > 58f6217e5d01 ("perf/x86/intel: KVM: Mask PEBS_ENABLE loaded for guest
> > with vCPU's value.").
>
> Blech.  This all feels like a losing game of whack-a-mole.  Proxying the =
PMU
> through perf is a mediocre approximation for non-PEBS events, and it seem=
s like
> it's downright awful for PEBS.  Ideally, we'd just rip out all of the per=
f-based
> PEBS virtualization support, and only support PEBS through the mediated P=
MU.  :-/
>
> Absent drastic measures though, saving the effective guest_pebs_enable in=
 the
> per-CPU tracking does seem like the least awful approach.  Though I don't=
 quite
> understand why we can't use GLOBAL_STATUS for x86_pmu_handle_guest_pebs()=
.  I.e.
> what happens if x86_pmu_handle_guest_pebs() only processes counters that =
actually
> got marked as overflowing?

x86_pmu_handle_guest_pebs() is called in the path where we are
handling GLOBAL_STATUS bit 62 (GLOBAL_STATUS_BUFFER_OVF_BIT).
Individual PEBS PMCs are not configured to raise PMI on overflow.

Moreover, I believe kvm_arch_pmi_in_guest() returns a false positive
if perf is using NMI for PMI, and a PMI occurs while between
kvm_before_interrupt(vcpu, KVM_HANDLING_IRQ) and
kvm_after_interrupt(vcpu).

> Regardless, I'm not going to try and address that mess in this series.  A=
FAICT,
> it's not urgent, and I don't want to snowball into a broader cleanup.

I'll let you know if our instrumentation changes that sense of urgency. :)
