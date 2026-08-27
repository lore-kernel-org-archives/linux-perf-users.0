Received: from sg-3-42.ptr.tlmpb.com (sg-3-42.ptr.tlmpb.com [101.45.255.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070A43655EC
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Aug 2026 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824706; cv=none; b=IhxPO4+27jDnpRgsZs4aQYqX711DyaOOVlKYE8j6qUyhy7mjZigOxMWeetjA3m/mRGYTTe55FIEPe7WIBbdoCixSfnfksuEYQTJKHggQY/A39vbWOVnS6E6ntL7WodgKw/yVAHbm3suBtrBbZVcCf9fk+Ho0KrrdfACmMa7vnyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824706; c=relaxed/simple;
	bh=g0i7BzTHw+LoTqsWFZHKrxgcUsHHBFnN2GgyqE5Nr3M=;
	h=To:Subject:In-Reply-To:Message-Id:Mime-Version:References:
	 Content-Type:Cc:From:Date; b=a16brise9xEZNnh4opjwDX5LIsPqG0HCNsUImHaUh98eX3B87x6CkIskq/c2aU7WJwsqDKVphd2yVVa+91EzP+JNAYmvjv+eH2Ao1JSC4176Usa3rkRfh6/+OY8zUQaHSlKk35aXbLbJtGkbkTRnM3Nl4cBiVIiTeeZ+0SLNJP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=hGWauXts; arc=none smtp.client-ip=101.45.255.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="hGWauXts"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1787824628; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=m/El6VdFg1V5R5NeV9pyCuzRYF24l5MoaRr2+pu7OAE=;
 b=hGWauXtsaX9vcbe6SeS9b8MWvo62NijGlKVwvpLjCWIzOMlH3jjfeHM7PSvJWKsItPUB9I
 YlpV33gtUZYwUCODtpQf9iUYfLTJcNnJWKnf1wPj2MVkalKXKo9E8cc+G305kLFkDDu/Eb
 jusM662k+Zn6s9QFVIJwfo2MLyjRQOBVuYYdzY63x8SIAHdPwAij7W7oM8sTLonFVDj8WX
 KJTMweSQeBaRv7BxY6GwiSGF7dTUa8Ma3BALPTSnm1EUl2lbCP1mFatLMHhy1qe3IuKtlF
 EpHazMzlP5roWmx84Z+5twyOMMfbmIs+dd9vp9foFaUSxNk3ZR2dThsXIiIIiw==
To: "Zong Li" <zong.li@sifive.com>
Subject: Re: [PATCH v6 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu driver
Content-Language: en-US
In-Reply-To: <CANXhq0rBYWyLztFQzLCPx1vMSdahcuH-kfKPGO+WRDvFEW6Osg@mail.gmail.com>
Message-Id: <6c4c4785-eb68-47b2-bbf5-ad77a9414100@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
References: <20260824022034.3916570-1-zong.li@sifive.com> <20260824022034.3916570-2-zong.li@sifive.com> <ab59c5b8-2915-4d59-8766-7a6297224494@picoheart.com> <CANXhq0rBYWyLztFQzLCPx1vMSdahcuH-kfKPGO+WRDvFEW6Osg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: quoted-printable
Cc: <yang.yicong@picoheart.com>, <tomasz.jeznach@linux.dev>, 
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>, 
	<pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, 
	<alex@ghiti.fr>, <mark.rutland@arm.com>, <andrew.jones@oss.qualcomm.com>, 
	<guoren@kernel.org>, <david.laight.linux@gmail.com>, 
	<zhangzhanpeng.jasper@bytedance.com>, <iommu@lists.linux.dev>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	<linux-perf-users@vger.kernel.org>, 
	"Chen Pei" <cp0613@linux.alibaba.com>, 
	"Fangyu Yu" <fangyu.yu@linux.alibaba.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Date: Thu, 27 Aug 2026 17:57:01 +0800
Received: from [100.86.213.231] ([61.141.241.110]) by smtp.feishu.cn with ESMTPS; Thu, 27 Aug 2026 17:57:04 +0800
X-Lms-Return-Path: <lba+26a9009f2+b6b150+vger.kernel.org+yang.yicong@picoheart.com>

On 8/27/26 5:22 PM, Zong Li wrote:
> On Wed, Aug 26, 2026 at 4:28=E2=80=AFPM Yicong Yang <yang.yicong@picohear=
t.com> wrote:
>>
>> On 8/24/26 10:20 AM, Zong Li wrote:
>>> Add a new driver to support the RISC-V IOMMU PMU. This is an auxiliary
>>> device driver created by the parent RISC-V IOMMU driver.
>>>
>>> The performance monitor provides counters with filtering support to
>>> collect events for specific device ID/process ID, or GSCID/PSCID.
>>>
>>> The RISC-V IOMMU PMU separates the cycle counter from the event counter=
s.
>>> The cycle counter is not associated with iohpmevt0, so a software-defin=
ed
>>> cycle event is required for the perf subsystem.
>>>
>>> The number and width of the counters are hardware-implemented and must
>>> be detected at runtime.
>>>
>>> Leave out all the dead cleanup code (i.e. .remove() operation) if the
>>> PMU driver is tied to the IOMMU driver and can never realistically be
>>> removed.
>>>
>>> PMU-related definitions are moved into the perf driver, where they are
>>> used exclusively.
>>>
>>> According to RISC-V IOMMU specification Chapter 6:
>>> Whether an 8 byte access to an IOMMU register is single-copy atomic is
>>> UNSPECIFIED. Use two separate 4 byte accesses for hardware
>>> compatibility.
>>>
>>> Tested-by: Chen Pei <cp0613@linux.alibaba.com>
>>> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>> Reviewed-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
>>> Suggested-by: David Laight <david.laight.linux@gmail.com>
>>> Suggested-by: Guo Ren <guoren@kernel.org>
>>> Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpk=
in/
>>> Signed-off-by: Zong Li <zong.li@sifive.com>
>>> ---
>>>  drivers/iommu/riscv/iommu-bits.h |  61 ---
>>>  drivers/perf/Kconfig             |  12 +
>>>  drivers/perf/Makefile            |   1 +
>>>  drivers/perf/riscv_iommu_pmu.c   | 813 +++++++++++++++++++++++++++++++
>>>  4 files changed, 826 insertions(+), 61 deletions(-)
>>>  create mode 100644 drivers/perf/riscv_iommu_pmu.c
>>>
>>
>> [...]
>>
>>> +
>>> +/* cpumask */
>>> +static ssize_t riscv_iommu_cpumask_show(struct device *dev,
>>> +                                     struct device_attribute *attr,
>>> +                                     char *buf)
>>> +{
>>> +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(dev_get_drvdat=
a(dev));
>>> +
>>> +     return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->on_cpu)=
);
>>
>> needs to use sysfs_emit(), cpumap_print_to_pagebuf is removed in 7.3-rc
>>
>> https://lore.kernel.org/lkml/20260702154725.185376-1-ynorov@nvidia.com/
>>
>=20
> I will fix it in the next version. Thanks
>=20
>>> +}
>>> +
>>
>> [...]
>>
>>> +
>>> +static int riscv_iommu_pmu_probe(struct auxiliary_device *auxdev,
>>> +                              const struct auxiliary_device_id *id)
>>> +{
>>> +     struct  riscv_iommu_device *iommu_dev =3D dev_get_platdata(&auxde=
v->dev);
>>> +     struct riscv_iommu_pmu *iommu_pmu;
>>> +     void __iomem *addr;
>>> +     char *name;
>>> +     int ret;
>>> +
>>> +     iommu_pmu =3D devm_kzalloc(&auxdev->dev, sizeof(*iommu_pmu), GFP_=
KERNEL);
>>> +     if (!iommu_pmu)
>>> +             return -ENOMEM;
>>> +
>>> +     iommu_pmu->reg =3D iommu_dev->reg;
>>> +
>>> +     /*
>>> +      * Counter number and width are hardware-implemented.
>>> +      * Detect them by write 1s. Counter should be consecutive.
>>> +      */
>>> +     addr =3D iommu_pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
>>> +     writel(RISCV_IOMMU_IOCOUNTINH_HPM, addr);
>>> +     iommu_pmu->num_counters =3D hweight32(readl(addr));
>>> +
>>> +     addr =3D iommu_pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;
>>> +     riscv_iommu_pmu_writeq(RISCV_IOMMU_IOHPMCYCLES_COUNTER, addr);
>>> +     iommu_pmu->cycle_cntr_mask =3D riscv_iommu_pmu_readq(addr);
>>> +
>>> +     /* Assume the width of all event counters are the same */
>>> +     addr =3D iommu_pmu->reg + RISCV_IOMMU_REG_IOHPMCTR_BASE;
>>> +     riscv_iommu_pmu_writeq(RISCV_IOMMU_IOHPMCTR_COUNTER, addr);
>>> +     iommu_pmu->event_cntr_mask =3D riscv_iommu_pmu_readq(addr);
>>> +
>>> +     iommu_pmu->pmu =3D (struct pmu) {
>>> +             .module         =3D THIS_MODULE,
>>> +             .parent         =3D &auxdev->dev,
>>> +             .task_ctx_nr    =3D perf_invalid_context,
>>> +             .event_init     =3D riscv_iommu_pmu_event_init,
>>> +             .add            =3D riscv_iommu_pmu_add,
>>> +             .del            =3D riscv_iommu_pmu_del,
>>> +             .start          =3D riscv_iommu_pmu_start,
>>> +             .stop           =3D riscv_iommu_pmu_stop,
>>> +             .read           =3D riscv_iommu_pmu_read,
>>> +             .attr_groups    =3D riscv_iommu_pmu_attr_grps,
>>> +             .capabilities   =3D PERF_PMU_CAP_NO_EXCLUDE,
>>> +     };
>>> +
>>> +     auxiliary_set_drvdata(auxdev, iommu_pmu);
>>> +
>>> +     name =3D devm_kasprintf(&auxdev->dev, GFP_KERNEL,
>>> +                           "riscv_iommu_pmu_%u", auxdev->id);
>>> +     if (!name) {
>>> +             dev_err(&auxdev->dev, "Failed to create name riscv_iommu_=
pmu%u\n",
>>> +                     auxdev->id);
>>> +             return -ENOMEM;
>>> +     }
>>> +
>>> +     iommu_pmu->numa_node =3D dev_to_node(iommu_dev->dev);
>>> +     iommu_pmu->irq =3D riscv_iommu_pmu_get_irq_num(iommu_dev);
>>> +
>>> +     ret =3D riscv_iommu_pmu_request_irq(auxdev, iommu_dev, iommu_pmu)=
;
>>> +     if (ret) {
>>> +             dev_err(&auxdev->dev, "Failed to request irq %s: %d\n", n=
ame, ret);
>>> +             return ret;
>>> +     }
>>> +
>>> +     /*
>>> +      * Bind all events to the same cpu context to avoid race enabling=
.
>>> +      * Pick a local CPU from the numa node of this iommu for the loca=
lity.
>>> +      *
>>> +      * Hold the hotplug lock until this instance is registered, other=
wise
>>> +      * the CPU picked here could go offline in between. The teardown
>>> +      * callback does not run for an instance which is not registered =
yet,
>>> +      * so nothing would move the PMU off that CPU afterwards.
>>> +      */
>>> +     cpus_read_lock();
>>> +
>>> +     iommu_pmu->on_cpu =3D cpumask_local_spread(0, iommu_pmu->numa_nod=
e);
>>> +     ret =3D irq_set_affinity(iommu_pmu->irq, cpumask_of(iommu_pmu->on=
_cpu));
>>> +     if (ret)
>>> +             dev_dbg(&auxdev->dev, "failed to set irq %u affinity to c=
pu %u: %d\n",
>>> +                     iommu_pmu->irq, iommu_pmu->on_cpu, ret);
>>> +
>>> +     ret =3D cpuhp_state_add_instance_nocalls_cpuslocked(cpuhp_state,
>>> +                                                      &iommu_pmu->node=
);
>>> +
>>> +     cpus_read_unlock();
>>
>> it could be simplified to init the ->on_cpu in the hotplug handler witho=
ut
>> holding the cpu hotplug lock like below:
>>
>> iommu_pmu->on_cpu =3D -1;
>> ret =3D cpuhp_state_add_instance() /* init the ->on_cpu in the hotplug h=
andler */
>=20
> It seems we might lose the benefits of cumask_local_spread this way.
>=20

could use cpumask_local_spread() in the online handler for a local cpu,
refer to dwc_pcie_pmu.c.

>>
>> otherwise looks good to me.
>>
>> Reviewed-by: Yicong Yang <yang.yicong@picoheart.com>
>>
>>> +
>>> +     if (ret) {
>>> +             dev_err(&auxdev->dev, "Failed to register hotplug %s: %d\=
n", name, ret);
>>> +             return ret;
>>> +     }
>>> +
>>> +     ret =3D devm_add_action_or_reset(&auxdev->dev,
>>> +                                    riscv_iommu_pmu_remove_cpuhp_insta=
nce,
>>> +                                    iommu_pmu);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     ret =3D perf_pmu_register(&iommu_pmu->pmu, name, -1);
>>> +     if (ret) {
>>> +             dev_err(&auxdev->dev, "Failed to registe %s: %d\n", name,=
 ret);
>>> +             return ret;
>>> +     }
>>> +
>>> +     ret =3D devm_add_action_or_reset(&auxdev->dev,
>>> +                                    riscv_iommu_pmu_do_unregister,
>>> +                                    iommu_pmu);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     /*
>>> +      * The PMU name only carries the aux dev id, not the iommu dev na=
me, so
>>> +      * find the iommu dev name here to map this PMU back to its iommu=
 dev.
>>> +      */
>>> +     dev_info(&auxdev->dev, "%s: Registered with %d counters (iommu %s=
)\n",
>>> +              name, iommu_pmu->num_counters, dev_name(iommu_dev->dev))=
;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static const struct auxiliary_device_id riscv_iommu_pmu_id_table[] =3D=
 {
>>> +     { .name =3D "riscv-iommu.pmu" },
>>> +     {}
>>> +};
>>> +MODULE_DEVICE_TABLE(auxiliary, riscv_iommu_pmu_id_table);
>>> +
>>> +static struct auxiliary_driver iommu_pmu_driver =3D {
>>> +     .driver =3D {
>>> +             .suppress_bind_attrs =3D true,
>>> +     },
>>> +     .probe          =3D riscv_iommu_pmu_probe,
>>> +     .id_table       =3D riscv_iommu_pmu_id_table,
>>> +};
>>> +
>>> +static int __init riscv_iommu_pmu_init(void)
>>> +{
>>> +     int ret;
>>> +
>>> +     cpuhp_state =3D cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
>>> +                                           "perf/riscv/iommu:online",
>>> +                                           riscv_iommu_pmu_online_cpu,
>>> +                                           riscv_iommu_pmu_offline_cpu=
);
>>> +     if (cpuhp_state < 0)
>>> +             return cpuhp_state;
>>> +
>>> +     ret =3D auxiliary_driver_register(&iommu_pmu_driver);
>>> +     if (ret)
>>> +             cpuhp_remove_multi_state(cpuhp_state);
>>> +
>>> +     return ret;
>>> +}
>>> +module_init(riscv_iommu_pmu_init);
>>> +
>>> +MODULE_DESCRIPTION("RISC-V IOMMU PMU");
>>> +MODULE_LICENSE("GPL");
