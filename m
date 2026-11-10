Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794337545;
	b=IgNwAG9ICZR1b3EsKWpnQFirkxWPc4h1qXTjF0uDWX6UfyWLfsNkccQiJNChyCxx3Si+
	 cTrA27d0kcfxDS5/Gds0rAquD6IEeCCtQ8ayX9SaiHe56Og56MEKa+EIxTdWl/Iy02yb3
	 eNyHUV9s0BOZT0g9lzt3QAfk59n4OK959YuueDkYIZD72UX6vwJTXnbuH3tSiOb1MfsH/
	 dJrzyZjd4erFct54uFiu3z+Pk6F+jQv6M/Of6jzj9nUoP3o7hBsQHhsmgZds/mARCrtVG
	 rN1fsI2p+v5avmpQh4Y6PmiRP2hw9FUpUkrGWBEPvBHkIvp6J28Sc2QGTROTjoTyGbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=anLt6qagkph9XR8vpxxzxpgqvxbcb9YqldFXaQ5KeM4=;
	b=TeBfI2EuBtlwG9x4uVxo5cyra1qZEAE/a6lgJ9HYm2cd7CMjDubvQrFoPepWiWI7y7Ad
	 zmvyacMBlxZfTquhutpd9fLaLSvG513exmofJLLVYSZdB4z72qTiW7/DXeQ54UxHRve82
	 AldEoNwSeoPR6a3uIQcf7rzp6pQCKhlCCG6AIjjYwEM93rPirdqmqnNdS9qcL/oMJcOpq
	 QewvXG60DLyM8n/5fmDc5wg6WCxtP6YzSKPW/RLlpSKZFAegOhBFEeMh+mosLMKyudHRe
	 OWcd23C1lExB66blPUYD65HABkbz5HXrdBpZjtIRH8xB3FDXaEBNGBIkcGVcLTzLK5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FoPrCu+l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D56606A325
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 19:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81D56606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FoPrCu+l
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso1609776f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 11:05:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794337544; cv=none;
        d=google.com; s=arc-20260327;
        b=M49yUKZDeF7g7U7+W4pwPqOs6D4VixhTvsWoR+TQosZrJ4JVwfyK2mfIEFUrDY+X05
         1v6oO1ld3hNV9cLhafvVHgNk+2AEtzmud17nmf3Q8ZUrVa4G3g8F9rV8IXVHOWiDMeol
         j5DCa0LgTRKhZ/6tNmiW/V72CJ3NCaKH7fGvujJwG/YkdSMkNWVYMxwQrnwIw920gfQK
         WpqSHFf7qMSJ2OqdoXOXyj3XRlULZEtDr+hdgE+6mALv8QSGNbS1JSwouKmWN1N/rKOM
         c4P0c4o5u9xaoaC1K4+AX9lt8CmKHp7tUw/P94hmwP1oBmwA3AOy38byuqovs5A53r4K
         Im5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=anLt6qagkph9XR8vpxxzxpgqvxbcb9YqldFXaQ5KeM4=;
        fh=SSO0xAKWEhe3FHbR3ulaMwz82EbatlIhb+cFEyXoUj0=;
        b=haQfp9aoQXtn6Qi1BFuFP75n7Ntim3l6YvbqwFAfE8lJR8w12UPqVznRU6bzNOZZdy
         0QVVgvma1qLiFIYDKWBPd25u9MXKIWj9lWUqZIte/dkI3uFJVnOrSvSXVnTEO02cPkWJ
         OzRVkrDBlcGrCOo6fX8qgF4y3DIQ1fh0kQ58NpCMTIHGsYaliq60b9YZW3wlUZHdimg3
         HH7ZJsXS8wOQ84miv0yQcTLK0MBeq7kfsxhA1HK3r2e6Wci5BWo2LjD5+L9DyGFMouuN
         eBehJF8O6dpf4rmLGVJNc2ExM0L7B9sw30At7GT94DEsrlJfyxQkKhfFiZ3h5PeCbjD8
         WtJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794337544; x=1794942344; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=anLt6qagkph9XR8vpxxzxpgqvxbcb9YqldFXaQ5KeM4=;
        b=FoPrCu+lgpPuMNG6t2WePToTWn1vV7OxoFB6yJCn3SW7ujyeMQPqPvI5MetASfN5t8
         aUVbujBjF9Hu1W2txzDolkMjz7o5JuekJ+JYD6KltD2HSGGWuWjec5FKHzJECE5iijKs
         JI6A04eOhY4OKbTYEL8+glLIl6Wb5A9dzm+fon3n+0CuHNLYzwXIhbmiEqiRC6Mp8/+V
         JpPCzsy5l9FUNFQ60oaTNlGLNEy3OLbzoGtCl6hkq3QjMJnGOOS7R4j0oJupsYPSOdyD
         CDayuFkXsON+vcFU66VzWecaTHRts1Z/5Z/A31nYSbEnYpS7yQe1PYhhXHCqwukBt0h+
         YbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794337544; x=1794942344;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=anLt6qagkph9XR8vpxxzxpgqvxbcb9YqldFXaQ5KeM4=;
        b=AjyOyEyN2Q7NNjJs4fhJF+DvrX+z2z6LqQblnxRFhqqZzXOSOl3I6zdIXvOjoLIIZF
         YwACeGmAcyDlpY6pgLK+ec5AXQ9gj3XhkxJe/R9+QVFWy6bZ5cReBqELx4uVU1yju0pf
         dlQ7yq0MJ62ABW3KqnHDlzD70igwEynNQfU4yYxOQAqNe/whJVccF3aUunL6xFIiiUxM
         DyyfqKQx4FdGzpAVDfvMSW3aWALWoLz3ZpbdtUiU1a7DQR2z0uWF/qfNQF43xj0KU+m9
         pWLdqreGHIqQ2r19/Q6O0bUq6IYzU/fR5dSxMb8QLFjUzqX+GopBHEWL4/l7glOyRkkP
         /DPA==
X-Forwarded-Encrypted: i=1; AL+hErGNaVVwx4JmBhkdW4/BZ4cp4xiatQrI78uMDEMligG7FTRE7KezMBAjZl3Hg6BmvYBCeGGHJjTohZODKNbxW3Rc@vger.kernel.org
X-Gm-Message-State: APuU4Z805aMJhyzi454GzITn5eF4CNsBt2wQNZ9eKKy0yiFtAS3KdAYy
	2akwHVWWPJcMAdZYk3RAPGqg38fkuPBy5elAbTYRCx2XI/Cs2UvEwb0Lm4PY1GkoJ3ndh1/cC9h
	xPWxxRb/csypeL67bIkosK7y6RhJbp7w=
X-Gm-Gg: AYBFou1KkJ0AHaapgYGTBAGSnQDcYU/RT+hqiFqFgBHRLjDsxz7YiCem7DjO5QCD34k
	GjCils1CSvJ8z1B2RQY6EJ5yLCClPWV2/AQPzZnDeXEHwoXkg5dNsE5EoLwgCtxFC8P8FQ/fKAH
	4joGIOWwrwC+/t8ABwFuj6gi3RbJaABp+E5nhfibc3bdZRJ1hKBoRg9+Feo0+ovtNlRAwDUfxi6
	mhjdljGd32C9T7Xi6Zzp3aoSt+QzeLqkBgMFJDIKLC5Y4quACg3VHfH3TQ2mnU7MkB3EZewx6dK
	Vfd6hjCpXlIIKclokncc675gYPe5va8n7qgOMBfXI9zoHc7QRfxn8cPyx2cjpcjl4zAzcnXPlBW
	2yaDTCZLsydFsftnSSZO2IwaYUZ7eXPhK7QU/AQlyseF1hNIxn+fyeMzYXOFAHEB4bOyTl8Lq1o
	ytfSXy3TVMAgt1+TAzZ9LGmhn5b0L0An61Sw==
X-Received: by 2002:a05:6000:1610:b0:498:364d:7509 with SMTP id
 ffacd0b85a97d-49997c6c18bmr523568f8f.24.1794337543600; Tue, 10 Nov 2026
 11:05:43 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <b7456dbb-16fd-45b4-8742-e9ea3f896317@amd.com> <20261105170340.165507-1-puranjay@kernel.org>
 <CAEf4BzZeVd4boXX4Hy1sKAM=dUPS7dvdmrOPybGrrZV+bU7eAA@mail.gmail.com>
In-Reply-To: <CAEf4BzZeVd4boXX4Hy1sKAM=dUPS7dvdmrOPybGrrZV+bU7eAA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 10 Nov 2026 11:05:32 -0800
X-Gm-Features: AclHuK8p9eKzrAmIvCtxKy6s76DJ6bc52Qt62Y2l4XXBjiRTKRk1Vg0I6Sg8r78
Message-ID: <CAEf4BzaGnsOhpz=bOxoSEyy-8W0epd5Go6juimoqDge+Rc-+Dw@mail.gmail.com>
Subject: Re: [PATCH RFC] perf/x86/amd/lbr: Don't freeze the LBR on PMI for
 user-only filters
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 5:07=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 5, 2026 at 9:03=E2=80=AFAM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
> >
> > On CPUs with X86_FEATURE_AMD_LBR_PMC_FREEZE the LBR is always frozen on
> > PMI, so the branch stack ends before the IP and callchain, which are
> > taken when the NMI is delivered. IBS rejects branch-stack events, so
> > there is no precise alternative.
> >
> > The freeze only keeps the PMI handler's branches out of the stack, whic=
h
> > matters only if branches into the kernel are recorded. Skip it when
> > LBR_SELECT suppresses them, and add a freeze format bit (config2:0) to
> > request it anyway.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> > Thanks both. A user-only default with an explicit request works for me,
> > with one exception I would like to keep: when branches into the kernel
> > are recorded the freeze has to stay. On a Zen 5 part with the freeze
> > cleared and a user+kernel filter, every entry in every sample was a
> > branch taken by amd_pmu_v2_handle_irq() or amd_pmu_lbr_read(), so users
> > recording kernel branches would regress with a "never freeze" default.
> >
> > This RFC does the following:
> >  - LBR_SELECT suppresses kernel branches: no freeze, unless the new
> >    AMD-only freeze format bit (config2:0, advertised through the format
> >    attributes) is set.
> >  - Otherwise: freeze as today.
> >
> > That needs no tool changes for the user-only case and gives an explicit
> > way to request the freeze. This version is only compile tested; I will
> > retest on a Zen 5 part if the approach is acceptable.
> >
> >  arch/x86/events/amd/core.c | 14 ++++++++++++++
> >  arch/x86/events/amd/lbr.c  | 21 ++++++++++++++++++---
> >  2 files changed, 32 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> > index 49b6b8fce5664..d63649c756a58 100644
> > --- a/arch/x86/events/amd/core.c
> > +++ b/arch/x86/events/amd/core.c
> > @@ -1404,8 +1404,22 @@ static struct attribute_group group_events_amd_b=
rs =3D {
> >
> >  #endif /* CONFIG_PERF_EVENTS_AMD_BRS */
> >
> > +PMU_FORMAT_ATTR(freeze, "config2:0");
> > +
> > +static struct attribute *amd_pmu_lbr_format_attrs[] =3D {
> > +       &format_attr_freeze.attr,
> > +       NULL,
> > +};
> > +
> > +static struct attribute_group group_format_amd_lbr =3D {
> > +       .name       =3D "format",
> > +       .attrs      =3D amd_pmu_lbr_format_attrs,
> > +       .is_visible =3D amd_branches_is_visible,
> > +};
> > +
> >  static const struct attribute_group *amd_attr_update[] =3D {
> >         &group_caps_amd_branches,
> > +       &group_format_amd_lbr,
> >  #ifdef CONFIG_PERF_EVENTS_AMD_BRS
> >         &group_events_amd_brs,
> >  #endif
> > diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> > index a55646fcb8465..f45e2c53566af 100644
> > --- a/arch/x86/events/amd/lbr.c
> > +++ b/arch/x86/events/amd/lbr.c
> > @@ -10,6 +10,12 @@
> >  /* LBR Branch Select valid bits */
> >  #define LBR_SELECT_MASK                0x1ff
> >
> > +/* attr.config2: freeze the LBR on PMI */
> > +#define LBR_CFG2_FREEZE                BIT_ULL(0)
> > +
> > +/* Software only, masked out before writing LBR_SELECT */
> > +#define LBR_FREEZE             BIT_ULL(63)
> > +
> >  /*
> >   * LBR Branch Select filter bits which when set, ensures that the
> >   * corresponding type of branches are not recorded
> > @@ -307,6 +313,9 @@ static int amd_pmu_lbr_setup_filter(struct perf_eve=
nt *event)
> >         /* Filter bits operate in suppress mode */
> >         reg->config =3D mask ^ LBR_SELECT_MASK;
> >
> > +       if (event->attr.config2 & LBR_CFG2_FREEZE)
> > +               reg->config |=3D LBR_FREEZE;
> > +
> >         return 0;
> >  }
> >
> > @@ -392,20 +401,26 @@ void amd_pmu_lbr_sched_task(struct perf_event_pmu=
_context *pmu_ctx,
> >  void amd_pmu_lbr_enable_all(void)
> >  {
> >         struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> > -       u64 lbr_select, dbg_ctl, dbg_extn_cfg;
> > +       u64 lbr_cfg =3D 0, lbr_select =3D 0, dbg_ctl, dbg_extn_cfg;
> >
> >         if (!cpuc->lbr_users || !x86_pmu.lbr_nr)
> >                 return;
> >
> >         /* Set hardware branch filter */
> >         if (cpuc->lbr_select) {
> > -               lbr_select =3D cpuc->lbr_sel->config & LBR_SELECT_MASK;
> > +               lbr_cfg =3D cpuc->lbr_sel->config;
> > +               lbr_select =3D lbr_cfg & LBR_SELECT_MASK;
> >                 wrmsrq(MSR_AMD64_LBR_SELECT, lbr_select);
> >         }
> >
> >         if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
> >                 rdmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> > -               wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREE=
ZE_LBRS_ON_PMI);
> > +               /* Skip the freeze if kernel branches are suppressed, u=
nless asked */
> > +               if ((lbr_select & LBR_KERNEL) && !(lbr_cfg & LBR_FREEZE=
))
>
> heh, so we basically either
>
> a) opt-in freeze with *new config*, but do it *only for non-kernel LBR*
>
> or
>
> b) opt-out freeze *only for non-kernel LBR* _unconditionally_, but
> without adding any new config
>
> In both cases we have a behavior that makes sense in practice, but a)
> adds some new config, while b) doesn't add anything. End result is the
> same, just more configuration and need to change user space code to
> opt-out the freeze.
>
> Is a) worth it, or we should stick to b) and keep it simple, Sandipan?

ping

>
> > +                       dbg_ctl &=3D ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
> > +               else
> > +                       dbg_ctl |=3D DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
> > +               wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
> >         }
> >
> >         rdmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
> >
> > base-commit: 0f443787a7f6ae907975742680aac2600483eaf1
> > --
> > 2.53.0-Meta
> >
