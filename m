Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867253890E0
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Mar 2026 05:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773291883; cv=pass; b=fHhOdSv1rYtnCtEPza2HEBGDOgMDt1HRZQ/eMm/s2dHMfnlTWjBDW3N9AgvbWNTaO/RYQJP+wz/Suk8dxALgQ5TTBS2bV4uoiEMFmED2/bOu/oLxFgNugUxCdSYoLLwd87bIZMAH28irrjUQXrzdkNl6epwYecy47J1yJqdjVfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773291883; c=relaxed/simple;
	bh=ai305NJN5dcAZaQFWsfNqYIs9l2jX071JSgJ3DRld40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfwrR9OGsetno10wGWw9oj80Q/Gon4amxmJvQm42+trkKpmVyZZ4S/e6aoQB/J4y3KfCFd1xapepv2BCi6Vv2lyic0b98byk+4EHrGSzBf1OPNU+l0niS4Wbt1r/Wmi260GymR4AHmATdMaLa3bnRSGXzg7fq8J0A1UIBYXqKiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AiQfA+PR; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AiQfA+PR"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae3f822163so55565ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 22:04:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773291882; cv=none;
        d=google.com; s=arc-20240605;
        b=Mr46Jxkx+JHzDgNu+pF5xX2oVOA1n6IZ/omf/g9IAEo/6sXxpir7NT2fihXIonWCbd
         Wfr2NBDXbUhSMcRbTqxRXXktrg39dXudOvEJt2JImmkZZSevgAuLP+pmp57lvXka3P29
         l8Uv8g1nshFvG20qTOn7j1Ni7UmOLzWvCytGDxnQ1kfCqzlf+Ovd61zGCrQOmmUqBoRr
         ozHxeI7aqWZlGFG5x32btLp/v2798jdNzrRcEh/bALoxQNIX5hEHTsiWnW3IJ7zYAK5X
         6Eh1PlAOsjunPDalA9M5hlCFr/olydCz4UJrVOVharAXdQw4Z82vPfhHWlewU4XZaXVb
         GcyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S9lL2IKLfBTYPLSJBsiwTba5097dYU3HyH5MoEtBnOU=;
        fh=me01RwMEZYGgdmjEMplT6QeFKkLrLurW+Kizy4pK2uw=;
        b=BsglHcTjcsdAQ+dX1fZlN9j/y3vVnSPwunsloF98dYC60QJxK2ixz7RR8THZ6L4XfH
         i+3hrsPYMCJVxX83DwjF+zcADCM+HnLz8mnuuwUOv6LLFQGpUvOMn/PoaWYg+Z1r5s2z
         EOH/FcMm08v/hPAo9QpUOAbpjmko97HnUeSSC6gtMNXcf/J4tbOQxNyqi0VPxtXKpeSq
         LnGhxZPaStNR3S1Jv24X00TPeDqqNH9/tTLLhXOSee5/GXhJnegQmQipuRCq7Hf2QUZs
         RZHxGwsU1HNtkcNe5Ht3vzdtza/EHNtiuoDH1wjafJkNN5eZeVsyT6BrF0l8ekHUk13L
         /DmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773291882; x=1773896682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9lL2IKLfBTYPLSJBsiwTba5097dYU3HyH5MoEtBnOU=;
        b=AiQfA+PRYF04qpdWK+MdKvMnZ2oRGbwYkFbItQEiwsyXaKcte3aqy/TOyl0gzHOtKx
         BfBb9ZuJ7+6wOY6ZuMffYxDxopAfaOqcgP4lkQ4vA+dS+tUHLtb/44fvpeEUlstTn285
         cDV0go+Z5dAX/YnjmjhvRaDwMfeTtNmWzNFcoKMXIKKqhDXmmFfIDPvzSw3DI6tQs4r0
         dRypw5pOofUgcqCr6RcoKtArO1NpNmaku8cgiNHyGOsAWJf6Y4ltD7h2i28y7MaZyp5/
         /MZ5Tq1i3LTADtRlZ37Z+y6xcgTKTGH4Usd3J792Gvh0YhclyBDAy7pNfljk0aEziLgk
         6TEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773291882; x=1773896682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S9lL2IKLfBTYPLSJBsiwTba5097dYU3HyH5MoEtBnOU=;
        b=uzgMWfdKKkL9czYYVfPnsM5zLm5K9HltkMIHnyCaO0kgkgBhTAq6iqAJ3k+Lq906yI
         6YMWucMWCeVUZ6sBME3pG2ay7SeJiqMxW9pN76eaC5F4fPRQx7RlW/NabR4zWjc+/GH1
         3lW04T0JXsN0YHDETs/YT994LdnXEVFD72VhEqtKT0VCuwCL/Mta6f48xLMRuxAt9+n5
         Xbf2St7jvnmqfCk0xVLmFcf0W1Z3whX42hLAwG7lQC6J32eyVtHCelGeoFWUz5eo0++W
         gXpdmWALvLSUKKzGK8aLwxOAoBVvAL1cASOB4/1oNQLUCboEh64t8B8IItIk+xINRvIH
         Ckjw==
X-Forwarded-Encrypted: i=1; AJvYcCVTKPTVNABLzZA2da5419lrXvuOIv6CmdHg3dtLdJykhaNXpBuULx992omv1qb0V6SW/ObDP6wkuFVqiNdksHZN@vger.kernel.org
X-Gm-Message-State: AOJu0YxMXM6z9d9hKeM8zqik8bSc9xROcsPEEGmwR28YYkeFCARobAr+
	nuxaangKBB/vD5X/Qacg5RLqUlzZyxmTcwo22C5ij/okByC3tteTOrRqb74/so6EvWHdVgBcWJz
	bxgUpGdBMZBISdmIWo0xerSzohDbbBtiwJd7kuC3X
X-Gm-Gg: ATEYQzx2DwviM+dDwVCJ7WD7UZbQB4P8AbuQvNjlBRgOQgGXDtXngJz1a6stlhaFe1v
	WK7GRTkrTiQaC2WRzgONK/8EC0ZeeYSLVAeQDH5r5EA1cq5Qp+YXyO+ROewT9Xf6pPJWLzeUPsB
	V69UpThlQwZ4txWKKc1ypBOSZ/nYPN+TsGtONDnjcFOS9ToCKyb6rYcFkvQfOPNGytvcOYc+sgY
	IHNjL532rmMTG+pVs24SzZVYXx00l9sfmiX688HvuB5ZRwSAV7boZkapVA2vUlp7Qd2eF26iGAt
	w8JUYWdQ
X-Received: by 2002:a17:903:2c04:b0:2ae:7eda:7510 with SMTP id
 d9443c01a7336-2aebd1f6039mr1505775ad.25.1773291881170; Wed, 11 Mar 2026
 22:04:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311075201.2951073-1-dapeng1.mi@linux.intel.com>
 <20260311075201.2951073-2-dapeng1.mi@linux.intel.com> <CAP-5=fWr2L6miiFZ6Km3HYEdmqp3T0NBL=WY3buKdKztW+HvmA@mail.gmail.com>
In-Reply-To: <CAP-5=fWr2L6miiFZ6Km3HYEdmqp3T0NBL=WY3buKdKztW+HvmA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Mar 2026 22:04:29 -0700
X-Gm-Features: AaiRm514Wsgzy-23PvCvVJ3EmpXQI5rRWEuWtWZDtmLsvuzO5fvAiEwjo0c2OZ4
Message-ID: <CAP-5=fUBy-vzdSB3xsuyU+AKd8o99R7DLgoyyJHxb6Shkfb-8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf/x86: Update cap_user_rdpmc base on rdpmc user
 disable state
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>, 
	Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 9:44=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Mar 11, 2026 at 12:56=E2=80=AFAM Dapeng Mi <dapeng1.mi@linux.inte=
l.com> wrote:
> >
> > After introducing the RDPMC user disable feature, user-space RDPMC may
> > return 0 instead of the actual event count. This creates an inconsisten=
cy
> > with cap_user_rdpmc, where cap_user_rdpmc is set, but user-space RDPMC
> > only returns 0.
> >
> > To accurately represent the user-space RDPMC capability, update
> > cap_user_rdpmc based on the RDPMC user disable state. If RDPMC user
> > disable is enabled, cap_user_rdpmc is set to false, allowing user-space
> > programs to fall back to the read() syscall to obtain the real event
> > count.
> >
> > Fixes: 59af95e028d4 ("perf/x86/intel: Add support for rdpmc user disabl=
e feature")
> > Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > ---
> >  arch/x86/events/core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 03ce1bc7ef2e..0266a11d7ec9 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -2807,6 +2807,9 @@ void arch_perf_update_userpage(struct perf_event =
*event,
> >         userpg->cap_user_time_zero =3D 0;
> >         userpg->cap_user_rdpmc =3D
> >                 !!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
> > +       if (x86_pmu_has_rdpmc_user_disable(event->pmu) &&
>
> With the AI's help the following bug was spotted:
>
> Places like cpu_clock_event_add call perf_event_update_userpage with a
> software event:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/k=
ernel/events/core.c#n12314
> This then calls arch_perf_update_userpage:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/k=
ernel/events/core.c#n6870
> In x86_pmu_has_rdpmc_user_disable:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/x86/events/perf_event.h#n1336
> ```
> static inline bool x86_pmu_has_rdpmc_user_disable(struct pmu *pmu)
> {
> return !!(hybrid(pmu, config_mask) &
> ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE);
> }
> ```
> The hybrid call does a call to hybrid_pmu:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/x86/events/perf_event.h#n793
> and that does a container_of:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/x86/events/perf_event.h#n782
> ```
> static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
> {
> return container_of(pmu, struct x86_hybrid_pmu, pmu);
> }
> ```
> In the case that the event's pmu is a software PMU the container_of
> should be invalid and this will lead to an out-of-bounds read of the
> config_mask on hybrid systems.
>
> Unfortunately checking the event is x86 doesn't cover the hybrid case:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/x86/events/core.c#n780
> and it seems this bug may exist elsewhere. It'd be nice if in the
> hybrid_pmu function there were a `BUG_ON(!is_x86_pmu(pmu))`, but
> unfortunately that'd only get exposed on hybrid systems.

Actually  is_x86_event does work for hybrid, so making this:
```
if (is_x86_event(event) && x86_pmu_has_rdpmc_user_disable(event->pmu) && ..=
.
```
Should fix the issue.

Thanks,
Ian

> Thanks,
> Ian
>
> > +           event->hw.config & ARCH_PERFMON_EVENTSEL_RDPMC_USER_DISABLE=
)
> > +               userpg->cap_user_rdpmc =3D 0;
> >         userpg->pmc_width =3D x86_pmu.cntval_bits;
> >
> >         if (!using_native_sched_clock() || !sched_clock_stable())
> > --
> > 2.34.1
> >
