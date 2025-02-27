Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A315A54738
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 01:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740618318; cv=none; b=RFMaQUphq1EoeApkvjP56UI5rRlbmI5uaaLK3n2aQpBcSUvJOnj8vIDk1l96Y4Cyhh69Eh52g4RVl3x1a4espibm7uPXGsE/jw5BbpFMcFPnBdRC1q1SL9LDv5muvZyfMJjpjzcZTj8L+mXWulIVa8N5OD8UWmkNveAso71UyXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740618318; c=relaxed/simple;
	bh=GRHohmURlG1J0vCfqtMiE4OfWdA8l+xtBbsvFxNKx/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5DQud6rwQyQlRzctf4k9lUCxpadMjOVdPZPZqGRE1dkzHpedCBe9FQ43oZeCVRpXWSe0XJEligHGfoyaI3ujmoSgaCtpUv26HN/sBcz0xBMD0sMi71QXNNhefrL5Q191lq91APRKfeoRwAxTGGPf1Vxk3dPWprqfhbUT5p/vnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=lnHLPhFi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="lnHLPhFi"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22113560c57so6378605ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 17:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740618316; x=1741223116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPhlc9bmrf/baBUYMBCbtsRt7KZ0PJ5cb4Ib6su88Rg=;
        b=lnHLPhFijyHRvkkOPm3MymgpuIllImcuvfCfhJpXO1Ak62eQz8A6fpJH7TDbWW5Y2h
         5Cij8YrgzM9d/gNHPHgeL2764ukOrs9CmM+iqF7Fh6YUCCIm2uBnJrQ8hOa9BFG0ZViF
         dqtlACZguZ2TA1xXiP4XqYLko5NNURfGYDXj9Srj37jnZEM4PsBqNOgCxp75SlzLha6Y
         gBF5RHWp+r0W8KW/kvfcPysWDdRX0yRSmQ5w/WXLOI3n8VWP5+3rSYXP1KT1+r19kmry
         RSgQqMjgheLe8oFoqEsRoJp3NbMAy5tnKJw8GkC3Vmhvgqer1/VRRS2viIcxzXvdImFH
         dTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740618316; x=1741223116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPhlc9bmrf/baBUYMBCbtsRt7KZ0PJ5cb4Ib6su88Rg=;
        b=Mi0Hrs4/lMr2VQanzDM/npfv5Qt/esv6Asq92wCMkkfuc4gRZXQMU8kcHswBYvQZ1L
         27u2o5wuvn5/wILg8SRIWtsqJPlx8rIt3OazIza0Byu3a4XlIRxgLlYXMzeGsy8MXD0+
         xtdBt8gV4qOW1mCTiswr7aoRm6x0AzEH8yJQhfCOwAuSLE27SuPLxWsuHl8FNu2F6boq
         48naTyjeZwC8RJC6h33GKnX9GTZEhxV8O2/285HW9OSyGJqfdw1A4a5H7kSbyEtNzhhg
         D1MTKYJZJXHrtjYD+UMtU1HoMv2a9ZWP2WNo46XFyEpnapKSKN1M8EBFrlZuBTQKnQRh
         OARA==
X-Forwarded-Encrypted: i=1; AJvYcCV9ZBl/Am+5gGR1JHoKaL+GufiVfq4yFdX0VzNALCOaNI6v51lIs9/UWIQkOwYKddpZSN6eYEkJ4yvY5v0fc6qW@vger.kernel.org
X-Gm-Message-State: AOJu0YywssZ+8moaQ5GrdAURKFCnVKIuylur50uT8wycn++mRyY+B4FZ
	dZWAtt9KcrLAWl+oktjk23tVedOA04numIplC/aEYn+1RuHqiEKKUdB1D1OmqQK19Y3UP6QgnGN
	ZoqvSKQcJoEuOLVsGTy+kPuhZ2/G5bTSRd0zpHg==
X-Gm-Gg: ASbGncvUMR9rSEA2xPFX6G0V70Bn3ke0QqlBpo6UpgzXgkDn7vc4IiYPz7zsMOcY6HM
	jqsdDp7etRoR3xiET4kJ7lQvsjo0JuAivUl8oz9pMRlpgpB+Az3Ebi6nroz8kYcu75ZhIrkPRMT
	UirbWMFA==
X-Google-Smtp-Source: AGHT+IEmzNz0icfWLpez1BUsW/bodw4yxi3kEJGu2T9c7GZ0fGiTA+k8NPv9fX34ISAbJbxPgbyIN7vFEs0p7/UvZxk=
X-Received: by 2002:a05:6a00:2445:b0:731:e974:f9c2 with SMTP id
 d2e1a72fcca58-73426af3a2dmr33707676b3a.0.1740618315744; Wed, 26 Feb 2025
 17:05:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205-counter_delegation-v4-0-835cfa88e3b1@rivosinc.com>
 <20250205-counter_delegation-v4-12-835cfa88e3b1@rivosinc.com> <586dc43d-74cd-413b-86e2-545384ad796f@rivosinc.com>
In-Reply-To: <586dc43d-74cd-413b-86e2-545384ad796f@rivosinc.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Wed, 26 Feb 2025 17:05:02 -0800
X-Gm-Features: AQ5f1Jpcwi9qlqm9BYyz76VdGTMqDksYTZy-kqauaAcNToAAh7JyG1DiMAREibo
Message-ID: <CAHBxVyGAtZV8mJdcLtSHKHCrtrx3ygUG16onhpPRUUPk6_WJuA@mail.gmail.com>
Subject: Re: [PATCH v4 12/21] RISC-V: perf: Modify the counter discovery mechanism
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, weilin.wang@intel.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 2:29=E2=80=AFAM Cl=C3=A9ment L=C3=A9ger <cleger@rivo=
sinc.com> wrote:
>
>
>
> On 06/02/2025 08:23, Atish Patra wrote:
> > If both counter delegation and SBI PMU is present, the counter
> > delegation will be used for hardware pmu counters while the SBI PMU
> > will be used for firmware counters. Thus, the driver has to probe
> > the counters info via SBI PMU to distinguish the firmware counters.
> >
> > The hybrid scheme also requires improvements of the informational
> > logging messages to indicate the user about underlying interface
> > used for each use case.
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >  drivers/perf/riscv_pmu_dev.c | 118 ++++++++++++++++++++++++++++++++---=
--------
> >  1 file changed, 88 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/perf/riscv_pmu_dev.c b/drivers/perf/riscv_pmu_dev.=
c
> > index 6b43d844eaea..5ddf4924c5b3 100644
> > --- a/drivers/perf/riscv_pmu_dev.c
> > +++ b/drivers/perf/riscv_pmu_dev.c
> > @@ -66,6 +66,10 @@ static bool sbi_v2_available;
> >  static DEFINE_STATIC_KEY_FALSE(sbi_pmu_snapshot_available);
> >  #define sbi_pmu_snapshot_available() \
> >       static_branch_unlikely(&sbi_pmu_snapshot_available)
> > +static DEFINE_STATIC_KEY_FALSE(riscv_pmu_sbi_available);
> > +static DEFINE_STATIC_KEY_FALSE(riscv_pmu_cdeleg_available);
> > +static bool cdeleg_available;
> > +static bool sbi_available;
> >
> >  static struct attribute *riscv_arch_formats_attr[] =3D {
> >       &format_attr_event.attr,
> > @@ -88,7 +92,8 @@ static int sysctl_perf_user_access __read_mostly =3D =
SYSCTL_USER_ACCESS;
> >
> >  /*
> >   * This structure is SBI specific but counter delegation also require =
counter
> > - * width, csr mapping. Reuse it for now.
> > + * width, csr mapping. Reuse it for now we can have firmware counters =
for
> > + * platfroms with counter delegation support.
> >   * RISC-V doesn't have heterogeneous harts yet. This need to be part o=
f
> >   * per_cpu in case of harts with different pmu counters
> >   */
> > @@ -100,6 +105,8 @@ static unsigned int riscv_pmu_irq;
> >
> >  /* Cache the available counters in a bitmask */
> >  static unsigned long cmask;
> > +/* Cache the available firmware counters in another bitmask */
> > +static unsigned long firmware_cmask;
> >
> >  struct sbi_pmu_event_data {
> >       union {
> > @@ -778,35 +785,49 @@ static int rvpmu_sbi_find_num_ctrs(void)
> >               return sbi_err_map_linux_errno(ret.error);
> >  }
> >
> > -static int rvpmu_sbi_get_ctrinfo(int nctr, unsigned long *mask)
> > +static int rvpmu_deleg_find_ctrs(void)
> > +{
> > +     /* TODO */
> > +     return -1;
> > +}
> > +
> > +static int rvpmu_sbi_get_ctrinfo(int nsbi_ctr, int ndeleg_ctr)
>
> Hi Atish,
>
> These parameters could be unsigned I think.
>

sure. Changed it to u32.

> >  {
> >       struct sbiret ret;
> > -     int i, num_hw_ctr =3D 0, num_fw_ctr =3D 0;
> > +     int i, num_hw_ctr =3D 0, num_fw_ctr =3D 0, num_ctr =3D 0;
> >       union sbi_pmu_ctr_info cinfo;
> >
> > -     pmu_ctr_list =3D kcalloc(nctr, sizeof(*pmu_ctr_list), GFP_KERNEL)=
;
> > -     if (!pmu_ctr_list)
> > -             return -ENOMEM;
> > -
> > -     for (i =3D 0; i < nctr; i++) {
> > +     for (i =3D 0; i < nsbi_ctr; i++) {
> >               ret =3D sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_IN=
FO, i, 0, 0, 0, 0, 0);
> >               if (ret.error)
> >                       /* The logical counter ids are not expected to be=
 contiguous */
> >                       continue;
> >
> > -             *mask |=3D BIT(i);
> > -
> >               cinfo.value =3D ret.value;
> >               if (cinfo.type =3D=3D SBI_PMU_CTR_TYPE_FW)
> >                       num_fw_ctr++;
> > -             else
> > +
> > +             if (!cdeleg_available) {
>
> What is the rationale for using additional boolean identical to the
> static keys ? Reducing the amount of code patch site in cold path ? If

yes.

> so, I guess you can use static_key_enabled(&riscv_pmu_cdeleg_available).
> But your solution is fine as well, it just duplicates two identical value=
s.
>

good point. I will change it. Thanks!

> >                       num_hw_ctr++;
> > -             pmu_ctr_list[i].value =3D cinfo.value;
> > +                     cmask |=3D BIT(i);
> > +                     pmu_ctr_list[i].value =3D cinfo.value;
> > +             } else if (cinfo.type =3D=3D SBI_PMU_CTR_TYPE_FW) {
> > +                     /* Track firmware counters in a different mask */
> > +                     firmware_cmask |=3D BIT(i);
> > +                     pmu_ctr_list[i].value =3D cinfo.value;
> > +             }
> > +
> >       }
> >
> > -     pr_info("%d firmware and %d hardware counters\n", num_fw_ctr, num=
_hw_ctr);
> > +     if (cdeleg_available) {
> > +             pr_info("%d firmware and %d hardware counters\n", num_fw_=
ctr, ndeleg_ctr);
> > +             num_ctr =3D num_fw_ctr + ndeleg_ctr;
> > +     } else {
> > +             pr_info("%d firmware and %d hardware counters\n", num_fw_=
ctr, num_hw_ctr);
> > +             num_ctr =3D nsbi_ctr;
> > +     }
> >
> > -     return 0;
> > +     return num_ctr;
> >  }
> >
> >  static inline void rvpmu_sbi_stop_all(struct riscv_pmu *pmu)
> > @@ -1067,16 +1088,33 @@ static void rvpmu_ctr_stop(struct perf_event *e=
vent, unsigned long flag)
> >       /* TODO: Counter delegation implementation */
> >  }
> >
> > -static int rvpmu_find_num_ctrs(void)
> > +static int rvpmu_find_ctrs(void)
> >  {
> > -     return rvpmu_sbi_find_num_ctrs();
> > -     /* TODO: Counter delegation implementation */
> > -}
> > +     int num_sbi_counters =3D 0, num_deleg_counters =3D 0, num_counter=
s =3D 0;
> >
> > -static int rvpmu_get_ctrinfo(int nctr, unsigned long *mask)
> > -{
> > -     return rvpmu_sbi_get_ctrinfo(nctr, mask);
> > -     /* TODO: Counter delegation implementation */
> > +     /*
> > +      * We don't know how many firmware counters available. Just alloc=
ate
> > +      * for maximum counters driver can support. The default is 64 any=
ways.
> > +      */
> > +     pmu_ctr_list =3D kcalloc(RISCV_MAX_COUNTERS, sizeof(*pmu_ctr_list=
),
> > +                            GFP_KERNEL);
> > +     if (!pmu_ctr_list)
> > +             return -ENOMEM;
> > +
> > +     if (cdeleg_available)
> > +             num_deleg_counters =3D rvpmu_deleg_find_ctrs();
> > +
> > +     /* This is required for firmware counters even if the above is tr=
ue */
> > +     if (sbi_available)
> > +             num_sbi_counters =3D rvpmu_sbi_find_num_ctrs();
> > +
> > +     if (num_sbi_counters >=3D RISCV_MAX_COUNTERS || num_deleg_counter=
s >=3D RISCV_MAX_COUNTERS)
> > +             return -ENOSPC;
>
> Why is this using '>=3D' ? You allocated space for RISCV_MAX_COUNTERS, so
> RISCV_MAX_COUNTERS should fit right ?
>
Yeah. That's a typo. Thanks for catching it.

> > +
> > +     /* cache all the information about counters now */
> > +     num_counters =3D rvpmu_sbi_get_ctrinfo(num_sbi_counters, num_dele=
g_counters);
> > +
> > +     return num_counters;
>
> return rvpmu_sbi_get_ctrinfo(num_sbi_counters, num_deleg_counters);
>
> >  }
> >
> >  static int rvpmu_event_map(struct perf_event *event, u64 *econfig)
> > @@ -1377,12 +1415,21 @@ static int rvpmu_device_probe(struct platform_d=
evice *pdev)
> >       int ret =3D -ENODEV;
> >       int num_counters;
> >
> > -     pr_info("SBI PMU extension is available\n");
> > +     if (cdeleg_available) {
> > +             pr_info("hpmcounters will use the counter delegation ISA =
extension\n");
> > +             if (sbi_available)
> > +                     pr_info("Firmware counters will be use SBI PMU ex=
tension\n");
>
> s/will be use/will use
>
> > +             else
> > +                     pr_info("Firmware counters will be not available =
as SBI PMU extension is not present\n");
>
> s/will be not/will not
>

Fixed.

> > +     } else if (sbi_available) {
> > +             pr_info("Both hpmcounters and firmware counters will use =
SBI PMU extension\n");
> > +     }
> > +
> >       pmu =3D riscv_pmu_alloc();
> >       if (!pmu)
> >               return -ENOMEM;
> >
> > -     num_counters =3D rvpmu_find_num_ctrs();
> > +     num_counters =3D rvpmu_find_ctrs();
> >       if (num_counters < 0) {
> >               pr_err("SBI PMU extension doesn't provide any counters\n"=
);
> >               goto out_free;
> > @@ -1394,9 +1441,6 @@ static int rvpmu_device_probe(struct platform_dev=
ice *pdev)
> >               pr_info("SBI returned more than maximum number of counter=
s. Limiting the number of counters to %d\n", num_counters);
> >       }
> >
> > -     /* cache all the information about counters now */
> > -     if (rvpmu_get_ctrinfo(num_counters, &cmask))
> > -             goto out_free;
> >
> >       ret =3D rvpmu_setup_irqs(pmu, pdev);
> >       if (ret < 0) {
> > @@ -1486,13 +1530,27 @@ static int __init rvpmu_devinit(void)
> >       int ret;
> >       struct platform_device *pdev;
> >
> > -     if (sbi_spec_version < sbi_mk_version(0, 3) ||
> > -         !sbi_probe_extension(SBI_EXT_PMU)) {
> > -             return 0;
> > +     if (sbi_spec_version >=3D sbi_mk_version(0, 3) &&
> > +         sbi_probe_extension(SBI_EXT_PMU)) {
> > +             static_branch_enable(&riscv_pmu_sbi_available);
> > +             sbi_available =3D true;
> >       }
> >
> >       if (sbi_spec_version >=3D sbi_mk_version(2, 0))
> >               sbi_v2_available =3D true;
> > +     /*
> > +      * We need all three extensions to be present to access the count=
ers
> > +      * in S-mode via Supervisor Counter delegation.
> > +      */
> > +     if (riscv_isa_extension_available(NULL, SSCCFG) &&
> > +         riscv_isa_extension_available(NULL, SMCDELEG) &&
> > +         riscv_isa_extension_available(NULL, SSCSRIND)) {
> > +             static_branch_enable(&riscv_pmu_cdeleg_available);
> > +             cdeleg_available =3D true;
> > +     }
> > +
> > +     if (!(sbi_available || cdeleg_available))
> > +             return 0;
> >
> >       ret =3D cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
> >                                     "perf/riscv/pmu:starting",
> >
>
