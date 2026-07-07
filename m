Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AC637C902
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jul 2026 05:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783403493; cv=none; b=jOhwaLyQRse4A6WF7e4+vLYNj1RlcE+pjcrAQoiUVE6u9BYfokoqduUC9JD6jqlPGzITctLejPCUsrus441MROsu/ro9vFlYDENkDULh0llYNk0C5TEPjE8JCueNnPeMFh2VdxLUY/6OizT9lb+06HdBfBW1p41zkvYaSjcxzLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783403493; c=relaxed/simple;
	bh=2xyjfPxtOQAl0lgKk38ssyTMTPhkP11TY4Y9gZ4jqm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sA5gj9xbwHcp7w62itd1zNF+rZA3q1wobGDVSys9cVb+pCbKA6TJqpJj4k0JzVom5oUJ75rvzA92pC/0SYqGqLluOe1Kh6ogtL36Z8KVoBmv14CXykZShJcQ1kTFn7g6+p1E97RC/zxL2mugHsb8+G/zs3Bc5AWHcUkzXQk7ZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKTcpaOq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKTcpaOq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687271F000E9
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jul 2026 05:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783403490;
	bh=wxIXF76cRHPy+vLqwihwij+SfLTf1HS5TLMotvT+jhc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oKTcpaOqG/7rq64SkBrSjQa9nnHyl0MjnHlPdspcJ1w2XVcApq7lFPh7FfOPdbioZ
	 SLSnLbxTXhB8bPGPukJYBhUTuy1QPfZnu9L+Ub/K3mtdtcsKJoZgl1+U4E90Lz34TZ
	 Q/env8MhG75e97bhHh+UTIbw7LSqKc3FOoZi9pAX3+aCmMeX2HfB0g1pnC08vlGhrA
	 Qrio3tljItqKZSkUBdjqPbtl7OW673/Se5/hmVxs77ztlxfNyRAY755+JuOrfdrFRZ
	 iOeHeQJEDwFuwJLLKDI8nfwpB10yIlr5Lw9LZZrSM7kCJryRF/IGftSqydUxfw1wGa
	 NbNVKNCEaznvQ==
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c00f74baso23222625e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jul 2026 22:51:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpA7y6zpgN+AHizmZPzNOP4X+HqoZQea0W5GWtG0nuluM01Vwzt706lhJmOUzcsuwsPcgz9GRVgV4KmrE3jWxfB@vger.kernel.org
X-Gm-Message-State: AOJu0YxeofQeCkXzKLNnMG03KGs7bm4alU4qnKGDJ58z4GPBVTaFzTUx
	u6CJY4i8m1b5YcCTFONerUKWcIMFOc1+h7U7Zj4ODJMdPu2i2ug0YI0dzGqi9QNNyNqZPH0AQwk
	iiSq3+1v1x6WwN2SETnImd4cXptDYzIo=
X-Received: by 2002:a05:600c:8b88:b0:492:41c9:886b with SMTP id
 5b1f17b1804b1-493df08b6dbmr37638935e9.14.1783403488989; Mon, 06 Jul 2026
 22:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630083833.1275837-1-zong.li@sifive.com> <20260630083833.1275837-2-zong.li@sifive.com>
 <CAJF2gTTHnv3-JqWEZFbxmvkqWERsgRz5ecZOFFnieTicAODtQw@mail.gmail.com>
 <CANXhq0p6g+cgky8rt0p0NZgyA7=q7ZQ3BSXwSUnTamvS_jc=rg@mail.gmail.com>
 <CANXhq0pP2SJk9N-3SG-A5FL5v9omFxLmLybKsAQowtt=5+gn5Q@mail.gmail.com>
 <CAJF2gTRnepM8b=nD+Ge+mnWsc7W+YCh6i_W7NH+gpZ9cASWcUA@mail.gmail.com> <CANXhq0okNZS6WT=aNTOXj+_fQSucNaj8o1gw82jeQyDA_PVxVw@mail.gmail.com>
In-Reply-To: <CANXhq0okNZS6WT=aNTOXj+_fQSucNaj8o1gw82jeQyDA_PVxVw@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 7 Jul 2026 13:51:15 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSpMpf0Hd6cFUhxVTF-QgEHMY7RX944E7_5ThEehZV96g@mail.gmail.com>
X-Gm-Features: AVVi8CdztTYOWNXKhIQ691Oany2W8B6Z83Bv6fzijQ3T54U4pv4ZWU3JVQJzdbQ
Message-ID: <CAJF2gTSpMpf0Hd6cFUhxVTF-QgEHMY7RX944E7_5ThEehZV96g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu driver
To: Zong Li <zong.li@sifive.com>
Cc: tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, mark.rutland@arm.com, 
	andrew.jones@oss.qualcomm.com, david.laight.linux@gmail.com, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 11:49=E2=80=AFAM Zong Li <zong.li@sifive.com> wrote:
>
> On Tue, Jul 7, 2026 at 10:58=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote=
:
> >
> > On Tue, Jul 7, 2026 at 10:01=E2=80=AFAM Zong Li <zong.li@sifive.com> wr=
ote:
> > >
> > > On Fri, Jul 3, 2026 at 9:36=E2=80=AFAM Zong Li <zong.li@sifive.com> w=
rote:
> > > >
> > > > On Tue, Jun 30, 2026 at 9:17=E2=80=AFPM Guo Ren <guoren@kernel.org>=
 wrote:
> > > > >
> > > > > Hi Zong Li,
> > > > >
> > > > > On Tue, Jun 30, 2026 at 4:38=E2=80=AFPM Zong Li <zong.li@sifive.c=
om> wrote:
> > > > > >
> > > > > > Add a new driver to support the RISC-V IOMMU PMU. This is an au=
xiliary
> > > > > > device driver created by the parent RISC-V IOMMU driver.
> > > > > >
> > > > > > The RISC-V IOMMU PMU separates the cycle counter from the event=
 counters.
> > > > > > The cycle counter is not associated with iohpmevt0, so a softwa=
re-defined
> > > > > > cycle event is required for the perf subsystem.
> > > > > >
> > > > > > The number and width of the counters are hardware-implemented a=
nd must
> > > > > > be detected at runtime.
> > > > > >
> > > > > > The performance monitor provides counters with filtering suppor=
t to
> > > > > > collect events for specific device ID/process ID, or GSCID/PSCI=
D.
> > > > > >
> > > > > > PMU-related definitions are moved into the perf driver, where t=
hey are
> > > > > > used exclusively.
> > > > > >
> > > > > > Suggested-by: David Laight <david.laight.linux@gmail.com>
> > > > > > Suggested-by: Guo Ren <guoren@kernel.org>
> > > > > > Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6=
c5@pumpkin/
> > > > > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > > > > ---
> > > > > >  drivers/iommu/riscv/iommu-bits.h |  61 ---
> > > > > >  drivers/perf/Kconfig             |  12 +
> > > > > >  drivers/perf/Makefile            |   1 +
> > > > > >  drivers/perf/riscv_iommu_pmu.c   | 703 +++++++++++++++++++++++=
++++++++
> > > > > >  4 files changed, 716 insertions(+), 61 deletions(-)
> > > > > >  create mode 100644 drivers/perf/riscv_iommu_pmu.c
> > > > > >
> > > > > > diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/r=
iscv/iommu-bits.h
> > > > > > index f2ef9bd3cde9..6b5de913a032 100644
> > > > > > --- a/drivers/iommu/riscv/iommu-bits.h
> > > > > > +++ b/drivers/iommu/riscv/iommu-bits.h
> > > > > > @@ -192,67 +192,6 @@ enum riscv_iommu_ddtp_modes {
> > > > > >  #define RISCV_IOMMU_IPSR_PMIP          BIT(RISCV_IOMMU_INTR_PM=
)
> > > > > >  #define RISCV_IOMMU_IPSR_PIP           BIT(RISCV_IOMMU_INTR_PQ=
)
> > > > > >
> > > > > > -/* 5.19 Performance monitoring counter overflow status (32bits=
) */
> > > > > > -#define RISCV_IOMMU_REG_IOCOUNTOVF     0x0058
> > > > > > -#define RISCV_IOMMU_IOCOUNTOVF_CY      BIT(0)
> > > > > > -#define RISCV_IOMMU_IOCOUNTOVF_HPM     GENMASK_ULL(31, 1)
> > > > > > -
> > > > > > -/* 5.20 Performance monitoring counter inhibits (32bits) */
> > > > > > -#define RISCV_IOMMU_REG_IOCOUNTINH     0x005C
> > > > > > -#define RISCV_IOMMU_IOCOUNTINH_CY      BIT(0)
> > > > > > -#define RISCV_IOMMU_IOCOUNTINH_HPM     GENMASK(31, 1)
> > > > > > -
> > > > > > -/* 5.21 Performance monitoring cycles counter (64bits) */
> > > > > > -#define RISCV_IOMMU_REG_IOHPMCYCLES     0x0060
> > > > > > -#define RISCV_IOMMU_IOHPMCYCLES_COUNTER        GENMASK_ULL(62,=
 0)
> > > > > > -#define RISCV_IOMMU_IOHPMCYCLES_OF     BIT_ULL(63)
> > > > > > -
> > > > > > -/* 5.22 Performance monitoring event counters (31 * 64bits) */
> > > > > > -#define RISCV_IOMMU_REG_IOHPMCTR_BASE  0x0068
> > > > > > -#define RISCV_IOMMU_REG_IOHPMCTR(_n)   (RISCV_IOMMU_REG_IOHPMC=
TR_BASE + ((_n) * 0x8))
> > > > > > -
> > > > > > -/* 5.23 Performance monitoring event selectors (31 * 64bits) *=
/
> > > > > > -#define RISCV_IOMMU_REG_IOHPMEVT_BASE  0x0160
> > > > > > -#define RISCV_IOMMU_REG_IOHPMEVT(_n)   (RISCV_IOMMU_REG_IOHPME=
VT_BASE + ((_n) * 0x8))
> > > > > > -#define RISCV_IOMMU_IOHPMEVT_EVENTID   GENMASK_ULL(14, 0)
> > > > > > -#define RISCV_IOMMU_IOHPMEVT_DMASK     BIT_ULL(15)
> > > > > > -#define RISCV_IOMMU_IOHPMEVT_PID_PSCID GENMASK_ULL(35, 16)
> > > > > > -#define RISCV_IOMMU_IOHPMEVT_DID_GSCID GENMASK_ULL(59, 36)
> > > > > > -#define RISCV_IOMMU_IOHPMEVT_PV_PSCV   BIT_ULL(60)
> > > > > > -#define RISCV_IOMMU_IOHPMEVT_DV_GSCV   BIT_ULL(61)
> > > > > > -#define RISCV_IOMMU_IOHPMEVT_IDT       BIT_ULL(62)
> > > > > > -#define RISCV_IOMMU_IOHPMEVT_OF                BIT_ULL(63)
> > > > > > -
> > > > > > -/* Number of defined performance-monitoring event selectors */
> > > > > > -#define RISCV_IOMMU_IOHPMEVT_CNT       31
> > > > > > -
> > > > > > -/**
> > > > > > - * enum riscv_iommu_hpmevent_id - Performance-monitoring event=
 identifier
> > > > > > - *
> > > > > > - * @RISCV_IOMMU_HPMEVENT_INVALID: Invalid event, do not count
> > > > > > - * @RISCV_IOMMU_HPMEVENT_URQ: Untranslated requests
> > > > > > - * @RISCV_IOMMU_HPMEVENT_TRQ: Translated requests
> > > > > > - * @RISCV_IOMMU_HPMEVENT_ATS_RQ: ATS translation requests
> > > > > > - * @RISCV_IOMMU_HPMEVENT_TLB_MISS: TLB misses
> > > > > > - * @RISCV_IOMMU_HPMEVENT_DD_WALK: Device directory walks
> > > > > > - * @RISCV_IOMMU_HPMEVENT_PD_WALK: Process directory walks
> > > > > > - * @RISCV_IOMMU_HPMEVENT_S_VS_WALKS: First-stage page table wa=
lks
> > > > > > - * @RISCV_IOMMU_HPMEVENT_G_WALKS: Second-stage page table walk=
s
> > > > > > - * @RISCV_IOMMU_HPMEVENT_MAX: Value to denote maximum Event ID=
s
> > > > > > - */
> > > > > > -enum riscv_iommu_hpmevent_id {
> > > > > > -       RISCV_IOMMU_HPMEVENT_INVALID    =3D 0,
> > > > > > -       RISCV_IOMMU_HPMEVENT_URQ        =3D 1,
> > > > > > -       RISCV_IOMMU_HPMEVENT_TRQ        =3D 2,
> > > > > > -       RISCV_IOMMU_HPMEVENT_ATS_RQ     =3D 3,
> > > > > > -       RISCV_IOMMU_HPMEVENT_TLB_MISS   =3D 4,
> > > > > > -       RISCV_IOMMU_HPMEVENT_DD_WALK    =3D 5,
> > > > > > -       RISCV_IOMMU_HPMEVENT_PD_WALK    =3D 6,
> > > > > > -       RISCV_IOMMU_HPMEVENT_S_VS_WALKS =3D 7,
> > > > > > -       RISCV_IOMMU_HPMEVENT_G_WALKS    =3D 8,
> > > > > > -       RISCV_IOMMU_HPMEVENT_MAX        =3D 9
> > > > > > -};
> > > > > > -
> > > > > >  /* 5.24 Translation request IOVA (64bits) */
> > > > > >  #define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
> > > > > >  #define RISCV_IOMMU_TR_REQ_IOVA_VPN    GENMASK_ULL(63, 12)
> > > > > > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> > > > > > index 245e7bb763b9..8cce6c2ea626 100644
> > > > > > --- a/drivers/perf/Kconfig
> > > > > > +++ b/drivers/perf/Kconfig
> > > > > > @@ -105,6 +105,18 @@ config RISCV_PMU_SBI
> > > > > >           full perf feature support i.e. counter overflow, priv=
ilege mode
> > > > > >           filtering, counter configuration.
> > > > > >
> > > > > > +config RISCV_IOMMU_PMU
> > > > > > +       depends on RISCV || COMPILE_TEST
> > > > > > +       depends on RISCV_IOMMU
> > > > > > +       bool "RISC-V IOMMU Hardware Performance Monitor"
> > > > > > +       default y
> > > > > > +       help
> > > > > > +         Say Y if you want to use the RISC-V IOMMU performance=
 monitor
> > > > > > +         implementation. The performance monitor is an optiona=
l hardware
> > > > > > +         feature, and whether it is actually enabled depends o=
n IOMMU
> > > > > > +         hardware support. If the underlying hardware does not=
 implement
> > > > > > +         the PMU, this option will have no effect.
> > > > > > +
> > > > > >  config STARFIVE_STARLINK_PMU
> > > > > >         depends on ARCH_STARFIVE || COMPILE_TEST
> > > > > >         depends on 64BIT
> > > > > > diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> > > > > > index eb8a022dad9a..90c75f3c0ac1 100644
> > > > > > --- a/drivers/perf/Makefile
> > > > > > +++ b/drivers/perf/Makefile
> > > > > > @@ -20,6 +20,7 @@ obj-$(CONFIG_QCOM_L3_PMU) +=3D qcom_l3_pmu.o
> > > > > >  obj-$(CONFIG_RISCV_PMU) +=3D riscv_pmu.o
> > > > > >  obj-$(CONFIG_RISCV_PMU_LEGACY) +=3D riscv_pmu_legacy.o
> > > > > >  obj-$(CONFIG_RISCV_PMU_SBI) +=3D riscv_pmu_sbi.o
> > > > > > +obj-$(CONFIG_RISCV_IOMMU_PMU) +=3D riscv_iommu_pmu.o
> > > > > >  obj-$(CONFIG_STARFIVE_STARLINK_PMU) +=3D starfive_starlink_pmu=
.o
> > > > > >  obj-$(CONFIG_THUNDERX2_PMU) +=3D thunderx2_pmu.o
> > > > > >  obj-$(CONFIG_XGENE_PMU) +=3D xgene_pmu.o
> > > > > > diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/risc=
v_iommu_pmu.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..2e856289ddc9
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/perf/riscv_iommu_pmu.c
> > > > > > @@ -0,0 +1,703 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > > +/*
> > > > > > + * Copyright (C) 2026 SiFive
> > > > > > + *
> > > > > > + * Authors
> > > > > > + *     Zong Li <zong.li@sifive.com>
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/auxiliary_bus.h>
> > > > > > +#include <linux/io-64-nonatomic-hi-lo.h>
> > > > > > +#include <linux/perf_event.h>
> > > > > > +
> > > > > > +#include "../iommu/riscv/iommu.h"
> > > > > > +
> > > > > > +/* 5.19 Performance monitoring counter overflow status (32bits=
) */
> > > > > > +#define RISCV_IOMMU_REG_IOCOUNTOVF     0x0058
> > > > > > +#define RISCV_IOMMU_IOCOUNTOVF_CY      BIT(0)
> > > > > > +#define RISCV_IOMMU_IOCOUNTOVF_HPM     GENMASK_ULL(31, 1)
> > > > > > +
> > > > > > +/* 5.20 Performance monitoring counter inhibits (32bits) */
> > > > > > +#define RISCV_IOMMU_REG_IOCOUNTINH     0x005C
> > > > > > +#define RISCV_IOMMU_IOCOUNTINH_CY      BIT(0)
> > > > > > +#define RISCV_IOMMU_IOCOUNTINH_HPM     GENMASK(31, 0)
> > > > > > +
> > > > > > +/* 5.21 Performance monitoring cycles counter (64bits) */
> > > > > > +#define RISCV_IOMMU_REG_IOHPMCYCLES    0x0060
> > > > > > +#define RISCV_IOMMU_IOHPMCYCLES_COUNTER        GENMASK_ULL(62,=
 0)
> > > > > > +#define RISCV_IOMMU_IOHPMCYCLES_OF     BIT_ULL(63)
> > > > > > +#define RISCV_IOMMU_REG_IOHPMCTR(_n)   (RISCV_IOMMU_REG_IOHPMC=
YCLES + ((_n) * 0x8))
> > > > > > +
> > > > > > +/* 5.22 Performance monitoring event counters (31 * 64bits) */
> > > > > > +#define RISCV_IOMMU_REG_IOHPMCTR_BASE  0x0068
> > > > > > +#define RISCV_IOMMU_IOHPMCTR_COUNTER   GENMASK_ULL(63, 0)
> > > > > > +
> > > > > > +/* 5.23 Performance monitoring event selectors (31 * 64bits) *=
/
> > > > > > +#define RISCV_IOMMU_REG_IOHPMEVT_BASE  0x0160
> > > > > > +#define RISCV_IOMMU_REG_IOHPMEVT(_n)   (RISCV_IOMMU_REG_IOHPME=
VT_BASE + ((_n) * 0x8))
> > > > > > +#define RISCV_IOMMU_IOHPMEVT_EVENTID   GENMASK_ULL(14, 0)
> > > > > > +#define RISCV_IOMMU_IOHPMEVT_DMASK     BIT_ULL(15)
> > > > > > +#define RISCV_IOMMU_IOHPMEVT_PID_PSCID GENMASK_ULL(35, 16)
> > > > > > +#define RISCV_IOMMU_IOHPMEVT_DID_GSCID GENMASK_ULL(59, 36)
> > > > > > +#define RISCV_IOMMU_IOHPMEVT_PV_PSCV   BIT_ULL(60)
> > > > > > +#define RISCV_IOMMU_IOHPMEVT_DV_GSCV   BIT_ULL(61)
> > > > > > +#define RISCV_IOMMU_IOHPMEVT_IDT       BIT_ULL(62)
> > > > > > +#define RISCV_IOMMU_IOHPMEVT_OF                BIT_ULL(63)
> > > > > > +#define RISCV_IOMMU_IOHPMEVT_EVENT     GENMASK_ULL(62, 0)
> > > > > > +
> > > > > > +/* The total number of counters is 31 event counters plus 1 cy=
cle counter */
> > > > > > +#define RISCV_IOMMU_HPM_COUNTER_NUM    32
> > > > > > +
> > > > > > +static int cpuhp_state;
> > > > > > +
> > > > > > +/**
> > > > > > + * enum riscv_iommu_hpmevent_id - Performance-monitoring event=
 identifier
> > > > > > + *
> > > > > > + * @RISCV_IOMMU_HPMEVENT_CYCLE: Clock cycle counter
> > > > > > + * @RISCV_IOMMU_HPMEVENT_URQ: Untranslated requests
> > > > > > + * @RISCV_IOMMU_HPMEVENT_TRQ: Translated requests
> > > > > > + * @RISCV_IOMMU_HPMEVENT_ATS_RQ: ATS translation requests
> > > > > > + * @RISCV_IOMMU_HPMEVENT_TLB_MISS: TLB misses
> > > > > > + * @RISCV_IOMMU_HPMEVENT_DD_WALK: Device directory walks
> > > > > > + * @RISCV_IOMMU_HPMEVENT_PD_WALK: Process directory walks
> > > > > > + * @RISCV_IOMMU_HPMEVENT_S_VS_WALKS: First-stage page table wa=
lks
> > > > > > + * @RISCV_IOMMU_HPMEVENT_G_WALKS: Second-stage page table walk=
s
> > > > > > + * @RISCV_IOMMU_HPMEVENT_MAX: Value to denote maximum Event ID=
s
> > > > > > + *
> > > > > > + * The specification does not define an event ID for counting =
the
> > > > > > + * number of clock cycles, meaning there is no associated 'ioh=
pmevt0'.
> > > > > > + * Event ID 0 is an invalid event and does not overlap with an=
y valid
> > > > > > + * event ID. Let's repurpose ID 0 as the cycle for perf, the c=
ycle
> > > > > > + * event is not actually written into any register, it serves =
solely
> > > > > > + * as an identifier.
> > > > > > + */
> > > > > > +enum riscv_iommu_hpmevent_id {
> > > > > > +       RISCV_IOMMU_HPMEVENT_CYCLE      =3D 0,
> > > > > > +       RISCV_IOMMU_HPMEVENT_URQ        =3D 1,
> > > > > > +       RISCV_IOMMU_HPMEVENT_TRQ        =3D 2,
> > > > > > +       RISCV_IOMMU_HPMEVENT_ATS_RQ     =3D 3,
> > > > > > +       RISCV_IOMMU_HPMEVENT_TLB_MISS   =3D 4,
> > > > > > +       RISCV_IOMMU_HPMEVENT_DD_WALK    =3D 5,
> > > > > > +       RISCV_IOMMU_HPMEVENT_PD_WALK    =3D 6,
> > > > > > +       RISCV_IOMMU_HPMEVENT_S_VS_WALKS =3D 7,
> > > > > > +       RISCV_IOMMU_HPMEVENT_G_WALKS    =3D 8,
> > > > > > +       RISCV_IOMMU_HPMEVENT_MAX        =3D 9
> > > > > > +};
> > > > > > +
> > > > > > +struct riscv_iommu_pmu {
> > > > > > +       struct pmu pmu;
> > > > > > +       struct hlist_node node;
> > > > > > +       void __iomem *reg;
> > > > > > +       unsigned int on_cpu;
> > > > > > +       int num_counters;
> > > > > > +       u64 cycle_cntr_mask;
> > > > > > +       u64 event_cntr_mask;
> > > > > > +       struct perf_event *events[RISCV_IOMMU_HPM_COUNTER_NUM];
> > > > > > +       DECLARE_BITMAP(used_counters, RISCV_IOMMU_HPM_COUNTER_N=
UM);
> > > > > > +       u32 hi_prev[RISCV_IOMMU_HPM_COUNTER_NUM];
> > > > > > +       u32 lo_prev[RISCV_IOMMU_HPM_COUNTER_NUM];
> > > > > > +};
> > > > > > +
> > > > > > +#define to_riscv_iommu_pmu(p) (container_of(p, struct riscv_io=
mmu_pmu, pmu))
> > > > > > +
> > > > > > +#define RISCV_IOMMU_PMU_ATTR_EXTRACTOR(_name, _mask)          =
         \
> > > > > > +       static inline u32 get_##_name(struct perf_event *event)=
         \
> > > > > > +       {                                                      =
         \
> > > > > > +               return FIELD_GET(_mask, event->attr.config);   =
         \
> > > > > > +       }                                                      =
         \
> > > > > > +
> > > > > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(event, RISCV_IOMMU_IOHPMEVT_EVE=
NTID);
> > > > > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(partial_matching, RISCV_IOMMU_I=
OHPMEVT_DMASK);
> > > > > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(pid_pscid, RISCV_IOMMU_IOHPMEVT=
_PID_PSCID);
> > > > > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(did_gscid, RISCV_IOMMU_IOHPMEVT=
_DID_GSCID);
> > > > > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_pid_pscid, RISCV_IOMMU_I=
OHPMEVT_PV_PSCV);
> > > > > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_did_gscid, RISCV_IOMMU_I=
OHPMEVT_DV_GSCV);
> > > > > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_id_type, RISCV_IOMMU_IOH=
PMEVT_IDT);
> > > > > > +
> > > > > > +/* Formats */
> > > > > > +PMU_FORMAT_ATTR(event,            "config:0-14");
> > > > > > +PMU_FORMAT_ATTR(partial_matching, "config:15");
> > > > > > +PMU_FORMAT_ATTR(pid_pscid,        "config:16-35");
> > > > > > +PMU_FORMAT_ATTR(did_gscid,        "config:36-59");
> > > > > > +PMU_FORMAT_ATTR(filter_pid_pscid, "config:60");
> > > > > > +PMU_FORMAT_ATTR(filter_did_gscid, "config:61");
> > > > > > +PMU_FORMAT_ATTR(filter_id_type,   "config:62");
> > > > > > +
> > > > > > +static struct attribute *riscv_iommu_pmu_formats[] =3D {
> > > > > > +       &format_attr_event.attr,
> > > > > > +       &format_attr_partial_matching.attr,
> > > > > > +       &format_attr_pid_pscid.attr,
> > > > > > +       &format_attr_did_gscid.attr,
> > > > > > +       &format_attr_filter_pid_pscid.attr,
> > > > > > +       &format_attr_filter_did_gscid.attr,
> > > > > > +       &format_attr_filter_id_type.attr,
> > > > > > +       NULL,
> > > > > > +};
> > > > > > +
> > > > > > +static const struct attribute_group riscv_iommu_pmu_format_gro=
up =3D {
> > > > > > +       .name =3D "format",
> > > > > > +       .attrs =3D riscv_iommu_pmu_formats,
> > > > > > +};
> > > > > > +
> > > > > > +/* Events */
> > > > > > +static ssize_t riscv_iommu_pmu_event_show(struct device *dev,
> > > > > > +                                         struct device_attribu=
te *attr,
> > > > > > +                                         char *page)
> > > > > > +{
> > > > > > +       struct perf_pmu_events_attr *pmu_attr;
> > > > > > +
> > > > > > +       pmu_attr =3D container_of(attr, struct perf_pmu_events_=
attr, attr);
> > > > > > +
> > > > > > +       return sysfs_emit(page, "event=3D0x%02llx\n", pmu_attr-=
>id);
> > > > > > +}
> > > > > > +
> > > > > > +#define RISCV_IOMMU_PMU_EVENT_ATTR(name, id)                  =
 \
> > > > > > +       PMU_EVENT_ATTR_ID(name, riscv_iommu_pmu_event_show, id)
> > > > > > +
> > > > > > +static struct attribute *riscv_iommu_pmu_events[] =3D {
> > > > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(cycle, RISCV_IOMMU_HPMEVENT_=
CYCLE),
> > > > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(untranslated_req, RISCV_IOMM=
U_HPMEVENT_URQ),
> > > > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(translated_req, RISCV_IOMMU_=
HPMEVENT_TRQ),
> > > > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(ats_trans_req, RISCV_IOMMU_H=
PMEVENT_ATS_RQ),
> > > > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(tlb_miss, RISCV_IOMMU_HPMEVE=
NT_TLB_MISS),
> > > > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(ddt_walks, RISCV_IOMMU_HPMEV=
ENT_DD_WALK),
> > > > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(pdt_walks, RISCV_IOMMU_HPMEV=
ENT_PD_WALK),
> > > > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(s_vs_pt_walks, RISCV_IOMMU_H=
PMEVENT_S_VS_WALKS),
> > > > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(g_pt_walks, RISCV_IOMMU_HPME=
VENT_G_WALKS),
> > > > > > +       NULL,
> > > > > > +};
> > > > > > +
> > > > > > +static const struct attribute_group riscv_iommu_pmu_events_gro=
up =3D {
> > > > > > +       .name =3D "events",
> > > > > > +       .attrs =3D riscv_iommu_pmu_events,
> > > > > > +};
> > > > > > +
> > > > > > +/* cpumask */
> > > > > > +static ssize_t riscv_iommu_cpumask_show(struct device *dev,
> > > > > > +                                       struct device_attribute=
 *attr,
> > > > > > +                                       char *buf)
> > > > > > +{
> > > > > > +       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(dev_=
get_drvdata(dev));
> > > > > > +
> > > > > > +       return cpumap_print_to_pagebuf(true, buf, cpumask_of(pm=
u->on_cpu));
> > > > > > +}
> > > > > > +
> > > > > > +static struct device_attribute riscv_iommu_cpumask_attr =3D
> > > > > > +       __ATTR(cpumask, 0444, riscv_iommu_cpumask_show, NULL);
> > > > > > +
> > > > > > +static struct attribute *riscv_iommu_cpumask_attrs[] =3D {
> > > > > > +       &riscv_iommu_cpumask_attr.attr,
> > > > > > +       NULL
> > > > > > +};
> > > > > > +
> > > > > > +static const struct attribute_group riscv_iommu_pmu_cpumask_gr=
oup =3D {
> > > > > > +       .attrs =3D riscv_iommu_cpumask_attrs,
> > > > > > +};
> > > > > > +
> > > > > > +static const struct attribute_group *riscv_iommu_pmu_attr_grps=
[] =3D {
> > > > > > +       &riscv_iommu_pmu_cpumask_group,
> > > > > > +       &riscv_iommu_pmu_format_group,
> > > > > > +       &riscv_iommu_pmu_events_group,
> > > > > > +       NULL,
> > > > > > +};
> > > > > > +
> > > > > > +/* PMU Operations */
> > > > > > +static void riscv_iommu_pmu_set_counter(struct riscv_iommu_pmu=
 *pmu, u32 idx,
> > > > > > +                                       u64 value)
> > > > > > +{
> > > > > > +       u64 counter_mask =3D idx ? pmu->event_cntr_mask : pmu->=
cycle_cntr_mask;
> > > > > > +
> > > > > > +       writeq(value & counter_mask, pmu->reg + RISCV_IOMMU_REG=
_IOHPMCTR(idx));
> > > > > #include <include/linux/io-64-nonatomic-lo-hi.h>
> > > > > lo_hi_writeq(value & counter_mask, pmu->reg + RISCV_IOMMU_REG_IOH=
PMCTR(idx));
> > > > >
> > > > > For better compatibility, it is recommended to use writel and rea=
dl
> > > > > instead of readq and writeq. Sorry for overlooking this last time=
 =E2=80=94
> > > > > could you please make the change again?
> > > > > In the future, your driver could support RV32 directly, as the RI=
SC-V
> > > > > IOMMU specification also supports RV32; it's just that the curren=
t
> > > > > RISC-V IOMMU driver's Kconfig depends on 64BIT.
> > > >
> > > > Hi Guo,
> > > > Thank you for your review. In my implementation for RV32, readq and
> > > > writeq are replaced by hi_lo_readq and hi_lo_writeq (from
> > > > io-64-nonatomic-hi-lo.h). So, supporting RV32 should be fine.
> > > > However, as you mentioned before: 64-bit access might be undefined =
on
> > > > some hardware. To be safe and compatible with all hardware, we shou=
ld
> > > > use 32-bit access instead of 64-bit access.
> > > > I will modify them in the next version
> > > >
> > > > I'd like to make sure I didn't miss anything important. My original
> > > > code uses the "hi-lo" order. May I ask if there is a specific reaso=
n
> > > > why you prefer the "lo-hi" order?
> > > > Thanks
> > > >
> > >
> > > Hi all,
> > > I have been thinking more about the IOMMU register access behavior an=
d
> > > would like to share my thoughts regarding the lo-hi vs. hi-lo access
> > > order.
> > >
> > > It seems to me that the correct 32-bit write order is strictly tied t=
o
> > > the underlying hardware implementation. From the software side, we
> > > have no way of knowing whether a specific vendor designed their
> > > hardware with a low-part trigger or a high-part trigger. Therefore,
> > > hardcoding a fixed 32-bit write sequence could result in compatibilit=
y
> > > issues across different hardware designs.
> > >
> > > Revisiting the spec regarding the UNSPECIFIED 8-byte atomic access,
> > > this might imply that the hardware itself will handle the split into
> > > two 4-byte accesses and internally manage its own trigger logic.
> > > Because of this, for RV64 systems, software might simply use standard
> > > 8-byte writes (e.g., writeq). Delegating the access handling to the
> > > hardware is likely the best way to maximize compatibility across all
> > > vendor implementations. For the counter reading strategy (hi-lo-hi
> > > pattern), I completely agree with using the hi-lo-hi pattern when
> > > reading the PMU counters. Since this is a read operation and does not
> > > alter hardware state.
> > >
> > > For RV32 support, we inevitably face the 32-bit access splitting
> > > issue. For the RV32 case, maybe we can assume the hi-lo order as the
> > > default fallback, because the IOMMU specification uses this sequence
> > > as example: "an access may appear, internally to the IOMMU, as if two
> > > separate 4 byte accesses - first to the high half and second to the
> > > low half - were performed.". Or do you prefer to use the same
> > > assumption (hi-lo pattern) in RV64 as well?
> > >
> > > Please let me know what you think about this.
> > >
> > > Thanks
> >
> > You're right, RV32 is not a valid argument here =E2=80=94 my wording wa=
s
> > incorrect. Thanks for pointing that out.
> > Also, I have no strong preference for lo-hi; that was just a careless
> > copy-paste on my part. I agree hi-lo is the right choice.
> >
>
> May I confirm if you still expect to use the hi-lo pattern to 'write'
> to 64-bit registers in RV64? Or would you agree that we should let the
> hardware handle this behavior, since software couldn't know the high
> part/low part trigger behavior?

1. I expect to use the hi-lo pattern to 'write' to 64-bit registers in
RV64. That is hi_lo_writeq or hi_lo_readq.
2. I don't agree to let the hardware handle this behavior; 64-bit MMIO
access is controversial for RISC-V IOMMU.

--=20
Best Regards
 Guo Ren
