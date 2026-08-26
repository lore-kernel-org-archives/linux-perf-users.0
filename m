Received: from va-2-26.ptr.blmpb.com (va-2-26.ptr.blmpb.com [209.127.231.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07F13B6C06
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Aug 2026 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732895; cv=none; b=nziUjBTZZYNPMJo2pXJUZtoThTHk56j7CAAaNouAkkZ8gSfgIshJ+enVYuEsF8C1DC3KjBr7mgHJlcatww8eDWC8pon+6ZyW2rc+SSiO8uVXgmDdGknMxezEHC9tYSj05PPM7Q3694TU+u0LcuUd4jQmyZOu0NU17UNR0WYNtP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732895; c=relaxed/simple;
	bh=ExPGEL3fKHrSXAac3Y/eauD+YfVC8H/QTdqjCB+sk8U=;
	h=References:In-Reply-To:From:Date:To:Content-Type:Cc:Subject:
	 Message-Id:Mime-Version; b=j7ZJy9LjjeDO0l6nZj6+JxBD9tCvyw0zpR2LGUwynulZ44wd4KJgy+8Xf5wAxPCwjalYDUq9fMjy+zGemJ2w3rSg+dOT5+b9lohFnUzVBD9P3Wvwwj95Uw97uL7lky7LFVMFvxsxP6l+zP0dsktECq1spJvQU0rOZ5WiT0iPxFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=EhtALBa0; arc=none smtp.client-ip=209.127.231.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="EhtALBa0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1787732878; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=WO2BCPR/8KRc3BQ0bllOBFiz4a3Wu8hjsL+uVPJ43H0=;
 b=EhtALBa0lisCCEGyRsVifyVF3gwVJ2q3zApxFKVoRU7sIrNKvyQG8AaBrawTxtwJ196hOQ
 9TE2rGzVhKfeJt5i27DcjL5VQLWtjedG3LpGzFTtssHndkCU2mlOHH65eOcH1yNgWZ7ofH
 dXN+l+Q1HR3GdJmGKuLHQBPuijY/dQEXbAM/9xspX+bLM4d6uo5prWD+GKLkdDikFJNJC9
 SpgeZYHHjx/6r6BkEueIjalrDphNkkYlmDW+L0ovpGLTbeMUO0rKjOZVzj3srEPtpj+kr6
 tvGyyjbYyF43zgLGNbcEB6ut9Z/fsT7CXeRmZ19lFPgQrZpiA/1sAGmC/0lzlQ==
X-Lms-Return-Path: <lba+26a8ea38c+2f2f63+vger.kernel.org+yang.yicong@picoheart.com>
References: <20260824022034.3916570-1-zong.li@sifive.com> <20260824022034.3916570-2-zong.li@sifive.com>
In-Reply-To: <20260824022034.3916570-2-zong.li@sifive.com>
Content-Transfer-Encoding: 7bit
From: "Yicong Yang" <yang.yicong@picoheart.com>
Date: Wed, 26 Aug 2026 16:27:52 +0800
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
To: "Zong Li" <zong.li@sifive.com>
Received: from [100.86.213.231] ([61.141.241.110]) by smtp.feishu.cn with ESMTPS; Wed, 26 Aug 2026 16:27:55 +0800
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
Cc: <tomasz.jeznach@linux.dev>, <joro@8bytes.org>, <will@kernel.org>, 
	<robin.murphy@arm.com>, <pjw@kernel.org>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <mark.rutland@arm.com>, 
	<andrew.jones@oss.qualcomm.com>, <guoren@kernel.org>, 
	<david.laight.linux@gmail.com>, <zhangzhanpeng.jasper@bytedance.com>, 
	<iommu@lists.linux.dev>, <linux-riscv@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>, 
	<yang.yicong@picoheart.com>, "Chen Pei" <cp0613@linux.alibaba.com>, 
	"Fangyu Yu" <fangyu.yu@linux.alibaba.com>
Subject: Re: [PATCH v6 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu driver
Message-Id: <ab59c5b8-2915-4d59-8766-7a6297224494@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Language: en-US

On 8/24/26 10:20 AM, Zong Li wrote:
> Add a new driver to support the RISC-V IOMMU PMU. This is an auxiliary
> device driver created by the parent RISC-V IOMMU driver.
> 
> The performance monitor provides counters with filtering support to
> collect events for specific device ID/process ID, or GSCID/PSCID.
> 
> The RISC-V IOMMU PMU separates the cycle counter from the event counters.
> The cycle counter is not associated with iohpmevt0, so a software-defined
> cycle event is required for the perf subsystem.
> 
> The number and width of the counters are hardware-implemented and must
> be detected at runtime.
> 
> Leave out all the dead cleanup code (i.e. .remove() operation) if the
> PMU driver is tied to the IOMMU driver and can never realistically be
> removed.
> 
> PMU-related definitions are moved into the perf driver, where they are
> used exclusively.
> 
> According to RISC-V IOMMU specification Chapter 6:
> Whether an 8 byte access to an IOMMU register is single-copy atomic is
> UNSPECIFIED. Use two separate 4 byte accesses for hardware
> compatibility.
> 
> Tested-by: Chen Pei <cp0613@linux.alibaba.com>
> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> Suggested-by: David Laight <david.laight.linux@gmail.com>
> Suggested-by: Guo Ren <guoren@kernel.org>
> Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpkin/
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  drivers/iommu/riscv/iommu-bits.h |  61 ---
>  drivers/perf/Kconfig             |  12 +
>  drivers/perf/Makefile            |   1 +
>  drivers/perf/riscv_iommu_pmu.c   | 813 +++++++++++++++++++++++++++++++
>  4 files changed, 826 insertions(+), 61 deletions(-)
>  create mode 100644 drivers/perf/riscv_iommu_pmu.c
> 

[...]

> +
> +/* cpumask */
> +static ssize_t riscv_iommu_cpumask_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	struct riscv_iommu_pmu *pmu = to_riscv_iommu_pmu(dev_get_drvdata(dev));
> +
> +	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pmu->on_cpu));

needs to use sysfs_emit(), cpumap_print_to_pagebuf is removed in 7.3-rc

https://lore.kernel.org/lkml/20260702154725.185376-1-ynorov@nvidia.com/

> +}
> +

[...]

> +
> +static int riscv_iommu_pmu_probe(struct auxiliary_device *auxdev,
> +				 const struct auxiliary_device_id *id)
> +{
> +	struct  riscv_iommu_device *iommu_dev = dev_get_platdata(&auxdev->dev);
> +	struct riscv_iommu_pmu *iommu_pmu;
> +	void __iomem *addr;
> +	char *name;
> +	int ret;
> +
> +	iommu_pmu = devm_kzalloc(&auxdev->dev, sizeof(*iommu_pmu), GFP_KERNEL);
> +	if (!iommu_pmu)
> +		return -ENOMEM;
> +
> +	iommu_pmu->reg = iommu_dev->reg;
> +
> +	/*
> +	 * Counter number and width are hardware-implemented.
> +	 * Detect them by write 1s. Counter should be consecutive.
> +	 */
> +	addr = iommu_pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> +	writel(RISCV_IOMMU_IOCOUNTINH_HPM, addr);
> +	iommu_pmu->num_counters = hweight32(readl(addr));
> +
> +	addr = iommu_pmu->reg + RISCV_IOMMU_REG_IOHPMCYCLES;
> +	riscv_iommu_pmu_writeq(RISCV_IOMMU_IOHPMCYCLES_COUNTER, addr);
> +	iommu_pmu->cycle_cntr_mask = riscv_iommu_pmu_readq(addr);
> +
> +	/* Assume the width of all event counters are the same */
> +	addr = iommu_pmu->reg + RISCV_IOMMU_REG_IOHPMCTR_BASE;
> +	riscv_iommu_pmu_writeq(RISCV_IOMMU_IOHPMCTR_COUNTER, addr);
> +	iommu_pmu->event_cntr_mask = riscv_iommu_pmu_readq(addr);
> +
> +	iommu_pmu->pmu = (struct pmu) {
> +		.module		= THIS_MODULE,
> +		.parent		= &auxdev->dev,
> +		.task_ctx_nr	= perf_invalid_context,
> +		.event_init	= riscv_iommu_pmu_event_init,
> +		.add		= riscv_iommu_pmu_add,
> +		.del		= riscv_iommu_pmu_del,
> +		.start		= riscv_iommu_pmu_start,
> +		.stop		= riscv_iommu_pmu_stop,
> +		.read		= riscv_iommu_pmu_read,
> +		.attr_groups	= riscv_iommu_pmu_attr_grps,
> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> +	};
> +
> +	auxiliary_set_drvdata(auxdev, iommu_pmu);
> +
> +	name = devm_kasprintf(&auxdev->dev, GFP_KERNEL,
> +			      "riscv_iommu_pmu_%u", auxdev->id);
> +	if (!name) {
> +		dev_err(&auxdev->dev, "Failed to create name riscv_iommu_pmu%u\n",
> +			auxdev->id);
> +		return -ENOMEM;
> +	}
> +
> +	iommu_pmu->numa_node = dev_to_node(iommu_dev->dev);
> +	iommu_pmu->irq = riscv_iommu_pmu_get_irq_num(iommu_dev);
> +
> +	ret = riscv_iommu_pmu_request_irq(auxdev, iommu_dev, iommu_pmu);
> +	if (ret) {
> +		dev_err(&auxdev->dev, "Failed to request irq %s: %d\n", name, ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Bind all events to the same cpu context to avoid race enabling.
> +	 * Pick a local CPU from the numa node of this iommu for the locality.
> +	 *
> +	 * Hold the hotplug lock until this instance is registered, otherwise
> +	 * the CPU picked here could go offline in between. The teardown
> +	 * callback does not run for an instance which is not registered yet,
> +	 * so nothing would move the PMU off that CPU afterwards.
> +	 */
> +	cpus_read_lock();
> +
> +	iommu_pmu->on_cpu = cpumask_local_spread(0, iommu_pmu->numa_node);
> +	ret = irq_set_affinity(iommu_pmu->irq, cpumask_of(iommu_pmu->on_cpu));
> +	if (ret)
> +		dev_dbg(&auxdev->dev, "failed to set irq %u affinity to cpu %u: %d\n",
> +			iommu_pmu->irq, iommu_pmu->on_cpu, ret);
> +
> +	ret = cpuhp_state_add_instance_nocalls_cpuslocked(cpuhp_state,
> +							 &iommu_pmu->node);
> +
> +	cpus_read_unlock();

it could be simplified to init the ->on_cpu in the hotplug handler without
holding the cpu hotplug lock like below:

iommu_pmu->on_cpu = -1;
ret = cpuhp_state_add_instance() /* init the ->on_cpu in the hotplug handler */

otherwise looks good to me.

Reviewed-by: Yicong Yang <yang.yicong@picoheart.com>

> +
> +	if (ret) {
> +		dev_err(&auxdev->dev, "Failed to register hotplug %s: %d\n", name, ret);
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&auxdev->dev,
> +				       riscv_iommu_pmu_remove_cpuhp_instance,
> +				       iommu_pmu);
> +	if (ret)
> +		return ret;
> +
> +	ret = perf_pmu_register(&iommu_pmu->pmu, name, -1);
> +	if (ret) {
> +		dev_err(&auxdev->dev, "Failed to registe %s: %d\n", name, ret);
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&auxdev->dev,
> +				       riscv_iommu_pmu_do_unregister,
> +				       iommu_pmu);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The PMU name only carries the aux dev id, not the iommu dev name, so
> +	 * find the iommu dev name here to map this PMU back to its iommu dev.
> +	 */
> +	dev_info(&auxdev->dev, "%s: Registered with %d counters (iommu %s)\n",
> +		 name, iommu_pmu->num_counters, dev_name(iommu_dev->dev));
> +
> +	return 0;
> +}
> +
> +static const struct auxiliary_device_id riscv_iommu_pmu_id_table[] = {
> +	{ .name = "riscv-iommu.pmu" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(auxiliary, riscv_iommu_pmu_id_table);
> +
> +static struct auxiliary_driver iommu_pmu_driver = {
> +	.driver = {
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe		= riscv_iommu_pmu_probe,
> +	.id_table	= riscv_iommu_pmu_id_table,
> +};
> +
> +static int __init riscv_iommu_pmu_init(void)
> +{
> +	int ret;
> +
> +	cpuhp_state = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> +					      "perf/riscv/iommu:online",
> +					      riscv_iommu_pmu_online_cpu,
> +					      riscv_iommu_pmu_offline_cpu);
> +	if (cpuhp_state < 0)
> +		return cpuhp_state;
> +
> +	ret = auxiliary_driver_register(&iommu_pmu_driver);
> +	if (ret)
> +		cpuhp_remove_multi_state(cpuhp_state);
> +
> +	return ret;
> +}
> +module_init(riscv_iommu_pmu_init);
> +
> +MODULE_DESCRIPTION("RISC-V IOMMU PMU");
> +MODULE_LICENSE("GPL");
