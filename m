Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD92220687
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Jul 2026 01:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783042626; cv=pass; b=RmdrPPpr4DfG8HAIBUX7JlutJZ41/FGoyJb4sKhejgshEUTUNdqaXBktYtMCIs71ytcPvp361ObEtljlDJADFDuTVLxi4UR8ePTFib/e1gGzJ+duOWZvx/EYYod0ccbshzUnzG/bMmk1kF5pImSppOhkbLL7WTbUIuDrdFrOlvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783042626; c=relaxed/simple;
	bh=z4od7SNhlWY+RZkvoMJsMuNRsa3OQrdg0Ubg2TmR8/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJKRNQD26rJ0xw4nVZaNGM/jGox3+QCpiZPLsuO2KVgcG8axTN8tPM9HqwMLsxDXEcJWcYmoG2b/bDn+e4dG4cXGcBMKLGjcwKTP544GJSCpgdOTgKpA0n0XnZxJc2uXfDXBWcHR+cfCdNZeWoFUeHvHsY8aHC1sgcI0H4utbrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=H/yYnZ+z; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="H/yYnZ+z"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-697763eeafcso102332a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Jul 2026 18:37:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783042622; cv=none;
        d=google.com; s=arc-20260327;
        b=UiyWjzDPNatywFUbz3HPDjWhvJip1nT+2V/ZAHDRDz5iZxjsP9pcGglqRpuna+0mw9
         LX6LEwcTmTi2nbUiNpfOe1CkAzoY/jqRPKHpBnkHyykPiXh5pbGUIoSuJpg6CJsPxsW1
         8YNIP3hk9+xkF5da9U70+6DdlJNF1ta9jGDMrHdtEdrV+zJIjaVTqfQ66WxDhylrXs89
         SHX0QLTz1KVRInUBWmimNYtAIbRnHEqzx7fKSJ5nzf30CH/G5jD5sh87WNea/EkcxBGK
         Cv/TgFqHQdteQIUOQ7kpvIDnCAZVQNt18+IFnt8D96iw71aGcTl7n0+9noGRElLNb5Ye
         IFtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aAPlpq9IBVgWjNKJyReiZ+Pn2+7K+rjbG8tom/0THv0=;
        fh=ht0mwYAlJBVk+lOGF1HG9V9y3rCi/yrUbiai0cDuq8w=;
        b=hU9QzumxZnrjpkOwC9+jQxduVSH4dFM9juEEECN0v1BkF2FpgN4ULyIJPZBVKb4CGa
         0BLq/MxHlk6cJY9E8GSX/j50Ap2nMsf+RpqKuOy1aW0DCw10NVnaohol/z4N1hS0hveE
         wJ/vhwCuvUoGQLtcEZBaCyf3pWT0CJzzcCYdX1aBermJnSGrWO9HuYN890hSjXEMgH/w
         HtN2kNfrQg75gbAd1vyjAEHvI1l7JCyWjynmER6mTFoK0WBJ0reKl3YU0Bwco0ruKn08
         xxG3z+2cZbfQzwxyc0EH5FuAb6yBtuZVuaPZWyTsyCI3mCscXCG1/D3/Y+alVTFSocu4
         OiUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1783042622; x=1783647422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAPlpq9IBVgWjNKJyReiZ+Pn2+7K+rjbG8tom/0THv0=;
        b=H/yYnZ+z2DOSp3U456E+PztgT7VfJlZ+cByxqabdPipM5BVKsC0SERrNQ2WxMp0LTt
         QTyJmswm3g1y+yZSxsmnw0OReC445mCnLGnyM0Q+Fqnwzkh4EY68DaCW4Ew93vys/8X/
         34mi6iBpTovxs6w4kKk5YKu2evAeOyx2JPIm5lm3xfMJw9Jphw2hm9UJ5qCSVcmMRgUG
         5917gkpu9u31YDPtHYIpvIe2mY7G/dyMV6X3+qC4Sbpr8GQBcZm15y2JHWjFwFMJz3Aw
         sjKE+i6rtDvUk43e4Keh3oi6ojVqrNiArYMyV/KpjoIxZCnMjm4eig+9d1dWz/ZUvD4P
         043Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783042622; x=1783647422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aAPlpq9IBVgWjNKJyReiZ+Pn2+7K+rjbG8tom/0THv0=;
        b=ebq13tdMmW8Hk7OWB7Ikg4Ie8U7jExiITbfkjJjKvWhXoz9y/OfDedP/YWqxv6HnKN
         CstbQYzuzXIonIlaQkUxKT+niUjiyU4YBpxwwB1zU2UqcAlcsUA0lWzXM10TlSFG0wJa
         DLCFsfv1ZqfjH0JL+xk3VY/6NQ/+gOFBJmFTc6eTcFokLprX4ZibNip6BQe0EHsKOz72
         j88Q4sgpxyMQ8zayBr9Aqn1OVN8ai0gqKe6qnY84kBgoAsuSk+fiFF6fYjtftu6ZdzGM
         s9N4L0WBtNVDFDNYuq/cmEe8Bj0XhTxOxu3ZfL3iv6AAITuEgix8h/sNb2sP2h1+ubNZ
         t8Ew==
X-Forwarded-Encrypted: i=1; AHgh+RplunVZQYdV474lZjvAcfDdDAZYhVFFmDt9Qse/HT7/A7lm23Eqa3qv9kZYuhiRIQ9S55cMSO1IGgk9SMKZatFY@vger.kernel.org
X-Gm-Message-State: AOJu0YwQMNt0vFMrvGsb0rhxe8qtyp2opyxMcJZxdoMq4gSooVYDTILl
	p8yniApKmaOZUkiTHvbhRmdOISgN/huPwcz/glpy44tzcF5KdkEyDruuXzAMZ+xRRwwCsI3ifK9
	+pSQKykEt+2iHQCMqz2rvAOY8eAfek5s4pcNySMnybg==
X-Gm-Gg: AfdE7cnuHpiNACCWB0K0xsKnUvAaSxq/Jo8MTnLB+uQjuDrjX3x5/Cyphn8gTpCx/To
	xAmMk5ebw52QpaWLzKJUEyqR+yC5G9oKp/j4Iji3Rw1wrNJdffixMpUqMujaxGiNPV3BV6jerDw
	JFzjLEJXBUik7xxyFVoA2vHIDjBIu2P82zMSewReahd4rtSXtBR1sOjjHKlL6v/DnEC8vbt4bI4
	b+qLSVKJ1mQgzG3yYKBcwKk/ht8YzaoIDKq5cWC12KQTnAObAmuGRkJVD+6aGeDC1nJGGE2lkI=
X-Received: by 2002:a05:6402:a159:b0:697:add3:a274 with SMTP id
 4fb4d7f45d1cf-698a2c7e349mr2329191a12.15.1783042622233; Thu, 02 Jul 2026
 18:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630083833.1275837-1-zong.li@sifive.com> <20260630083833.1275837-2-zong.li@sifive.com>
 <CAJF2gTTHnv3-JqWEZFbxmvkqWERsgRz5ecZOFFnieTicAODtQw@mail.gmail.com>
In-Reply-To: <CAJF2gTTHnv3-JqWEZFbxmvkqWERsgRz5ecZOFFnieTicAODtQw@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 3 Jul 2026 09:36:50 +0800
X-Gm-Features: AVVi8Cf22uJVfMNDwPQj9m_Ifdr3nDyNWv4o56wzL61DPTwG6z37I62HqyiJHE8
Message-ID: <CANXhq0p6g+cgky8rt0p0NZgyA7=q7ZQ3BSXwSUnTamvS_jc=rg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu driver
To: Guo Ren <guoren@kernel.org>
Cc: tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, mark.rutland@arm.com, 
	andrew.jones@oss.qualcomm.com, david.laight.linux@gmail.com, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 9:17=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> Hi Zong Li,
>
> On Tue, Jun 30, 2026 at 4:38=E2=80=AFPM Zong Li <zong.li@sifive.com> wrot=
e:
> >
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
> > Suggested-by: David Laight <david.laight.linux@gmail.com>
> > Suggested-by: Guo Ren <guoren@kernel.org>
> > Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpk=
in/
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/iommu/riscv/iommu-bits.h |  61 ---
> >  drivers/perf/Kconfig             |  12 +
> >  drivers/perf/Makefile            |   1 +
> >  drivers/perf/riscv_iommu_pmu.c   | 703 +++++++++++++++++++++++++++++++
> >  4 files changed, 716 insertions(+), 61 deletions(-)
> >  create mode 100644 drivers/perf/riscv_iommu_pmu.c
> >
> > diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iom=
mu-bits.h
> > index f2ef9bd3cde9..6b5de913a032 100644
> > --- a/drivers/iommu/riscv/iommu-bits.h
> > +++ b/drivers/iommu/riscv/iommu-bits.h
> > @@ -192,67 +192,6 @@ enum riscv_iommu_ddtp_modes {
> >  #define RISCV_IOMMU_IPSR_PMIP          BIT(RISCV_IOMMU_INTR_PM)
> >  #define RISCV_IOMMU_IPSR_PIP           BIT(RISCV_IOMMU_INTR_PQ)
> >
> > -/* 5.19 Performance monitoring counter overflow status (32bits) */
> > -#define RISCV_IOMMU_REG_IOCOUNTOVF     0x0058
> > -#define RISCV_IOMMU_IOCOUNTOVF_CY      BIT(0)
> > -#define RISCV_IOMMU_IOCOUNTOVF_HPM     GENMASK_ULL(31, 1)
> > -
> > -/* 5.20 Performance monitoring counter inhibits (32bits) */
> > -#define RISCV_IOMMU_REG_IOCOUNTINH     0x005C
> > -#define RISCV_IOMMU_IOCOUNTINH_CY      BIT(0)
> > -#define RISCV_IOMMU_IOCOUNTINH_HPM     GENMASK(31, 1)
> > -
> > -/* 5.21 Performance monitoring cycles counter (64bits) */
> > -#define RISCV_IOMMU_REG_IOHPMCYCLES     0x0060
> > -#define RISCV_IOMMU_IOHPMCYCLES_COUNTER        GENMASK_ULL(62, 0)
> > -#define RISCV_IOMMU_IOHPMCYCLES_OF     BIT_ULL(63)
> > -
> > -/* 5.22 Performance monitoring event counters (31 * 64bits) */
> > -#define RISCV_IOMMU_REG_IOHPMCTR_BASE  0x0068
> > -#define RISCV_IOMMU_REG_IOHPMCTR(_n)   (RISCV_IOMMU_REG_IOHPMCTR_BASE =
+ ((_n) * 0x8))
> > -
> > -/* 5.23 Performance monitoring event selectors (31 * 64bits) */
> > -#define RISCV_IOMMU_REG_IOHPMEVT_BASE  0x0160
> > -#define RISCV_IOMMU_REG_IOHPMEVT(_n)   (RISCV_IOMMU_REG_IOHPMEVT_BASE =
+ ((_n) * 0x8))
> > -#define RISCV_IOMMU_IOHPMEVT_EVENTID   GENMASK_ULL(14, 0)
> > -#define RISCV_IOMMU_IOHPMEVT_DMASK     BIT_ULL(15)
> > -#define RISCV_IOMMU_IOHPMEVT_PID_PSCID GENMASK_ULL(35, 16)
> > -#define RISCV_IOMMU_IOHPMEVT_DID_GSCID GENMASK_ULL(59, 36)
> > -#define RISCV_IOMMU_IOHPMEVT_PV_PSCV   BIT_ULL(60)
> > -#define RISCV_IOMMU_IOHPMEVT_DV_GSCV   BIT_ULL(61)
> > -#define RISCV_IOMMU_IOHPMEVT_IDT       BIT_ULL(62)
> > -#define RISCV_IOMMU_IOHPMEVT_OF                BIT_ULL(63)
> > -
> > -/* Number of defined performance-monitoring event selectors */
> > -#define RISCV_IOMMU_IOHPMEVT_CNT       31
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
> > -       RISCV_IOMMU_HPMEVENT_INVALID    =3D 0,
> > -       RISCV_IOMMU_HPMEVENT_URQ        =3D 1,
> > -       RISCV_IOMMU_HPMEVENT_TRQ        =3D 2,
> > -       RISCV_IOMMU_HPMEVENT_ATS_RQ     =3D 3,
> > -       RISCV_IOMMU_HPMEVENT_TLB_MISS   =3D 4,
> > -       RISCV_IOMMU_HPMEVENT_DD_WALK    =3D 5,
> > -       RISCV_IOMMU_HPMEVENT_PD_WALK    =3D 6,
> > -       RISCV_IOMMU_HPMEVENT_S_VS_WALKS =3D 7,
> > -       RISCV_IOMMU_HPMEVENT_G_WALKS    =3D 8,
> > -       RISCV_IOMMU_HPMEVENT_MAX        =3D 9
> > -};
> > -
> >  /* 5.24 Translation request IOVA (64bits) */
> >  #define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
> >  #define RISCV_IOMMU_TR_REQ_IOVA_VPN    GENMASK_ULL(63, 12)
> > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> > index 245e7bb763b9..8cce6c2ea626 100644
> > --- a/drivers/perf/Kconfig
> > +++ b/drivers/perf/Kconfig
> > @@ -105,6 +105,18 @@ config RISCV_PMU_SBI
> >           full perf feature support i.e. counter overflow, privilege mo=
de
> >           filtering, counter configuration.
> >
> > +config RISCV_IOMMU_PMU
> > +       depends on RISCV || COMPILE_TEST
> > +       depends on RISCV_IOMMU
> > +       bool "RISC-V IOMMU Hardware Performance Monitor"
> > +       default y
> > +       help
> > +         Say Y if you want to use the RISC-V IOMMU performance monitor
> > +         implementation. The performance monitor is an optional hardwa=
re
> > +         feature, and whether it is actually enabled depends on IOMMU
> > +         hardware support. If the underlying hardware does not impleme=
nt
> > +         the PMU, this option will have no effect.
> > +
> >  config STARFIVE_STARLINK_PMU
> >         depends on ARCH_STARFIVE || COMPILE_TEST
> >         depends on 64BIT
> > diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> > index eb8a022dad9a..90c75f3c0ac1 100644
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
> > index 000000000000..2e856289ddc9
> > --- /dev/null
> > +++ b/drivers/perf/riscv_iommu_pmu.c
> > @@ -0,0 +1,703 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2026 SiFive
> > + *
> > + * Authors
> > + *     Zong Li <zong.li@sifive.com>
> > + */
> > +
> > +#include <linux/auxiliary_bus.h>
> > +#include <linux/io-64-nonatomic-hi-lo.h>
> > +#include <linux/perf_event.h>
> > +
> > +#include "../iommu/riscv/iommu.h"
> > +
> > +/* 5.19 Performance monitoring counter overflow status (32bits) */
> > +#define RISCV_IOMMU_REG_IOCOUNTOVF     0x0058
> > +#define RISCV_IOMMU_IOCOUNTOVF_CY      BIT(0)
> > +#define RISCV_IOMMU_IOCOUNTOVF_HPM     GENMASK_ULL(31, 1)
> > +
> > +/* 5.20 Performance monitoring counter inhibits (32bits) */
> > +#define RISCV_IOMMU_REG_IOCOUNTINH     0x005C
> > +#define RISCV_IOMMU_IOCOUNTINH_CY      BIT(0)
> > +#define RISCV_IOMMU_IOCOUNTINH_HPM     GENMASK(31, 0)
> > +
> > +/* 5.21 Performance monitoring cycles counter (64bits) */
> > +#define RISCV_IOMMU_REG_IOHPMCYCLES    0x0060
> > +#define RISCV_IOMMU_IOHPMCYCLES_COUNTER        GENMASK_ULL(62, 0)
> > +#define RISCV_IOMMU_IOHPMCYCLES_OF     BIT_ULL(63)
> > +#define RISCV_IOMMU_REG_IOHPMCTR(_n)   (RISCV_IOMMU_REG_IOHPMCYCLES + =
((_n) * 0x8))
> > +
> > +/* 5.22 Performance monitoring event counters (31 * 64bits) */
> > +#define RISCV_IOMMU_REG_IOHPMCTR_BASE  0x0068
> > +#define RISCV_IOMMU_IOHPMCTR_COUNTER   GENMASK_ULL(63, 0)
> > +
> > +/* 5.23 Performance monitoring event selectors (31 * 64bits) */
> > +#define RISCV_IOMMU_REG_IOHPMEVT_BASE  0x0160
> > +#define RISCV_IOMMU_REG_IOHPMEVT(_n)   (RISCV_IOMMU_REG_IOHPMEVT_BASE =
+ ((_n) * 0x8))
> > +#define RISCV_IOMMU_IOHPMEVT_EVENTID   GENMASK_ULL(14, 0)
> > +#define RISCV_IOMMU_IOHPMEVT_DMASK     BIT_ULL(15)
> > +#define RISCV_IOMMU_IOHPMEVT_PID_PSCID GENMASK_ULL(35, 16)
> > +#define RISCV_IOMMU_IOHPMEVT_DID_GSCID GENMASK_ULL(59, 36)
> > +#define RISCV_IOMMU_IOHPMEVT_PV_PSCV   BIT_ULL(60)
> > +#define RISCV_IOMMU_IOHPMEVT_DV_GSCV   BIT_ULL(61)
> > +#define RISCV_IOMMU_IOHPMEVT_IDT       BIT_ULL(62)
> > +#define RISCV_IOMMU_IOHPMEVT_OF                BIT_ULL(63)
> > +#define RISCV_IOMMU_IOHPMEVT_EVENT     GENMASK_ULL(62, 0)
> > +
> > +/* The total number of counters is 31 event counters plus 1 cycle coun=
ter */
> > +#define RISCV_IOMMU_HPM_COUNTER_NUM    32
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
> > +       RISCV_IOMMU_HPMEVENT_CYCLE      =3D 0,
> > +       RISCV_IOMMU_HPMEVENT_URQ        =3D 1,
> > +       RISCV_IOMMU_HPMEVENT_TRQ        =3D 2,
> > +       RISCV_IOMMU_HPMEVENT_ATS_RQ     =3D 3,
> > +       RISCV_IOMMU_HPMEVENT_TLB_MISS   =3D 4,
> > +       RISCV_IOMMU_HPMEVENT_DD_WALK    =3D 5,
> > +       RISCV_IOMMU_HPMEVENT_PD_WALK    =3D 6,
> > +       RISCV_IOMMU_HPMEVENT_S_VS_WALKS =3D 7,
> > +       RISCV_IOMMU_HPMEVENT_G_WALKS    =3D 8,
> > +       RISCV_IOMMU_HPMEVENT_MAX        =3D 9
> > +};
> > +
> > +struct riscv_iommu_pmu {
> > +       struct pmu pmu;
> > +       struct hlist_node node;
> > +       void __iomem *reg;
> > +       unsigned int on_cpu;
> > +       int num_counters;
> > +       u64 cycle_cntr_mask;
> > +       u64 event_cntr_mask;
> > +       struct perf_event *events[RISCV_IOMMU_HPM_COUNTER_NUM];
> > +       DECLARE_BITMAP(used_counters, RISCV_IOMMU_HPM_COUNTER_NUM);
> > +       u32 hi_prev[RISCV_IOMMU_HPM_COUNTER_NUM];
> > +       u32 lo_prev[RISCV_IOMMU_HPM_COUNTER_NUM];
> > +};
> > +
> > +#define to_riscv_iommu_pmu(p) (container_of(p, struct riscv_iommu_pmu,=
 pmu))
> > +
> > +#define RISCV_IOMMU_PMU_ATTR_EXTRACTOR(_name, _mask)                  =
 \
> > +       static inline u32 get_##_name(struct perf_event *event)        =
 \
> > +       {                                                              =
 \
> > +               return FIELD_GET(_mask, event->attr.config);           =
 \
> > +       }                                                              =
 \
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
> > +       &format_attr_event.attr,
> > +       &format_attr_partial_matching.attr,
> > +       &format_attr_pid_pscid.attr,
> > +       &format_attr_did_gscid.attr,
> > +       &format_attr_filter_pid_pscid.attr,
> > +       &format_attr_filter_did_gscid.attr,
> > +       &format_attr_filter_id_type.attr,
> > +       NULL,
> > +};
> > +
> > +static const struct attribute_group riscv_iommu_pmu_format_group =3D {
> > +       .name =3D "format",
> > +       .attrs =3D riscv_iommu_pmu_formats,
> > +};
> > +
> > +/* Events */
> > +static ssize_t riscv_iommu_pmu_event_show(struct device *dev,
> > +                                         struct device_attribute *attr=
,
> > +                                         char *page)
> > +{
> > +       struct perf_pmu_events_attr *pmu_attr;
> > +
> > +       pmu_attr =3D container_of(attr, struct perf_pmu_events_attr, at=
tr);
> > +
> > +       return sysfs_emit(page, "event=3D0x%02llx\n", pmu_attr->id);
> > +}
> > +
> > +#define RISCV_IOMMU_PMU_EVENT_ATTR(name, id)                   \
> > +       PMU_EVENT_ATTR_ID(name, riscv_iommu_pmu_event_show, id)
> > +
> > +static struct attribute *riscv_iommu_pmu_events[] =3D {
> > +       RISCV_IOMMU_PMU_EVENT_ATTR(cycle, RISCV_IOMMU_HPMEVENT_CYCLE),
> > +       RISCV_IOMMU_PMU_EVENT_ATTR(untranslated_req, RISCV_IOMMU_HPMEVE=
NT_URQ),
> > +       RISCV_IOMMU_PMU_EVENT_ATTR(translated_req, RISCV_IOMMU_HPMEVENT=
_TRQ),
> > +       RISCV_IOMMU_PMU_EVENT_ATTR(ats_trans_req, RISCV_IOMMU_HPMEVENT_=
ATS_RQ),
> > +       RISCV_IOMMU_PMU_EVENT_ATTR(tlb_miss, RISCV_IOMMU_HPMEVENT_TLB_M=
ISS),
> > +       RISCV_IOMMU_PMU_EVENT_ATTR(ddt_walks, RISCV_IOMMU_HPMEVENT_DD_W=
ALK),
> > +       RISCV_IOMMU_PMU_EVENT_ATTR(pdt_walks, RISCV_IOMMU_HPMEVENT_PD_W=
ALK),
> > +       RISCV_IOMMU_PMU_EVENT_ATTR(s_vs_pt_walks, RISCV_IOMMU_HPMEVENT_=
S_VS_WALKS),
> > +       RISCV_IOMMU_PMU_EVENT_ATTR(g_pt_walks, RISCV_IOMMU_HPMEVENT_G_W=
ALKS),
> > +       NULL,
> > +};
> > +
> > +static const struct attribute_group riscv_iommu_pmu_events_group =3D {
> > +       .name =3D "events",
> > +       .attrs =3D riscv_iommu_pmu_events,
> > +};
> > +
> > +/* cpumask */
> > +static ssize_t riscv_iommu_cpumask_show(struct device *dev,
> > +                                       struct device_attribute *attr,
> > +                                       char *buf)
> > +{
> > +       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(dev_get_drvd=
ata(dev));
> > +
> > +       return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->on_cp=
u));
> > +}
> > +
> > +static struct device_attribute riscv_iommu_cpumask_attr =3D
> > +       __ATTR(cpumask, 0444, riscv_iommu_cpumask_show, NULL);
> > +
> > +static struct attribute *riscv_iommu_cpumask_attrs[] =3D {
> > +       &riscv_iommu_cpumask_attr.attr,
> > +       NULL
> > +};
> > +
> > +static const struct attribute_group riscv_iommu_pmu_cpumask_group =3D =
{
> > +       .attrs =3D riscv_iommu_cpumask_attrs,
> > +};
> > +
> > +static const struct attribute_group *riscv_iommu_pmu_attr_grps[] =3D {
> > +       &riscv_iommu_pmu_cpumask_group,
> > +       &riscv_iommu_pmu_format_group,
> > +       &riscv_iommu_pmu_events_group,
> > +       NULL,
> > +};
> > +
> > +/* PMU Operations */
> > +static void riscv_iommu_pmu_set_counter(struct riscv_iommu_pmu *pmu, u=
32 idx,
> > +                                       u64 value)
> > +{
> > +       u64 counter_mask =3D idx ? pmu->event_cntr_mask : pmu->cycle_cn=
tr_mask;
> > +
> > +       writeq(value & counter_mask, pmu->reg + RISCV_IOMMU_REG_IOHPMCT=
R(idx));
> #include <include/linux/io-64-nonatomic-lo-hi.h>
> lo_hi_writeq(value & counter_mask, pmu->reg + RISCV_IOMMU_REG_IOHPMCTR(id=
x));
>
> For better compatibility, it is recommended to use writel and readl
> instead of readq and writeq. Sorry for overlooking this last time =E2=80=
=94
> could you please make the change again?
> In the future, your driver could support RV32 directly, as the RISC-V
> IOMMU specification also supports RV32; it's just that the current
> RISC-V IOMMU driver's Kconfig depends on 64BIT.

Hi Guo,
Thank you for your review. In my implementation for RV32, readq and
writeq are replaced by hi_lo_readq and hi_lo_writeq (from
io-64-nonatomic-hi-lo.h). So, supporting RV32 should be fine.
However, as you mentioned before: 64-bit access might be undefined on
some hardware. To be safe and compatible with all hardware, we should
use 32-bit access instead of 64-bit access.
I will modify them in the next version

I'd like to make sure I didn't miss anything important. My original
code uses the "hi-lo" order. May I ask if there is a specific reason
why you prefer the "lo-hi" order?
Thanks

>
> > +}
> > +
> > +/*
> > + * As stated in the RISC-V IOMMU Specification, Chapter 6:
> > + * Whether an 8 byte access to an IOMMU register is single-copy atomic
> > + * is UNSPECIFIED, and such an access may appear, internally to the
> > + * IOMMU, as if two separate 4 byte accesses -=E2=80=89first to the hi=
gh half
> > + * and second to the low half=E2=80=89-=E2=80=89were performed
> > + *
> > + * To make sure the driver works correctly on different hardware,
> > + * the software will always use two 4-byte access for the counter.
> > + *
> > + * This function implements the hi-lo-hi pattern to detect and handle
> > + * wraparound during the read operation:
> > + *   1. Read high half (hi)
> > + *   2. Read low half (lo)
> > + *   3. Check if low half wrapped or high half changed:
> > + *      - If lo <=3D lo_prev: possible wraparound occurred
> > + *      - If hi !=3D hi_prev: high half changed during read
> > + *   4. If wraparound detected, re-read high half and assume low half =
is 0
> > + *   5. Update previous values for next read
> > + */
> > +static u64 riscv_iommu_pmu_get_counter(struct riscv_iommu_pmu *pmu, u3=
2 idx)
> > +{
> > +       void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOHPMCTR(idx)=
;
> > +       u64 value, counter_mask =3D idx ? pmu->event_cntr_mask : pmu->c=
ycle_cntr_mask;
> > +       u32 hi, lo;
> > +
> > +       hi =3D readl(addr + 4);
> > +       lo =3D readl(addr);
> > +
> > +       if (lo <=3D pmu->lo_prev[idx] || hi !=3D pmu->hi_prev[idx]) {
> > +               u32 hi_tmp =3D readl(addr + 4);
> > +
> > +               /*
> > +                * If hi changes, then hi+1:0 must have happened while
> > +                * the code was running so it is a safe return value
> > +                */
> > +               if (hi_tmp !=3D hi) {
> > +                       hi =3D hi_tmp;
> > +                       lo =3D 0;
> > +               }
> > +               pmu->lo_prev[idx] =3D ~0u;
> > +               pmu->hi_prev[idx] =3D hi;
> > +       }
> > +       pmu->lo_prev[idx] =3D lo;
> > +
> > +       value =3D (((u64)hi << 32) | lo) & counter_mask;
> > +
> > +       /* The bit 63 of cycle counter (i.e., idx =3D=3D 0) is OF bit *=
/
> > +       return idx ? value : (value & ~RISCV_IOMMU_IOHPMCYCLES_OF);
> > +}
> Yes! Thanks for your implementation.
>
> > +
> > +static bool is_cycle_event(u64 event)
> > +{
> > +       return event =3D=3D RISCV_IOMMU_HPMEVENT_CYCLE;
> > +}
> > +
> > +static void riscv_iommu_pmu_set_event(struct riscv_iommu_pmu *pmu, u32=
 idx,
> > +                                     u64 value)
> > +{
> > +       /* There is no associtated IOHPMEVT0 for IOHPMCYCLES */
> > +       if (is_cycle_event(value))
> > +               return;
> > +
> > +       /* Event counter start from idx 1 */
> > +       writeq(FIELD_GET(RISCV_IOMMU_IOHPMEVT_EVENT, value),
> > +              pmu->reg + RISCV_IOMMU_REG_IOHPMEVT(idx - 1));
>        lo_hi_writeq(FIELD_GET(RISCV_IOMMU_IOHPMEVT_EVENT, value),
>               pmu->reg + RISCV_IOMMU_REG_IOHPMEVT(idx - 1));
>
> > +}
> > +
> > +static void riscv_iommu_pmu_enable_counter(struct riscv_iommu_pmu *pmu=
, u32 idx)
> > +{
> > +       void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> > +       u32 value =3D readl(addr);
> > +
> > +       writel(value & ~BIT(idx), addr);
> > +}
> > +
> > +static void riscv_iommu_pmu_disable_counter(struct riscv_iommu_pmu *pm=
u, u32 idx)
> > +{
> > +       void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> > +       u32 value =3D readl(addr);
> > +
> > +       writel(value | BIT(idx), addr);
> > +}
> > +
> > +static void riscv_iommu_pmu_start_all(struct riscv_iommu_pmu *pmu)
> > +{
> > +       void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> > +       u32 used_cntr =3D 0;
> > +
> > +       /* The performance-monitoring counter inhibits is a 32-bit WARL=
 register */
> > +       bitmap_to_arr32(&used_cntr, pmu->used_counters, pmu->num_counte=
rs);
> > +
> > +       writel(~used_cntr, addr);
> > +}
> > +
> > +static void riscv_iommu_pmu_stop_all(struct riscv_iommu_pmu *pmu)
> > +{
> > +       writel(GENMASK_ULL(pmu->num_counters - 1, 0),
> > +              pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH);
> > +}
> > +
> > +/* PMU APIs */
> > +static void riscv_iommu_pmu_set_period(struct perf_event *event)
> > +{
> > +       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +       struct hw_perf_event *hwc =3D &event->hw;
> > +       u64 counter_mask =3D hwc->idx ? pmu->event_cntr_mask : pmu->cyc=
le_cntr_mask;
> > +       u64 period;
> > +
> > +       /*
> > +        * Limit the maximum period to prevent the counter value
> > +        * from overtaking the one we are about to program.
> > +        * In effect we are reducing max_period to account for
> > +        * interrupt latency (and we are being very conservative).
> > +        */
> > +       period =3D counter_mask >> 1;
> > +       riscv_iommu_pmu_set_counter(pmu, hwc->idx, period);
> > +       local64_set(&hwc->prev_count, period);
> > +}
> > +
> > +static int riscv_iommu_pmu_event_init(struct perf_event *event)
> > +{
> > +       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +       struct hw_perf_event *hwc =3D &event->hw;
> > +       struct perf_event *sibling;
> > +       int total_event_counters =3D pmu->num_counters - 1;
> > +       int counters =3D 0;
> > +
> > +       if (event->attr.type !=3D event->pmu->type)
> > +               return -ENOENT;
> > +
> > +       if (hwc->sample_period)
> > +               return -EOPNOTSUPP;
> > +
> > +       if (event->cpu < 0)
> > +               return -EOPNOTSUPP;
> > +
> > +       event->cpu =3D pmu->on_cpu;
> > +
> > +       hwc->idx =3D -1;
> > +       hwc->config =3D event->attr.config;
> > +
> > +       if (event->group_leader =3D=3D event)
> > +               return 0;
> > +
> > +       if (is_cycle_event(get_event(event->group_leader)))
> > +               if (++counters > total_event_counters)
> > +                       return -EINVAL;
> > +
> > +       for_each_sibling_event(sibling, event->group_leader) {
> > +               if (is_cycle_event(get_event(sibling)))
> > +                       continue;
> > +
> > +               if (sibling->pmu !=3D event->pmu && !is_software_event(=
sibling))
> > +                       return -EINVAL;
> > +
> > +               if (++counters > total_event_counters)
> > +                       return -EINVAL;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void riscv_iommu_pmu_update(struct perf_event *event)
> > +{
> > +       struct hw_perf_event *hwc =3D &event->hw;
> > +       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +       u64 delta, prev, now;
> > +       u32 idx =3D hwc->idx;
> > +       u64 counter_mask =3D idx ? pmu->event_cntr_mask : pmu->cycle_cn=
tr_mask;
> > +
> > +       do {
> > +               prev =3D local64_read(&hwc->prev_count);
> > +               now =3D riscv_iommu_pmu_get_counter(pmu, idx);
> > +       } while (local64_cmpxchg(&hwc->prev_count, prev, now) !=3D prev=
);
> > +
> > +       delta =3D (now - prev) & counter_mask;
> > +       local64_add(delta, &event->count);
> > +}
> > +
> > +static void riscv_iommu_pmu_start(struct perf_event *event, int flags)
> > +{
> > +       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +       struct hw_perf_event *hwc =3D &event->hw;
> > +
> > +       if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
> > +               return;
> > +
> > +       if (flags & PERF_EF_RELOAD)
> > +               WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
> > +
> > +       hwc->state =3D 0;
> > +       riscv_iommu_pmu_set_period(event);
> > +       riscv_iommu_pmu_set_event(pmu, hwc->idx, hwc->config);
> > +       riscv_iommu_pmu_enable_counter(pmu, hwc->idx);
> > +
> > +       perf_event_update_userpage(event);
> > +}
> > +
> > +static void riscv_iommu_pmu_stop(struct perf_event *event, int flags)
> > +{
> > +       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +       struct hw_perf_event *hwc =3D &event->hw;
> > +       int idx =3D hwc->idx;
> > +
> > +       if (hwc->state & PERF_HES_STOPPED)
> > +               return;
> > +
> > +       riscv_iommu_pmu_disable_counter(pmu, idx);
> > +
> > +       if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODAT=
E))
> > +               riscv_iommu_pmu_update(event);
> > +
> > +       hwc->state |=3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> > +}
> > +
> > +static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
> > +{
> > +       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +       struct hw_perf_event *hwc =3D &event->hw;
> > +       unsigned int num_counters =3D pmu->num_counters;
> > +       int idx;
> > +
> > +       /* Reserve index zero for iohpmcycles */
> > +       if (is_cycle_event(get_event(event)))
> > +               idx =3D 0;
> > +       else
> > +               idx =3D find_next_zero_bit(pmu->used_counters, num_coun=
ters, 1);
> > +
> > +       /* All event counters or cycle counter are in use */
> > +       if (idx =3D=3D num_counters || pmu->events[idx])
> > +               return -EAGAIN;
> > +
> > +       set_bit(idx, pmu->used_counters);
> > +
> > +       pmu->events[idx] =3D event;
> > +       hwc->idx =3D idx;
> > +       hwc->state =3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> > +       local64_set(&hwc->prev_count, 0);
> > +
> > +       if (flags & PERF_EF_START)
> > +               riscv_iommu_pmu_start(event, flags);
> > +
> > +       /* Propagate changes to the userspace mapping. */
> > +       perf_event_update_userpage(event);
> > +
> > +       return 0;
> > +}
> > +
> > +static void riscv_iommu_pmu_read(struct perf_event *event)
> > +{
> > +       riscv_iommu_pmu_update(event);
> > +}
> > +
> > +static void riscv_iommu_pmu_del(struct perf_event *event, int flags)
> > +{
> > +       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +       struct hw_perf_event *hwc =3D &event->hw;
> > +       int idx =3D hwc->idx;
> > +
> > +       riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
> > +       pmu->events[idx] =3D NULL;
> > +       clear_bit(idx, pmu->used_counters);
> > +
> > +       perf_event_update_userpage(event);
> > +}
> > +
> > +static int riscv_iommu_pmu_online_cpu(unsigned int cpu, struct hlist_n=
ode *node)
> > +{
> > +       struct riscv_iommu_pmu *iommu_pmu;
> > +
> > +       iommu_pmu =3D hlist_entry_safe(node, struct riscv_iommu_pmu, no=
de);
> > +
> > +       if (iommu_pmu->on_cpu =3D=3D -1)
> > +               iommu_pmu->on_cpu =3D cpu;
> > +
> > +       return 0;
> > +}
> > +
> > +static int riscv_iommu_pmu_offline_cpu(unsigned int cpu, struct hlist_=
node *node)
> > +{
> > +       struct riscv_iommu_pmu *iommu_pmu;
> > +       unsigned int target_cpu;
> > +
> > +       iommu_pmu =3D hlist_entry_safe(node, struct riscv_iommu_pmu, no=
de);
> > +
> > +       if (cpu !=3D iommu_pmu->on_cpu)
> > +               return 0;
> > +
> > +       iommu_pmu->on_cpu =3D -1;
> > +
> > +       target_cpu =3D cpumask_any_but(cpu_online_mask, cpu);
> > +       if (target_cpu >=3D nr_cpu_ids)
> > +               return 0;
> > +
> > +       perf_pmu_migrate_context(&iommu_pmu->pmu, cpu, target_cpu);
> > +       iommu_pmu->on_cpu =3D target_cpu;
> > +
> > +       return 0;
> > +}
> > +
> > +static irqreturn_t riscv_iommu_pmu_handle_irq(struct riscv_iommu_pmu *=
pmu)
> > +{
> > +       u32 ovf =3D readl(pmu->reg + RISCV_IOMMU_REG_IOCOUNTOVF);
> > +       int idx;
> > +
> > +       if (!ovf)
> > +               return IRQ_NONE;
> > +
> > +       riscv_iommu_pmu_stop_all(pmu);
> > +
> > +       for_each_set_bit(idx, (unsigned long *)&ovf, pmu->num_counters)=
 {
> > +               struct perf_event *event =3D pmu->events[idx];
> > +
> > +               if (WARN_ON_ONCE(!event))
> > +                       continue;
> > +
> > +               riscv_iommu_pmu_update(event);
> > +               riscv_iommu_pmu_set_period(event);
> > +       }
> > +
> > +       riscv_iommu_pmu_start_all(pmu);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t riscv_iommu_pmu_irq_handler(int irq, void *dev_id)
> > +{
> > +       struct riscv_iommu_pmu *pmu =3D (struct riscv_iommu_pmu *)dev_i=
d;
> > +       irqreturn_t ret;
> > +
> > +       /* Check whether this interrupt is for PMU */
> > +       if (!(readl_relaxed(pmu->reg + RISCV_IOMMU_REG_IPSR) & RISCV_IO=
MMU_IPSR_PMIP))
> > +               return IRQ_NONE;
> > +
> > +       /* Process PMU IRQ */
> > +       ret =3D riscv_iommu_pmu_handle_irq(pmu);
> > +
> > +       /* Clear performance monitoring interrupt pending bit */
> > +       writel_relaxed(RISCV_IOMMU_IPSR_PMIP, pmu->reg + RISCV_IOMMU_RE=
G_IPSR);
> > +
> > +       return ret;
> > +}
> > +
> > +static unsigned int riscv_iommu_pmu_get_irq_num(struct riscv_iommu_dev=
ice *iommu)
> > +{
> > +       /* Reuse ICVEC.CIV mask for all interrupt vectors mapping */
> > +       int vec =3D (iommu->icvec >> (RISCV_IOMMU_IPSR_PMIP * 4)) & RIS=
CV_IOMMU_ICVEC_CIV;
> > +
> > +       return iommu->irqs[vec];
> > +}
> > +
> > +static int riscv_iommu_pmu_request_irq(struct riscv_iommu_device *iomm=
u,
> > +                                      struct riscv_iommu_pmu *pmu)
> > +{
> > +       unsigned int irq =3D riscv_iommu_pmu_get_irq_num(iommu);
> > +
> > +       /*
> > +        * Set the IRQF_ONESHOT flag because this IRQ can be shared wit=
h
> > +        * other threaded IRQs by other queues.
> > +        */
> > +       return devm_request_irq(iommu->dev, irq, riscv_iommu_pmu_irq_ha=
ndler,
> > +                               IRQF_ONESHOT | IRQF_SHARED, dev_name(io=
mmu->dev), pmu);
> > +}
> > +
> > +static void riscv_iommu_pmu_free_irq(struct riscv_iommu_device *iommu,
> > +                                    struct riscv_iommu_pmu *pmu)
> > +{
> > +       unsigned int irq =3D riscv_iommu_pmu_get_irq_num(iommu);
> > +
> > +       free_irq(irq, pmu);
> > +}
> > +
> > +static int riscv_iommu_pmu_probe(struct auxiliary_device *auxdev,
> > +                                const struct auxiliary_device_id *id)
> > +{
> > +       struct  riscv_iommu_device *iommu_dev =3D dev_get_platdata(&aux=
dev->dev);
> > +       struct riscv_iommu_pmu *iommu_pmu;
> > +       void __iomem *addr;
> > +       char *name;
> > +       int ret;
> > +
> > +       iommu_pmu =3D devm_kzalloc(&auxdev->dev, sizeof(*iommu_pmu), GF=
P_KERNEL);
> > +       if (!iommu_pmu)
> > +               return -ENOMEM;
> > +
> > +       iommu_pmu->reg =3D iommu_dev->reg;
> > +
> > +       /* Counter number and width are hardware-implemented. Detect th=
em by write 1s */
> > +       addr =3D iommu_pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> > +       writel(RISCV_IOMMU_IOCOUNTINH_HPM, addr);
> > +       iommu_pmu->num_counters =3D hweight32(readl(addr));
> > +
> > +       addr =3D iommu_pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;
> > +       writeq(RISCV_IOMMU_IOHPMCYCLES_COUNTER, addr);
>     lo_hi_writeq(RISCV_IOMMU_IOHPMCYCLES_COUNTER, addr);
>
> > +       iommu_pmu->cycle_cntr_mask =3D readq(addr);
> iommu_pmu->cycle_cntr_mask =3D lo_hi_readq(addr);
>
> > +
> > +       /* Assume the width of all event counters are the same */
> > +       addr =3D iommu_pmu->reg + RISCV_IOMMU_REG_IOHPMCTR_BASE;
> > +       writeq(RISCV_IOMMU_IOHPMCTR_COUNTER, addr);
>     lo_hi_writeq(RISCV_IOMMU_IOHPMCTR_COUNTER, addr);
>
> > +       iommu_pmu->event_cntr_mask =3D readq(addr);
>  iommu_pmu->event_cntr_mask =3D lo_hi_readq(addr);
>
> > +
> > +       iommu_pmu->pmu =3D (struct pmu) {
> > +               .module         =3D THIS_MODULE,
> > +               .parent         =3D &auxdev->dev,
> > +               .task_ctx_nr    =3D perf_invalid_context,
> > +               .event_init     =3D riscv_iommu_pmu_event_init,
> > +               .add            =3D riscv_iommu_pmu_add,
> > +               .del            =3D riscv_iommu_pmu_del,
> > +               .start          =3D riscv_iommu_pmu_start,
> > +               .stop           =3D riscv_iommu_pmu_stop,
> > +               .read           =3D riscv_iommu_pmu_read,
> > +               .attr_groups    =3D riscv_iommu_pmu_attr_grps,
> > +               .capabilities   =3D PERF_PMU_CAP_NO_EXCLUDE,
> > +       };
> > +
> > +       auxiliary_set_drvdata(auxdev, iommu_pmu);
> > +
> > +       name =3D devm_kasprintf(&auxdev->dev, GFP_KERNEL,
> > +                             "riscv_iommu_pmu_%s", dev_name(iommu_dev-=
>dev));
> > +       if (!name) {
> > +               dev_err(&auxdev->dev, "Failed to create name riscv_iomm=
u_pmu_%s\n",
> > +                       dev_name(iommu_dev->dev));
> > +               return -ENOMEM;
> > +       }
> > +
> > +       /* Bind all events to the same cpu context to avoid race enabli=
ng */
> > +       iommu_pmu->on_cpu =3D raw_smp_processor_id();
> > +
> > +       ret =3D cpuhp_state_add_instance_nocalls(cpuhp_state, &iommu_pm=
u->node);
> > +       if (ret) {
> > +               dev_err(&auxdev->dev, "Failed to register hotplug %s: %=
d\n", name, ret);
> > +               return ret;
> > +       }
> > +
> > +       ret =3D riscv_iommu_pmu_request_irq(iommu_dev, iommu_pmu);
> > +       if (ret) {
> > +               dev_err(&auxdev->dev, "Failed to request irq %s: %d\n",=
 name, ret);
> > +               goto err_cpuhp_remove;
> > +       }
> > +
> > +       ret =3D perf_pmu_register(&iommu_pmu->pmu, name, -1);
> > +       if (ret) {
> > +               dev_err(&auxdev->dev, "Failed to registe %s: %d\n", nam=
e, ret);
> > +               goto err_free_irq;
> > +       }
> > +
> > +       dev_info(&auxdev->dev, "%s: Registered with %d counters\n",
> > +                name, iommu_pmu->num_counters);
> > +
> > +       return 0;
> > +
> > +err_free_irq:
> > +       riscv_iommu_pmu_free_irq(iommu_dev, iommu_pmu);
> > +err_cpuhp_remove:
> > +       cpuhp_state_remove_instance_nocalls(cpuhp_state, &iommu_pmu->no=
de);
> > +       return ret;
> > +}
> > +
> > +static const struct auxiliary_device_id riscv_iommu_pmu_id_table[] =3D=
 {
> > +       { .name =3D "iommu.pmu" },
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(auxiliary, riscv_iommu_pmu_id_table);
> > +
> > +static struct auxiliary_driver iommu_pmu_driver =3D {
> > +       .probe          =3D riscv_iommu_pmu_probe,
> > +       .id_table       =3D riscv_iommu_pmu_id_table,
> > +};
> > +
> > +static int __init riscv_iommu_pmu_init(void)
> > +{
> > +       int ret;
> > +
> > +       cpuhp_state =3D cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> > +                                             "perf/riscv/iommu:online"=
,
> > +                                             riscv_iommu_pmu_online_cp=
u,
> > +                                             riscv_iommu_pmu_offline_c=
pu);
> > +       if (cpuhp_state < 0)
> > +               return cpuhp_state;
> > +
> > +       ret =3D auxiliary_driver_register(&iommu_pmu_driver);
> > +       if (ret)
> > +               cpuhp_remove_multi_state(cpuhp_state);
> > +
> > +       return ret;
> > +}
> > +module_init(riscv_iommu_pmu_init);
> > +
> > +MODULE_DESCRIPTION("RISC-V IOMMU PMU");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.43.7
> >
>
> --
> Best Regards
>  Guo Ren
