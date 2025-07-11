Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5926320F;
	Fri, 11 Jul 2025 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752249863; cv=none; b=OjSNGBnlp5sE5/qmdjg5etk3/tKyRRURFSt7eYjk1J7gPaVdO7ssbqSbtYPE2Cr/kR/4mtsm7mLGqqz5qIJVYG4+EmzRH7ET3YfRKfBAMFyijgraUDpSz+89wtB2E6dBXSLQ7V4uQT27Rl22Huj1TeJKGP6i0UkZn36PshYlrg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752249863; c=relaxed/simple;
	bh=IAq0avLztA0tQGKDBGVN9zA80D9EBuaQyMbPP2yTD0A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVtVRtzCXOV6KyoDYngeHTxo/YsSG9dgxFXVj3jR3i/fC6qQ5dXtmhV6fOscbK7TT6byHP+/CPicsZJbN6EMikyKasEvMPYAetzeD6Y1On9I5SRHYar+4dPYeahS3tTNGVInqLY7eZM+RVLefUitIF07D2wNyTyQQLtBvA86m9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdxMK40mpz6M4mZ;
	Sat, 12 Jul 2025 00:03:09 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 353E81402FE;
	Sat, 12 Jul 2025 00:04:18 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Jul
 2025 18:04:17 +0200
Date: Fri, 11 Jul 2025 17:04:15 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: =?ISO-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>
CC: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, "Gatien
 Chevallier" <gatien.chevallier@foss.st.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "Gabriel
 Fernandez" <gabriel.fernandez@foss.st.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, Le Goffic <legoffic.clement@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 09/16] perf: stm32: introduce DDRPERFM driver
Message-ID: <20250711170415.00001901@huawei.com>
In-Reply-To: <20250711-ddrperfm-upstream-v2-9-cdece720348f@foss.st.com>
References: <20250711-ddrperfm-upstream-v2-0-cdece720348f@foss.st.com>
	<20250711-ddrperfm-upstream-v2-9-cdece720348f@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 11 Jul 2025 16:49:01 +0200
Cl=E9ment Le Goffic <clement.legoffic@foss.st.com> wrote:

> Introduce the driver for the DDR Performance Monitor available on
> STM32MPU SoC.
>=20
> On STM32MP2 platforms, the DDRPERFM allows to monitor up to 8 DDR events
> that come from the DDR Controller such as read or write events.
>=20
> On STM32MP1 platforms, the DDRPERFM cannot monitor any event on any
> counter, there is a notion of set of events.
> Events from different sets cannot be monitored at the same time.
> The first chosen event selects the set.
> The set is coded in the first two bytes of the config value which is on 4
> bytes.
>=20
> On STM32MP25x series, the DDRPERFM clock is shared with the DDR controller
> and may be secured by bootloaders.
> Access controllers allow to check access to a resource. Use the access
> controller defined in the devicetree to know about the access to the
> DDRPERFM clock.
>=20
> Signed-off-by: Cl=E9ment Le Goffic <clement.legoffic@foss.st.com>

Hi Cl=E9ment,

A quick drive by review as it's Friday afternoon and I was curious..

Mostly superficial stuff. I didn't look closely at the perf logic.

Jonathan

> diff --git a/drivers/perf/stm32_ddr_pmu.c b/drivers/perf/stm32_ddr_pmu.c
> new file mode 100644
> index 000000000000..1be5bbe12978
> --- /dev/null
> +++ b/drivers/perf/stm32_ddr_pmu.c
> @@ -0,0 +1,910 @@

> +#define EVENT_NUMBER(group, index)	(((group) << 8) | (index))
> +#define GROUP_VALUE(event_number)		((event_number) >> 8)
> +#define EVENT_INDEX(event_number)	((event_number) & 0xFF)

Prefix these macro names with something driver specific.  They are
very likely to clash with something in a header in future otherwise.

> +
> +enum stm32_ddr_pmu_memory_type {
> +	STM32_DDR_PMU_LPDDR4,
> +	STM32_DDR_PMU_LPDDR3,
> +	STM32_DDR_PMU_DDR4,
> +	STM32_DDR_PMU_DDR3

This should have a trailing comma as might well be more
added in future if this IP gets used in more devices.

> +};
>


> +
> +static const struct attribute_group *stm32_ddr_pmu_attr_groups_mp2[] =3D=
 {
> +	&stm32_ddr_pmu_events_attrs_group_mp2,
> +	&stm32_ddr_pmu_format_attr_group,
> +	NULL,

No comma needed on terminating entries.

> +};
> +
> +static int stm32_ddr_pmu_device_probe(struct platform_device *pdev)
> +{
> +	struct stm32_firewall firewall;
> +	struct stm32_ddr_pmu *pmu;
> +	struct reset_control *rst;
> +	struct resource *res;
> +	int ret;
> +
> +	pmu =3D devm_kzalloc(&pdev->dev, struct_size(pmu, counters, MP2_CNT_NB)=
, GFP_KERNEL);
> +	if (!pmu)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, pmu);
> +	pmu->dev =3D &pdev->dev;
> +
> +	pmu->cfg =3D device_get_match_data(&pdev->dev);
> +
> +	pmu->membase =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(pmu->membase))
> +		return PTR_ERR(pmu->membase);
> +
> +	if (of_property_present(pmu->dev->of_node, "access-controllers")) {
> +		ret =3D stm32_firewall_get_firewall(pmu->dev->of_node, &firewall, 1);
> +		if (ret)
> +			return dev_err_probe(pmu->dev, ret, "Failed to get firewall\n");
> +		ret =3D stm32_firewall_grant_access_by_id(&firewall, firewall.firewall=
_id);
> +		if (ret)
> +			return dev_err_probe(pmu->dev, ret, "Failed to grant access\n");
> +	}
> +
> +	pmu->clk =3D devm_clk_get_optional_prepared(pmu->dev, NULL);

Given there are quite a few uses of pmu->dev, maybe worth a local
struct device *dev =3D &pdev->dev; at the top and use dev to replace all th=
ese.

> +	if (IS_ERR(pmu->clk))
> +		return dev_err_probe(pmu->dev, PTR_ERR(pmu->clk), "Failed to get prepa=
re clock\n");
> +
> +	clk_enable(pmu->clk);
> +
> +	rst =3D devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);

You mix and match between pdev->dev, and pmu->dev. Good to pick one or use =
local
variable as suggested above.

> +	if (IS_ERR(rst)) {
> +		clk_disable_unprepare(pmu->clk);
Given use of _prepared() get above. This doesn't look right - the unprepare
should be handled by devm unwinding. clk_disable()=20
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rst), "Failed to get reset\n"=
);
> +	}
> +
> +	reset_control_assert(rst);
> +	reset_control_deassert(rst);
> +
> +	pmu->poll_period =3D ms_to_ktime(POLL_MS);
> +	hrtimer_setup(&pmu->hrtimer, stm32_ddr_pmu_poll, CLOCK_MONOTONIC, HRTIM=
ER_MODE_REL);
> +
> +	for (int i =3D 0; i < MP2_CNT_NB; i++)
> +		INIT_LIST_HEAD(&pmu->counters[i]);
> +
> +	pmu->selected_set =3D -1;
> +
> +	pmu->pmu =3D (struct pmu) {
> +		.task_ctx_nr =3D perf_invalid_context,
> +		.start =3D stm32_ddr_pmu_event_start,
> +		.stop =3D stm32_ddr_pmu_event_stop,
> +		.add =3D stm32_ddr_pmu_event_add,
> +		.del =3D stm32_ddr_pmu_event_del,
> +		.read =3D stm32_ddr_pmu_event_read,
> +		.event_init =3D stm32_ddr_pmu_event_init,
> +		.attr_groups =3D pmu->cfg->attribute,
> +		.module =3D THIS_MODULE,
> +	};
> +
> +	ret =3D perf_pmu_register(&pmu->pmu, DRIVER_NAME, -1);

Calling this exposes user interfaces etc.  Does it really make sense to
do that and then write another register?  I'd normally expect this
last in probe.

> +	if (ret) {
> +		clk_disable_unprepare(pmu->clk);

As above.

> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Couldn't register DDRPERFM driver as a PMU\n");
> +	}
> +
> +	if (pmu->cfg->regs->dram_inf.reg) {
> +		ret =3D stm32_ddr_pmu_get_memory_type(pmu);
> +		if (ret) {
> +			perf_pmu_unregister(&pmu->pmu);
> +			clk_disable_unprepare(pmu->clk);
> +			return dev_err_probe(&pdev->dev, ret, "Failed to get memory type\n");
> +		}
> +
> +		writel_relaxed(pmu->dram_type, pmu->membase + pmu->cfg->regs->dram_inf=
.reg);
> +	}
> +
> +	clk_disable(pmu->clk);
> +
> +	return 0;
> +}

> +static const struct stm32_ddr_pmu_regspec stm32_ddr_pmu_regspec_mp2 =3D {
> +	.stop =3D		{ DDRPERFM_CTRL, CTRL_STOP },
> +	.start =3D	{ DDRPERFM_CTRL, CTRL_START },
> +	.status =3D	{ DDRPERFM_MP2_STATUS, MP2_STATUS_BUSY },
> +	.clear_cnt =3D	{ DDRPERFM_CLR, MP2_CLR_CNT},
> +	.clear_time =3D	{ DDRPERFM_CLR, MP2_CLR_TIME},

Spaces before } are missing
There are a few others above that I'll not mention directly.


> +	.cfg0 =3D		{ DDRPERFM_MP2_CFG0 },
> +	.cfg1 =3D		{ DDRPERFM_MP2_CFG1 },
> +	.enable =3D	{ DDRPERFM_MP2_CFG5 },
> +	.dram_inf =3D	{ DDRPERFM_MP2_DRAMINF },
> +	.counter_time =3D	{ DDRPERFM_MP2_TCNT },
> +	.counter_evt =3D	{
> +				{ DDRPERFM_MP2_EVCNT(0) },
Somewhat unusual formatting though neat I guess so fine if you
really like it!.
	.counter_evt =3D	{
		{ DDRPERFM_MP2_EVCNT(0) },

would be what I'd normally expect.
> +				{ DDRPERFM_MP2_EVCNT(1) },
> +				{ DDRPERFM_MP2_EVCNT(2) },
> +				{ DDRPERFM_MP2_EVCNT(3) },
> +				{ DDRPERFM_MP2_EVCNT(4) },
> +				{ DDRPERFM_MP2_EVCNT(5) },
> +				{ DDRPERFM_MP2_EVCNT(6) },
> +				{ DDRPERFM_MP2_EVCNT(7) },
> +	},
> +};
> +
> +static const struct stm32_ddr_pmu_cfg stm32_ddr_pmu_cfg_mp1 =3D {
> +	.regs =3D &stm32_ddr_pmu_regspec_mp1,
> +	.attribute =3D stm32_ddr_pmu_attr_groups_mp1,
> +	.counters_nb =3D MP1_CNT_NB,
> +	.evt_counters_nb =3D MP1_CNT_NB - 1, /* Time counter is not an event co=
unter */
> +	.time_cnt_idx =3D MP1_TIME_CNT_IDX,
> +	.get_counter =3D stm32_ddr_pmu_get_event_counter_mp1,
> +};
> +
> +static const struct stm32_ddr_pmu_cfg stm32_ddr_pmu_cfg_mp2 =3D {
> +	.regs =3D &stm32_ddr_pmu_regspec_mp2,
> +	.attribute =3D stm32_ddr_pmu_attr_groups_mp2,
> +	.counters_nb =3D MP2_CNT_NB,
> +	.evt_counters_nb =3D MP2_CNT_NB - 1, /* Time counter is an event counte=
r */
> +	.time_cnt_idx =3D MP2_TIME_CNT_IDX,
> +	.get_counter =3D stm32_ddr_pmu_get_event_counter_mp2,
> +};
> +
> +static const struct dev_pm_ops stm32_ddr_pmu_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, stm32_ddr_pmu_device_resume)
> +};

static DEFINE_SIMPLE_DEV_PM_OPS() looks appropriate here.


> +
> +static const struct of_device_id stm32_ddr_pmu_of_match[] =3D {
> +	{
> +		.compatible =3D "st,stm32mp131-ddr-pmu",
> +		.data =3D &stm32_ddr_pmu_cfg_mp1
> +	},
> +	{
> +		.compatible =3D "st,stm32mp251-ddr-pmu",
> +		.data =3D &stm32_ddr_pmu_cfg_mp2
> +	},
> +	{ },

No comma need after terminating entry.  Nice to make it hard
to accidentally add entries after one of these!

> +};
> +MODULE_DEVICE_TABLE(of, stm32_ddr_pmu_of_match);
> +
> +static struct platform_driver stm32_ddr_pmu_driver =3D {
> +	.driver =3D {
> +		.name =3D DRIVER_NAME,
> +		.pm =3D pm_sleep_ptr(&stm32_ddr_pmu_pm_ops),
> +		.of_match_table =3D stm32_ddr_pmu_of_match,
> +	},
> +	.probe =3D stm32_ddr_pmu_device_probe,
> +	.remove =3D stm32_ddr_pmu_device_remove,
> +};
> +
> +module_platform_driver(stm32_ddr_pmu_driver);
> +
> +MODULE_AUTHOR("Cl=E9ment Le Goffic");
> +MODULE_DESCRIPTION("STMicroelectronics STM32 DDR performance monitor dri=
ver");
> +MODULE_LICENSE("GPL");
>=20

