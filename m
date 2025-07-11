Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262401FBEB9;
	Fri, 11 Jul 2025 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245124; cv=none; b=qwfzcP5QE5aItkoXwqG6vv+cP7f/yHpFypz9dMVFpaFL904+mYjE/TUKql9BNUDqgAa1i2lYSkkyvcaUh2HrWef3QUT4vGtyizrIbqOtW0JSKOrURCt7CeQc8wgoCibhSCMd73WHkaObD4ilPB4cU8vRbe2mlFVFwTsE6nOGj2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245124; c=relaxed/simple;
	bh=BVCFPAe+VaW716/dVJanTGMnnTm5naA6n1aU+KVhgPM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZsFQHtoYLZO+cAnKuepyc0WUtAQZZTPAJS3GIqFuL055IW1v3nJB+jlL36UNaNd3ic7Dl9Ju0KRpIwamd1d+ZOfqrZ7Xa53X5dPZNesJ2kw2xqboWuvjJph2jrzOUvtSSMvYyDvQLoyHEluE6Z/80zXL7yJSfWk+qqJVyuzIq5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdvYg0ZQbz6L55x;
	Fri, 11 Jul 2025 22:41:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5AC321402F7;
	Fri, 11 Jul 2025 22:45:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Jul
 2025 16:45:16 +0200
Date: Fri, 11 Jul 2025 15:45:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Vivek Yadav <vivek.2311@samsung.com>
CC: <pankaj.dubey@samsung.com>, <ravi.patel@samsung.com>,
	<shradha.t@samsung.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<robh@kernel.org>, <krzk@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <will@kernel.org>, <mark.rutland@arm.com>,
	<s.nawrocki@samsung.com>, <cw00.choi@samsung.com>, <alim.akhtar@samsung.com>,
	<linux-fsd@tesla.com>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH 4/6] drivers: perf: samsung: Add PPMU driver support
Message-ID: <20250711154514.000008eb@huawei.com>
In-Reply-To: <20250708103208.79444-5-vivek.2311@samsung.com>
References: <20250708103208.79444-1-vivek.2311@samsung.com>
	<CGME20250708103240epcas5p336539d4c3a1fb489708c61f9aae6bfa8@epcas5p3.samsung.com>
	<20250708103208.79444-5-vivek.2311@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue,  8 Jul 2025 16:02:06 +0530
Vivek Yadav <vivek.2311@samsung.com> wrote:

> Add Samsung PPMU driver support in the Linux perf subsystem.
> 
> PPMU24 driver configures the PPMU24 hardware which is found
> in the Samsung SoCs like Tesla FSD.
> 
> Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
> Signed-off-by: Vivek Yadav <vivek.2311@samsung.com>
Hi,

My main feedback here is that you have a layer of abstraction that is
not currently useful. So unless you plan to include another driver
that makes use of the ops structures etc, just squash the whole thing into
one much simpler c file without any of the ops stuff.

Should simplify the code a lot and generally accelerate it getting
reviewed and merged.

If it becomes useful to have that abstraction in the future, that is the
point when you should add it.

Jonathan

> diff --git a/drivers/perf/samsung/Makefile b/drivers/perf/samsung/Makefile
> new file mode 100644
> index 000000000000..c9ed1e1a986e
> --- /dev/null
> +++ b/drivers/perf/samsung/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_SAMSUNG_PPMU24) += ppmu_platform.o ppmu.o

Not immediately obvious why this is multiple files. (no exports needed
anyway as Krzysztof pointed out.

> diff --git a/drivers/perf/samsung/ppmu.c b/drivers/perf/samsung/ppmu.c
> new file mode 100644
> index 000000000000..cacb9cdec79f
> --- /dev/null
> +++ b/drivers/perf/samsung/ppmu.c
> @@ -0,0 +1,494 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Samsung Platform Performance Measuring Unit (PPMU) driver
> + *
> + * Copyright (c) 2024-25 Samsung Electronics Co., Ltd.
> + *
> + * Authors: Vivek Yadav <vivek.2311@samsung.com>
> + *          Ravi Patel <ravi.patel@samsung.com>
> + */
> +
> +#include <linux/idr.h>
> +#include <linux/of.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +#include "samsung_ppmu.h"
> +
> +#define PPMU_CLEAR_FLAG				(GENMASK(3, 0) | BIT(31))
> +
> +#define PPMU_PMCNT3_HIGH_VAL			(3)
> +#define PPMU_PMCNT2_HIGH_VAL			(2)
> +#define PPMU_RESET_CCNT				BIT(2)
> +#define PPMU_RESET_PMCNT			BIT(1)
> +
> +#define PPMU_PMNC_OP_MODE_MASK			(GENMASK(21, 20))
> +#define PPMU_PMNC_OP_MODE_OFF			(20)
> +#define PPMU_MANUAL_MODE_VAL			(0x0)
> +#define PPMU_PMNC_GLB_CNT_EN_VAL		(BIT(0))
> +#define PPMU_PMNC_RESET_PMCNT_VAL		(BIT(1))
> +#define PPMU_PMNC_RESET_CCNT_VAL		(BIT(2))
> +
> +#define PPMU_V24_IDENTIFIER			(0x45)
> +
> +#define PPMU_CCNT_IDX				(4)
> +#define PPMU_CCNT_POS_OFF			(31)
> +#define PPMU_VERSION_CHECK			(GENMASK(19, 12))
> +
> +#define PPMU_SM_ENABLE_ALL_CNT			(0xf)
> +#define PPMU_ENABLE_CCNT			BIT(31)
> +#define PPMU_FILTER_MASK			(0x7)
> +
> +/* ID of event type */
> +enum {
> +	PPMU_EVENT_READ_CHANNEL_ACTIVE		= (0x00),
> +	PPMU_EVENT_WRITE_CHANNEL_ACTIVE		= (0x01),
> +	PPMU_EVENT_READ_REQUEST			= (0x02),
> +	PPMU_EVENT_WRITE_REQUEST		= (0x03),
> +	PPMU_EVENT_READ_DATA			= (0x04),
> +	PPMU_EVENT_WRITE_DATA			= (0x05),
> +	PPMU_EVENT_WRITE_RESPONSE		= (0x06),
> +	PPMU_EVENT_LAST_READ_DATA		= (0x07),
> +	PPMU_EVENT_LAST_WRITE_DATA		= (0x08),
> +	PPMU_EVENT_READ_REQUEST_BOLCKING	= (0x10),
> +	PPMU_EVENT_WRITE_REQUEST_BOLCKING	= (0x11),
> +	PPMU_EVENT_READ_DATA_BLOCKING		= (0x12),
> +	PPMU_EVENT_WRITE_DATA_BLOCKING		= (0x13),
> +	PPMU_EVENT_WRITE_RESPONSE_BLOCKING	= (0x14),
> +	PPMU_EVENT_READ_BURST_LENGTH		= (0x2a),
> +	PPMU_EVENT_WRITE_BURST_LENGTH		= (0x2b),
> +	PPMU_EVENT_CCNT				= (0xfe),
> +	PPMU_EVENT_MAX				= (0xff),
> +};
> +
> +/* Register offsets */
> +enum ppmu_reg {
> +	PPMU_VERSION				= (0x0000),
> +	PPMU_PMNC				= (0x0004),
> +	PPMU_CNTENS				= (0x0008),
> +	PPMU_CNTENC				= (0x000c),
> +	PPMU_INTENS				= (0x0010),
> +	PPMU_INTENC				= (0x0014),
> +	PPMU_FLAG				= (0x0018),
> +	PPMU_CIG_CFG0				= (0x001c),
> +	PPMU_CIG_CFG1				= (0x0020),
> +	PPMU_CIG_CFG2				= (0x0024),
> +	PPMU_CIG_RESULT				= (0x0028),
> +	PPMU_CNT_RESET				= (0x002c),
> +	PPMU_CNT_AUTO				= (0x0030),
> +	PPMU_PMCNT0				= (0x0034),
> +	PPMU_PMCNT1				= (0x0038),
> +	PPMU_PMCNT2				= (0x003c),
> +	PPMU_PMCNT3_LOW				= (0x0040),
> +	PPMU_PMCNT3_HIGH			= (0x0044),
> +	PPMU_CCNT				= (0x0048),
> +	PPMU_PMCNT2_HIGH			= (0x0054),
> +	PPMU_CONFIG_INFO			= (0X005c),
> +	PPMU_INTERRUPT_TEST			= (0x0060),
> +	PPMU_EVENT_EV0_TYPE			= (0x0200),
> +	PPMU_EVENT_EV1_TYPE			= (0x0204),
> +	PPMU_EVENT_EV2_TYPE			= (0x0208),
> +	PPMU_EVENT_EV3_TYPE			= (0x020c),
> +	PPMU_EVENT_SM_ID_MASK			= (0x0220),
> +	PPMU_EVENT_SM_ID_VALUE			= (0x0224),
> +	PPMU_EVENT_SM_ID_A			= (0x0228),
> +	PPMU_EVENT_SM_OTHERS_V			= (0x022c),
> +	PPMU_EVENT_SM_OTHERS_A			= (0x0230),
> +	PPMU_EVENT_SAMPLE_RD_ID_MASK		= (0x0234),
> +	PPMU_EVENT_SAMPLE_RD_ID_VALUE		= (0x0238),
> +	PPMU_EVENT_SAMPLE_WR_ID_MASK		= (0x023c),
> +	PPMU_EVENT_SAMPLE_WD_ID_VALUE		= (0x0240),
> +	PPMU_EVENT_AXI_CH_TYPE			= (0x0244),
> +	PPMU_EVENT_MO_INFO			= (0x0250),
> +	PPMU_EVENT_MO_INFO_SM_ID		= (0x0254),
> +	PPMU_EVENT_MO_INFO_SAMPLE		= (0x0258),
> +	PPMU_EVENT_IMPRECISE_ERR		= (0x0260),

Brackets () not adding anything useful.


> +static void samsung_ppmu_get_stop_counters(struct samsung_ppmu *s_ppmu)
> +{
> +	u32 val;
> +
> +	/* Stop counters */
> +	val = readl(s_ppmu->base + PPMU_PMNC);
> +	val &= (~PPMU_PMNC_GLB_CNT_EN_VAL);
> +	writel(val, s_ppmu->base + PPMU_PMNC);
> +
> +	s_ppmu->status = PPMU_STOP;
If it only takes states on and off make it a bool and give it
name to indicate directly what the two states are.

	s_ppmu->started = false;

> +}

> +static const struct samsung_ppmu_ops samsung_ppmu_plat_ops = {

If there is only one implementation in a patch set it is best
to avoid abstractions and ops tables like this.

If you have multiple implementations then submit them all at once
so we can see how this is used.  For now it complicates the
driver for no known reason.


> +	.write_evtype		= samsung_ppmu_write_evtype,
> +	.get_event_idx		= samsung_ppmu_get_event_idx,
> +	.read_counter		= samsung_ppmu_get_read_counter,
> +	.enable_counter		= samsung_ppmu_get_enable_counter,
> +	.disable_counter	= samsung_ppmu_get_disable_counter,
> +	.start_counters		= samsung_ppmu_get_start_counters,
> +	.stop_counters		= samsung_ppmu_get_stop_counters,
> +	.get_int_status		= samsung_ppmu_get_int_status,
> +	.clear_int_status	= samsung_ppmu_clear_int_status,
> +};
> +
> +static int ppmu_clock_init(struct samsung_ppmu *s_ppmu)
> +{
> +	int ret = 0;
> +	struct device *dev = s_ppmu->dev;
> +
> +	s_ppmu->clks[PPMU_ACLK].id = "aclk";
> +	s_ppmu->clks[PPMU_PCLK].id = "pclk";
> +
> +	ret = devm_clk_bulk_get(dev, PPMU_CLK_COUNT, s_ppmu->clks);
> +	if (ret) {
> +		dev_err(dev, "Failed to get clocks. Err %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_bulk_prepare_enable(PPMU_CLK_COUNT, s_ppmu->clks);

> +	if (ret)
> +		dev_err(dev, "Clock enable failed. Err %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int samsung_ppmu_probe(struct platform_device *pdev)
> +{
> +	struct samsung_ppmu *s_ppmu;
> +	struct device *dev = &pdev->dev;
> +	u32 version;
> +	char *name;
> +	int ret;
> +
> +	s_ppmu = devm_kzalloc(dev, sizeof(*s_ppmu), GFP_KERNEL);
> +	if (!s_ppmu)
> +		return -ENOMEM;
> +
> +	s_ppmu->dev = &pdev->dev;
> +
> +	s_ppmu->id = idr_alloc(&my_idr, dev, 0, 2, GFP_KERNEL);

Mixing devm cleaned up stuff and things that aren't is usuall a bad
idea.  You can use devm_add_action_or_reset() to deal with allocations
and configuration that does not have it's own devm interfaces.

> +	if (s_ppmu->id < 0) {
> +		dev_err(dev, "Failed to allocate ID dynamically\n");
> +		return s_ppmu->id;
> +	}
> +
> +	/* Register base address */
> +	s_ppmu->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(s_ppmu->base)) {
> +		dev_err(dev, "IO remap failed\n");
> +		return PTR_ERR(s_ppmu->base);
> +	}
> +
> +	/* Register IRQ */
> +	ret = samsung_ppmu_init_irq(s_ppmu, pdev);
> +	if (ret)
> +		return ret;
> +
> +	s_ppmu->check_event = PPMU_EVENT_MAX;
> +	s_ppmu->num_counters = PPMU_MAX_COUNTERS;
> +	s_ppmu->on_cpu = 0;
> +	s_ppmu->identifier = PPMU_V24_IDENTIFIER;
> +
> +	s_ppmu->ppmu_data = device_get_match_data(&pdev->dev);
> +	if (!s_ppmu->ppmu_data) {
> +		dev_err(&pdev->dev, "No matching device data found\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Register PPMU driver ops */
> +	s_ppmu->pmu_events.attr_groups = s_ppmu->ppmu_data->ppmu_attr_group;
> +	s_ppmu->ops = &samsung_ppmu_plat_ops;
> +
> +	/* Set private data to platform_device structure */
> +	platform_set_drvdata(pdev, s_ppmu);
> +
> +	/* Initialize the PPMU */
> +	samsung_ppmu_init(s_ppmu, THIS_MODULE);
> +
> +	ret = ppmu_clock_init(s_ppmu);
> +	if (ret)
> +		return ret;
> +
> +	version = readl(s_ppmu->base + PPMU_VERSION);
> +	version &= PPMU_VERSION_CHECK;
> +	version >>= 12;
> +	s_ppmu->samsung_ppmu_version = version;
> +
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "ppmu_v_%x_%d", version, s_ppmu->id);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	ret = perf_pmu_register(&s_ppmu->pmu, name, -1);
> +	if (ret) {
> +		clk_bulk_disable_unprepare(PPMU_CLK_COUNT, s_ppmu->clks);
> +		dev_err(dev, "Failed to register PPMU in perf. Err %d\n", ret);
> +	}
> +
> +	return ret;
> +}
> +
> +static void samsung_ppmu_remove(struct platform_device *pdev)
> +{
> +	struct samsung_ppmu *s_ppmu = platform_get_drvdata(pdev);
> +
> +	clk_bulk_disable_unprepare(PPMU_CLK_COUNT, s_ppmu->clks);

Should reverse what happens in probe.  Here you turn off clocks bfore
you remove userspace interfaces which looks unlikely to be correct.

> +
> +	perf_pmu_unregister(&s_ppmu->pmu);
> +
> +	idr_remove(&my_idr, s_ppmu->id);
> +}

> diff --git a/drivers/perf/samsung/ppmu_platform.c b/drivers/perf/samsung/ppmu_platform.c
> new file mode 100644
> index 000000000000..ee11311d5a61
> --- /dev/null
> +++ b/drivers/perf/samsung/ppmu_platform.c
> @@ -0,0 +1,338 @@

> +int samsung_ppmu_init_irq(struct samsung_ppmu *samsung_ppmu,
> +			  struct platform_device *pdev)
> +{
> +	int irq0, irq1, ret, irq_count;
> +
> +	irq0 = platform_get_irq(pdev, 0);
> +	if (irq0 < 0) {
> +		dev_err(&pdev->dev, "Failed to get IRQ 0\n");
In stuff that only happens from probe() use
		return dev_err_probe(&pdev->dev, irq0, "Failed to get IRQ 0\n");
etc

> +		return irq0;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, irq0, samsung_ppmu_isr,
> +			       IRQF_NOBALANCING | IRQF_NO_THREAD | IRQF_SHARED,
> +			       dev_name(&pdev->dev), samsung_ppmu);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"Fail to request IRQ: %d ret: %d.\n", irq0, ret);
> +		return ret;
> +	}
> +
> +	samsung_ppmu->irq0 = irq0;
> +
> +	irq_count = of_property_count_elems_of_size(pdev->dev.of_node, "interrupts", sizeof(u32));
> +	if (irq_count > 1) {
> +		irq1 = platform_get_irq(pdev, 1);
> +		if (irq1 < 0) {
> +			dev_err(&pdev->dev, "Failed to get IRQ 0\n");
> +			return irq1;
> +		}
> +
> +		ret = devm_request_irq(&pdev->dev, irq1, samsung_ppmu_isr,
> +				       IRQF_NOBALANCING | IRQF_NO_THREAD | IRQF_SHARED,
> +				       dev_name(&pdev->dev), samsung_ppmu);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"Fail to request IRQ: %d ret: %d.\n", irq1, ret);
> +			return ret;
> +		}
> +		samsung_ppmu->irq1 = irq1;
> +	}
> +
> +	return ret;

If you know it's 0, then hard code that to make it obvious that this
is the good exit path.

	return 0;

> +}
> +EXPORT_SYMBOL_GPL(samsung_ppmu_init_irq);

> +void samsung_ppmu_disable(struct pmu *pmu)
> +{
> +	struct samsung_ppmu *samsung_ppmu = to_samsung_ppmu(pmu);
> +
> +	samsung_ppmu->ops->stop_counters(samsung_ppmu);
> +}
> +EXPORT_SYMBOL_GPL(samsung_ppmu_disable);

As noted, 1 module so no exports needed.
As in many comments in this review, if you don't have multiple
stop_counters implementations, don't have these ops wrappers.
They massively increase code complexity for no gain yet.

> +
> +void samsung_ppmu_init(struct samsung_ppmu *s_ppmu, struct module *module)
> +{
> +	struct pmu *pmu = &s_ppmu->pmu;
> +
> +	pmu->module		= module;
> +	pmu->task_ctx_nr	= perf_invalid_context;
> +	pmu->event_init		= samsung_ppmu_event_init;
> +	pmu->pmu_enable		= samsung_ppmu_enable;
> +	pmu->pmu_disable	= samsung_ppmu_disable;
> +	pmu->add		= samsung_ppmu_add;
> +	pmu->del		= samsung_ppmu_del;
> +	pmu->start		= samsung_ppmu_start;
> +	pmu->stop		= samsung_ppmu_stop;
> +	pmu->read		= samsung_ppmu_read;
> +	pmu->attr_groups	= s_ppmu->pmu_events.attr_groups;
> +	pmu->capabilities	= PERF_PMU_CAP_NO_EXCLUDE;
> +}
> +EXPORT_SYMBOL_GPL(samsung_ppmu_init);

> diff --git a/drivers/perf/samsung/samsung_ppmu.h b/drivers/perf/samsung/samsung_ppmu.h
> new file mode 100644
> index 000000000000..2cad75cfa97b
> --- /dev/null
> +++ b/drivers/perf/samsung/samsung_ppmu.h

Squashing the lot into 1 c file with no header will end up simpler I think.

> @@ -0,0 +1,128 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Samsung Platform Performance Measuring Unit (PPMU) headers
> + *
> + * Copyright (c) 2024-25 Samsung Electronics Co., Ltd.
> + *
> + * Authors: Vivek Yadav <vivek.2311@samsung.com>
> + *          Ravi Patel <ravi.patel@samsung.com>
> + */
> +
> +#ifndef __SAMSUNG_PPMU_H__
> +#define __SAMSUNG_PPMU_H__
> +
> +#include <linux/clk.h>
> +
> +#define PPMU_MAX_COUNTERS	(5)

It's a number not a macro parameter, so no need for ()

> +
> +#define to_samsung_ppmu(p)	(container_of(p, struct samsung_ppmu, pmu))
> +
> +#define SAMSUNG_PPMU_ATTR(_name, _func, _config)			\
> +	(&((struct dev_ext_attribute[]) {				\
> +		{ __ATTR(_name, 0444, _func, NULL), (void *)_config }	\
> +	})[0].attr.attr)
> +
> +#define SAMSUNG_PPMU_FORMAT_ATTR(_name, _config)		\
> +	SAMSUNG_PPMU_ATTR(_name, samsung_ppmu_format_sysfs_show, (void *)_config)
> +#define SAMSUNG_PPMU_EVENT_ATTR(_name, _config)		\
> +	SAMSUNG_PPMU_ATTR(_name, samsung_ppmu_event_sysfs_show, (unsigned long)_config)
> +
> +#define SAMSUNG_PPMU_GET_EVENTID(ev) ((ev)->hw.config_base & 0xff)
> +
> +enum ppmu_clock_type {
> +	PPMU_ACLK,
> +	PPMU_PCLK,
> +	PPMU_CLK_COUNT,

Given this is (I think) just here as a counter element and hence must always
be last, good to drop the trailing ,

> +};
> +
> +enum ppmu_status {
> +	PPMU_STOP,
> +	PPMU_START,
> +};
> +
> +struct samsung_ppmu;
> +
> +struct samsung_ppmu_ops {

As mentioned above, a ops table for one implementation looks like preparation
for generalization that may never happen.  If you don't have a second
user today, just squash the calls inline and drop this.  It is easy to
bring the abstraction back at the point where it is useful (1st patch in a series
that adds a second user of shared infrastructure)

> +	void (*write_evtype)(struct samsung_ppmu *s_ppmu, int idx, u32 type);
> +	int (*get_event_idx)(struct perf_event *event);
> +	u64 (*read_counter)(struct samsung_ppmu *s_ppmu, struct hw_perf_event *event);
> +	void (*enable_counter)(struct samsung_ppmu *s_ppmu, struct hw_perf_event *event);
> +	void (*disable_counter)(struct samsung_ppmu *s_ppmu, struct hw_perf_event *event);
> +	void (*start_counters)(struct samsung_ppmu *s_ppmu);
> +	void (*stop_counters)(struct samsung_ppmu *s_ppmu);
> +	u32 (*get_int_status)(struct samsung_ppmu *s_ppmu);
> +	void (*clear_int_status)(struct samsung_ppmu *s_ppmu, int idx);
> +};
> +
> +/* Describes the Samsung PPMU features information */
> +struct samsung_ppmu_dev_info {

Not used that I can see.  You have an instance in the structure
below but nothing ever sets it.


> +	const char *name;
> +	const struct attribute_group **attr_groups;
> +	void *private;
> +};
> +
> +struct samsung_ppmu_hwevents {
If this is never used except as encapsulation of related
fields in the main structure below then no need for the type.
Just have the structure defined inline in struct samsung_ppmu

> +	struct perf_event *hw_events[PPMU_MAX_COUNTERS];
> +	DECLARE_BITMAP(used_mask, PPMU_MAX_COUNTERS);
> +	const struct attribute_group **attr_groups;
> +};
> +
> +struct samsung_ppmu_drv_data {

Currently only one value - as such just hard code it in
the driver (all these comments only apply if you don't have another
driver to post that also uses the shared infrastructure).

> +	const struct attribute_group **ppmu_attr_group;
> +};
> +
> +/* Generic pmu struct for different pmu types */
> +struct samsung_ppmu {
> +	struct pmu pmu;
> +	const struct samsung_ppmu_ops *ops;
> +	const struct samsung_ppmu_dev_info *dev_info;
> +	struct samsung_ppmu_hwevents pmu_events;
> +	const struct samsung_ppmu_drv_data *ppmu_data;
> +	u32 samsung_ppmu_version;
> +	u32 samsung_ppmu_master_id_val;
> +	u8 status;
> +	u8 id;
> +	/* CPU used for counting */
> +	int on_cpu;
> +	int irq0;
> +	int irq1;
> +	struct device *dev;
> +	struct hlist_node node;
> +	void __iomem *base;
> +	int num_counters;
> +	u32 counter_overflow[PPMU_MAX_COUNTERS];
> +	u64 prev_counter[PPMU_MAX_COUNTERS];
> +	/* check event code range */
> +	int check_event;
> +	u32 identifier;
> +	struct clk_bulk_data clks[PPMU_CLK_COUNT];
> +};
> +
> +void samsung_ppmu_read(struct perf_event *event);
> +int samsung_ppmu_add(struct perf_event *event, int flags);
> +void samsung_ppmu_del(struct perf_event *event, int flags);
> +void samsung_ppmu_start(struct perf_event *event, int flags);
> +void samsung_ppmu_stop(struct perf_event *event, int flags);
> +void samsung_ppmu_set_event_period(struct perf_event *event);
> +void samsung_ppmu_event_update(struct perf_event *event);
> +int samsung_ppmu_event_init(struct perf_event *event);
> +void samsung_ppmu_enable(struct pmu *pmu);
> +void samsung_ppmu_disable(struct pmu *pmu);
> +ssize_t samsung_ppmu_event_sysfs_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf);
> +ssize_t samsung_ppmu_format_sysfs_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf);
> +ssize_t samsung_ppmu_cpumask_sysfs_show(struct device *dev,
> +					struct device_attribute *attr, char *buf);
> +int samsung_ppmu_online_cpu(unsigned int cpu, struct hlist_node *node);
> +int samsung_ppmu_offline_cpu(unsigned int cpu, struct hlist_node *node);
> +
> +ssize_t samsung_ppmu_identifier_attr_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *page);
> +int samsung_ppmu_init_irq(struct samsung_ppmu *samsung_ppmu,
> +			  struct platform_device *pdev);
> +
> +void samsung_ppmu_init(struct samsung_ppmu *samsung_ppmu, struct module *module);
> +
> +#endif /* __SAMSUNG_PPMU_H__ */

