Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1E93783A0
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jul 2026 02:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783393102; cv=none; b=UyakyCITuwM4s3YtCDbywi3jX4gfRUPs2peQEamrMvdkTQQtBUoLTQt9mUvegzoAZH8kyAIrlHpE94dhWnrfnRyYvH5/wXkFcvC1oY7qPnKbkXS3P5/qBsU27YFuY/1g9Z9f8oKrdx0xkJM1qemHoHdlb2ZqC1dM+QknPzCWTk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783393102; c=relaxed/simple;
	bh=V2jRVWHZbfeFwgax1y25wKJVVJoLJq2ltAZqKM90S7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMDBWno1d+hPM9s6g1D65k6nlekHfe2iKw54lEkz9C8oaQ1FOunlz4bzvPZZRljj9fjqWrRICl5n3K6XVQTYsL534upL53a5NopzJgW6ZUwM5Q8ecwXA8OZCZE79U3Xsz1OWmmjUKtWseYE53cBAbrjfV4mVqQ6l0P3bed9k5Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUXPe2rB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUXPe2rB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D4D1F000E9
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jul 2026 02:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783393100;
	bh=Ax31u46xpDxyaTuLwEuBRY1cpifK9C74G1BlVQX5smU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QUXPe2rBqrXlARdFtaCgyO3eYkZ0aQ5xhEpA66EyQJPrLIeVH+JS8vjfS8qDMGsc/
	 c9trHT9ZimXEnmlCGnBVlqyEJT7EYvn6K2wXcfdmGD/HIrq8DLLM0XDdpamcTtz0dU
	 BVTQgk0nV6C1HlK3aRTWuELsBV/JTLYGH0jD/2ZQMh1A7yaX8yUwo4XPyxVqVdkitG
	 o65pKXj7I59+TnlHvhh5No7zAKyGZhlngOW+HnVDMiwkpDWKeWHFKcYTJc3k5DmVmE
	 /XVgjamXJ8a0q4HpH8/ST+zj66s2PdP1j5dtAmMCxLRgJMk62+Tdrudfn7cKqKtCzF
	 g4xrf+yozr9dA==
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47de0093c42so1721694f8f.3
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jul 2026 19:58:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr2UFbCV3D5jBI5VG6iLkkvlKrtF75x5M0twnjtNjBPBoQQ8+8DkB5W3K3e1SLwhhKWOt/vugTNbe4MCPxmgEQl@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7KeWwusZjI48qavkNwt0xTwx3pYuqaExNzBVWi4RfHMCrwC61
	bZAPP5WDxwgD9d5+jzEVDhscwx+iU8yK7z9BwQ8fpPIPhLxo+V4+pgQp84rZj1b6iEhd4Y5rlLf
	dB6uS/C0Z0a5zZfnArTuzhotqYwuihjA=
X-Received: by 2002:adf:f9cd:0:b0:474:9991:60d0 with SMTP id
 ffacd0b85a97d-47de6689bc8mr2192750f8f.12.1783393098489; Mon, 06 Jul 2026
 19:58:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630083833.1275837-1-zong.li@sifive.com> <20260630083833.1275837-2-zong.li@sifive.com>
 <CAJF2gTTHnv3-JqWEZFbxmvkqWERsgRz5ecZOFFnieTicAODtQw@mail.gmail.com>
 <CANXhq0p6g+cgky8rt0p0NZgyA7=q7ZQ3BSXwSUnTamvS_jc=rg@mail.gmail.com> <CANXhq0pP2SJk9N-3SG-A5FL5v9omFxLmLybKsAQowtt=5+gn5Q@mail.gmail.com>
In-Reply-To: <CANXhq0pP2SJk9N-3SG-A5FL5v9omFxLmLybKsAQowtt=5+gn5Q@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 7 Jul 2026 10:58:06 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRnepM8b=nD+Ge+mnWsc7W+YCh6i_W7NH+gpZ9cASWcUA@mail.gmail.com>
X-Gm-Features: AVVi8Cd_v7-CAj85Yo7nE57yaNvXl187Hcpvh_nKvnxZu5BDT7RN0ei4itDixhQ
Message-ID: <CAJF2gTRnepM8b=nD+Ge+mnWsc7W+YCh6i_W7NH+gpZ9cASWcUA@mail.gmail.com>
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

On Tue, Jul 7, 2026 at 10:01=E2=80=AFAM Zong Li <zong.li@sifive.com> wrote:
>
> On Fri, Jul 3, 2026 at 9:36=E2=80=AFAM Zong Li <zong.li@sifive.com> wrote=
:
> >
> > On Tue, Jun 30, 2026 at 9:17=E2=80=AFPM Guo Ren <guoren@kernel.org> wro=
te:
> > >
> > > Hi Zong Li,
> > >
> > > On Tue, Jun 30, 2026 at 4:38=E2=80=AFPM Zong Li <zong.li@sifive.com> =
wrote:
> > > >
> > > > Add a new driver to support the RISC-V IOMMU PMU. This is an auxili=
ary
> > > > device driver created by the parent RISC-V IOMMU driver.
> > > >
> > > > The RISC-V IOMMU PMU separates the cycle counter from the event cou=
nters.
> > > > The cycle counter is not associated with iohpmevt0, so a software-d=
efined
> > > > cycle event is required for the perf subsystem.
> > > >
> > > > The number and width of the counters are hardware-implemented and m=
ust
> > > > be detected at runtime.
> > > >
> > > > The performance monitor provides counters with filtering support to
> > > > collect events for specific device ID/process ID, or GSCID/PSCID.
> > > >
> > > > PMU-related definitions are moved into the perf driver, where they =
are
> > > > used exclusively.
> > > >
> > > > Suggested-by: David Laight <david.laight.linux@gmail.com>
> > > > Suggested-by: Guo Ren <guoren@kernel.org>
> > > > Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@p=
umpkin/
> > > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > > ---
> > > >  drivers/iommu/riscv/iommu-bits.h |  61 ---
> > > >  drivers/perf/Kconfig             |  12 +
> > > >  drivers/perf/Makefile            |   1 +
> > > >  drivers/perf/riscv_iommu_pmu.c   | 703 +++++++++++++++++++++++++++=
++++
> > > >  4 files changed, 716 insertions(+), 61 deletions(-)
> > > >  create mode 100644 drivers/perf/riscv_iommu_pmu.c
> > > >
> > > > diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv=
/iommu-bits.h
> > > > index f2ef9bd3cde9..6b5de913a032 100644
> > > > --- a/drivers/iommu/riscv/iommu-bits.h
> > > > +++ b/drivers/iommu/riscv/iommu-bits.h
> > > > @@ -192,67 +192,6 @@ enum riscv_iommu_ddtp_modes {
> > > >  #define RISCV_IOMMU_IPSR_PMIP          BIT(RISCV_IOMMU_INTR_PM)
> > > >  #define RISCV_IOMMU_IPSR_PIP           BIT(RISCV_IOMMU_INTR_PQ)
> > > >
> > > > -/* 5.19 Performance monitoring counter overflow status (32bits) */
> > > > -#define RISCV_IOMMU_REG_IOCOUNTOVF     0x0058
> > > > -#define RISCV_IOMMU_IOCOUNTOVF_CY      BIT(0)
> > > > -#define RISCV_IOMMU_IOCOUNTOVF_HPM     GENMASK_ULL(31, 1)
> > > > -
> > > > -/* 5.20 Performance monitoring counter inhibits (32bits) */
> > > > -#define RISCV_IOMMU_REG_IOCOUNTINH     0x005C
> > > > -#define RISCV_IOMMU_IOCOUNTINH_CY      BIT(0)
> > > > -#define RISCV_IOMMU_IOCOUNTINH_HPM     GENMASK(31, 1)
> > > > -
> > > > -/* 5.21 Performance monitoring cycles counter (64bits) */
> > > > -#define RISCV_IOMMU_REG_IOHPMCYCLES     0x0060
> > > > -#define RISCV_IOMMU_IOHPMCYCLES_COUNTER        GENMASK_ULL(62, 0)
> > > > -#define RISCV_IOMMU_IOHPMCYCLES_OF     BIT_ULL(63)
> > > > -
> > > > -/* 5.22 Performance monitoring event counters (31 * 64bits) */
> > > > -#define RISCV_IOMMU_REG_IOHPMCTR_BASE  0x0068
> > > > -#define RISCV_IOMMU_REG_IOHPMCTR(_n)   (RISCV_IOMMU_REG_IOHPMCTR_B=
ASE + ((_n) * 0x8))
> > > > -
> > > > -/* 5.23 Performance monitoring event selectors (31 * 64bits) */
> > > > -#define RISCV_IOMMU_REG_IOHPMEVT_BASE  0x0160
> > > > -#define RISCV_IOMMU_REG_IOHPMEVT(_n)   (RISCV_IOMMU_REG_IOHPMEVT_B=
ASE + ((_n) * 0x8))
> > > > -#define RISCV_IOMMU_IOHPMEVT_EVENTID   GENMASK_ULL(14, 0)
> > > > -#define RISCV_IOMMU_IOHPMEVT_DMASK     BIT_ULL(15)
> > > > -#define RISCV_IOMMU_IOHPMEVT_PID_PSCID GENMASK_ULL(35, 16)
> > > > -#define RISCV_IOMMU_IOHPMEVT_DID_GSCID GENMASK_ULL(59, 36)
> > > > -#define RISCV_IOMMU_IOHPMEVT_PV_PSCV   BIT_ULL(60)
> > > > -#define RISCV_IOMMU_IOHPMEVT_DV_GSCV   BIT_ULL(61)
> > > > -#define RISCV_IOMMU_IOHPMEVT_IDT       BIT_ULL(62)
> > > > -#define RISCV_IOMMU_IOHPMEVT_OF                BIT_ULL(63)
> > > > -
> > > > -/* Number of defined performance-monitoring event selectors */
> > > > -#define RISCV_IOMMU_IOHPMEVT_CNT       31
> > > > -
> > > > -/**
> > > > - * enum riscv_iommu_hpmevent_id - Performance-monitoring event ide=
ntifier
> > > > - *
> > > > - * @RISCV_IOMMU_HPMEVENT_INVALID: Invalid event, do not count
> > > > - * @RISCV_IOMMU_HPMEVENT_URQ: Untranslated requests
> > > > - * @RISCV_IOMMU_HPMEVENT_TRQ: Translated requests
> > > > - * @RISCV_IOMMU_HPMEVENT_ATS_RQ: ATS translation requests
> > > > - * @RISCV_IOMMU_HPMEVENT_TLB_MISS: TLB misses
> > > > - * @RISCV_IOMMU_HPMEVENT_DD_WALK: Device directory walks
> > > > - * @RISCV_IOMMU_HPMEVENT_PD_WALK: Process directory walks
> > > > - * @RISCV_IOMMU_HPMEVENT_S_VS_WALKS: First-stage page table walks
> > > > - * @RISCV_IOMMU_HPMEVENT_G_WALKS: Second-stage page table walks
> > > > - * @RISCV_IOMMU_HPMEVENT_MAX: Value to denote maximum Event IDs
> > > > - */
> > > > -enum riscv_iommu_hpmevent_id {
> > > > -       RISCV_IOMMU_HPMEVENT_INVALID    =3D 0,
> > > > -       RISCV_IOMMU_HPMEVENT_URQ        =3D 1,
> > > > -       RISCV_IOMMU_HPMEVENT_TRQ        =3D 2,
> > > > -       RISCV_IOMMU_HPMEVENT_ATS_RQ     =3D 3,
> > > > -       RISCV_IOMMU_HPMEVENT_TLB_MISS   =3D 4,
> > > > -       RISCV_IOMMU_HPMEVENT_DD_WALK    =3D 5,
> > > > -       RISCV_IOMMU_HPMEVENT_PD_WALK    =3D 6,
> > > > -       RISCV_IOMMU_HPMEVENT_S_VS_WALKS =3D 7,
> > > > -       RISCV_IOMMU_HPMEVENT_G_WALKS    =3D 8,
> > > > -       RISCV_IOMMU_HPMEVENT_MAX        =3D 9
> > > > -};
> > > > -
> > > >  /* 5.24 Translation request IOVA (64bits) */
> > > >  #define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
> > > >  #define RISCV_IOMMU_TR_REQ_IOVA_VPN    GENMASK_ULL(63, 12)
> > > > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> > > > index 245e7bb763b9..8cce6c2ea626 100644
> > > > --- a/drivers/perf/Kconfig
> > > > +++ b/drivers/perf/Kconfig
> > > > @@ -105,6 +105,18 @@ config RISCV_PMU_SBI
> > > >           full perf feature support i.e. counter overflow, privileg=
e mode
> > > >           filtering, counter configuration.
> > > >
> > > > +config RISCV_IOMMU_PMU
> > > > +       depends on RISCV || COMPILE_TEST
> > > > +       depends on RISCV_IOMMU
> > > > +       bool "RISC-V IOMMU Hardware Performance Monitor"
> > > > +       default y
> > > > +       help
> > > > +         Say Y if you want to use the RISC-V IOMMU performance mon=
itor
> > > > +         implementation. The performance monitor is an optional ha=
rdware
> > > > +         feature, and whether it is actually enabled depends on IO=
MMU
> > > > +         hardware support. If the underlying hardware does not imp=
lement
> > > > +         the PMU, this option will have no effect.
> > > > +
> > > >  config STARFIVE_STARLINK_PMU
> > > >         depends on ARCH_STARFIVE || COMPILE_TEST
> > > >         depends on 64BIT
> > > > diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> > > > index eb8a022dad9a..90c75f3c0ac1 100644
> > > > --- a/drivers/perf/Makefile
> > > > +++ b/drivers/perf/Makefile
> > > > @@ -20,6 +20,7 @@ obj-$(CONFIG_QCOM_L3_PMU) +=3D qcom_l3_pmu.o
> > > >  obj-$(CONFIG_RISCV_PMU) +=3D riscv_pmu.o
> > > >  obj-$(CONFIG_RISCV_PMU_LEGACY) +=3D riscv_pmu_legacy.o
> > > >  obj-$(CONFIG_RISCV_PMU_SBI) +=3D riscv_pmu_sbi.o
> > > > +obj-$(CONFIG_RISCV_IOMMU_PMU) +=3D riscv_iommu_pmu.o
> > > >  obj-$(CONFIG_STARFIVE_STARLINK_PMU) +=3D starfive_starlink_pmu.o
> > > >  obj-$(CONFIG_THUNDERX2_PMU) +=3D thunderx2_pmu.o
> > > >  obj-$(CONFIG_XGENE_PMU) +=3D xgene_pmu.o
> > > > diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_io=
mmu_pmu.c
> > > > new file mode 100644
> > > > index 000000000000..2e856289ddc9
> > > > --- /dev/null
> > > > +++ b/drivers/perf/riscv_iommu_pmu.c
> > > > @@ -0,0 +1,703 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * Copyright (C) 2026 SiFive
> > > > + *
> > > > + * Authors
> > > > + *     Zong Li <zong.li@sifive.com>
> > > > + */
> > > > +
> > > > +#include <linux/auxiliary_bus.h>
> > > > +#include <linux/io-64-nonatomic-hi-lo.h>
> > > > +#include <linux/perf_event.h>
> > > > +
> > > > +#include "../iommu/riscv/iommu.h"
> > > > +
> > > > +/* 5.19 Performance monitoring counter overflow status (32bits) */
> > > > +#define RISCV_IOMMU_REG_IOCOUNTOVF     0x0058
> > > > +#define RISCV_IOMMU_IOCOUNTOVF_CY      BIT(0)
> > > > +#define RISCV_IOMMU_IOCOUNTOVF_HPM     GENMASK_ULL(31, 1)
> > > > +
> > > > +/* 5.20 Performance monitoring counter inhibits (32bits) */
> > > > +#define RISCV_IOMMU_REG_IOCOUNTINH     0x005C
> > > > +#define RISCV_IOMMU_IOCOUNTINH_CY      BIT(0)
> > > > +#define RISCV_IOMMU_IOCOUNTINH_HPM     GENMASK(31, 0)
> > > > +
> > > > +/* 5.21 Performance monitoring cycles counter (64bits) */
> > > > +#define RISCV_IOMMU_REG_IOHPMCYCLES    0x0060
> > > > +#define RISCV_IOMMU_IOHPMCYCLES_COUNTER        GENMASK_ULL(62, 0)
> > > > +#define RISCV_IOMMU_IOHPMCYCLES_OF     BIT_ULL(63)
> > > > +#define RISCV_IOMMU_REG_IOHPMCTR(_n)   (RISCV_IOMMU_REG_IOHPMCYCLE=
S + ((_n) * 0x8))
> > > > +
> > > > +/* 5.22 Performance monitoring event counters (31 * 64bits) */
> > > > +#define RISCV_IOMMU_REG_IOHPMCTR_BASE  0x0068
> > > > +#define RISCV_IOMMU_IOHPMCTR_COUNTER   GENMASK_ULL(63, 0)
> > > > +
> > > > +/* 5.23 Performance monitoring event selectors (31 * 64bits) */
> > > > +#define RISCV_IOMMU_REG_IOHPMEVT_BASE  0x0160
> > > > +#define RISCV_IOMMU_REG_IOHPMEVT(_n)   (RISCV_IOMMU_REG_IOHPMEVT_B=
ASE + ((_n) * 0x8))
> > > > +#define RISCV_IOMMU_IOHPMEVT_EVENTID   GENMASK_ULL(14, 0)
> > > > +#define RISCV_IOMMU_IOHPMEVT_DMASK     BIT_ULL(15)
> > > > +#define RISCV_IOMMU_IOHPMEVT_PID_PSCID GENMASK_ULL(35, 16)
> > > > +#define RISCV_IOMMU_IOHPMEVT_DID_GSCID GENMASK_ULL(59, 36)
> > > > +#define RISCV_IOMMU_IOHPMEVT_PV_PSCV   BIT_ULL(60)
> > > > +#define RISCV_IOMMU_IOHPMEVT_DV_GSCV   BIT_ULL(61)
> > > > +#define RISCV_IOMMU_IOHPMEVT_IDT       BIT_ULL(62)
> > > > +#define RISCV_IOMMU_IOHPMEVT_OF                BIT_ULL(63)
> > > > +#define RISCV_IOMMU_IOHPMEVT_EVENT     GENMASK_ULL(62, 0)
> > > > +
> > > > +/* The total number of counters is 31 event counters plus 1 cycle =
counter */
> > > > +#define RISCV_IOMMU_HPM_COUNTER_NUM    32
> > > > +
> > > > +static int cpuhp_state;
> > > > +
> > > > +/**
> > > > + * enum riscv_iommu_hpmevent_id - Performance-monitoring event ide=
ntifier
> > > > + *
> > > > + * @RISCV_IOMMU_HPMEVENT_CYCLE: Clock cycle counter
> > > > + * @RISCV_IOMMU_HPMEVENT_URQ: Untranslated requests
> > > > + * @RISCV_IOMMU_HPMEVENT_TRQ: Translated requests
> > > > + * @RISCV_IOMMU_HPMEVENT_ATS_RQ: ATS translation requests
> > > > + * @RISCV_IOMMU_HPMEVENT_TLB_MISS: TLB misses
> > > > + * @RISCV_IOMMU_HPMEVENT_DD_WALK: Device directory walks
> > > > + * @RISCV_IOMMU_HPMEVENT_PD_WALK: Process directory walks
> > > > + * @RISCV_IOMMU_HPMEVENT_S_VS_WALKS: First-stage page table walks
> > > > + * @RISCV_IOMMU_HPMEVENT_G_WALKS: Second-stage page table walks
> > > > + * @RISCV_IOMMU_HPMEVENT_MAX: Value to denote maximum Event IDs
> > > > + *
> > > > + * The specification does not define an event ID for counting the
> > > > + * number of clock cycles, meaning there is no associated 'iohpmev=
t0'.
> > > > + * Event ID 0 is an invalid event and does not overlap with any va=
lid
> > > > + * event ID. Let's repurpose ID 0 as the cycle for perf, the cycle
> > > > + * event is not actually written into any register, it serves sole=
ly
> > > > + * as an identifier.
> > > > + */
> > > > +enum riscv_iommu_hpmevent_id {
> > > > +       RISCV_IOMMU_HPMEVENT_CYCLE      =3D 0,
> > > > +       RISCV_IOMMU_HPMEVENT_URQ        =3D 1,
> > > > +       RISCV_IOMMU_HPMEVENT_TRQ        =3D 2,
> > > > +       RISCV_IOMMU_HPMEVENT_ATS_RQ     =3D 3,
> > > > +       RISCV_IOMMU_HPMEVENT_TLB_MISS   =3D 4,
> > > > +       RISCV_IOMMU_HPMEVENT_DD_WALK    =3D 5,
> > > > +       RISCV_IOMMU_HPMEVENT_PD_WALK    =3D 6,
> > > > +       RISCV_IOMMU_HPMEVENT_S_VS_WALKS =3D 7,
> > > > +       RISCV_IOMMU_HPMEVENT_G_WALKS    =3D 8,
> > > > +       RISCV_IOMMU_HPMEVENT_MAX        =3D 9
> > > > +};
> > > > +
> > > > +struct riscv_iommu_pmu {
> > > > +       struct pmu pmu;
> > > > +       struct hlist_node node;
> > > > +       void __iomem *reg;
> > > > +       unsigned int on_cpu;
> > > > +       int num_counters;
> > > > +       u64 cycle_cntr_mask;
> > > > +       u64 event_cntr_mask;
> > > > +       struct perf_event *events[RISCV_IOMMU_HPM_COUNTER_NUM];
> > > > +       DECLARE_BITMAP(used_counters, RISCV_IOMMU_HPM_COUNTER_NUM);
> > > > +       u32 hi_prev[RISCV_IOMMU_HPM_COUNTER_NUM];
> > > > +       u32 lo_prev[RISCV_IOMMU_HPM_COUNTER_NUM];
> > > > +};
> > > > +
> > > > +#define to_riscv_iommu_pmu(p) (container_of(p, struct riscv_iommu_=
pmu, pmu))
> > > > +
> > > > +#define RISCV_IOMMU_PMU_ATTR_EXTRACTOR(_name, _mask)              =
     \
> > > > +       static inline u32 get_##_name(struct perf_event *event)    =
     \
> > > > +       {                                                          =
     \
> > > > +               return FIELD_GET(_mask, event->attr.config);       =
     \
> > > > +       }                                                          =
     \
> > > > +
> > > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(event, RISCV_IOMMU_IOHPMEVT_EVENTID=
);
> > > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(partial_matching, RISCV_IOMMU_IOHPM=
EVT_DMASK);
> > > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(pid_pscid, RISCV_IOMMU_IOHPMEVT_PID=
_PSCID);
> > > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(did_gscid, RISCV_IOMMU_IOHPMEVT_DID=
_GSCID);
> > > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_pid_pscid, RISCV_IOMMU_IOHPM=
EVT_PV_PSCV);
> > > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_did_gscid, RISCV_IOMMU_IOHPM=
EVT_DV_GSCV);
> > > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_id_type, RISCV_IOMMU_IOHPMEV=
T_IDT);
> > > > +
> > > > +/* Formats */
> > > > +PMU_FORMAT_ATTR(event,            "config:0-14");
> > > > +PMU_FORMAT_ATTR(partial_matching, "config:15");
> > > > +PMU_FORMAT_ATTR(pid_pscid,        "config:16-35");
> > > > +PMU_FORMAT_ATTR(did_gscid,        "config:36-59");
> > > > +PMU_FORMAT_ATTR(filter_pid_pscid, "config:60");
> > > > +PMU_FORMAT_ATTR(filter_did_gscid, "config:61");
> > > > +PMU_FORMAT_ATTR(filter_id_type,   "config:62");
> > > > +
> > > > +static struct attribute *riscv_iommu_pmu_formats[] =3D {
> > > > +       &format_attr_event.attr,
> > > > +       &format_attr_partial_matching.attr,
> > > > +       &format_attr_pid_pscid.attr,
> > > > +       &format_attr_did_gscid.attr,
> > > > +       &format_attr_filter_pid_pscid.attr,
> > > > +       &format_attr_filter_did_gscid.attr,
> > > > +       &format_attr_filter_id_type.attr,
> > > > +       NULL,
> > > > +};
> > > > +
> > > > +static const struct attribute_group riscv_iommu_pmu_format_group =
=3D {
> > > > +       .name =3D "format",
> > > > +       .attrs =3D riscv_iommu_pmu_formats,
> > > > +};
> > > > +
> > > > +/* Events */
> > > > +static ssize_t riscv_iommu_pmu_event_show(struct device *dev,
> > > > +                                         struct device_attribute *=
attr,
> > > > +                                         char *page)
> > > > +{
> > > > +       struct perf_pmu_events_attr *pmu_attr;
> > > > +
> > > > +       pmu_attr =3D container_of(attr, struct perf_pmu_events_attr=
, attr);
> > > > +
> > > > +       return sysfs_emit(page, "event=3D0x%02llx\n", pmu_attr->id)=
;
> > > > +}
> > > > +
> > > > +#define RISCV_IOMMU_PMU_EVENT_ATTR(name, id)                   \
> > > > +       PMU_EVENT_ATTR_ID(name, riscv_iommu_pmu_event_show, id)
> > > > +
> > > > +static struct attribute *riscv_iommu_pmu_events[] =3D {
> > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(cycle, RISCV_IOMMU_HPMEVENT_CYCL=
E),
> > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(untranslated_req, RISCV_IOMMU_HP=
MEVENT_URQ),
> > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(translated_req, RISCV_IOMMU_HPME=
VENT_TRQ),
> > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(ats_trans_req, RISCV_IOMMU_HPMEV=
ENT_ATS_RQ),
> > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(tlb_miss, RISCV_IOMMU_HPMEVENT_T=
LB_MISS),
> > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(ddt_walks, RISCV_IOMMU_HPMEVENT_=
DD_WALK),
> > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(pdt_walks, RISCV_IOMMU_HPMEVENT_=
PD_WALK),
> > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(s_vs_pt_walks, RISCV_IOMMU_HPMEV=
ENT_S_VS_WALKS),
> > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(g_pt_walks, RISCV_IOMMU_HPMEVENT=
_G_WALKS),
> > > > +       NULL,
> > > > +};
> > > > +
> > > > +static const struct attribute_group riscv_iommu_pmu_events_group =
=3D {
> > > > +       .name =3D "events",
> > > > +       .attrs =3D riscv_iommu_pmu_events,
> > > > +};
> > > > +
> > > > +/* cpumask */
> > > > +static ssize_t riscv_iommu_cpumask_show(struct device *dev,
> > > > +                                       struct device_attribute *at=
tr,
> > > > +                                       char *buf)
> > > > +{
> > > > +       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(dev_get_=
drvdata(dev));
> > > > +
> > > > +       return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->o=
n_cpu));
> > > > +}
> > > > +
> > > > +static struct device_attribute riscv_iommu_cpumask_attr =3D
> > > > +       __ATTR(cpumask, 0444, riscv_iommu_cpumask_show, NULL);
> > > > +
> > > > +static struct attribute *riscv_iommu_cpumask_attrs[] =3D {
> > > > +       &riscv_iommu_cpumask_attr.attr,
> > > > +       NULL
> > > > +};
> > > > +
> > > > +static const struct attribute_group riscv_iommu_pmu_cpumask_group =
=3D {
> > > > +       .attrs =3D riscv_iommu_cpumask_attrs,
> > > > +};
> > > > +
> > > > +static const struct attribute_group *riscv_iommu_pmu_attr_grps[] =
=3D {
> > > > +       &riscv_iommu_pmu_cpumask_group,
> > > > +       &riscv_iommu_pmu_format_group,
> > > > +       &riscv_iommu_pmu_events_group,
> > > > +       NULL,
> > > > +};
> > > > +
> > > > +/* PMU Operations */
> > > > +static void riscv_iommu_pmu_set_counter(struct riscv_iommu_pmu *pm=
u, u32 idx,
> > > > +                                       u64 value)
> > > > +{
> > > > +       u64 counter_mask =3D idx ? pmu->event_cntr_mask : pmu->cycl=
e_cntr_mask;
> > > > +
> > > > +       writeq(value & counter_mask, pmu->reg + RISCV_IOMMU_REG_IOH=
PMCTR(idx));
> > > #include <include/linux/io-64-nonatomic-lo-hi.h>
> > > lo_hi_writeq(value & counter_mask, pmu->reg + RISCV_IOMMU_REG_IOHPMCT=
R(idx));
> > >
> > > For better compatibility, it is recommended to use writel and readl
> > > instead of readq and writeq. Sorry for overlooking this last time =E2=
=80=94
> > > could you please make the change again?
> > > In the future, your driver could support RV32 directly, as the RISC-V
> > > IOMMU specification also supports RV32; it's just that the current
> > > RISC-V IOMMU driver's Kconfig depends on 64BIT.
> >
> > Hi Guo,
> > Thank you for your review. In my implementation for RV32, readq and
> > writeq are replaced by hi_lo_readq and hi_lo_writeq (from
> > io-64-nonatomic-hi-lo.h). So, supporting RV32 should be fine.
> > However, as you mentioned before: 64-bit access might be undefined on
> > some hardware. To be safe and compatible with all hardware, we should
> > use 32-bit access instead of 64-bit access.
> > I will modify them in the next version
> >
> > I'd like to make sure I didn't miss anything important. My original
> > code uses the "hi-lo" order. May I ask if there is a specific reason
> > why you prefer the "lo-hi" order?
> > Thanks
> >
>
> Hi all,
> I have been thinking more about the IOMMU register access behavior and
> would like to share my thoughts regarding the lo-hi vs. hi-lo access
> order.
>
> It seems to me that the correct 32-bit write order is strictly tied to
> the underlying hardware implementation. From the software side, we
> have no way of knowing whether a specific vendor designed their
> hardware with a low-part trigger or a high-part trigger. Therefore,
> hardcoding a fixed 32-bit write sequence could result in compatibility
> issues across different hardware designs.
>
> Revisiting the spec regarding the UNSPECIFIED 8-byte atomic access,
> this might imply that the hardware itself will handle the split into
> two 4-byte accesses and internally manage its own trigger logic.
> Because of this, for RV64 systems, software might simply use standard
> 8-byte writes (e.g., writeq). Delegating the access handling to the
> hardware is likely the best way to maximize compatibility across all
> vendor implementations. For the counter reading strategy (hi-lo-hi
> pattern), I completely agree with using the hi-lo-hi pattern when
> reading the PMU counters. Since this is a read operation and does not
> alter hardware state.
>
> For RV32 support, we inevitably face the 32-bit access splitting
> issue. For the RV32 case, maybe we can assume the hi-lo order as the
> default fallback, because the IOMMU specification uses this sequence
> as example: "an access may appear, internally to the IOMMU, as if two
> separate 4 byte accesses - first to the high half and second to the
> low half - were performed.". Or do you prefer to use the same
> assumption (hi-lo pattern) in RV64 as well?
>
> Please let me know what you think about this.
>
> Thanks

You're right, RV32 is not a valid argument here =E2=80=94 my wording was
incorrect. Thanks for pointing that out.
Also, I have no strong preference for lo-hi; that was just a careless
copy-paste on my part. I agree hi-lo is the right choice.

Thanks again for your great work.

--=20
Best Regards
 Guo Ren
