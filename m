Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD03943B3FE
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311338; cv=pass; b=ef4AQrYANGtZKnQrtSU/1UeF0JwosMkWmPTKPniwrhdAUpv1QDOCzZjd++8F7ZsI6i/a2MrjfJzO00UvW+lKhlqIGe1tSwQwId4LuIYozIG9We8ukBWhsUaL/TiBOKIr5nAjGfSXMSg65PlDOof/rqh6ndyu5WGM5Y4OX7fxLbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311338; c=relaxed/simple;
	bh=URNc7pvZGIUWBxZNrrNz2Y+PPMSQiAqwryx7bMP5NOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFAqx/CoLJuG9U7VyZFb7f6sNJ+w0nzloyzkIesw2+HHBFC5iMYY0KeTg6RI8DjepAHJQP4cVjyMCIXZiczriXRGVh22oDsfsC0QDyCy5+5kM1F1z2IUr7HHRF25e/j4RsmbtjOYmj99jvib0iZOe+BQOA/S7VogwuGyG9nWjzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=nXXs3qun; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nXXs3qun"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69fdcb13fdbso1465238a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 00:48:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785311323; cv=none;
        d=google.com; s=arc-20260327;
        b=isA+3t2Zfw8vFiX7UZiHonqpNU1SVYhX4rbzrHCg8YOj7jSqrBTbSnUAHV+uvJz86L
         WwTqjar1cZvre0Trw9ZHpRUhEcZgzDMvMeJnIIfCHLWKE3LbfDK8JrBQDDJuC/pXJg0x
         v5DCXRnhR7SFut43t65AUkG+rIaJEhSZG36bWlWOi8fu1qVamol5Fzb2/D8sXClMS9Tc
         QsyqeUKzll1MqRs5AWhti6gu5M8Xv1eqfsgst2YdKc2aVIIZw2Is/TbqIKl9w7o7wxkB
         Ebsdn0t8l7kNzP3jCDfXBX+QnIlg8e0Ta4ZfMOpEncj7uUtTKTguvHaFGrQ2oN+f6abx
         XbHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1ZGzBQU4lqnubRUt2pDsncpBlVA8v40YWsv2eJeSgT0=;
        fh=wFmG0UvUja3FhvtEKDDu/j74xnxog4wCGGdoU1o9dtA=;
        b=Mq6o43YLvYChrJbhsDsLHX4qxrQVJ2m38nDagbWQ5GyvHnyckssJvOgES+XnOApMiG
         9SWFGjkndjFPP25wLRrrMfDSlcXm0QTEuRi6zQXYkJ9k070SDZ3m2n1G++IA754Ifhv+
         9xkRWEZwFPK8TbgyegeE/gGfvHnfqn4G/BilQdQ9Wcq4pf2mX46GaxvYy42GxwZHh/Jt
         3fsyIsnqnj6+e0SqL9H6vbBrTh7/hXJ7flHGjTobK+3Jqj5HBO+u4PFloPFa2oQtJDy3
         x+Sus752+UEAvX6cTvtCqjfJS7qvFWuw6O9NOw896cyHGWdaYPuhaPnN/67swMK3RtNB
         Qcjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1785311323; x=1785916123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1ZGzBQU4lqnubRUt2pDsncpBlVA8v40YWsv2eJeSgT0=;
        b=nXXs3qunrfCGnp7Xa19rt5a9DEAprbwYi+uDUWwQVnYs3hjte0uVm5cYHVO4UVoIu9
         EYWBFlIezea/nuvlTWAKjSGGubVLmhehjBE30mMXZ+T/QCRvlMnODWieCI19EnOmvhWj
         Kf0/Vp1TgQbpXqRppHlTSf4RWTixzaQuet2/MMIs8uW8JaXgZ9FIpuu2/4fpj3NxhAad
         hQkvJM/795mIELIYr9vw6v/tdRDWn4g6Uydtp1HIBGr4HoTfAVRxrjCSxK2tdAj3ATSC
         z9vI/mcHC+Ua1rOfeZ5bnxLmYkUx1Sb6WY1mxDwQqwF2t2fGEoP/N0NkLBrbYSYN2NKD
         5R3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785311323; x=1785916123;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1ZGzBQU4lqnubRUt2pDsncpBlVA8v40YWsv2eJeSgT0=;
        b=SvnFD7xEVTr/XFtj8rePGD6Ut5C/+SeS83tQkfvkICIF1G8hbQZFB7sx3GyH1IeNRM
         cTCnFUyXBq70s4irP29sR7NMXrawcoz/99tvxE3m7LnduXdBYSN/JScKRW0tDmd2pkyu
         iQWpYIjjMkF0W2lx2h/13Dsg9h6Rdgw29gLfX2xSCEDVoQEQbCL+i5ASgDhUR2Uh/hMH
         +BmPM9KtbOOBOH2RJ5lUDj5usr7mubeq4Fh4AeAuLq7aQF49zrFEm1M3o5p/aSVHpBOS
         N00dFxVTwbF3+C4BuWEqPV9Y7dJ5WTzeZN0OUOb3vl7uRDWUoJVT1LWai/5XVmzmeuIf
         Yvgg==
X-Forwarded-Encrypted: i=1; AHgh+RpHOuermNnPWZm7BGPTm9zvokz4stBzyJNHIhVtuHujBueijTSWUDa5o0kgPrQ6JdCU8auMX1y9k1a5G6o5JUcm@vger.kernel.org
X-Gm-Message-State: AOJu0YyoJjf+He3zQssRH19wfkO4DIGregBkTr+icfmDuUtcrrmTzMmW
	Neo14/80H18+/Szzz3l/YYhikBTZUai1uqj2UORuXDFrIZjkcXx6v9rGxMN3nOQZSJge2O6RfzA
	kXyC3ye4G412pnTpS05rgjn4Rwccyxeo5M22+H8o1Ig==
X-Gm-Gg: AR+sD12rcUVXsTliiY7beAxxMSUWJxnWLBr8mpRT1B4hEtDK/THygE783VVhyOLmxiK
	QTdjTgOVlkazDkv5k04jSMdRrA2SyJzk7fBl0B+o+O/qgchYZgmJYihPthVgPH1l+KExnZZu5/C
	MKQpid1PhFI+t8WLtbIAYpdaqjNx+PkyjgQj1T7Go39Kn8htmdRU3PDqUHfYp2w0nPu1FRxkflj
	ykZSyyEcbqG4Om2LrLaZfmKljMIJxH0oB+/sFRT8ijCb8d0RnPPxqMxn34WBoRF89cVTDJx20qM
	Bf4S5UwYg4KTilIpR/97IxhRxmlVY8HVTdcgRRZQSKYJYcM=
X-Received: by 2002:a05:6402:a209:10b0:69c:5eb6:d913 with SMTP id
 4fb4d7f45d1cf-6a052ffb3e6mr415234a12.14.1785311323098; Wed, 29 Jul 2026
 00:48:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714083625.1083606-1-zong.li@sifive.com> <20260714083625.1083606-2-zong.li@sifive.com>
 <6a5dc092-d0b5-4304-acfb-9de161f2bfd6@picoheart.com> <CANXhq0o1t5D76pscjqHteLjGJB4Z2iSS1a=o0+JCjKQtdPJ+vQ@mail.gmail.com>
 <47de2c31-04e0-4095-84a2-81e18b5fc855@picoheart.com>
In-Reply-To: <47de2c31-04e0-4095-84a2-81e18b5fc855@picoheart.com>
From: Zong Li <zong.li@sifive.com>
Date: Wed, 29 Jul 2026 15:48:30 +0800
X-Gm-Features: AUfX_mzYcGtlPbViM4iooW3jm0P0ERi1IuGxyhFH9Kwe0mbAOXv20JGGSl6YN-Q
Message-ID: <CANXhq0p9HnnU9BOhDVPT8_WMn4uY6h+QoOeh3OnG0EWO6dzHNw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu driver
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, mark.rutland@arm.com, 
	andrew.jones@oss.qualcomm.com, guoren@kernel.org, 
	david.laight.linux@gmail.com, zhangzhanpeng.jasper@bytedance.com, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 5:32=E2=80=AFPM Yicong Yang <yang.yicong@picoheart.=
com> wrote:
>
> On 7/22/26 1:15 PM, Zong Li wrote:
> > On Mon, Jul 20, 2026 at 3:29=E2=80=AFPM Yicong Yang <yang.yicong@picohe=
art.com> wrote:
> >>
> >> Hi Zong,
> >>
> >> On 7/14/26 4:36 PM, Zong Li wrote:
> >>> Add a new driver to support the RISC-V IOMMU PMU. This is an auxiliar=
y
> >>> device driver created by the parent RISC-V IOMMU driver.
> >>>
> >>> The RISC-V IOMMU PMU separates the cycle counter from the event count=
ers.
> >>> The cycle counter is not associated with iohpmevt0, so a software-def=
ined
> >>> cycle event is required for the perf subsystem.
> >>>
> >>> The number and width of the counters are hardware-implemented and mus=
t
> >>> be detected at runtime.
> >>>
> >>> The performance monitor provides counters with filtering support to
> >>> collect events for specific device ID/process ID, or GSCID/PSCID.
> >>>
> >>> According to RISC-V IOMMU specification Chapter 6:
> >>> Whether an 8 byte access to an IOMMU register is single-copy atomic i=
s
> >>> UNSPECIFIED. Use two separate 4 byte accesses for hardware
> >>> compatibility.
> >>>
> >>> PMU-related definitions are moved into the perf driver, where they ar=
e
> >>> used exclusively.
> >>>
> >>> Suggested-by: David Laight <david.laight.linux@gmail.com>
> >>> Suggested-by: Guo Ren <guoren@kernel.org>
> >>> Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pum=
pkin/
> >>> Signed-off-by: Zong Li <zong.li@sifive.com>
> >>> ---
> >>>  drivers/iommu/riscv/iommu-bits.h |  61 ---
> >>>  drivers/perf/Kconfig             |  12 +
> >>>  drivers/perf/Makefile            |   1 +
> >>>  drivers/perf/riscv_iommu_pmu.c   | 722 +++++++++++++++++++++++++++++=
++
> >>>  4 files changed, 735 insertions(+), 61 deletions(-)
> >>>  create mode 100644 drivers/perf/riscv_iommu_pmu.c
> >>>
>
> [...]
>
> >>> +
> >>> +static irqreturn_t riscv_iommu_pmu_irq_handler(int irq, void *dev_id=
)
> >>> +{
> >>> +     struct riscv_iommu_pmu *pmu =3D (struct riscv_iommu_pmu *)dev_i=
d;
> >>> +     DECLARE_BITMAP(ovf_bitmap, RISCV_IOMMU_HPM_COUNTER_NUM);
> >>> +     u32 ovf, idx;
> >>> +
> >>> +     /* Check whether this interrupt is for PMU */
> >>> +     if (!(readl_relaxed(pmu->reg + RISCV_IOMMU_REG_IPSR) & RISCV_IO=
MMU_IPSR_PMIP))
> >>> +             return IRQ_NONE;
> >>> +
> >>> +     /* Process PMU IRQ */
> >>> +     riscv_iommu_pmu_stop_all(pmu);
> >>> +
> >>> +     ovf =3D readl(pmu->reg + RISCV_IOMMU_REG_IOCOUNTOVF);
> >>> +     if (!ovf)
> >>> +             return IRQ_NONE;
> >>> +
> >>> +     bitmap_from_u64(ovf_bitmap, ovf);
> >>> +     for_each_set_bit(idx, ovf_bitmap, pmu->num_counters) {
> >>> +             struct perf_event *event =3D pmu->events[idx];
> >>> +
> >>> +             if (WARN_ON_ONCE(!event))
> >>> +                     continue;
> >>> +
> >>> +             riscv_iommu_pmu_update(event);
> >>> +             riscv_iommu_pmu_set_period(event);
> >>> +             riscv_iommu_pmu_clear_ovf(event, idx);
> >>> +     }
> >>> +
> >>> +     /* Clear performance monitoring interrupt pending bit */
> >>> +     writel_relaxed(RISCV_IOMMU_IPSR_PMIP, pmu->reg + RISCV_IOMMU_RE=
G_IPSR);
> >>> +
> >>> +     riscv_iommu_pmu_start_all(pmu);
> >>> +
> >>> +     return IRQ_HANDLED;
> >>> +}
> >>> +
> >>> +static unsigned int riscv_iommu_pmu_get_irq_num(struct riscv_iommu_d=
evice *iommu)
> >>> +{
> >>> +     /* Reuse ICVEC.CIV mask for all interrupt vectors mapping */
> >>> +     int vec =3D (iommu->icvec >> (RISCV_IOMMU_INTR_PM * 4)) & RISCV=
_IOMMU_ICVEC_CIV;
> >>> +
> >>> +     return iommu->irqs[vec];
> >>> +}
> >>> +
> >>> +static int riscv_iommu_pmu_request_irq(struct riscv_iommu_device *io=
mmu,
> >>> +                                    struct riscv_iommu_pmu *pmu)
> >>> +{
> >>> +     return devm_request_irq(iommu->dev, pmu->irq, riscv_iommu_pmu_i=
rq_handler,
> >>> +                             IRQF_NOBALANCING | IRQF_SHARED, dev_nam=
e(iommu->dev), pmu);
> >>
> >> need IRQF_NO_THREAD to avoid force thread of the handler.
> >>
> >> it's a PMU exclusive interrupt, reason to make it IRQF_SHARED?
> >
> > PMU interrupt can be shared with the queue's interrupt (such as the
> > command queue, fault queue, and so on). Also, in the IOMMU driver,
> > these queue interrupts are handled as threaded IRQ
> >
>
> you can keep iommu's handler threaded while pmu's still in
> the top half, so it doesn't matter to set IRQF_SHARED.

Thanks for clarifying. I will remove it.

>
> if so we cannot ensure the count's updated in the atmoic
> context on event->cpu, which is required by the perf core
> to keep serializaiton. e.g. possible for the other users
> bind this irq to another cpu other than event->cpu?

Normally, this IRQ is dedicated to the IOMMU and is not shared with
other devices. It just shares the same IRQ among different interrupt
types within the IOMMU (e.g., command queue, fault queue and so on).
The IOMMU driver won't modify the CPU affinity. Even if it happens to
do so, the auxiliary device driver initializes after the IOMMU driver.
As a result, the CPU affinity will eventually apply the settings from
here.

>
>
> >>
> >>> +}
> >>> +
> >>> +static int riscv_iommu_pmu_probe(struct auxiliary_device *auxdev,
> >>> +                              const struct auxiliary_device_id *id)
> >>> +{
> >>> +     struct  riscv_iommu_device *iommu_dev =3D dev_get_platdata(&aux=
dev->dev);
> >>> +     struct riscv_iommu_pmu *iommu_pmu;
> >>> +     void __iomem *addr;
> >>> +     char *name;
> >>> +     int ret;
> >>> +
> >>> +     iommu_pmu =3D devm_kzalloc(&auxdev->dev, sizeof(*iommu_pmu), GF=
P_KERNEL);
> >>> +     if (!iommu_pmu)
> >>> +             return -ENOMEM;
> >>> +
> >>> +     iommu_pmu->reg =3D iommu_dev->reg;
> >>> +
> >>> +     /* Counter number and width are hardware-implemented. Detect th=
em by write 1s */
> >>> +     addr =3D iommu_pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> >>> +     writel(RISCV_IOMMU_IOCOUNTINH_HPM, addr);
> >>> +     iommu_pmu->num_counters =3D hweight32(readl(addr));
> >>> +
> >>> +     addr =3D iommu_pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;
> >>> +     riscv_iommu_pmu_writeq(RISCV_IOMMU_IOHPMCYCLES_COUNTER, addr);
> >>> +     iommu_pmu->cycle_cntr_mask =3D riscv_iommu_pmu_readq(addr);
> >>> +
> >>> +     /* Assume the width of all event counters are the same */
> >>> +     addr =3D iommu_pmu->reg + RISCV_IOMMU_REG_IOHPMCTR_BASE;
> >>> +     riscv_iommu_pmu_writeq(RISCV_IOMMU_IOHPMCTR_COUNTER, addr);
> >>> +     iommu_pmu->event_cntr_mask =3D riscv_iommu_pmu_readq(addr);
> >>> +
> >>> +     iommu_pmu->pmu =3D (struct pmu) {
> >>> +             .module         =3D THIS_MODULE,
> >>> +             .parent         =3D &auxdev->dev,
> >>> +             .task_ctx_nr    =3D perf_invalid_context,
> >>> +             .event_init     =3D riscv_iommu_pmu_event_init,
> >>> +             .add            =3D riscv_iommu_pmu_add,
> >>> +             .del            =3D riscv_iommu_pmu_del,
> >>> +             .start          =3D riscv_iommu_pmu_start,
> >>> +             .stop           =3D riscv_iommu_pmu_stop,
> >>> +             .read           =3D riscv_iommu_pmu_read,
> >>> +             .attr_groups    =3D riscv_iommu_pmu_attr_grps,
> >>> +             .capabilities   =3D PERF_PMU_CAP_NO_EXCLUDE,
> >>> +     };
> >>> +
> >>> +     auxiliary_set_drvdata(auxdev, iommu_pmu);
> >>> +
> >>> +     name =3D devm_kasprintf(&auxdev->dev, GFP_KERNEL,
> >>> +                           "riscv_iommu_pmu_%s", dev_name(iommu_dev-=
>dev));
> >>
> >> this name is a bit unfriendly for a platform iommu. perf use ":" as
> >> a special delimiter, so I need to double quote the event like:
> >>
> >>   perf stat -e "'riscv_iommu_pmu_RSCV0004:00'/cycle/"
> >>
> >> possible to make it something like riscv_iommu_pmu_RSCV0004_00?
> >
> > Ok, this will also happen in the PCIe case. Let's find a way to modify
> > it. Or do you have any idea for the name?
> >
>
> maybe just replace ":" with "_" or use the PFN to distinguish
> like arm smmu pmcg. the latter one will eliminate the
> implementation differences (platform or pci device) but may
> not suitable since it's hard to find the connection between
> iommu and it's related pmu as iommu is still named by device
> name.
>
> I see the PCIe based IOMMU is named in the raw BDF encoding
> in fengyu's test [1] but it should be separate by ":", did
> I miss something for the name of PCIe based IOMMU?

I am not quite sure how his name is generated, but on my QEMU virtual
machine, it shows as riscv_iommu_pmu_0000:00:01.0

>
> [1] https://lore.kernel.org/linux-riscv/20260714083625.1083606-1-zong.li@=
sifive.com/T/#m847cd5cba7f53e9191e09e64ef604c7c38fd0173
>
> >>
> >>> +     if (!name) {
> >>> +             dev_err(&auxdev->dev, "Failed to create name riscv_iomm=
u_pmu_%s\n",
> >>> +                     dev_name(iommu_dev->dev));
> >>> +             return -ENOMEM;
> >>> +     }
> >>> +
> >>> +     /* Bind all events to the same cpu context to avoid race enabli=
ng */
> >>> +     iommu_pmu->on_cpu =3D raw_smp_processor_id();
> >>
> >> smp_processor_id() should be enough.
> >
> > Perhaps we should try to get the local CPU of iommu as above.
> >
> >>
> >>> +     iommu_pmu->irq =3D riscv_iommu_pmu_get_irq_num(iommu_dev);
> >>> +     WARN_ON(irq_set_affinity(iommu_pmu->irq, cpumask_of(iommu_pmu->=
on_cpu)));
> >>> +
> >>> +     ret =3D riscv_iommu_pmu_request_irq(iommu_dev, iommu_pmu);
> >>> +     if (ret) {
> >>> +             dev_err(&auxdev->dev, "Failed to request irq %s: %d\n",=
 name, ret);
> >>> +             return ret;
> >>> +     }
> >>> +
> >>> +     ret =3D cpuhp_state_add_instance_nocalls(cpuhp_state, &iommu_pm=
u->node);
> >>> +     if (ret) {
> >>> +             dev_err(&auxdev->dev, "Failed to register hotplug %s: %=
d\n", name, ret);
> >>> +             return ret;
> >>> +     }
> >>> +
> >>> +     ret =3D perf_pmu_register(&iommu_pmu->pmu, name, -1);
> >>> +     if (ret) {
> >>> +             dev_err(&auxdev->dev, "Failed to registe %s: %d\n", nam=
e, ret);
> >>> +             goto err_unregister;
> >>> +     }
> >>> +
> >>> +     dev_info(&auxdev->dev, "%s: Registered with %d counters\n",
> >>> +              name, iommu_pmu->num_counters);
> >>> +
> >>> +     return 0;
> >>> +
> >>> +err_unregister:
> >>> +     cpuhp_state_remove_instance_nocalls(cpuhp_state, &iommu_pmu->no=
de);> +  return ret;
> >>> +}
> >>> +
> >>> +static const struct auxiliary_device_id riscv_iommu_pmu_id_table[] =
=3D {
> >>> +     { .name =3D "iommu.pmu" },
> >>
> >> it's clear and consistent to name it as "riscv-iommu.pmu".
> >> you've already have this "riscv" prefix in other places
> >> like the name of the PMU.
> >
> > Ok. Let's add prefix in the next version
> >
> >>
> >>> +     {}
> >>> +};
> >>> +MODULE_DEVICE_TABLE(auxiliary, riscv_iommu_pmu_id_table);
> >>> +
> >>> +static struct auxiliary_driver iommu_pmu_driver =3D {
> >>> +     .probe          =3D riscv_iommu_pmu_probe,
> >>
> >> need ->remove() to clean up the resources like PMU and cpuhp instance
> >> on driver unbind. otherwise you can use devm_add_action_or_reset()
> >> to make them device managed.
> >
> > As suggested by Robin in my v1 version,  we might be inclined to just
> > leave out all the dead cleanup code if the PMU driver is tied to the
> > IOMMU driver and can never realistically be removed. So in my
> > subsequent versions, I didn't add any cleanup code.
> >
>
> ok, thanks for the background.
>
> then need to ensure there will be no possible removal from the
> userspace, e.g. at least set driver::suppress_bind_attrs to
> avoid manual unbind.

I missed this. Thanks for the reminder

>
> in fact it's the auxiliary device tied to the iommu driver
> rather than this auxiliary driver. as only the pmu and
> cpuhp registration lack cleanups (you've already made
> other resources device managed), it'll be easy to do
> the cleanups and support this driver as a module. but it's
> up to you.
>
> thanks.
>
> >>
> >>> +     .id_table       =3D riscv_iommu_pmu_id_table,
> >>> +};
> >>> +
> >>> +static int __init riscv_iommu_pmu_init(void)
> >>> +{
> >>> +     int ret;
> >>> +
> >>> +     cpuhp_state =3D cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> >>> +                                           "perf/riscv/iommu:online"=
,
> >>> +                                           riscv_iommu_pmu_online_cp=
u,
> >>> +                                           riscv_iommu_pmu_offline_c=
pu);
> >>> +     if (cpuhp_state < 0)
> >>> +             return cpuhp_state;
> >>> +
> >>> +     ret =3D auxiliary_driver_register(&iommu_pmu_driver);
> >>> +     if (ret)
> >>> +             cpuhp_remove_multi_state(cpuhp_state);
> >>> +
> >>> +     return ret;
> >>> +}
> >>> +module_init(riscv_iommu_pmu_init);
> >>
> >> it'll be easy to make it a module for debug and test.
> >>
> >> thanks.
