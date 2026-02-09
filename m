Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024E829BDAB
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770655499; cv=pass; b=fHKQoXEdj2Yr/+UxhCLtQExAwZ0IXbXCLHprQJGwMIfS5qXWG570CKtu9mHDDc238h0ckAJET+hNfCSYuZ04jSKodWTBjoYylanAIRfF4twW1cc5b+IM24zYh47oQfKE6AqYgBLmG1QnB04ROYHSNQeQ8NZMDMHsuxfmlYBOpCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770655499; c=relaxed/simple;
	bh=wrdplUFA6RKQnfr1gdqv3J36haYwyiXQ+Y3/DHl6WiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWf7pdwNkla+7OsQPXGa5aG5OTYsnWEiUYv8dwWieUkTOjuMrrG5YurKNQlxMXYlHCOHLuOPCDf+iQc8bKSj/bZoO+5jyRwcq0BjRr8xd77hAPWyrg0vjqIs4V0YuRsgO6qFLehzbVUna9FFWntdgHINIaOED3xwmCqN9+TnzNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=To2cRWNE; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="To2cRWNE"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64baa44df99so14393a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 08:44:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770655497; cv=none;
        d=google.com; s=arc-20240605;
        b=W/TA+WhkESZVaV/3IYhjM6khxRubyhReEoljPLvbBSW7VTmzrO87cLf5almiNlEEJg
         iQ4f/u2CQ1192ZoQXg7ivguq+x3U8bpMl5hR2m6fOEp7WMiIxqGedQEt/VAxDKT0YgnJ
         q6TJNzKGK0528I8Cpubb5RIRL7MDLAEywHZOpsKkpOOXQPdoQSz8WtxqD90ih0+jislt
         aR5TIA4OcgQNaZWNb632DtDsxjv+M511Ov2TftsebszBV7NWEVgi2eSqbBWEid9yV0E7
         eEVMg7Hmh8iMqILEsJcy6Qzh19MtX8oRNsTtXPZx/nSRBJTTmKZPO3h0x35fYBWHwzFk
         T7Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tmyTl6q+tqeF975POxGfJcIFC8oCHkJvZ2/ujs9yNDE=;
        fh=6PGhJgpSH6gijKQN9PKRxrPAjfIxvpyE3Dtl5XjOQiM=;
        b=X54oWgb9qWonLlUXGUsMx9JOiCVJ799pBebNGBsvG/QkJTuHUgQ94sOY8yDkiUc4t4
         Unlc/L/rGDYMP9ZsyT7alGVVzGNcwiwVoN0ceDNPQDN2XFxWsF2SlT46CzxMZ8WNN7pe
         AWF1PRp3fR2IHSHATFV2J+HjD4huJOg4I+ketRa0ED8rOFU5TDK0tGt3CBkuwx6ewuHf
         dGQK67WZa4xiaQILAUwsKufU5UXjIJWnIYegJacB8ePfJJ2GDKNQwkgb7MncD8aB764u
         0jic/uXOH8j3N1G+LyA22h4igTMnALesXBVl7icg4HLUwNgeax2pEIWPWws+WCVwDtgU
         bclg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770655497; x=1771260297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmyTl6q+tqeF975POxGfJcIFC8oCHkJvZ2/ujs9yNDE=;
        b=To2cRWNE6e1wPUuwK+alUHmmPkgmsDFZNBNFUblIFSNZ+YQMKtWFDLiDHBDRqRr0sI
         ZlyOciUTc/AqGOZnglish7Ov6HHg6PtaO5pBWlxx9eHytl1gZWo5OPZ/U3WzLvYZN5qu
         ybHnZqGZoPO7sKU4+3Zj5HdlGKM1louIt/ZzOMFWh16/0YJYaLecSwHEBZHId+ksoAmA
         Udj8kSDFuuMCAijS4ulUMzM8hne+zhrWMjPEL4t44UdeMgwTAvLFgBNpNXb1mOiGLUj2
         uvFPL92zT6wBmWXE8GFNdhmVJ71bPNrPu4VTyY+CjksBdkBBJIITs/aCf1pE57gtTZv2
         bW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770655497; x=1771260297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tmyTl6q+tqeF975POxGfJcIFC8oCHkJvZ2/ujs9yNDE=;
        b=Y1VRo6KfkVFUP3Yt/SiAaT0shGsv9/ft14I4OgkCsUdl/sKxsPKS1m+wpvrm2br+gw
         o5ZU7rG/BDxGx4OFhSe22IL68pPylmMIjolAQxgW4aZDQzrtMH4JzhP8HF3NrE3VDHVz
         x0DieWaWgoMGSjvgRkfz3NFFsjVUewqXw8gVN7m3rLrzKfQ2X7NmZNu7tp+sxs0HLHXX
         QetNVklwGIcra7bet8KQHymW+MudIV6syU4iZiXyV0A/b6s8UMef0cvMse8ZjQ3RUNil
         gbK7Bg20x/mvb+mgTSXgOQ/p6yHRnWCmjEt/MJ8oxWiZLkbML+IbkP4tRce3oIQ9MvmK
         LczQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxXtaXehYXnuQPda+5H7R+FW1Bu9s23zzcnFmwVdluUouKbau5CBrgc5rgHHfKJiHAdeJnlcgTo8YKVuhltycU@vger.kernel.org
X-Gm-Message-State: AOJu0YzarsCnagjoTG9zuE7vm8ezuin/43Ryk2vSE63Dsh4BDvF6TFGd
	YkvkqUX+BaAIdHSLkfMaVGHELR5dy9WZm6KqxSRw+Ym7nBm/mZA+qabgA72EqOItLinzn0fvddH
	7rGjbk09XU7suYjtGkHXYGQxNKB/YXnv3nJaQj4JA
X-Gm-Gg: AZuq6aK7AKQkT90O1JCkAHqt6ril3AiI0x32RR827OzGd0O9msoXarfgT1MaKBLuzMG
	Du/SyOnkYQ7orKHb9mkKRilKP5Ts3NasyIyRnwA9RjpIoVpRk/YjLq9kh9zVmA9/XbWa8CPU5mM
	m/R3UjFeBLZxgM/oX/U2ZNw8JfOHe8W5VeQXEST8EkEMuc1jPdIt0Fe37EpxxZadIZWll8YG5oY
	W2W59x9TJ0IwvsQLSwPaJ7oecpk6dkvFuJwRwFyjI0696oqzUmYI5iP56yoz1SagBveZYo=
X-Received: by 2002:aa7:c617:0:b0:63e:447d:6aee with SMTP id
 4fb4d7f45d1cf-659a7265904mr60684a12.0.1770655497156; Mon, 09 Feb 2026
 08:44:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207012339.2646196-1-jmattson@google.com> <20260207012339.2646196-3-jmattson@google.com>
 <8e032a54-1444-46ce-8ddf-371ca74debc9@amd.com>
In-Reply-To: <8e032a54-1444-46ce-8ddf-371ca74debc9@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 9 Feb 2026 08:44:44 -0800
X-Gm-Features: AZwV_QjUWlKwn7roG1diwoLDEG8hWuwKopezzs7giHM4EoO_JkdZbGU4Y-mmfc0
Message-ID: <CALMp9eRpNxDz_AkeZ8GgfbLr1fnYRrKDUJY4SsZ97oJZGsGiuA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] KVM: x86/pmu: Disable Host-Only/Guest-Only events
 as appropriate for vCPU state
To: Sandipan Das <sandipan.das@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 8, 2026 at 11:46=E2=80=AFPM Sandipan Das <sandipan.das@amd.com>=
 wrote:
>
> On 2/7/2026 6:53 AM, Jim Mattson wrote:
> > Update amd_pmu_set_eventsel_hw() to clear the event selector's hardware
> > enable bit when the PMC should not count based on the guest's Host-Only=
 and
> > Guest-Only event selector bits and the current vCPU state.
> >
> > Signed-off-by: Jim Mattson <jmattson@google.com>
> > ---
> >  arch/x86/include/asm/perf_event.h |  2 ++
> >  arch/x86/kvm/svm/pmu.c            | 18 ++++++++++++++++++
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/p=
erf_event.h
> > index 0d9af4135e0a..4dfe12053c09 100644
> > --- a/arch/x86/include/asm/perf_event.h
> > +++ b/arch/x86/include/asm/perf_event.h
> > @@ -58,6 +58,8 @@
> >  #define AMD64_EVENTSEL_INT_CORE_ENABLE                       (1ULL << =
36)
> >  #define AMD64_EVENTSEL_GUESTONLY                     (1ULL << 40)
> >  #define AMD64_EVENTSEL_HOSTONLY                              (1ULL << =
41)
> > +#define AMD64_EVENTSEL_HOST_GUEST_MASK                       \
> > +     (AMD64_EVENTSEL_HOSTONLY | AMD64_EVENTSEL_GUESTONLY)
> >
> >  #define AMD64_EVENTSEL_INT_CORE_SEL_SHIFT            37
> >  #define AMD64_EVENTSEL_INT_CORE_SEL_MASK             \
> > diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
> > index d9ca633f9f49..8d451110a94d 100644
> > --- a/arch/x86/kvm/svm/pmu.c
> > +++ b/arch/x86/kvm/svm/pmu.c
> > @@ -149,8 +149,26 @@ static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, =
struct msr_data *msr_info)
> >
> >  static void amd_pmu_set_eventsel_hw(struct kvm_pmc *pmc)
> >  {
> > +     struct kvm_vcpu *vcpu =3D pmc->vcpu;
> > +     u64 host_guest_bits;
> > +
> >       pmc->eventsel_hw =3D (pmc->eventsel & ~AMD64_EVENTSEL_HOSTONLY) |
> >                          AMD64_EVENTSEL_GUESTONLY;
> > +
> > +     if (!(pmc->eventsel & ARCH_PERFMON_EVENTSEL_ENABLE))
> > +             return;
> > +
> > +     if (!(vcpu->arch.efer & EFER_SVME))
> > +             return;
> > +
> > +     host_guest_bits =3D pmc->eventsel & AMD64_EVENTSEL_HOST_GUEST_MAS=
K;
> > +     if (!host_guest_bits || host_guest_bits =3D=3D AMD64_EVENTSEL_HOS=
T_GUEST_MASK)
> > +             return;
> > +
> > +     if (!!(host_guest_bits & AMD64_EVENTSEL_GUESTONLY) =3D=3D is_gues=
t_mode(vcpu))
> > +             return;
>
> This seems to disable the PMCs after exits from an L2 guest to the L0 hyp=
ervisor.
> For such transitions, the corresponding L1 vCPU's PMC has GuestOnly set b=
ut
> is_guest_mode() is false as this function is called at the very end of
> leave_guest_mode() after vcpu->stat.guest_mode is set to 0.
>
> Is this a correct interpretation of the condition above?

I think you are confusing the VMCB02 bits (that always have Guest-Only
set) and the VMCB12 bits (which are under the control of L1.

If L1 sets only Guest-Only, that indicates a desire to monitor only L2
execution. So, yes, after emulating an exit from L2 to L1, the PMC is
disabled.

> > +
> > +     pmc->eventsel_hw &=3D ~ARCH_PERFMON_EVENTSEL_ENABLE;
> >  }
> >
> >  static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr=
_info)
>
