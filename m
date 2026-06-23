Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F80638657D
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 01:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179087; cv=pass; b=EJ6R3pacZGfR7Trk3xOXShLL4xE/MJOFcOONE2AGhJ0DfHHSp+lebtQ8BOmc+z2ut1owmgQIBvp6L1g1Mp5xqoW96aJ5yCUBCmZXk73iMwqaVNkBn8SgIdrEFimRHv2Bd2mjzQ8yLQTYMg7qXfFqAFBb1DfSMPdvGlaKd34CZj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179087; c=relaxed/simple;
	bh=1M98cGJ08mUTtdWfCY1tpCKU3USsYCNCAPmUC+8RzlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsH3B/XzGPp3aNUMualsNxwsr9Cows5a6dDv7MTnZXlWhqkEuGB0BMnwD/UTUuPDIzFes0SPoxE+e68s/IjGf0ZVX80ceZWxtmukyh9Yi+64mCEt8T098qEV7DNvp5fRcUrA2MMKpKlMcYI/o8vorgBxPNbwlkQlhs68gJimWes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=H7qI6rx0; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="H7qI6rx0"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-697ce8cfe65so1512342a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 18:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782179083; cv=none;
        d=google.com; s=arc-20240605;
        b=i1hF5AwgK90yCyTEnen+dPyubZx2HmtUjJJAlG9naHtRa9xErL9Ol2ltmzanUtmkkF
         m1cWeUCP7f8FqsI4Otd8ddmupSi8Di4wR3OYdpUDexRvMNBVnuNVt3xT9SaedXYJZi/b
         +VL11NWZj8G98wheOjo8Un0cqDDMnr1hbdV4M7NpWVRxLkUZWV+bBhdip3Dtktc8tRt8
         cJMw+nsuWwxDX0/ygjgKmxHAEa5HhOwpVUMlyTsZm/9XdJZVPsyQeWZUm4Q5cyzMzKha
         wL1zi4f716rQSDLwzrttO2rTzWgVpye7FBcBF3r7HWOqTOEVIvS644GFLD5+qA6xBOg+
         /I6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VTObfD+LGsUlNj5koaI6/jeGDhw0Yskkjz6sDadFTX8=;
        fh=k3f5E7SXb8VYy6wflPDHbiQ6wltQ271w8ozTTmohmOk=;
        b=TWtk6FPTNUaGHXQ283tSfof4PCci+tL6Q4ug8nnRNtIY25DoQP+hQ0TOgA2mcnYjKg
         /w89y9Gi/MzVfI46ctMAixtguWD44QR4kDAEZX8Em0dqSIT2k5VbqGNCHrsFr4q8ximW
         9YNM1kau8UoMFOvh2h16mLQOf/VPW1SD6K855G8olE6pcofWSa/qYFjkF6ZJg/Fng6/7
         25JFeRjPnXr0LQ8hLzveWmrDMcfg++auUXsrnlRcwRvgUVHszjW0xRFmcgXxJuiJFbBi
         /TCzu8g3zJNHGf3pOjjDuqkiyk8zyn/CR4QnyzlGtgsMS9G9zw6U6bLsMQW10rZQ2Vk/
         B+yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1782179083; x=1782783883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTObfD+LGsUlNj5koaI6/jeGDhw0Yskkjz6sDadFTX8=;
        b=H7qI6rx0g1AOJPmN7Kec4cDlh73s+PGMmAI2MnwYUDnO0quX5dx+6ZBUxmZ4Qli+AP
         0CNxcl9uwOQbHkKWoZdA6MTj688CwCmX9y+Nymwj3tQtVeqVLURKDw7EYfUckmub/cGW
         hAcwQg2wgTIQ9/um7o+NXGH/4v8dicq9lxPq4YXZLJ5HxIOlx404c3pAeJNNTeyewgs4
         /LklCNCAL62Y4C52PX7fnTYyA8eCZo3W5/R+58GSBN6JwEGxZntEWSzbyW13ZWaCswYz
         keYpWxsfj6GK2g6KDONemjseY3L2JJBivO8cBCp6eKV/B8xtQ3pQJGLwqpdUlIlNkzPd
         MruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782179083; x=1782783883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VTObfD+LGsUlNj5koaI6/jeGDhw0Yskkjz6sDadFTX8=;
        b=TXpoeoeb/z2zMq84K7CHg2qnw8z5fPU16Gj/k273zACXBwoynb+QxS38ql9swB9Y4o
         vsuwmmEATa76ZHxy7rZLaKO0E7aCWJPi9GIZVa8KXjbXXv+9lLmcMLFiImmYQ9s/NlVf
         j3hwPn9GPq8L4xjLl7+D9t8s8HgEnLgiOWLNm8wynEZVV0m0mE5mKGRNFFL99nZSz9pk
         jXwNOP6NYhwPC9/OIf/yNOaRBLMLrqyyCTYqQ/Ve1NcU9xBRonBfoHtnSz9/Y+4x6Q0P
         KQdKr+BboQNjfdNK/gITJc7dKCTchYRzmAFGp+vpPGu4cNPRsOFI0uv87Fhj2EPZB0+x
         kcEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+R9oLLJCV8EdA31+ahWAbmP+FbYqiEi9hOs3y1UuKh+hwlfYIMFiCA2IuHINaRGWgND6UzmgDFwz+Fdx6f1twf@vger.kernel.org
X-Gm-Message-State: AOJu0YwRk5mJWDAN8ZRhCioXSEthn1p7g/9Eu2xCx0hzUOP8P7/y4iFN
	d8KE+YB1YLV8hb9MYFD8G1DUn9gbl3vd2mNbwFzpoG1yhpq7t6DidiMFLt3DpN4sMphYYh9BgQv
	ccl4nBwFuT5xajPmPNgGrCfPDKKvlNdVleP1eICOMcg==
X-Gm-Gg: AfdE7clC63xe3117slqhwNtznTejqjNc4dQdoEmuy1ZkzIz7G5UaNu0fOh11GGCR1Lx
	sVL2FJ/pNcLt2btHUumDmmjob5ylQ2lTBBe4jc4L4ZW9e3wCc/+ZKU9OCm9iXoySx/VWcaeAGjT
	KRaHUuQwezuw4t1KSXzEbeJq9Bp6dhFrf2QxcUBTIMbY0NDurke3iPVYgmE8l9L94wW/ytZbP7q
	04pi8CucxXqhJO4SbfBXEbz0unm4lYk28ealVYTcceHjSBAPKsGPP/j0eAyoRAbOdKWQNk7MDM=
X-Received: by 2002:a05:6402:2707:b0:697:4307:991d with SMTP id
 4fb4d7f45d1cf-697dbb3bd97mr184977a12.19.1782179083008; Mon, 22 Jun 2026
 18:44:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208063848.3547817-1-zong.li@sifive.com> <20260208063848.3547817-2-zong.li@sifive.com>
 <ajVo34aTfZFBZpoe@gmail.com>
In-Reply-To: <ajVo34aTfZFBZpoe@gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 23 Jun 2026 09:44:31 +0800
X-Gm-Features: AVVi8Cfj_PoKvLryKV0KrV-qAEy0FhyvGZNPO-2VknzogzsR8VVnTP34eU81FUE
Message-ID: <CANXhq0pZyfgKUZpozrC+FN-0S2XiPOo+b_5npQyvvCgV+EBVqQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu driver
To: Guo Ren <guoren@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, tjeznach@rivosinc.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, robh@kernel.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	mark.rutland@arm.com, conor+dt@kernel.org, krzk@kernel.org, 
	guoyaxing@bosc.ac.cn, luxu.kernel@bytedance.com, lv.zheng@linux.spacemit.com, 
	andrew.jones@oss.qualcomm.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 20, 2026 at 12:06=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Sat, Feb 07, 2026 at 10:38:35PM -0800, Zong Li wrote:
> > Add a new driver to support the RISC-V IOMMU PMU. This is an auxiliary
> > device driver created by the parent RISC-V IOMMU driver.
> >
> > The RISC-V IOMMU PMU separates the cycle counter from the event counter=
s.
> > The cycle counter is not associated with iohpmevt0, so a software-defin=
ed
> > cycle event is required for the perf subsystem.
> >
> > The number and width of the counters are hardware-implemented and must
> > be detected at runtime.
> >
> > The performance monitor provides counters with filtering support to
> > collect events for specific device ID/process ID, or GSCID/PSCID.
> >
> > PMU-related definitions are moved into the perf driver, where they are
> > used exclusively.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/iommu/riscv/iommu-bits.h |  61 ---
> >  drivers/perf/Kconfig             |  12 +
> >  drivers/perf/Makefile            |   1 +
> >  drivers/perf/riscv_iommu_pmu.c   | 661 +++++++++++++++++++++++++++++++
> >  4 files changed, 674 insertions(+), 61 deletions(-)
> >  create mode 100644 drivers/perf/riscv_iommu_pmu.c
> >
> > diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iom=
mu-bits.h
> > index 98daf0e1a306..746cd11f4938 100644
> > --- a/drivers/iommu/riscv/iommu-bits.h
> > +++ b/drivers/iommu/riscv/iommu-bits.h
> > @@ -189,67 +189,6 @@ enum riscv_iommu_ddtp_modes {
> >  #define RISCV_IOMMU_IPSR_PMIP                BIT(RISCV_IOMMU_INTR_PM)
> >  #define RISCV_IOMMU_IPSR_PIP         BIT(RISCV_IOMMU_INTR_PQ)
> >
> > -/* 5.19 Performance monitoring counter overflow status (32bits) */
> > -#define RISCV_IOMMU_REG_IOCOUNTOVF   0x0058
> > -#define RISCV_IOMMU_IOCOUNTOVF_CY    BIT(0)
> > -#define RISCV_IOMMU_IOCOUNTOVF_HPM   GENMASK_ULL(31, 1)
> > -
> > -/* 5.20 Performance monitoring counter inhibits (32bits) */
> > -#define RISCV_IOMMU_REG_IOCOUNTINH   0x005C
> > -#define RISCV_IOMMU_IOCOUNTINH_CY    BIT(0)
> > -#define RISCV_IOMMU_IOCOUNTINH_HPM   GENMASK(31, 1)
> > -
> > -/* 5.21 Performance monitoring cycles counter (64bits) */
> > -#define RISCV_IOMMU_REG_IOHPMCYCLES     0x0060
> > -#define RISCV_IOMMU_IOHPMCYCLES_COUNTER      GENMASK_ULL(62, 0)
> > -#define RISCV_IOMMU_IOHPMCYCLES_OF   BIT_ULL(63)
> > -
> > -/* 5.22 Performance monitoring event counters (31 * 64bits) */
> > -#define RISCV_IOMMU_REG_IOHPMCTR_BASE        0x0068
> > -#define RISCV_IOMMU_REG_IOHPMCTR(_n) (RISCV_IOMMU_REG_IOHPMCTR_BASE + =
((_n) * 0x8))
> > -
> > -/* 5.23 Performance monitoring event selectors (31 * 64bits) */
> > -#define RISCV_IOMMU_REG_IOHPMEVT_BASE        0x0160
> > -#define RISCV_IOMMU_REG_IOHPMEVT(_n) (RISCV_IOMMU_REG_IOHPMEVT_BASE + =
((_n) * 0x8))
> > -#define RISCV_IOMMU_IOHPMEVT_EVENTID GENMASK_ULL(14, 0)
> > -#define RISCV_IOMMU_IOHPMEVT_DMASK   BIT_ULL(15)
> > -#define RISCV_IOMMU_IOHPMEVT_PID_PSCID       GENMASK_ULL(35, 16)
> > -#define RISCV_IOMMU_IOHPMEVT_DID_GSCID       GENMASK_ULL(59, 36)
> > -#define RISCV_IOMMU_IOHPMEVT_PV_PSCV BIT_ULL(60)
> > -#define RISCV_IOMMU_IOHPMEVT_DV_GSCV BIT_ULL(61)
> > -#define RISCV_IOMMU_IOHPMEVT_IDT     BIT_ULL(62)
> > -#define RISCV_IOMMU_IOHPMEVT_OF              BIT_ULL(63)
> > -
> > -/* Number of defined performance-monitoring event selectors */
> > -#define RISCV_IOMMU_IOHPMEVT_CNT     31
> > -
> > -/**
> > - * enum riscv_iommu_hpmevent_id - Performance-monitoring event identif=
ier
> > - *
> > - * @RISCV_IOMMU_HPMEVENT_INVALID: Invalid event, do not count
> > - * @RISCV_IOMMU_HPMEVENT_URQ: Untranslated requests
> > - * @RISCV_IOMMU_HPMEVENT_TRQ: Translated requests
> > - * @RISCV_IOMMU_HPMEVENT_ATS_RQ: ATS translation requests
> > - * @RISCV_IOMMU_HPMEVENT_TLB_MISS: TLB misses
> > - * @RISCV_IOMMU_HPMEVENT_DD_WALK: Device directory walks
> > - * @RISCV_IOMMU_HPMEVENT_PD_WALK: Process directory walks
> > - * @RISCV_IOMMU_HPMEVENT_S_VS_WALKS: First-stage page table walks
> > - * @RISCV_IOMMU_HPMEVENT_G_WALKS: Second-stage page table walks
> > - * @RISCV_IOMMU_HPMEVENT_MAX: Value to denote maximum Event IDs
> > - */
> > -enum riscv_iommu_hpmevent_id {
> > -     RISCV_IOMMU_HPMEVENT_INVALID    =3D 0,
> > -     RISCV_IOMMU_HPMEVENT_URQ        =3D 1,
> > -     RISCV_IOMMU_HPMEVENT_TRQ        =3D 2,
> > -     RISCV_IOMMU_HPMEVENT_ATS_RQ     =3D 3,
> > -     RISCV_IOMMU_HPMEVENT_TLB_MISS   =3D 4,
> > -     RISCV_IOMMU_HPMEVENT_DD_WALK    =3D 5,
> > -     RISCV_IOMMU_HPMEVENT_PD_WALK    =3D 6,
> > -     RISCV_IOMMU_HPMEVENT_S_VS_WALKS =3D 7,
> > -     RISCV_IOMMU_HPMEVENT_G_WALKS    =3D 8,
> > -     RISCV_IOMMU_HPMEVENT_MAX        =3D 9
> > -};
> > -
> >  /* 5.24 Translation request IOVA (64bits) */
> >  #define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
> >  #define RISCV_IOMMU_TR_REQ_IOVA_VPN  GENMASK_ULL(63, 12)
> > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> > index 638321fc9800..6d0ece827501 100644
> > --- a/drivers/perf/Kconfig
> > +++ b/drivers/perf/Kconfig
> > @@ -105,6 +105,18 @@ config RISCV_PMU_SBI
> >         full perf feature support i.e. counter overflow, privilege mode
> >         filtering, counter configuration.
> >
> > +config RISCV_IOMMU_PMU
> > +     depends on RISCV || COMPILE_TEST
> > +     depends on RISCV_IOMMU
> > +     bool "RISC-V IOMMU Hardware Performance Monitor"
> > +     default y
> > +     help
> > +       Say Y if you want to use the RISC-V IOMMU performance monitor
> > +       implementation. The performance monitor is an optional hardware
> > +       feature, and whether it is actually enabled depends on IOMMU
> > +       hardware support. If the underlying hardware does not implement
> > +       the PMU, this option will have no effect.
> > +
> >  config STARFIVE_STARLINK_PMU
> >       depends on ARCH_STARFIVE || COMPILE_TEST
> >       depends on 64BIT
> > diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> > index ea52711a87e3..f64f7dc046f1 100644
> > --- a/drivers/perf/Makefile
> > +++ b/drivers/perf/Makefile
> > @@ -20,6 +20,7 @@ obj-$(CONFIG_QCOM_L3_PMU) +=3D qcom_l3_pmu.o
> >  obj-$(CONFIG_RISCV_PMU) +=3D riscv_pmu.o
> >  obj-$(CONFIG_RISCV_PMU_LEGACY) +=3D riscv_pmu_legacy.o
> >  obj-$(CONFIG_RISCV_PMU_SBI) +=3D riscv_pmu_sbi.o
> > +obj-$(CONFIG_RISCV_IOMMU_PMU) +=3D riscv_iommu_pmu.o
> >  obj-$(CONFIG_STARFIVE_STARLINK_PMU) +=3D starfive_starlink_pmu.o
> >  obj-$(CONFIG_THUNDERX2_PMU) +=3D thunderx2_pmu.o
> >  obj-$(CONFIG_XGENE_PMU) +=3D xgene_pmu.o
> > diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iommu_=
pmu.c
> > new file mode 100644
> > index 000000000000..72fc4341b165
> > --- /dev/null
> > +++ b/drivers/perf/riscv_iommu_pmu.c
> > @@ -0,0 +1,661 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2026 SiFive
> > + *
> > + * Authors
> > + *   Zong Li <zong.li@sifive.com>
> > + */
> > +
> > +#include <linux/auxiliary_bus.h>
> > +#include <linux/io-64-nonatomic-hi-lo.h>
> > +#include <linux/perf_event.h>
> > +
> > +#include "../iommu/riscv/iommu.h"
> > +
> > +/* 5.19 Performance monitoring counter overflow status (32bits) */
> > +#define RISCV_IOMMU_REG_IOCOUNTOVF   0x0058
> > +#define RISCV_IOMMU_IOCOUNTOVF_CY    BIT(0)
> > +#define RISCV_IOMMU_IOCOUNTOVF_HPM   GENMASK_ULL(31, 1)
> > +
> > +/* 5.20 Performance monitoring counter inhibits (32bits) */
> > +#define RISCV_IOMMU_REG_IOCOUNTINH   0x005C
> > +#define RISCV_IOMMU_IOCOUNTINH_CY    BIT(0)
> > +#define RISCV_IOMMU_IOCOUNTINH_HPM   GENMASK(31, 0)
> > +
> > +/* 5.21 Performance monitoring cycles counter (64bits) */
> > +#define RISCV_IOMMU_REG_IOHPMCYCLES  0x0060
> > +#define RISCV_IOMMU_IOHPMCYCLES_COUNTER      GENMASK_ULL(62, 0)
> > +#define RISCV_IOMMU_IOHPMCYCLES_OF   BIT_ULL(63)
> > +#define RISCV_IOMMU_REG_IOHPMCTR(_n) (RISCV_IOMMU_REG_IOHPMCYCLES + ((=
_n) * 0x8))
> > +
> > +/* 5.22 Performance monitoring event counters (31 * 64bits) */
> > +#define RISCV_IOMMU_REG_IOHPMCTR_BASE        0x0068
> > +#define RISCV_IOMMU_IOHPMCTR_COUNTER GENMASK_ULL(63, 0)
> > +
> > +/* 5.23 Performance monitoring event selectors (31 * 64bits) */
> > +#define RISCV_IOMMU_REG_IOHPMEVT_BASE        0x0160
> > +#define RISCV_IOMMU_REG_IOHPMEVT(_n) (RISCV_IOMMU_REG_IOHPMEVT_BASE + =
((_n) * 0x8))
> > +#define RISCV_IOMMU_IOHPMEVT_EVENTID GENMASK_ULL(14, 0)
> > +#define RISCV_IOMMU_IOHPMEVT_DMASK   BIT_ULL(15)
> > +#define RISCV_IOMMU_IOHPMEVT_PID_PSCID       GENMASK_ULL(35, 16)
> > +#define RISCV_IOMMU_IOHPMEVT_DID_GSCID       GENMASK_ULL(59, 36)
> > +#define RISCV_IOMMU_IOHPMEVT_PV_PSCV BIT_ULL(60)
> > +#define RISCV_IOMMU_IOHPMEVT_DV_GSCV BIT_ULL(61)
> > +#define RISCV_IOMMU_IOHPMEVT_IDT     BIT_ULL(62)
> > +#define RISCV_IOMMU_IOHPMEVT_OF              BIT_ULL(63)
> > +#define RISCV_IOMMU_IOHPMEVT_EVENT   GENMASK_ULL(62, 0)
> > +
> > +/* The total number of counters is 31 event counters plus 1 cycle coun=
ter */
> > +#define RISCV_IOMMU_HPM_COUNTER_NUM  32
> > +
> > +static int cpuhp_state;
> > +
> > +/**
> > + * enum riscv_iommu_hpmevent_id - Performance-monitoring event identif=
ier
> > + *
> > + * @RISCV_IOMMU_HPMEVENT_CYCLE: Clock cycle counter
> > + * @RISCV_IOMMU_HPMEVENT_URQ: Untranslated requests
> > + * @RISCV_IOMMU_HPMEVENT_TRQ: Translated requests
> > + * @RISCV_IOMMU_HPMEVENT_ATS_RQ: ATS translation requests
> > + * @RISCV_IOMMU_HPMEVENT_TLB_MISS: TLB misses
> > + * @RISCV_IOMMU_HPMEVENT_DD_WALK: Device directory walks
> > + * @RISCV_IOMMU_HPMEVENT_PD_WALK: Process directory walks
> > + * @RISCV_IOMMU_HPMEVENT_S_VS_WALKS: First-stage page table walks
> > + * @RISCV_IOMMU_HPMEVENT_G_WALKS: Second-stage page table walks
> > + * @RISCV_IOMMU_HPMEVENT_MAX: Value to denote maximum Event IDs
> > + *
> > + * The specification does not define an event ID for counting the
> > + * number of clock cycles, meaning there is no associated 'iohpmevt0'.
> > + * Event ID 0 is an invalid event and does not overlap with any valid
> > + * event ID. Let's repurpose ID 0 as the cycle for perf, the cycle
> > + * event is not actually written into any register, it serves solely
> > + * as an identifier.
> > + */
> > +enum riscv_iommu_hpmevent_id {
> > +     RISCV_IOMMU_HPMEVENT_CYCLE      =3D 0,
> > +     RISCV_IOMMU_HPMEVENT_URQ        =3D 1,
> > +     RISCV_IOMMU_HPMEVENT_TRQ        =3D 2,
> > +     RISCV_IOMMU_HPMEVENT_ATS_RQ     =3D 3,
> > +     RISCV_IOMMU_HPMEVENT_TLB_MISS   =3D 4,
> > +     RISCV_IOMMU_HPMEVENT_DD_WALK    =3D 5,
> > +     RISCV_IOMMU_HPMEVENT_PD_WALK    =3D 6,
> > +     RISCV_IOMMU_HPMEVENT_S_VS_WALKS =3D 7,
> > +     RISCV_IOMMU_HPMEVENT_G_WALKS    =3D 8,
> > +     RISCV_IOMMU_HPMEVENT_MAX        =3D 9
> > +};
> > +
> > +struct riscv_iommu_pmu {
> > +     struct pmu pmu;
> > +     struct hlist_node node;
> > +     void __iomem *reg;
> > +     unsigned int on_cpu;
> > +     int num_counters;
> > +     u64 cycle_cntr_mask;
> > +     u64 event_cntr_mask;
> > +     struct perf_event *events[RISCV_IOMMU_HPM_COUNTER_NUM];
> > +     DECLARE_BITMAP(used_counters, RISCV_IOMMU_HPM_COUNTER_NUM);
> > +};
> > +
> > +#define to_riscv_iommu_pmu(p) (container_of(p, struct riscv_iommu_pmu,=
 pmu))
> > +
> > +#define RISCV_IOMMU_PMU_ATTR_EXTRACTOR(_name, _mask)                 \
> > +     static inline u32 get_##_name(struct perf_event *event)         \
> > +     {                                                               \
> > +             return FIELD_GET(_mask, event->attr.config);            \
> > +     }                                                               \
> > +
> > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(event, RISCV_IOMMU_IOHPMEVT_EVENTID);
> > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(partial_matching, RISCV_IOMMU_IOHPMEVT_=
DMASK);
> > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(pid_pscid, RISCV_IOMMU_IOHPMEVT_PID_PSC=
ID);
> > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(did_gscid, RISCV_IOMMU_IOHPMEVT_DID_GSC=
ID);
> > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_pid_pscid, RISCV_IOMMU_IOHPMEVT_=
PV_PSCV);
> > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_did_gscid, RISCV_IOMMU_IOHPMEVT_=
DV_GSCV);
> > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_id_type, RISCV_IOMMU_IOHPMEVT_ID=
T);
> > +
> > +/* Formats */
> > +PMU_FORMAT_ATTR(event,            "config:0-14");
> > +PMU_FORMAT_ATTR(partial_matching, "config:15");
> > +PMU_FORMAT_ATTR(pid_pscid,        "config:16-35");
> > +PMU_FORMAT_ATTR(did_gscid,        "config:36-59");
> > +PMU_FORMAT_ATTR(filter_pid_pscid, "config:60");
> > +PMU_FORMAT_ATTR(filter_did_gscid, "config:61");
> > +PMU_FORMAT_ATTR(filter_id_type,   "config:62");
> > +
> > +static struct attribute *riscv_iommu_pmu_formats[] =3D {
> > +     &format_attr_event.attr,
> > +     &format_attr_partial_matching.attr,
> > +     &format_attr_pid_pscid.attr,
> > +     &format_attr_did_gscid.attr,
> > +     &format_attr_filter_pid_pscid.attr,
> > +     &format_attr_filter_did_gscid.attr,
> > +     &format_attr_filter_id_type.attr,
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group riscv_iommu_pmu_format_group =3D {
> > +     .name =3D "format",
> > +     .attrs =3D riscv_iommu_pmu_formats,
> > +};
> > +
> > +/* Events */
> > +static ssize_t riscv_iommu_pmu_event_show(struct device *dev,
> > +                                       struct device_attribute *attr,
> > +                                       char *page)
> > +{
> > +     struct perf_pmu_events_attr *pmu_attr;
> > +
> > +     pmu_attr =3D container_of(attr, struct perf_pmu_events_attr, attr=
);
> > +
> > +     return sysfs_emit(page, "event=3D0x%02llx\n", pmu_attr->id);
> > +}
> > +
> > +#define RISCV_IOMMU_PMU_EVENT_ATTR(name, id)                 \
> > +     PMU_EVENT_ATTR_ID(name, riscv_iommu_pmu_event_show, id)
> > +
> > +static struct attribute *riscv_iommu_pmu_events[] =3D {
> > +     RISCV_IOMMU_PMU_EVENT_ATTR(cycle, RISCV_IOMMU_HPMEVENT_CYCLE),
> > +     RISCV_IOMMU_PMU_EVENT_ATTR(untranslated_req, RISCV_IOMMU_HPMEVENT=
_URQ),
> > +     RISCV_IOMMU_PMU_EVENT_ATTR(translated_req, RISCV_IOMMU_HPMEVENT_T=
RQ),
> > +     RISCV_IOMMU_PMU_EVENT_ATTR(ats_trans_req, RISCV_IOMMU_HPMEVENT_AT=
S_RQ),
> > +     RISCV_IOMMU_PMU_EVENT_ATTR(tlb_miss, RISCV_IOMMU_HPMEVENT_TLB_MIS=
S),
> > +     RISCV_IOMMU_PMU_EVENT_ATTR(ddt_walks, RISCV_IOMMU_HPMEVENT_DD_WAL=
K),
> > +     RISCV_IOMMU_PMU_EVENT_ATTR(pdt_walks, RISCV_IOMMU_HPMEVENT_PD_WAL=
K),
> > +     RISCV_IOMMU_PMU_EVENT_ATTR(s_vs_pt_walks, RISCV_IOMMU_HPMEVENT_S_=
VS_WALKS),
> > +     RISCV_IOMMU_PMU_EVENT_ATTR(g_pt_walks, RISCV_IOMMU_HPMEVENT_G_WAL=
KS),
> > +     NULL,
> > +};
> > +
> > +static const struct attribute_group riscv_iommu_pmu_events_group =3D {
> > +     .name =3D "events",
> > +     .attrs =3D riscv_iommu_pmu_events,
> > +};
> > +
> > +/* cpumask */
> > +static ssize_t riscv_iommu_cpumask_show(struct device *dev,
> > +                                     struct device_attribute *attr,
> > +                                     char *buf)
> > +{
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(dev_get_drvdat=
a(dev));
> > +
> > +     return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->on_cpu)=
);
> > +}
> > +
> > +static struct device_attribute riscv_iommu_cpumask_attr =3D
> > +     __ATTR(cpumask, 0444, riscv_iommu_cpumask_show, NULL);
> > +
> > +static struct attribute *riscv_iommu_cpumask_attrs[] =3D {
> > +     &riscv_iommu_cpumask_attr.attr,
> > +     NULL
> > +};
> > +
> > +static const struct attribute_group riscv_iommu_pmu_cpumask_group =3D =
{
> > +     .attrs =3D riscv_iommu_cpumask_attrs,
> > +};
> > +
> > +static const struct attribute_group *riscv_iommu_pmu_attr_grps[] =3D {
> > +     &riscv_iommu_pmu_cpumask_group,
> > +     &riscv_iommu_pmu_format_group,
> > +     &riscv_iommu_pmu_events_group,
> > +     NULL,
> > +};
> > +
> > +/* PMU Operations */
> > +static void riscv_iommu_pmu_set_counter(struct riscv_iommu_pmu *pmu, u=
32 idx,
> > +                                     u64 value)
> > +{
> > +     u64 counter_mask =3D idx ? pmu->event_cntr_mask : pmu->cycle_cntr=
_mask;
> > +
> > +     writeq(value & counter_mask, pmu->reg + RISCV_IOMMU_REG_IOHPMCTR(=
idx));
> > +}
> > +
> > +static u64 riscv_iommu_pmu_get_counter(struct riscv_iommu_pmu *pmu, u3=
2 idx)
> > +{
> > +     u64 value, counter_mask =3D idx ? pmu->event_cntr_mask : pmu->cyc=
le_cntr_mask;
> > +
> > +     /* Use readq to read counter would be imprecise on 32-bits system=
 */
> > +     value =3D readq(pmu->reg + RISCV_IOMMU_REG_IOHPMCTR(idx)) & count=
er_mask;
> As stated in the RISC-V IOMMU Specification, Chapter 6:
>   Whether an 8-byte access to an IOMMU register is single-copy atomic is
>   UNSPECIFIED, and such an access may appear, internally to the IOMMU,
>   as if two separate 4-byte accesses =E2=80=94 first to the high half and=
 second
>   to the low half =E2=80=94 were performed.
>
> Therefore, the atomicity of 64-bit MMIO accesses is UNSPECIFIED and
> not clearly defined in the current ratified RISC-V IOMMU
> specification. To handle this correctly, the Linux RISC-V IOMMU driver
> should fall back to 32-bit MMIO accesses when reading 64-bit HPM counter
> register.
>
> Additionally, David Laight has proposed an optimization using the
> hi-lo-hi read pattern with multiple 32-bit MMIO accesses [1], no retry
> loop.

Hi Guo,
Thanks for your review and suggestion, let me modify it in the next version

>
> [1]: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpkin/
>
> > +
> > +     /* The bit 63 of cycle counter (i.e., idx =3D=3D 0) is OF bit */
> > +     return idx ? value : (value & ~RISCV_IOMMU_IOHPMCYCLES_OF);
> > +}
> > +
> > +static bool is_cycle_event(u64 event)
> > +{
> > +     return event =3D=3D RISCV_IOMMU_HPMEVENT_CYCLE;
> > +}
> > +
> > +static void riscv_iommu_pmu_set_event(struct riscv_iommu_pmu *pmu, u32=
 idx,
> > +                                   u64 value)
> > +{
> > +     /* There is no associtated IOHPMEVT0 for IOHPMCYCLES */
> > +     if (is_cycle_event(value))
> > +             return;
> > +
> > +     /* Event counter start from idx 1 */
> > +     writeq(FIELD_GET(RISCV_IOMMU_IOHPMEVT_EVENT, value),
> > +            pmu->reg + RISCV_IOMMU_REG_IOHPMEVT(idx - 1));
> > +}
> > +
> > +static void riscv_iommu_pmu_enable_counter(struct riscv_iommu_pmu *pmu=
, u32 idx)
> > +{
> > +     void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> > +     u32 value =3D readl(addr);
> > +
> > +     writel(value & ~BIT(idx), addr);
> > +}
> > +
> > +static void riscv_iommu_pmu_disable_counter(struct riscv_iommu_pmu *pm=
u, u32 idx)
> > +{
> > +     void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> > +     u32 value =3D readl(addr);
> > +
> > +     writel(value | BIT(idx), addr);
> > +}
> > +
> > +static void riscv_iommu_pmu_start_all(struct riscv_iommu_pmu *pmu)
> > +{
> > +     void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> > +     u32 used_cntr =3D 0;
> > +
> > +     /* The performance-monitoring counter inhibits is a 32-bit WARL r=
egister */
> > +     bitmap_to_arr32(&used_cntr, pmu->used_counters, pmu->num_counters=
);
> > +
> > +     writel(~used_cntr, addr);
> > +}
> > +
> > +static void riscv_iommu_pmu_stop_all(struct riscv_iommu_pmu *pmu)
> > +{
> > +     writel(GENMASK_ULL(pmu->num_counters - 1, 0),
> > +            pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH);
> > +}
> > +
> > +/* PMU APIs */
> > +static void riscv_iommu_pmu_set_period(struct perf_event *event)
> > +{
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +     struct hw_perf_event *hwc =3D &event->hw;
> > +     u64 counter_mask =3D hwc->idx ? pmu->event_cntr_mask : pmu->cycle=
_cntr_mask;
> > +     u64 period;
> > +
> > +     /*
> > +      * Limit the maximum period to prevent the counter value
> > +      * from overtaking the one we are about to program.
> > +      * In effect we are reducing max_period to account for
> > +      * interrupt latency (and we are being very conservative).
> > +      */
> > +     period =3D counter_mask >> 1;
> > +     riscv_iommu_pmu_set_counter(pmu, hwc->idx, period);
> > +     local64_set(&hwc->prev_count, period);
> > +}
> > +
> > +static int riscv_iommu_pmu_event_init(struct perf_event *event)
> > +{
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +     struct hw_perf_event *hwc =3D &event->hw;
> > +     struct perf_event *sibling;
> > +     int total_event_counters =3D pmu->num_counters - 1;
> > +     int counters =3D 0;
> > +
> > +     if (event->attr.type !=3D event->pmu->type)
> > +             return -ENOENT;
> > +
> > +     if (hwc->sample_period)
> > +             return -EOPNOTSUPP;
> > +
> > +     if (event->cpu < 0)
> > +             return -EOPNOTSUPP;
> > +
> > +     event->cpu =3D pmu->on_cpu;
> > +
> > +     hwc->idx =3D -1;
> > +     hwc->config =3D event->attr.config;
> > +
> > +     if (event->group_leader =3D=3D event)
> > +             return 0;
> > +
> > +     if (is_cycle_event(get_event(event->group_leader)))
> > +             if (++counters > total_event_counters)
> > +                     return -EINVAL;
> > +
> > +     for_each_sibling_event(sibling, event->group_leader) {
> > +             if (is_cycle_event(get_event(sibling)))
> > +                     continue;
> > +
> > +             if (sibling->pmu !=3D event->pmu && !is_software_event(si=
bling))
> > +                     return -EINVAL;
> > +
> > +             if (++counters > total_event_counters)
> > +                     return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void riscv_iommu_pmu_update(struct perf_event *event)
> > +{
> > +     struct hw_perf_event *hwc =3D &event->hw;
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +     u64 delta, prev, now;
> > +     u32 idx =3D hwc->idx;
> > +     u64 counter_mask =3D idx ? pmu->event_cntr_mask : pmu->cycle_cntr=
_mask;
> > +
> > +     do {
> > +             prev =3D local64_read(&hwc->prev_count);
> > +             now =3D riscv_iommu_pmu_get_counter(pmu, idx);
> > +     } while (local64_cmpxchg(&hwc->prev_count, prev, now) !=3D prev);
> > +
> > +     delta =3D (now - prev) & counter_mask;
> > +     local64_add(delta, &event->count);
> > +}
> > +
> > +static void riscv_iommu_pmu_start(struct perf_event *event, int flags)
> > +{
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +     struct hw_perf_event *hwc =3D &event->hw;
> > +
> > +     if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
> > +             return;
> > +
> > +     if (flags & PERF_EF_RELOAD)
> > +             WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
> > +
> > +     hwc->state =3D 0;
> > +     riscv_iommu_pmu_set_period(event);
> > +     riscv_iommu_pmu_set_event(pmu, hwc->idx, hwc->config);
> > +     riscv_iommu_pmu_enable_counter(pmu, hwc->idx);
> > +
> > +     perf_event_update_userpage(event);
> > +}
> > +
> > +static void riscv_iommu_pmu_stop(struct perf_event *event, int flags)
> > +{
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +     struct hw_perf_event *hwc =3D &event->hw;
> > +     int idx =3D hwc->idx;
> > +
> > +     if (hwc->state & PERF_HES_STOPPED)
> > +             return;
> > +
> > +     riscv_iommu_pmu_disable_counter(pmu, idx);
> > +
> > +     if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)=
)
> > +             riscv_iommu_pmu_update(event);
> > +
> > +     hwc->state |=3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> > +}
> > +
> > +static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
> > +{
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +     struct hw_perf_event *hwc =3D &event->hw;
> > +     unsigned int num_counters =3D pmu->num_counters;
> > +     int idx;
> > +
> > +     /* Reserve index zero for iohpmcycles */
> > +     if (is_cycle_event(get_event(event)))
> > +             idx =3D 0;
> > +     else
> > +             idx =3D find_next_zero_bit(pmu->used_counters, num_counte=
rs, 1);
> > +
> > +     /* All event counters or cycle counter are in use */
> > +     if (idx =3D=3D num_counters || pmu->events[idx])
> > +             return -EAGAIN;
> > +
> > +     set_bit(idx, pmu->used_counters);
> > +
> > +     pmu->events[idx] =3D event;
> > +     hwc->idx =3D idx;
> > +     hwc->state =3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> > +     local64_set(&hwc->prev_count, 0);
> > +
> > +     if (flags & PERF_EF_START)
> > +             riscv_iommu_pmu_start(event, flags);
> > +
> > +     /* Propagate changes to the userspace mapping. */
> > +     perf_event_update_userpage(event);
> > +
> > +     return 0;
> > +}
> > +
> > +static void riscv_iommu_pmu_read(struct perf_event *event)
> > +{
> > +     riscv_iommu_pmu_update(event);
> > +}
> > +
> > +static void riscv_iommu_pmu_del(struct perf_event *event, int flags)
> > +{
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +     struct hw_perf_event *hwc =3D &event->hw;
> > +     int idx =3D hwc->idx;
> > +
> > +     riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
> > +     pmu->events[idx] =3D NULL;
> > +     clear_bit(idx, pmu->used_counters);
> > +
> > +     perf_event_update_userpage(event);
> > +}
> > +
> > +static int riscv_iommu_pmu_online_cpu(unsigned int cpu, struct hlist_n=
ode *node)
> > +{
> > +     struct riscv_iommu_pmu *iommu_pmu;
> > +
> > +     iommu_pmu =3D hlist_entry_safe(node, struct riscv_iommu_pmu, node=
);
> > +
> > +     if (iommu_pmu->on_cpu =3D=3D -1)
> > +             iommu_pmu->on_cpu =3D cpu;
> > +
> > +     return 0;
> > +}
> > +
> > +static int riscv_iommu_pmu_offline_cpu(unsigned int cpu, struct hlist_=
node *node)
> > +{
> > +     struct riscv_iommu_pmu *iommu_pmu;
> > +     unsigned int target_cpu;
> > +
> > +     iommu_pmu =3D hlist_entry_safe(node, struct riscv_iommu_pmu, node=
);
> > +
> > +     if (cpu !=3D iommu_pmu->on_cpu)
> > +             return 0;
> > +
> > +     iommu_pmu->on_cpu =3D -1;
> > +
> > +     target_cpu =3D cpumask_any_but(cpu_online_mask, cpu);
> > +     if (target_cpu >=3D nr_cpu_ids)
> > +             return 0;
> > +
> > +     perf_pmu_migrate_context(&iommu_pmu->pmu, cpu, target_cpu);
> > +     iommu_pmu->on_cpu =3D target_cpu;
> > +
> > +     return 0;
> > +}
> > +
> > +static irqreturn_t riscv_iommu_pmu_handle_irq(struct riscv_iommu_pmu *=
pmu)
> > +{
> > +     u32 ovf =3D readl(pmu->reg + RISCV_IOMMU_REG_IOCOUNTOVF);
> > +     int idx;
> > +
> > +     if (!ovf)
> > +             return IRQ_NONE;
> > +
> > +     riscv_iommu_pmu_stop_all(pmu);
> > +
> > +     for_each_set_bit(idx, (unsigned long *)&ovf, pmu->num_counters) {
> > +             struct perf_event *event =3D pmu->events[idx];
> > +
> > +             if (WARN_ON_ONCE(!event))
> > +                     continue;
> > +
> > +             riscv_iommu_pmu_update(event);
> > +             riscv_iommu_pmu_set_period(event);
> > +     }
> > +
> > +     riscv_iommu_pmu_start_all(pmu);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t riscv_iommu_pmu_irq_handler(int irq, void *dev_id)
> > +{
> > +     struct riscv_iommu_pmu *pmu =3D (struct riscv_iommu_pmu *)dev_id;
> > +     irqreturn_t ret;
> > +
> > +     /* Check whether this interrupt is for PMU */
> > +     if (!(readl_relaxed(pmu->reg + RISCV_IOMMU_REG_IPSR) & RISCV_IOMM=
U_IPSR_PMIP))
> > +             return IRQ_NONE;
> > +
> > +     /* Process PMU IRQ */
> > +     ret =3D riscv_iommu_pmu_handle_irq(pmu);
> > +
> > +     /* Clear performance monitoring interrupt pending bit */
> > +     writel_relaxed(RISCV_IOMMU_IPSR_PMIP, pmu->reg + RISCV_IOMMU_REG_=
IPSR);
> > +
> > +     return ret;
> > +}
> > +
> > +static unsigned int riscv_iommu_pmu_get_irq_num(struct riscv_iommu_dev=
ice *iommu)
> > +{
> > +     /* Reuse ICVEC.CIV mask for all interrupt vectors mapping */
> > +     int vec =3D (iommu->icvec >> (RISCV_IOMMU_IPSR_PMIP * 4)) & RISCV=
_IOMMU_ICVEC_CIV;
> > +
> > +     return iommu->irqs[vec];
> > +}
> > +
> > +static int riscv_iommu_pmu_request_irq(struct riscv_iommu_device *iomm=
u,
> > +                                    struct riscv_iommu_pmu *pmu)
> > +{
> > +     unsigned int irq =3D riscv_iommu_pmu_get_irq_num(iommu);
> > +
> > +     /*
> > +      * Set the IRQF_ONESHOT flag because this IRQ can be shared with
> > +      * other threaded IRQs by other queues.
> > +      */
> > +     return devm_request_irq(iommu->dev, irq, riscv_iommu_pmu_irq_hand=
ler,
> > +                             IRQF_ONESHOT | IRQF_SHARED, dev_name(iomm=
u->dev), pmu);
> > +}
> > +
> > +static void riscv_iommu_pmu_free_irq(struct riscv_iommu_device *iommu,
> > +                                  struct riscv_iommu_pmu *pmu)
> > +{
> > +     unsigned int irq =3D riscv_iommu_pmu_get_irq_num(iommu);
> > +
> > +     free_irq(irq, pmu);
> > +}
> > +
> > +static int riscv_iommu_pmu_probe(struct auxiliary_device *auxdev,
> > +                              const struct auxiliary_device_id *id)
> > +{
> > +     struct  riscv_iommu_device *iommu_dev =3D dev_get_platdata(&auxde=
v->dev);
> > +     struct riscv_iommu_pmu *iommu_pmu;
> > +     void __iomem *addr;
> > +     char *name;
> > +     int ret;
> > +
> > +     iommu_pmu =3D devm_kzalloc(&auxdev->dev, sizeof(*iommu_pmu), GFP_=
KERNEL);
> > +     if (!iommu_pmu)
> > +             return -ENOMEM;
> > +
> > +     iommu_pmu->reg =3D iommu_dev->reg;
> > +
> > +     /* Counter number and width are hardware-implemented. Detect them=
 by write 1s */
> > +     addr =3D iommu_pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> > +     writel(RISCV_IOMMU_IOCOUNTINH_HPM, addr);
> > +     iommu_pmu->num_counters =3D hweight32(readl(addr));
> > +
> > +     addr =3D iommu_pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;
> > +     writeq(RISCV_IOMMU_IOHPMCYCLES_COUNTER, addr);
> > +     iommu_pmu->cycle_cntr_mask =3D readq(addr);
> > +
> > +     /* Assume the width of all event counters are the same */
> > +     addr =3D iommu_pmu->reg + RISCV_IOMMU_REG_IOHPMCTR_BASE;
> > +     writeq(RISCV_IOMMU_IOHPMCTR_COUNTER, addr);
> > +     iommu_pmu->event_cntr_mask =3D readq(addr);
> > +
> > +     iommu_pmu->pmu =3D (struct pmu) {
> > +             .module         =3D THIS_MODULE,
> > +             .parent         =3D &auxdev->dev,
> > +             .task_ctx_nr    =3D perf_invalid_context,
> > +             .event_init     =3D riscv_iommu_pmu_event_init,
> > +             .add            =3D riscv_iommu_pmu_add,
> > +             .del            =3D riscv_iommu_pmu_del,
> > +             .start          =3D riscv_iommu_pmu_start,
> > +             .stop           =3D riscv_iommu_pmu_stop,
> > +             .read           =3D riscv_iommu_pmu_read,
> > +             .attr_groups    =3D riscv_iommu_pmu_attr_grps,
> > +             .capabilities   =3D PERF_PMU_CAP_NO_EXCLUDE,
> > +     };
> > +
> > +     auxiliary_set_drvdata(auxdev, iommu_pmu);
> > +
> > +     name =3D devm_kasprintf(&auxdev->dev, GFP_KERNEL,
> > +                           "riscv_iommu_pmu_%s", dev_name(iommu_dev->d=
ev));
> > +     if (!name) {
> > +             dev_err(&auxdev->dev, "Failed to create name riscv_iommu_=
pmu_%s\n",
> > +                     dev_name(iommu_dev->dev));
> > +             return -ENOMEM;
> > +     }
> > +
> > +     /* Bind all events to the same cpu context to avoid race enabling=
 */
> > +     iommu_pmu->on_cpu =3D raw_smp_processor_id();
> > +
> > +     ret =3D cpuhp_state_add_instance_nocalls(cpuhp_state, &iommu_pmu-=
>node);
> > +     if (ret) {
> > +             dev_err(&auxdev->dev, "Failed to register hotplug %s: %d\=
n", name, ret);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D riscv_iommu_pmu_request_irq(iommu_dev, iommu_pmu);
> > +     if (ret) {
> > +             dev_err(&auxdev->dev, "Failed to request irq %s: %d\n", n=
ame, ret);
> > +             goto err_cpuhp_remove;
> > +     }
> > +
> > +     ret =3D perf_pmu_register(&iommu_pmu->pmu, name, -1);
> > +     if (ret) {
> > +             dev_err(&auxdev->dev, "Failed to registe %s: %d\n", name,=
 ret);
> > +             goto err_free_irq;
> > +     }
> > +
> > +     dev_info(&auxdev->dev, "%s: Registered with %d counters\n",
> > +              name, iommu_pmu->num_counters);
> > +
> > +     return 0;
> > +
> > +err_free_irq:
> > +     riscv_iommu_pmu_free_irq(iommu_dev, iommu_pmu);
> > +err_cpuhp_remove:
> > +     cpuhp_state_remove_instance_nocalls(cpuhp_state, &iommu_pmu->node=
);
> > +     return ret;
> > +}
> > +
> > +static const struct auxiliary_device_id riscv_iommu_pmu_id_table[] =3D=
 {
> > +     { .name =3D "iommu.pmu" },
> > +     {}
> > +};
> > +MODULE_DEVICE_TABLE(auxiliary, riscv_iommu_pmu_id_table);
> > +
> > +static struct auxiliary_driver iommu_pmu_driver =3D {
> > +     .probe          =3D riscv_iommu_pmu_probe,
> > +     .id_table       =3D riscv_iommu_pmu_id_table,
> > +};
> > +
> > +static int __init riscv_iommu_pmu_init(void)
> > +{
> > +     int ret;
> > +
> > +     cpuhp_state =3D cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> > +                                           "perf/riscv/iommu:online",
> > +                                           riscv_iommu_pmu_online_cpu,
> > +                                           riscv_iommu_pmu_offline_cpu=
);
> > +     if (cpuhp_state < 0)
> > +             return cpuhp_state;
> > +
> > +     ret =3D auxiliary_driver_register(&iommu_pmu_driver);
> > +     if (ret)
> > +             cpuhp_remove_multi_state(cpuhp_state);
> > +
> > +     return ret;
> > +}
> > +module_init(riscv_iommu_pmu_init);
> > +
> > +MODULE_DESCRIPTION("RISC-V IOMMU PMU");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.43.7
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
