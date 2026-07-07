Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D6242088B
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jul 2026 03:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783396176; cv=pass; b=GwAFRY+0Ks9P43OFCH4wWMgeXRFcufmpMgX4nHMv95OPYcAqXSD8z5hf1XC+Euma86iaBpKE/OO03PgCNTZ7wQ2gc59SOVWHfOvaa/YkScJqaPcDCMzU/EpO9qC9nd0+TDuuwjVJk1kOZwS261t0CSuCP22bBm5qHGrio8AkJFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783396176; c=relaxed/simple;
	bh=t7sIRsGul5H43kytCp7Gfj8H6EOgnopD/v/HCadu7so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKcndnvRdmohwrHxsDCNeAQhUszWP1zvYXdWGTPgflLoZMGAYpuryD47xtB2GIIsqB2rzkcnuzgBYms1LmQrs1TPq9iXU7J+G5CqOos5PQNe4NvUZo/jxQAixdMvjHHIe3TbInCmIEsuKH0l3j8s6fYBqL+G7Jn4kdQMnalCaHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=VgbLtoZJ; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VgbLtoZJ"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c0c15bd6b8fso359655666b.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jul 2026 20:49:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783396172; cv=none;
        d=google.com; s=arc-20260327;
        b=HZ1mp+GUAfiJDgDTgKGOG0TfOqdDFIxXfVLr77yoVsCLO2sOMosAUwiDNaIbS7Usit
         He5VpNXIkg78zfli7M4E4+3EeTdTrcuXHqN53dlAJYCFRAoJ8CT1EFXEv2/9EJ35c57q
         CPB5DVM9AdBz0/HTsLoHRjJ0mrrXVH4k0QSyzZjYCMa6nUGJEG2MTd92sfhLtKTghvs6
         U+W6WkKiPdCLuAOj6i930sR6msUV1a0DhAtcq2VDZuLlQkk16Z+vh0Dwj0H6eK6Yytw3
         RZcwTrr+hQL6RbgvXO/YwV8Z8jlHt32u9u3TxjkMhwiNnFBA0P2OlBq8qP5izAPANjF1
         tbIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kj6tgYwvy3Loy1tUBHYN3O13O7Cu5LgxUv81UpvmC70=;
        fh=kGuRyohkme2nBk5QQ4cgvsUmef08tLI0szlWhiWmMgc=;
        b=OdN3cZ9QqwCbs8ROLBGqEbJsobmLEQOr8DqVfZ9EN4g7eUB5DcQg711EXOv2ucpm+S
         RomMEHP+nHS17GXfoyymXcsPfbdNcX8JPok6NDYBwcCMggs1aeWi/WUKdhbaDQgvRFnJ
         aOu3od1tWBcdg8R1H3kEqfbWB3v/reYkmEjDKt6QNi6LzcA3h95HwBCtv6mNjG4ZGxmk
         iN6RfRcmxgX0z1zGGt4ZlVIDGJ+FOLUWAU2ameg4/r57pLa+FXVzy3lridgjnf4/5fKu
         qjUCGZdDrM45KLUprbFUOix/nqIHUCgdvC0iD7SgAVf+NMXyzBBtYebSf3lNB2HZ47QM
         Qa/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1783396172; x=1784000972; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kj6tgYwvy3Loy1tUBHYN3O13O7Cu5LgxUv81UpvmC70=;
        b=VgbLtoZJ8RB02zVDaKQDtyHe8caz5vRxM+1ERLnQIkNW9pFpJAHV1qYXaeGkAeyooZ
         w4pO915Wj4ZL6jHWpU3cN5AaBCvkmEQnYbvFpPf4hra01vuGSp6+rkkZeY6/J25llKt4
         cprcmP1f8O0HoGWYX5qAAE+lbfToo3C0ey6EP9YlO+UzZq3PIXyLTCfBG8MP4HDoz8GL
         fC+lBGU4PLuhSDj2ALIGupPWHODhZbNtfGay08h7ToZ5fMJit5kQyhDeZQIiw66PfyrX
         UNzOB7fsty3LPysNOOxJayo9hf6PAbMkMBtG67D1Q7Wu75OjjMMdiv9dMfRJEuoHez3V
         FWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783396172; x=1784000972;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kj6tgYwvy3Loy1tUBHYN3O13O7Cu5LgxUv81UpvmC70=;
        b=cJmNFbbml2+qBzjfYVaSlrCz1yntzlkISPfAcb84EzmtcyeErBA6rX6bIBhXpQj83j
         gqTNVDEO3Pf5kiYcWzdxxBKAklhdBl3GbNbqe8utIwx0AVGducMZtzzfNN5eFo0AkJnk
         nkZOkVwVpa0obpSLhgt014t7WJ9XUwwiBZMdaAqoFCYD+soqPiZLDCIT8267o3//iQ50
         3QCtgerI0Df11OhGVHu+eNAiS1Yw0P1l/jqNHuQhVZSIvLY8hGFjAPeFVzKRtwnVhCYm
         1GRx90iNAx9R9+r0SnPcwLXuQVfTFdQNQBiqZdRn1Q4NO7FajWd4iKJr8bvgKamndURT
         VrzQ==
X-Forwarded-Encrypted: i=1; AHgh+RoAwgwK0CGe/g5lmM4tyw9B8QbsxqnUy2mX70aBshIBJSQUFFAPY4sDxI/KF7VnW9J9UpF82ze4Pe6Xa8tqPSal@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6xA3ExbPbfnvwNcBkT2JL5AqCtp7VIxq5us1iQb+EJBgqdb6C
	PixvTonpZL14XKB6iMysePuOSyziNwxUUYWBAFCofv5uhAAb3wjaSVR4Wz0RjkPzyBAKDUwi4oj
	qaxnKcQtZIwyT1/8/bKVftGF3i/TOpknIxeIjUOQTkA==
X-Gm-Gg: AfdE7clMgphEFuB61dG4c1Hui9hz4MfXbv9QQAsaD7+WUBvEYn2ozinnRbHxr4Ig/5F
	PieQ/QWl9MHSXB7zMnx+rZuwHZ6nhoDedUAh0PmRhNqGOCbtFz3RMPD/feOcKlDICpgQOkfKhul
	8glMxJhVX+3SzeOFF8F7Z3Db3eDtEkJks0C2PdClJfPth9c4qfuBw88W7lUyAfzROMeUmuhG+Tx
	HYUHq9UV7oOYdsLTxGX4Z164P6H53HM831f/pF5X3LCgOxZfz8idLrbSDn5NDRmle615Owey9A=
X-Received: by 2002:a17:907:3c95:b0:c12:4c5b:f170 with SMTP id
 a640c23a62f3a-c15a6a353a5mr177713266b.62.1783396172188; Mon, 06 Jul 2026
 20:49:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630083833.1275837-1-zong.li@sifive.com> <20260630083833.1275837-2-zong.li@sifive.com>
 <CAJF2gTTHnv3-JqWEZFbxmvkqWERsgRz5ecZOFFnieTicAODtQw@mail.gmail.com>
 <CANXhq0p6g+cgky8rt0p0NZgyA7=q7ZQ3BSXwSUnTamvS_jc=rg@mail.gmail.com>
 <CANXhq0pP2SJk9N-3SG-A5FL5v9omFxLmLybKsAQowtt=5+gn5Q@mail.gmail.com> <CAJF2gTRnepM8b=nD+Ge+mnWsc7W+YCh6i_W7NH+gpZ9cASWcUA@mail.gmail.com>
In-Reply-To: <CAJF2gTRnepM8b=nD+Ge+mnWsc7W+YCh6i_W7NH+gpZ9cASWcUA@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 7 Jul 2026 11:49:20 +0800
X-Gm-Features: AVVi8CcTb0EgvwtFsjHXnTNSSjTGVrZeecEQFemR-Ff6ZdlYOcv7bcoAtnbpoqA
Message-ID: <CANXhq0okNZS6WT=aNTOXj+_fQSucNaj8o1gw82jeQyDA_PVxVw@mail.gmail.com>
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

On Tue, Jul 7, 2026 at 10:58=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Tue, Jul 7, 2026 at 10:01=E2=80=AFAM Zong Li <zong.li@sifive.com> wrot=
e:
> >
> > On Fri, Jul 3, 2026 at 9:36=E2=80=AFAM Zong Li <zong.li@sifive.com> wro=
te:
> > >
> > > On Tue, Jun 30, 2026 at 9:17=E2=80=AFPM Guo Ren <guoren@kernel.org> w=
rote:
> > > >
> > > > Hi Zong Li,
> > > >
> > > > On Tue, Jun 30, 2026 at 4:38=E2=80=AFPM Zong Li <zong.li@sifive.com=
> wrote:
> > > > >
> > > > > Add a new driver to support the RISC-V IOMMU PMU. This is an auxi=
liary
> > > > > device driver created by the parent RISC-V IOMMU driver.
> > > > >
> > > > > The RISC-V IOMMU PMU separates the cycle counter from the event c=
ounters.
> > > > > The cycle counter is not associated with iohpmevt0, so a software=
-defined
> > > > > cycle event is required for the perf subsystem.
> > > > >
> > > > > The number and width of the counters are hardware-implemented and=
 must
> > > > > be detected at runtime.
> > > > >
> > > > > The performance monitor provides counters with filtering support =
to
> > > > > collect events for specific device ID/process ID, or GSCID/PSCID.
> > > > >
> > > > > PMU-related definitions are moved into the perf driver, where the=
y are
> > > > > used exclusively.
> > > > >
> > > > > Suggested-by: David Laight <david.laight.linux@gmail.com>
> > > > > Suggested-by: Guo Ren <guoren@kernel.org>
> > > > > Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5=
@pumpkin/
> > > > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > > > ---
> > > > >  drivers/iommu/riscv/iommu-bits.h |  61 ---
> > > > >  drivers/perf/Kconfig             |  12 +
> > > > >  drivers/perf/Makefile            |   1 +
> > > > >  drivers/perf/riscv_iommu_pmu.c   | 703 +++++++++++++++++++++++++=
++++++
> > > > >  4 files changed, 716 insertions(+), 61 deletions(-)
> > > > >  create mode 100644 drivers/perf/riscv_iommu_pmu.c
> > > > >
> > > > > diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/ris=
cv/iommu-bits.h
> > > > > index f2ef9bd3cde9..6b5de913a032 100644
> > > > > --- a/drivers/iommu/riscv/iommu-bits.h
> > > > > +++ b/drivers/iommu/riscv/iommu-bits.h
> > > > > @@ -192,67 +192,6 @@ enum riscv_iommu_ddtp_modes {
> > > > >  #define RISCV_IOMMU_IPSR_PMIP          BIT(RISCV_IOMMU_INTR_PM)
> > > > >  #define RISCV_IOMMU_IPSR_PIP           BIT(RISCV_IOMMU_INTR_PQ)
> > > > >
> > > > > -/* 5.19 Performance monitoring counter overflow status (32bits) =
*/
> > > > > -#define RISCV_IOMMU_REG_IOCOUNTOVF     0x0058
> > > > > -#define RISCV_IOMMU_IOCOUNTOVF_CY      BIT(0)
> > > > > -#define RISCV_IOMMU_IOCOUNTOVF_HPM     GENMASK_ULL(31, 1)
> > > > > -
> > > > > -/* 5.20 Performance monitoring counter inhibits (32bits) */
> > > > > -#define RISCV_IOMMU_REG_IOCOUNTINH     0x005C
> > > > > -#define RISCV_IOMMU_IOCOUNTINH_CY      BIT(0)
> > > > > -#define RISCV_IOMMU_IOCOUNTINH_HPM     GENMASK(31, 1)
> > > > > -
> > > > > -/* 5.21 Performance monitoring cycles counter (64bits) */
> > > > > -#define RISCV_IOMMU_REG_IOHPMCYCLES     0x0060
> > > > > -#define RISCV_IOMMU_IOHPMCYCLES_COUNTER        GENMASK_ULL(62, 0=
)
> > > > > -#define RISCV_IOMMU_IOHPMCYCLES_OF     BIT_ULL(63)
> > > > > -
> > > > > -/* 5.22 Performance monitoring event counters (31 * 64bits) */
> > > > > -#define RISCV_IOMMU_REG_IOHPMCTR_BASE  0x0068
> > > > > -#define RISCV_IOMMU_REG_IOHPMCTR(_n)   (RISCV_IOMMU_REG_IOHPMCTR=
_BASE + ((_n) * 0x8))
> > > > > -
> > > > > -/* 5.23 Performance monitoring event selectors (31 * 64bits) */
> > > > > -#define RISCV_IOMMU_REG_IOHPMEVT_BASE  0x0160
> > > > > -#define RISCV_IOMMU_REG_IOHPMEVT(_n)   (RISCV_IOMMU_REG_IOHPMEVT=
_BASE + ((_n) * 0x8))
> > > > > -#define RISCV_IOMMU_IOHPMEVT_EVENTID   GENMASK_ULL(14, 0)
> > > > > -#define RISCV_IOMMU_IOHPMEVT_DMASK     BIT_ULL(15)
> > > > > -#define RISCV_IOMMU_IOHPMEVT_PID_PSCID GENMASK_ULL(35, 16)
> > > > > -#define RISCV_IOMMU_IOHPMEVT_DID_GSCID GENMASK_ULL(59, 36)
> > > > > -#define RISCV_IOMMU_IOHPMEVT_PV_PSCV   BIT_ULL(60)
> > > > > -#define RISCV_IOMMU_IOHPMEVT_DV_GSCV   BIT_ULL(61)
> > > > > -#define RISCV_IOMMU_IOHPMEVT_IDT       BIT_ULL(62)
> > > > > -#define RISCV_IOMMU_IOHPMEVT_OF                BIT_ULL(63)
> > > > > -
> > > > > -/* Number of defined performance-monitoring event selectors */
> > > > > -#define RISCV_IOMMU_IOHPMEVT_CNT       31
> > > > > -
> > > > > -/**
> > > > > - * enum riscv_iommu_hpmevent_id - Performance-monitoring event i=
dentifier
> > > > > - *
> > > > > - * @RISCV_IOMMU_HPMEVENT_INVALID: Invalid event, do not count
> > > > > - * @RISCV_IOMMU_HPMEVENT_URQ: Untranslated requests
> > > > > - * @RISCV_IOMMU_HPMEVENT_TRQ: Translated requests
> > > > > - * @RISCV_IOMMU_HPMEVENT_ATS_RQ: ATS translation requests
> > > > > - * @RISCV_IOMMU_HPMEVENT_TLB_MISS: TLB misses
> > > > > - * @RISCV_IOMMU_HPMEVENT_DD_WALK: Device directory walks
> > > > > - * @RISCV_IOMMU_HPMEVENT_PD_WALK: Process directory walks
> > > > > - * @RISCV_IOMMU_HPMEVENT_S_VS_WALKS: First-stage page table walk=
s
> > > > > - * @RISCV_IOMMU_HPMEVENT_G_WALKS: Second-stage page table walks
> > > > > - * @RISCV_IOMMU_HPMEVENT_MAX: Value to denote maximum Event IDs
> > > > > - */
> > > > > -enum riscv_iommu_hpmevent_id {
> > > > > -       RISCV_IOMMU_HPMEVENT_INVALID    =3D 0,
> > > > > -       RISCV_IOMMU_HPMEVENT_URQ        =3D 1,
> > > > > -       RISCV_IOMMU_HPMEVENT_TRQ        =3D 2,
> > > > > -       RISCV_IOMMU_HPMEVENT_ATS_RQ     =3D 3,
> > > > > -       RISCV_IOMMU_HPMEVENT_TLB_MISS   =3D 4,
> > > > > -       RISCV_IOMMU_HPMEVENT_DD_WALK    =3D 5,
> > > > > -       RISCV_IOMMU_HPMEVENT_PD_WALK    =3D 6,
> > > > > -       RISCV_IOMMU_HPMEVENT_S_VS_WALKS =3D 7,
> > > > > -       RISCV_IOMMU_HPMEVENT_G_WALKS    =3D 8,
> > > > > -       RISCV_IOMMU_HPMEVENT_MAX        =3D 9
> > > > > -};
> > > > > -
> > > > >  /* 5.24 Translation request IOVA (64bits) */
> > > > >  #define RISCV_IOMMU_REG_TR_REQ_IOVA     0x0258
> > > > >  #define RISCV_IOMMU_TR_REQ_IOVA_VPN    GENMASK_ULL(63, 12)
> > > > > diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> > > > > index 245e7bb763b9..8cce6c2ea626 100644
> > > > > --- a/drivers/perf/Kconfig
> > > > > +++ b/drivers/perf/Kconfig
> > > > > @@ -105,6 +105,18 @@ config RISCV_PMU_SBI
> > > > >           full perf feature support i.e. counter overflow, privil=
ege mode
> > > > >           filtering, counter configuration.
> > > > >
> > > > > +config RISCV_IOMMU_PMU
> > > > > +       depends on RISCV || COMPILE_TEST
> > > > > +       depends on RISCV_IOMMU
> > > > > +       bool "RISC-V IOMMU Hardware Performance Monitor"
> > > > > +       default y
> > > > > +       help
> > > > > +         Say Y if you want to use the RISC-V IOMMU performance m=
onitor
> > > > > +         implementation. The performance monitor is an optional =
hardware
> > > > > +         feature, and whether it is actually enabled depends on =
IOMMU
> > > > > +         hardware support. If the underlying hardware does not i=
mplement
> > > > > +         the PMU, this option will have no effect.
> > > > > +
> > > > >  config STARFIVE_STARLINK_PMU
> > > > >         depends on ARCH_STARFIVE || COMPILE_TEST
> > > > >         depends on 64BIT
> > > > > diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> > > > > index eb8a022dad9a..90c75f3c0ac1 100644
> > > > > --- a/drivers/perf/Makefile
> > > > > +++ b/drivers/perf/Makefile
> > > > > @@ -20,6 +20,7 @@ obj-$(CONFIG_QCOM_L3_PMU) +=3D qcom_l3_pmu.o
> > > > >  obj-$(CONFIG_RISCV_PMU) +=3D riscv_pmu.o
> > > > >  obj-$(CONFIG_RISCV_PMU_LEGACY) +=3D riscv_pmu_legacy.o
> > > > >  obj-$(CONFIG_RISCV_PMU_SBI) +=3D riscv_pmu_sbi.o
> > > > > +obj-$(CONFIG_RISCV_IOMMU_PMU) +=3D riscv_iommu_pmu.o
> > > > >  obj-$(CONFIG_STARFIVE_STARLINK_PMU) +=3D starfive_starlink_pmu.o
> > > > >  obj-$(CONFIG_THUNDERX2_PMU) +=3D thunderx2_pmu.o
> > > > >  obj-$(CONFIG_XGENE_PMU) +=3D xgene_pmu.o
> > > > > diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_=
iommu_pmu.c
> > > > > new file mode 100644
> > > > > index 000000000000..2e856289ddc9
> > > > > --- /dev/null
> > > > > +++ b/drivers/perf/riscv_iommu_pmu.c
> > > > > @@ -0,0 +1,703 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +/*
> > > > > + * Copyright (C) 2026 SiFive
> > > > > + *
> > > > > + * Authors
> > > > > + *     Zong Li <zong.li@sifive.com>
> > > > > + */
> > > > > +
> > > > > +#include <linux/auxiliary_bus.h>
> > > > > +#include <linux/io-64-nonatomic-hi-lo.h>
> > > > > +#include <linux/perf_event.h>
> > > > > +
> > > > > +#include "../iommu/riscv/iommu.h"
> > > > > +
> > > > > +/* 5.19 Performance monitoring counter overflow status (32bits) =
*/
> > > > > +#define RISCV_IOMMU_REG_IOCOUNTOVF     0x0058
> > > > > +#define RISCV_IOMMU_IOCOUNTOVF_CY      BIT(0)
> > > > > +#define RISCV_IOMMU_IOCOUNTOVF_HPM     GENMASK_ULL(31, 1)
> > > > > +
> > > > > +/* 5.20 Performance monitoring counter inhibits (32bits) */
> > > > > +#define RISCV_IOMMU_REG_IOCOUNTINH     0x005C
> > > > > +#define RISCV_IOMMU_IOCOUNTINH_CY      BIT(0)
> > > > > +#define RISCV_IOMMU_IOCOUNTINH_HPM     GENMASK(31, 0)
> > > > > +
> > > > > +/* 5.21 Performance monitoring cycles counter (64bits) */
> > > > > +#define RISCV_IOMMU_REG_IOHPMCYCLES    0x0060
> > > > > +#define RISCV_IOMMU_IOHPMCYCLES_COUNTER        GENMASK_ULL(62, 0=
)
> > > > > +#define RISCV_IOMMU_IOHPMCYCLES_OF     BIT_ULL(63)
> > > > > +#define RISCV_IOMMU_REG_IOHPMCTR(_n)   (RISCV_IOMMU_REG_IOHPMCYC=
LES + ((_n) * 0x8))
> > > > > +
> > > > > +/* 5.22 Performance monitoring event counters (31 * 64bits) */
> > > > > +#define RISCV_IOMMU_REG_IOHPMCTR_BASE  0x0068
> > > > > +#define RISCV_IOMMU_IOHPMCTR_COUNTER   GENMASK_ULL(63, 0)
> > > > > +
> > > > > +/* 5.23 Performance monitoring event selectors (31 * 64bits) */
> > > > > +#define RISCV_IOMMU_REG_IOHPMEVT_BASE  0x0160
> > > > > +#define RISCV_IOMMU_REG_IOHPMEVT(_n)   (RISCV_IOMMU_REG_IOHPMEVT=
_BASE + ((_n) * 0x8))
> > > > > +#define RISCV_IOMMU_IOHPMEVT_EVENTID   GENMASK_ULL(14, 0)
> > > > > +#define RISCV_IOMMU_IOHPMEVT_DMASK     BIT_ULL(15)
> > > > > +#define RISCV_IOMMU_IOHPMEVT_PID_PSCID GENMASK_ULL(35, 16)
> > > > > +#define RISCV_IOMMU_IOHPMEVT_DID_GSCID GENMASK_ULL(59, 36)
> > > > > +#define RISCV_IOMMU_IOHPMEVT_PV_PSCV   BIT_ULL(60)
> > > > > +#define RISCV_IOMMU_IOHPMEVT_DV_GSCV   BIT_ULL(61)
> > > > > +#define RISCV_IOMMU_IOHPMEVT_IDT       BIT_ULL(62)
> > > > > +#define RISCV_IOMMU_IOHPMEVT_OF                BIT_ULL(63)
> > > > > +#define RISCV_IOMMU_IOHPMEVT_EVENT     GENMASK_ULL(62, 0)
> > > > > +
> > > > > +/* The total number of counters is 31 event counters plus 1 cycl=
e counter */
> > > > > +#define RISCV_IOMMU_HPM_COUNTER_NUM    32
> > > > > +
> > > > > +static int cpuhp_state;
> > > > > +
> > > > > +/**
> > > > > + * enum riscv_iommu_hpmevent_id - Performance-monitoring event i=
dentifier
> > > > > + *
> > > > > + * @RISCV_IOMMU_HPMEVENT_CYCLE: Clock cycle counter
> > > > > + * @RISCV_IOMMU_HPMEVENT_URQ: Untranslated requests
> > > > > + * @RISCV_IOMMU_HPMEVENT_TRQ: Translated requests
> > > > > + * @RISCV_IOMMU_HPMEVENT_ATS_RQ: ATS translation requests
> > > > > + * @RISCV_IOMMU_HPMEVENT_TLB_MISS: TLB misses
> > > > > + * @RISCV_IOMMU_HPMEVENT_DD_WALK: Device directory walks
> > > > > + * @RISCV_IOMMU_HPMEVENT_PD_WALK: Process directory walks
> > > > > + * @RISCV_IOMMU_HPMEVENT_S_VS_WALKS: First-stage page table walk=
s
> > > > > + * @RISCV_IOMMU_HPMEVENT_G_WALKS: Second-stage page table walks
> > > > > + * @RISCV_IOMMU_HPMEVENT_MAX: Value to denote maximum Event IDs
> > > > > + *
> > > > > + * The specification does not define an event ID for counting th=
e
> > > > > + * number of clock cycles, meaning there is no associated 'iohpm=
evt0'.
> > > > > + * Event ID 0 is an invalid event and does not overlap with any =
valid
> > > > > + * event ID. Let's repurpose ID 0 as the cycle for perf, the cyc=
le
> > > > > + * event is not actually written into any register, it serves so=
lely
> > > > > + * as an identifier.
> > > > > + */
> > > > > +enum riscv_iommu_hpmevent_id {
> > > > > +       RISCV_IOMMU_HPMEVENT_CYCLE      =3D 0,
> > > > > +       RISCV_IOMMU_HPMEVENT_URQ        =3D 1,
> > > > > +       RISCV_IOMMU_HPMEVENT_TRQ        =3D 2,
> > > > > +       RISCV_IOMMU_HPMEVENT_ATS_RQ     =3D 3,
> > > > > +       RISCV_IOMMU_HPMEVENT_TLB_MISS   =3D 4,
> > > > > +       RISCV_IOMMU_HPMEVENT_DD_WALK    =3D 5,
> > > > > +       RISCV_IOMMU_HPMEVENT_PD_WALK    =3D 6,
> > > > > +       RISCV_IOMMU_HPMEVENT_S_VS_WALKS =3D 7,
> > > > > +       RISCV_IOMMU_HPMEVENT_G_WALKS    =3D 8,
> > > > > +       RISCV_IOMMU_HPMEVENT_MAX        =3D 9
> > > > > +};
> > > > > +
> > > > > +struct riscv_iommu_pmu {
> > > > > +       struct pmu pmu;
> > > > > +       struct hlist_node node;
> > > > > +       void __iomem *reg;
> > > > > +       unsigned int on_cpu;
> > > > > +       int num_counters;
> > > > > +       u64 cycle_cntr_mask;
> > > > > +       u64 event_cntr_mask;
> > > > > +       struct perf_event *events[RISCV_IOMMU_HPM_COUNTER_NUM];
> > > > > +       DECLARE_BITMAP(used_counters, RISCV_IOMMU_HPM_COUNTER_NUM=
);
> > > > > +       u32 hi_prev[RISCV_IOMMU_HPM_COUNTER_NUM];
> > > > > +       u32 lo_prev[RISCV_IOMMU_HPM_COUNTER_NUM];
> > > > > +};
> > > > > +
> > > > > +#define to_riscv_iommu_pmu(p) (container_of(p, struct riscv_iomm=
u_pmu, pmu))
> > > > > +
> > > > > +#define RISCV_IOMMU_PMU_ATTR_EXTRACTOR(_name, _mask)            =
       \
> > > > > +       static inline u32 get_##_name(struct perf_event *event)  =
       \
> > > > > +       {                                                        =
       \
> > > > > +               return FIELD_GET(_mask, event->attr.config);     =
       \
> > > > > +       }                                                        =
       \
> > > > > +
> > > > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(event, RISCV_IOMMU_IOHPMEVT_EVENT=
ID);
> > > > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(partial_matching, RISCV_IOMMU_IOH=
PMEVT_DMASK);
> > > > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(pid_pscid, RISCV_IOMMU_IOHPMEVT_P=
ID_PSCID);
> > > > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(did_gscid, RISCV_IOMMU_IOHPMEVT_D=
ID_GSCID);
> > > > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_pid_pscid, RISCV_IOMMU_IOH=
PMEVT_PV_PSCV);
> > > > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_did_gscid, RISCV_IOMMU_IOH=
PMEVT_DV_GSCV);
> > > > > +RISCV_IOMMU_PMU_ATTR_EXTRACTOR(filter_id_type, RISCV_IOMMU_IOHPM=
EVT_IDT);
> > > > > +
> > > > > +/* Formats */
> > > > > +PMU_FORMAT_ATTR(event,            "config:0-14");
> > > > > +PMU_FORMAT_ATTR(partial_matching, "config:15");
> > > > > +PMU_FORMAT_ATTR(pid_pscid,        "config:16-35");
> > > > > +PMU_FORMAT_ATTR(did_gscid,        "config:36-59");
> > > > > +PMU_FORMAT_ATTR(filter_pid_pscid, "config:60");
> > > > > +PMU_FORMAT_ATTR(filter_did_gscid, "config:61");
> > > > > +PMU_FORMAT_ATTR(filter_id_type,   "config:62");
> > > > > +
> > > > > +static struct attribute *riscv_iommu_pmu_formats[] =3D {
> > > > > +       &format_attr_event.attr,
> > > > > +       &format_attr_partial_matching.attr,
> > > > > +       &format_attr_pid_pscid.attr,
> > > > > +       &format_attr_did_gscid.attr,
> > > > > +       &format_attr_filter_pid_pscid.attr,
> > > > > +       &format_attr_filter_did_gscid.attr,
> > > > > +       &format_attr_filter_id_type.attr,
> > > > > +       NULL,
> > > > > +};
> > > > > +
> > > > > +static const struct attribute_group riscv_iommu_pmu_format_group=
 =3D {
> > > > > +       .name =3D "format",
> > > > > +       .attrs =3D riscv_iommu_pmu_formats,
> > > > > +};
> > > > > +
> > > > > +/* Events */
> > > > > +static ssize_t riscv_iommu_pmu_event_show(struct device *dev,
> > > > > +                                         struct device_attribute=
 *attr,
> > > > > +                                         char *page)
> > > > > +{
> > > > > +       struct perf_pmu_events_attr *pmu_attr;
> > > > > +
> > > > > +       pmu_attr =3D container_of(attr, struct perf_pmu_events_at=
tr, attr);
> > > > > +
> > > > > +       return sysfs_emit(page, "event=3D0x%02llx\n", pmu_attr->i=
d);
> > > > > +}
> > > > > +
> > > > > +#define RISCV_IOMMU_PMU_EVENT_ATTR(name, id)                   \
> > > > > +       PMU_EVENT_ATTR_ID(name, riscv_iommu_pmu_event_show, id)
> > > > > +
> > > > > +static struct attribute *riscv_iommu_pmu_events[] =3D {
> > > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(cycle, RISCV_IOMMU_HPMEVENT_CY=
CLE),
> > > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(untranslated_req, RISCV_IOMMU_=
HPMEVENT_URQ),
> > > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(translated_req, RISCV_IOMMU_HP=
MEVENT_TRQ),
> > > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(ats_trans_req, RISCV_IOMMU_HPM=
EVENT_ATS_RQ),
> > > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(tlb_miss, RISCV_IOMMU_HPMEVENT=
_TLB_MISS),
> > > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(ddt_walks, RISCV_IOMMU_HPMEVEN=
T_DD_WALK),
> > > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(pdt_walks, RISCV_IOMMU_HPMEVEN=
T_PD_WALK),
> > > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(s_vs_pt_walks, RISCV_IOMMU_HPM=
EVENT_S_VS_WALKS),
> > > > > +       RISCV_IOMMU_PMU_EVENT_ATTR(g_pt_walks, RISCV_IOMMU_HPMEVE=
NT_G_WALKS),
> > > > > +       NULL,
> > > > > +};
> > > > > +
> > > > > +static const struct attribute_group riscv_iommu_pmu_events_group=
 =3D {
> > > > > +       .name =3D "events",
> > > > > +       .attrs =3D riscv_iommu_pmu_events,
> > > > > +};
> > > > > +
> > > > > +/* cpumask */
> > > > > +static ssize_t riscv_iommu_cpumask_show(struct device *dev,
> > > > > +                                       struct device_attribute *=
attr,
> > > > > +                                       char *buf)
> > > > > +{
> > > > > +       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(dev_ge=
t_drvdata(dev));
> > > > > +
> > > > > +       return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu-=
>on_cpu));
> > > > > +}
> > > > > +
> > > > > +static struct device_attribute riscv_iommu_cpumask_attr =3D
> > > > > +       __ATTR(cpumask, 0444, riscv_iommu_cpumask_show, NULL);
> > > > > +
> > > > > +static struct attribute *riscv_iommu_cpumask_attrs[] =3D {
> > > > > +       &riscv_iommu_cpumask_attr.attr,
> > > > > +       NULL
> > > > > +};
> > > > > +
> > > > > +static const struct attribute_group riscv_iommu_pmu_cpumask_grou=
p =3D {
> > > > > +       .attrs =3D riscv_iommu_cpumask_attrs,
> > > > > +};
> > > > > +
> > > > > +static const struct attribute_group *riscv_iommu_pmu_attr_grps[]=
 =3D {
> > > > > +       &riscv_iommu_pmu_cpumask_group,
> > > > > +       &riscv_iommu_pmu_format_group,
> > > > > +       &riscv_iommu_pmu_events_group,
> > > > > +       NULL,
> > > > > +};
> > > > > +
> > > > > +/* PMU Operations */
> > > > > +static void riscv_iommu_pmu_set_counter(struct riscv_iommu_pmu *=
pmu, u32 idx,
> > > > > +                                       u64 value)
> > > > > +{
> > > > > +       u64 counter_mask =3D idx ? pmu->event_cntr_mask : pmu->cy=
cle_cntr_mask;
> > > > > +
> > > > > +       writeq(value & counter_mask, pmu->reg + RISCV_IOMMU_REG_I=
OHPMCTR(idx));
> > > > #include <include/linux/io-64-nonatomic-lo-hi.h>
> > > > lo_hi_writeq(value & counter_mask, pmu->reg + RISCV_IOMMU_REG_IOHPM=
CTR(idx));
> > > >
> > > > For better compatibility, it is recommended to use writel and readl
> > > > instead of readq and writeq. Sorry for overlooking this last time =
=E2=80=94
> > > > could you please make the change again?
> > > > In the future, your driver could support RV32 directly, as the RISC=
-V
> > > > IOMMU specification also supports RV32; it's just that the current
> > > > RISC-V IOMMU driver's Kconfig depends on 64BIT.
> > >
> > > Hi Guo,
> > > Thank you for your review. In my implementation for RV32, readq and
> > > writeq are replaced by hi_lo_readq and hi_lo_writeq (from
> > > io-64-nonatomic-hi-lo.h). So, supporting RV32 should be fine.
> > > However, as you mentioned before: 64-bit access might be undefined on
> > > some hardware. To be safe and compatible with all hardware, we should
> > > use 32-bit access instead of 64-bit access.
> > > I will modify them in the next version
> > >
> > > I'd like to make sure I didn't miss anything important. My original
> > > code uses the "hi-lo" order. May I ask if there is a specific reason
> > > why you prefer the "lo-hi" order?
> > > Thanks
> > >
> >
> > Hi all,
> > I have been thinking more about the IOMMU register access behavior and
> > would like to share my thoughts regarding the lo-hi vs. hi-lo access
> > order.
> >
> > It seems to me that the correct 32-bit write order is strictly tied to
> > the underlying hardware implementation. From the software side, we
> > have no way of knowing whether a specific vendor designed their
> > hardware with a low-part trigger or a high-part trigger. Therefore,
> > hardcoding a fixed 32-bit write sequence could result in compatibility
> > issues across different hardware designs.
> >
> > Revisiting the spec regarding the UNSPECIFIED 8-byte atomic access,
> > this might imply that the hardware itself will handle the split into
> > two 4-byte accesses and internally manage its own trigger logic.
> > Because of this, for RV64 systems, software might simply use standard
> > 8-byte writes (e.g., writeq). Delegating the access handling to the
> > hardware is likely the best way to maximize compatibility across all
> > vendor implementations. For the counter reading strategy (hi-lo-hi
> > pattern), I completely agree with using the hi-lo-hi pattern when
> > reading the PMU counters. Since this is a read operation and does not
> > alter hardware state.
> >
> > For RV32 support, we inevitably face the 32-bit access splitting
> > issue. For the RV32 case, maybe we can assume the hi-lo order as the
> > default fallback, because the IOMMU specification uses this sequence
> > as example: "an access may appear, internally to the IOMMU, as if two
> > separate 4 byte accesses - first to the high half and second to the
> > low half - were performed.". Or do you prefer to use the same
> > assumption (hi-lo pattern) in RV64 as well?
> >
> > Please let me know what you think about this.
> >
> > Thanks
>
> You're right, RV32 is not a valid argument here =E2=80=94 my wording was
> incorrect. Thanks for pointing that out.
> Also, I have no strong preference for lo-hi; that was just a careless
> copy-paste on my part. I agree hi-lo is the right choice.
>

May I confirm if you still expect to use the hi-lo pattern to 'write'
to 64-bit registers in RV64? Or would you agree that we should let the
hardware handle this behavior, since software couldn't know the high
part/low part trigger behavior?

> Thanks again for your great work.
>
> --
> Best Regards
>  Guo Ren
