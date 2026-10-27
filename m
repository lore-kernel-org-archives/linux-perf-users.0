Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140701;
	b=vYJajdfAkFwBHp+IUUIW7wg1qelLXdKTzy+QQ7dJUwD+Prd39PkNUddmjKU2BhS1HpYR
	 OyLjhNCKROp3M7zYcWcTLgPBjPwHOWz0izzcTpIH4+7NUt3BjmTAX944Awf+eIt3e2D2p
	 RFp6enQwxPboP0oY2T1aBR5yugTRLwoSVDDs6dZUPe/nl2aU7OjVpmEwCh/zWs7aYgrtB
	 BCsJUO+fnFQRCdRj3+KzL4jdPORs0VEP+SYl6JTz9l73FNNtiP2DlWppxNFIlx3dUV3mW
	 dry7R4vC3BP1AVxmSvv/2vpLfS9Gug573b6lLGEqRBm6k66+tpheCLRHHRSyWiJn2cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140701;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=EnxcP/GoF2SJtmPG/yNhv2LK3o8lF8cNzeHXovI7wlU=;
	b=NhRbLhfpgVJSTrvTjMnmZ4CsOE+/0KIS/06RaA0e2DQtGpVaNf35brhm1L8yWYOb81eH
	 HdNLfRkXKdk7DwE2qa6RGK/Wo7BKbkve/AzimUfwHAnbahKnApdAVUT7GopbOjklBdj7d
	 ylmGQKvjUeIb7elgxKtBYbRhtl0eRM+NGW8bquedmRWBC+yM7WjSINK/NRwrv3W6Dvlcu
	 +hNo0ManZdP3q6GJHlqutYVjqKyBlIMJIzds1oJfMPXJxz6JAeSc8AzPElxuKnsmDTcsh
	 o3vft4eTdbRNRvGwY3oiG/ykpVlLjgUUro4hGEMJL9dxWOlV7ZNzMkwzGAWwCN7ropA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VvnMMguX;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC81606A31A;
	Tue, 27 Oct 2026 22:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDC81606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=VvnMMguX
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80E21175D;
	Tue, 27 Oct 2026 15:38:15 -0700 (PDT)
Received: from [172.29.20.205] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 151403F673;
	Tue, 27 Oct 2026 15:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793140698; bh=DKmUioyZfws4gHtxba/Tvise4huEByL4XM6ptiUs0uQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VvnMMguX0GXfXEzSLqrXv8UAEziY792KmM+SeAW3HOTE3TO18R8/XI6bXMo+nK5QM
	 ND07BNvvo2DPVG9KK9+SOYMNu4DY3IGJejFFofWpYjYFXNHL5wYepFCFEEVZh+OOz3
	 OPlvXDcTkRzDPpCSj3k5s1o87Zb8B6Lr6l88lam4=
Message-ID: <97bde4ed-f44b-4205-9945-6c924ff268f4@arm.com>
Date: Tue, 27 Oct 2026 17:37:39 -0500
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf: arm_spe: Support heterogeneous ACPI systems
To: "Johnny.Fan" <johnny.fan@cixtech.com>, will@kernel.org,
 mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 suzuki.poulose@arm.com, mike.leach@arm.com, james.clark@linaro.org,
 leo.yan@arm.com, maz@kernel.org, cix-kernel-upstream@cixtech.com,
 bob.zhang@cixtech.com, jie.fu@cixtech.com,
 Fugang Duan <fugang.duan@cixtech.com>
References: <20261021020322.3015121-1-johnny.fan@cixtech.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20261021020322.3015121-1-johnny.fan@cixtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This largely looks reasonable, some comments inline.

On 10/20/26 9:03 PM, Johnny.Fan wrote:
> From: "Johnny.Fan" <Johnny.Fan@cixtech.com>
> 
> On heterogeneous ACPI systems, not all CPUs implement SPE, and the
> ones that do may use different PPIs. The MADT describes this per
> GICC entry: a CPU without SPE reports a zero SPE overflow interrupt,
> and the PPTT hetero id identifies CPUs of the same implementation.
> 
> The current code registers a single platform device and gives up if
> the GICC entries disagree on either the hetero id or the interrupt,
> so SPE is unavailable on such systems even though the firmware
> describes it.
> 
> Group the CPUs by (hetero id, SPE interrupt) and register one
> platform device per group. A GSI may be shared between groups with
> non-overlapping CPU masks, so only unregister the GSI mapping when
> no other group uses the same interrupt, as the mapping is not
> reference counted.
> 
> These synthetic devices have no fwnode, so the firmware-described
> IRQ affinity cannot tell which CPUs implement the feature. Pass the
> CPU mask as platform data and have the drivers prefer it over the
> IRQ affinity when present.
> 
> Apply the same treatment to TRBE, which shares this registration
> code. TRBE must also pass a stable copy of the mask to
> request_percpu_irq_affinity(), since supported_cpus is pruned as
> CPUs are probed.
> 
> Tested on a CIX sky1 SoC with heterogeneous SPE support.
> 
> Signed-off-by: Johnny.Fan <Johnny.Fan@cixtech.com>
> Reviewed-by: Fugang Duan <fugang.duan@cixtech.com>
> ---
>   drivers/hwtracing/coresight/coresight-trbe.c |  22 +-
>   drivers/perf/arm_pmu_acpi.c                  | 211 ++++++++++++-------

It makes sense to split the device creation portion in arm_pmu_acpi.c 
into its own patch separate from the consumption IMHO.

>   drivers/perf/arm_spe_pmu.c                   |  10 +-
>   include/linux/perf/arm_pmu.h                 |  10 +
>   4 files changed, 176 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index c7cbca45f2de..0c4bc8fbcaf3 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -158,6 +158,7 @@ struct trbe_drvdata {
>   	struct hlist_node hotplug_node;
>   	int irq;
>   	cpumask_t supported_cpus;
> +	cpumask_t irq_affinity;
>   	enum cpuhp_state trbe_online;
>   	struct platform_device *pdev;
>   };
> @@ -1533,6 +1534,8 @@ static void arm_trbe_remove_cpuhp(struct trbe_drvdata *drvdata)
>   static int arm_trbe_probe_irq(struct platform_device *pdev,
>   			      struct trbe_drvdata *drvdata)
>   {
> +	const struct arm_pmu_acpi_dev_data *acpi_data =
> +		dev_get_platdata(&pdev->dev);
>   	const struct cpumask *affinity;
>   	int ret;
>   
> @@ -1547,14 +1550,27 @@ static int arm_trbe_probe_irq(struct platform_device *pdev,
>   		return -EINVAL;
>   	}
>   
> -	cpumask_copy(&drvdata->supported_cpus, affinity);
> +	/*
> +	 * The ACPI path has no fwnode describing which CPUs implement TRBE,
> +	 * so it passes the mask explicitly. DT devices still use the
> +	 * firmware-described IRQ affinity.
> +	 */
> +	cpumask_copy(&drvdata->supported_cpus,
> +		     acpi_data ? &acpi_data->cpus : affinity);
> +
> +	/*
> +	 * supported_cpus gets pruned as CPUs are probed, so keep a stable
> +	 * copy for the IRQ action.
> +	 */
> +	cpumask_copy(&drvdata->irq_affinity, &drvdata->supported_cpus);
>   
>   	drvdata->handle = alloc_percpu(struct perf_output_handle *);
>   	if (!drvdata->handle)
>   		return -ENOMEM;
>   
> -	ret = request_percpu_irq_affinity(drvdata->irq, arm_trbe_irq_handler, DRVNAME,
> -					  affinity, drvdata->handle);
> +	ret = request_percpu_irq_affinity(drvdata->irq, arm_trbe_irq_handler,
> +					  DRVNAME, &drvdata->irq_affinity,
> +					  drvdata->handle);
>   	if (ret) {
>   		free_percpu(drvdata->handle);
>   		return ret;
> diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
> index ca6bf8f86cfe..fdf39673648f 100644
> --- a/drivers/perf/arm_pmu_acpi.c
> +++ b/drivers/perf/arm_pmu_acpi.c
> @@ -12,6 +12,8 @@
>   #include <linux/irqdesc.h>
>   #include <linux/percpu.h>
>   #include <linux/perf/arm_pmu.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
>   
>   #include <asm/cpu.h>
>   #include <asm/cputype.h>
> @@ -68,91 +70,165 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
>   		acpi_unregister_gsi(gsi);
>   }
>   
> -static int __maybe_unused
> -arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
> -			     u16 (*parse_gsi)(struct acpi_madt_generic_interrupt *))
> +struct arm_pmu_acpi_group {
> +	int hetid;
> +	u16 gsi;
> +	struct cpumask cpus;
> +};
> +
> +static int arm_acpi_find_group(struct arm_pmu_acpi_group *groups, int nr_groups,
> +			       int hetid, u16 gsi)
>   {
> -	int cpu, this_hetid, hetid, irq, ret;
> -	u16 this_gsi = 0, gsi = 0;
> +	int i;
>   
> -	/*
> -	 * Ensure that platform device must have IORESOURCE_IRQ
> -	 * resource to hold gsi interrupt.
> -	 */
> -	if (pdev->num_resources != 1)
> -		return -ENXIO;
> +	for (i = 0; i < nr_groups; i++) {
> +		if (groups[i].hetid == hetid && groups[i].gsi == gsi)
> +			return i;
> +	}
> +
> +	return -1;
> +}
> +
> +static bool arm_acpi_gsi_is_shared(struct arm_pmu_acpi_group *groups,
> +				   int nr_groups, int idx)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_groups; i++) {
> +		if (i != idx && groups[i].gsi == groups[idx].gsi)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int arm_acpi_register_group(struct arm_pmu_acpi_group *group,
> +				   const char *name, bool gsi_shared)
> +{
> +	struct arm_pmu_acpi_dev_data data = { };
> +	struct platform_device *pdev;
> +	struct resource res;
> +	int irq, ret;
> +
> +	irq = acpi_register_gsi(NULL, group->gsi, ACPI_LEVEL_SENSITIVE,
> +				ACPI_ACTIVE_HIGH);
> +	if (irq < 0)
> +		return irq;
> +
> +	pdev = platform_device_alloc(name, PLATFORM_DEVID_AUTO);
> +	if (!pdev) {
> +		ret = -ENOMEM;
> +		goto err_unreg;
> +	}
>   
> -	if (pdev->resource[0].flags != IORESOURCE_IRQ)
> -		return -ENXIO;
> +	res = DEFINE_RES_IRQ(irq);
> +	data.cpus = group->cpus;
>   
> +	ret = platform_device_add_resources(pdev, &res, 1);
> +	if (ret)
> +		goto err_put;
> +
> +	ret = platform_device_add_data(pdev, &data, sizeof(data));
> +	if (ret)
> +		goto err_put;
> +
> +	ret = platform_device_add(pdev);
> +	if (!ret)
> +		return 0;
> +
> +err_put:
> +	platform_device_put(pdev);
> +err_unreg:
>   	/*
> -	 * Sanity check all the GICC tables for the same interrupt
> -	 * number. For now, only support homogeneous ACPI machines.
> +	 * The GSI mapping is not reference counted, so only drop it if no
> +	 * other group shares it.
>   	 */
> +	if (!gsi_shared)
> +		acpi_unregister_gsi(group->gsi);

This is a bit odd, if whatever fails, and gets here happens on all the 
paths associated with the shared GSI, then that GSI is never 
unregistered and the resource is leaked.

> +
> +	return ret;
> +}
> +
> +static int __maybe_unused
> +arm_acpi_register_pmu_devices(const char *name, u8 len,
> +			      u16 (*parse_gsi)(struct acpi_madt_generic_interrupt *))
> +{
> +	struct arm_pmu_acpi_group *groups;
> +	int cpu, i, nr_cpus = 0, nr_groups = 0, nr_devices = 0;
> +	int last_err = 0, ret;
> +
>   	for_each_possible_cpu(cpu) {
>   		struct acpi_madt_generic_interrupt *gicc;
>   
>   		gicc = acpi_cpu_get_madt_gicc(cpu);
>   		if (gicc->header.length < len)
> -			return gsi ? -ENXIO : 0;
> -
> -		this_gsi = parse_gsi(gicc);
> -		this_hetid = find_acpi_cpu_topology_hetero_id(cpu);
> -		if (!gsi) {
> -			hetid = this_hetid;
> -			gsi = this_gsi;
> -		} else if (hetid != this_hetid || gsi != this_gsi) {
> -			pr_warn("ACPI: %s: must be homogeneous\n", pdev->name);
> -			return -ENXIO;
> -		}
> +			continue;

This continue seems like a mistake, if the firmware has provided 
unreliable tables we should abort all device creation, even if that 
means some subset of the SPE devices which appear to be correct aren't 
created.


> +		if (parse_gsi(gicc))
> +			nr_cpus++;
>   	}
>   
> -	if (!this_gsi)
> +	if (!nr_cpus)
>   		return 0;
>   
> -	irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
> -	if (irq < 0) {
> -		pr_warn("ACPI: %s Unable to register interrupt: %d\n", pdev->name, gsi);
> -		return -ENXIO;
> -	}
> +	groups = kcalloc(nr_cpus, sizeof(*groups), GFP_KERNEL);

And this seemed a bit chunky because in theory this could be NR_CPUS, 
which made me initially say, skip counting the cores and just allocate 
the max, then I realized its close to having kcalloc() failures if there 
are a lot of cores in the machine since this allocation becomes multiple 
MB. I think we are creating a future headache and need something smarter 
than counting the number of cores with valid SPE/TRBE interrupts.


> +	if (!groups)
> +		return -ENOMEM;
>   
> -	pdev->resource[0].start = irq;
> -	ret = platform_device_register(pdev);
> -	if (ret)
> -		acpi_unregister_gsi(gsi);
> +	for_each_possible_cpu(cpu) {
> +		struct acpi_madt_generic_interrupt *gicc;
> +		int hetid;
> +		u16 gsi;
>   
> -	return ret;
> -}
> +		gicc = acpi_cpu_get_madt_gicc(cpu);
> +		if (gicc->header.length < len)
> +			continue;
same continue issue here as above>
> -#if IS_ENABLED(CONFIG_ARM_SPE_PMU)
> -static struct resource spe_resources[] = {
> -	{
> -		/* irq */
> -		.flags          = IORESOURCE_IRQ,
> +		gsi = parse_gsi(gicc);
> +		if (!gsi)
> +			continue;
> +
> +		hetid = find_acpi_cpu_topology_hetero_id(cpu);

If groups were say a linked list (or something else dynamic) you could 
just use the failure case here to allocate the next entry and simply 
skip the first loop iteration above counting cpus.

> +		i = arm_acpi_find_group(groups, nr_groups, hetid, gsi);
> +		if (i < 0) {
> +			i = nr_groups++;
> +			groups[i].hetid = hetid;
> +			groups[i].gsi = gsi;
> +		}
> +
> +		cpumask_set_cpu(cpu, &groups[i].cpus);
>   	}
> -};
>   
> -static struct platform_device spe_dev = {
> -	.name = ARMV8_SPE_PDEV_NAME,
> -	.id = -1,
> -	.resource = spe_resources,
> -	.num_resources = ARRAY_SIZE(spe_resources)
> -};
> +	for (i = 0; i < nr_groups; i++) {
> +		ret = arm_acpi_register_group(&groups[i], name,
> +					      arm_acpi_gsi_is_shared(groups,
> +								     nr_groups, i));
> +		if (ret) {
> +			pr_warn("ACPI: %s: %*pbl: add device failed (%d)\n",
> +				name, cpumask_pr_args(&groups[i].cpus), ret);
> +			last_err = ret;
> +		} else {
> +			nr_devices++;
> +		}
> +	}
> +
> +	kfree(groups);
> +
> +	return nr_devices ? 0 : last_err;
> +}
>   
> +#if IS_ENABLED(CONFIG_ARM_SPE_PMU)
>   static u16 arm_spe_parse_gsi(struct acpi_madt_generic_interrupt *gicc)
>   {
>   	return gicc->spe_interrupt;
>   }
>   
> -/*
> - * For lack of a better place, hook the normal PMU MADT walk
> - * and create a SPE device if we detect a recent MADT with
> - * a homogeneous PPI mapping.
> - */
>   static void arm_spe_acpi_register_device(void)
>   {
> -	int ret = arm_acpi_register_pmu_device(&spe_dev, ACPI_MADT_GICC_SPE,
> -					       arm_spe_parse_gsi);
> +	int ret;
> +
> +	ret = arm_acpi_register_pmu_devices(ARMV8_SPE_PDEV_NAME,
> +					    ACPI_MADT_GICC_SPE,
> +					    arm_spe_parse_gsi);
>   	if (ret)
>   		pr_warn("ACPI: SPE: Unable to register device\n");
>   }
> @@ -163,20 +239,6 @@ static inline void arm_spe_acpi_register_device(void)
>   #endif /* CONFIG_ARM_SPE_PMU */
>   
>   #if IS_ENABLED(CONFIG_CORESIGHT_TRBE)
> -static struct resource trbe_resources[] = {
> -	{
> -		/* irq */
> -		.flags          = IORESOURCE_IRQ,
> -	}
> -};
> -
> -static struct platform_device trbe_dev = {
> -	.name = ARMV8_TRBE_PDEV_NAME,
> -	.id = -1,
> -	.resource = trbe_resources,
> -	.num_resources = ARRAY_SIZE(trbe_resources)
> -};
> -
>   static u16 arm_trbe_parse_gsi(struct acpi_madt_generic_interrupt *gicc)
>   {
>   	return gicc->trbe_interrupt;
> @@ -184,8 +246,11 @@ static u16 arm_trbe_parse_gsi(struct acpi_madt_generic_interrupt *gicc)
>   
>   static void arm_trbe_acpi_register_device(void)
>   {
> -	int ret = arm_acpi_register_pmu_device(&trbe_dev, ACPI_MADT_GICC_TRBE,
> -					       arm_trbe_parse_gsi);
> +	int ret;
> +
> +	ret = arm_acpi_register_pmu_devices(ARMV8_TRBE_PDEV_NAME,
> +					    ACPI_MADT_GICC_TRBE,
> +					    arm_trbe_parse_gsi);
>   	if (ret)
>   		pr_warn("ACPI: TRBE: Unable to register device\n");
>   }
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index b70f3fedf028..712b7f187301 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -1330,6 +1330,8 @@ static void arm_spe_pmu_dev_teardown(struct arm_spe_pmu *spe_pmu)
>   static int arm_spe_pmu_irq_probe(struct arm_spe_pmu *spe_pmu)
>   {
>   	struct platform_device *pdev = spe_pmu->pdev;
> +	const struct arm_pmu_acpi_dev_data *acpi_data =
> +		dev_get_platdata(&pdev->dev);
>   	const struct cpumask *affinity;
>   	int irq;
>   
> @@ -1342,7 +1344,13 @@ static int arm_spe_pmu_irq_probe(struct arm_spe_pmu *spe_pmu)
>   		return -EINVAL;
>   	}
>   
> -	cpumask_copy(&spe_pmu->supported_cpus, affinity);
> +	/*
> +	 * The ACPI path has no fwnode describing which CPUs implement SPE,
> +	 * so it passes the mask explicitly. DT devices still use the
> +	 * firmware-described IRQ affinity.
> +	 */
> +	cpumask_copy(&spe_pmu->supported_cpus,
> +		     acpi_data ? &acpi_data->cpus : affinity);
>   
>   	spe_pmu->irq = irq;
>   	return 0;
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 02d2c7f45b52..7f1c03c55025 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -8,6 +8,7 @@
>   #ifndef __ARM_PMU_H__
>   #define __ARM_PMU_H__
>   
> +#include <linux/cpumask.h>
>   #include <linux/interrupt.h>
>   #include <linux/perf_event.h>
>   #include <linux/platform_device.h>
> @@ -199,6 +200,15 @@ void armpmu_free_irq(struct arm_pmu * __percpu *armpmu, int irq, int cpu);
>   #define ARMV8_SPE_PDEV_NAME "arm,spe-v1"
>   #define ARMV8_TRBE_PDEV_NAME "arm,trbe"
>   
> +/*
> + * Per-device CPU mask passed by the ACPI MADT walk. The synthetic
> + * platform devices have no fwnode, so the IRQ affinity cannot describe
> + * which CPUs actually implement the feature.
> + */
> +struct arm_pmu_acpi_dev_data {
> +	struct cpumask cpus;
> +};
> +
>   /* Why does everything I do descend into this? */
>   #define __GEN_PMU_FORMAT_ATTR(cfg, lo, hi)				\
>   	(lo) == (hi) ? #cfg ":" #lo "\n" : #cfg ":" #lo "-" #hi

Thanks for working on this.

Jeremy

