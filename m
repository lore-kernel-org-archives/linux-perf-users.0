Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476502D5406;
	Tue, 15 Jul 2025 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573205; cv=none; b=BlD3hDscz+MHEaRUqo+RqaqTLW3l1IS5vCQwjAI9KmI4UeWE8z3Qp0in4dsyNm2cM2/AS9oQEQqlz2a/UeScGlghnYpQStEWGaiv0Z3dAZwIYOwxsD25ttjaYL4ujDInq3Fd29FOATASyQLMX477lMj1x39xmjmquSGNhA7e88k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573205; c=relaxed/simple;
	bh=tmHF7gRStiy8BJTFYsfZHMVqt0KO2UrdQFipnPx5lP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qILFLe590piW4PVxnpV08gyNeafiIl7hUZbOjCeN69OpHnmCRJyRCczTwDWECxKcE2U2kguH16hPCgGMPmF4kUtz3YGvCBbHLQEeuxcbtWZlV0kDEK6sGBfF94UEQByG1t+QmEICbrXnyj15GvmUYkM13EHuDbappSRX98Qt7jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=YKNS/mj1; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="YKNS/mj1"
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F6uNQR002322;
	Tue, 15 Jul 2025 11:52:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	G1/gp4B+L0w00yUAj4aY/kWgU6WTpYFWiQQBVNHuBZg=; b=YKNS/mj1LT/6AIJY
	+8QQVR+QBp0xP38nrqNwzF1iu2AWohdHl67RWB0HupkfYK2dzhwq0DVRmzMeyAUK
	Bczm3DLmg0hapbdZxuMkeqgkx+H31vHa9rak9IRO3QREsWJVE/5Wbe0Ukibb7pOF
	U0m+pJ8m10/FbMpMolE11jeAhCJt2tSg0t09RHgEFjh4Ei5/DHtaZ4n9iDiUPXY+
	4hAtt4FYFh6E87hzoap+tBeUvSOhgCaCGGvbuH4ZZb5gFP7CNhZcKwNfbLzQ/GDS
	9kyBHq7ax+ADFLTED/lyL0IgP2bySJImYvTuovPh/KNfpyQVeIENyEmqy9llvxnR
	Ws5b1w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47uf22mk5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 11:52:55 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A118F4004A;
	Tue, 15 Jul 2025 11:51:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 03564B6CE36;
	Tue, 15 Jul 2025 11:49:43 +0200 (CEST)
Received: from [10.48.86.185] (10.48.86.185) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 11:49:41 +0200
Message-ID: <1d22a89d-f060-4663-aef9-6645a66d15a5@foss.st.com>
Date: Tue, 15 Jul 2025 11:49:41 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] perf: stm32: introduce DDRPERFM driver
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Gatien Chevallier
	<gatien.chevallier@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Gabriel Fernandez
	<gabriel.fernandez@foss.st.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Le
 Goffic <legoffic.clement@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20250711-ddrperfm-upstream-v2-0-cdece720348f@foss.st.com>
 <20250711-ddrperfm-upstream-v2-9-cdece720348f@foss.st.com>
 <20250711170415.00001901@huawei.com>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <20250711170415.00001901@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01

Hi Jonathan,

On 7/11/25 18:04, Jonathan Cameron wrote:
> On Fri, 11 Jul 2025 16:49:01 +0200
> Clément Le Goffic <clement.legoffic@foss.st.com> wrote:
> 
>> Introduce the driver for the DDR Performance Monitor available on
>> STM32MPU SoC.
>>
>> On STM32MP2 platforms, the DDRPERFM allows to monitor up to 8 DDR events
>> that come from the DDR Controller such as read or write events.
>>
>> On STM32MP1 platforms, the DDRPERFM cannot monitor any event on any
>> counter, there is a notion of set of events.
>> Events from different sets cannot be monitored at the same time.
>> The first chosen event selects the set.
>> The set is coded in the first two bytes of the config value which is on 4
>> bytes.
>>
>> On STM32MP25x series, the DDRPERFM clock is shared with the DDR controller
>> and may be secured by bootloaders.
>> Access controllers allow to check access to a resource. Use the access
>> controller defined in the devicetree to know about the access to the
>> DDRPERFM clock.
>>
>> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> 
> Hi Clément,
> 
> A quick drive by review as it's Friday afternoon and I was curious..
> 
> Mostly superficial stuff. I didn't look closely at the perf logic.

Thank you for the review.
The perf logic is new to me so if you have any suggestion, you're welcome.


> 
>> diff --git a/drivers/perf/stm32_ddr_pmu.c b/drivers/perf/stm32_ddr_pmu.c
>> new file mode 100644
>> index 000000000000..1be5bbe12978
>> --- /dev/null
>> +++ b/drivers/perf/stm32_ddr_pmu.c
>> @@ -0,0 +1,910 @@
> 
>> +#define EVENT_NUMBER(group, index)	(((group) << 8) | (index))
>> +#define GROUP_VALUE(event_number)		((event_number) >> 8)
>> +#define EVENT_INDEX(event_number)	((event_number) & 0xFF)
> 
> Prefix these macro names with something driver specific.  They are
> very likely to clash with something in a header in future otherwise.

Ok

> 
>> +
>> +enum stm32_ddr_pmu_memory_type {
>> +	STM32_DDR_PMU_LPDDR4,
>> +	STM32_DDR_PMU_LPDDR3,
>> +	STM32_DDR_PMU_DDR4,
>> +	STM32_DDR_PMU_DDR3
> 
> This should have a trailing comma as might well be more
> added in future if this IP gets used in more devices.

Ok

>> +};
>>
> 
> 
>> +
>> +static const struct attribute_group *stm32_ddr_pmu_attr_groups_mp2[] = {
>> +	&stm32_ddr_pmu_events_attrs_group_mp2,
>> +	&stm32_ddr_pmu_format_attr_group,
>> +	NULL,
> 
> No comma needed on terminating entries.

Ok, will also be fixed for `stm32_ddr_pmu_attr_groups_mp1[]` and
`stm32_ddr_pmu_format_attrs[]`
> 
>> +};
>> +
>> +static int stm32_ddr_pmu_device_probe(struct platform_device *pdev)
>> +{
>> +	struct stm32_firewall firewall;
>> +	struct stm32_ddr_pmu *pmu;
>> +	struct reset_control *rst;
>> +	struct resource *res;
>> +	int ret;
>> +
>> +	pmu = devm_kzalloc(&pdev->dev, struct_size(pmu, counters, MP2_CNT_NB), GFP_KERNEL);
>> +	if (!pmu)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, pmu);
>> +	pmu->dev = &pdev->dev;
>> +
>> +	pmu->cfg = device_get_match_data(&pdev->dev);
>> +
>> +	pmu->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>> +	if (IS_ERR(pmu->membase))
>> +		return PTR_ERR(pmu->membase);
>> +
>> +	if (of_property_present(pmu->dev->of_node, "access-controllers")) {
>> +		ret = stm32_firewall_get_firewall(pmu->dev->of_node, &firewall, 1);
>> +		if (ret)
>> +			return dev_err_probe(pmu->dev, ret, "Failed to get firewall\n");
>> +		ret = stm32_firewall_grant_access_by_id(&firewall, firewall.firewall_id);
>> +		if (ret)
>> +			return dev_err_probe(pmu->dev, ret, "Failed to grant access\n");
>> +	}
>> +
>> +	pmu->clk = devm_clk_get_optional_prepared(pmu->dev, NULL);
> 
> Given there are quite a few uses of pmu->dev, maybe worth a local
> struct device *dev = &pdev->dev; at the top and use dev to replace all these.

As I need pmu->dev elsewhere in the driver I'll stick to it and replace 
all &pdev->dev

> 
>> +	if (IS_ERR(pmu->clk))
>> +		return dev_err_probe(pmu->dev, PTR_ERR(pmu->clk), "Failed to get prepare clock\n");
>> +
>> +	clk_enable(pmu->clk);
>> +
>> +	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
> 
> You mix and match between pdev->dev, and pmu->dev. Good to pick one or use local
> variable as suggested above.

Ok
> 
>> +	if (IS_ERR(rst)) {
>> +		clk_disable_unprepare(pmu->clk);
> Given use of _prepared() get above. This doesn't look right - the unprepare
> should be handled by devm unwinding. clk_disable()

Oh you're right, I can fix this unwinding issue by using 
`devm_clk_get_optional_enabled()` instead of 
`devm_clk_get_optional_prepared()` and remove the `clk_enable()` so all 
`clk_disable_unprepare()` disappear from the probe


>> +		return dev_err_probe(&pdev->dev, PTR_ERR(rst), "Failed to get reset\n");
>> +	}
>> +
>> +	reset_control_assert(rst);
>> +	reset_control_deassert(rst);
>> +
>> +	pmu->poll_period = ms_to_ktime(POLL_MS);
>> +	hrtimer_setup(&pmu->hrtimer, stm32_ddr_pmu_poll, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>> +
>> +	for (int i = 0; i < MP2_CNT_NB; i++)
>> +		INIT_LIST_HEAD(&pmu->counters[i]);
>> +
>> +	pmu->selected_set = -1;
>> +
>> +	pmu->pmu = (struct pmu) {
>> +		.task_ctx_nr = perf_invalid_context,
>> +		.start = stm32_ddr_pmu_event_start,
>> +		.stop = stm32_ddr_pmu_event_stop,
>> +		.add = stm32_ddr_pmu_event_add,
>> +		.del = stm32_ddr_pmu_event_del,
>> +		.read = stm32_ddr_pmu_event_read,
>> +		.event_init = stm32_ddr_pmu_event_init,
>> +		.attr_groups = pmu->cfg->attribute,
>> +		.module = THIS_MODULE,
>> +	};
>> +
>> +	ret = perf_pmu_register(&pmu->pmu, DRIVER_NAME, -1);
> 
> Calling this exposes user interfaces etc.  Does it really make sense to
> do that and then write another register?  I'd normally expect this
> last in probe.

Indeed, will move it at the end of the probe

> 
>> +	if (ret) {
>> +		clk_disable_unprepare(pmu->clk);
> 
> As above.

Ok
> 
>> +		return dev_err_probe(&pdev->dev, ret,
>> +				     "Couldn't register DDRPERFM driver as a PMU\n");
>> +	}
>> +
>> +	if (pmu->cfg->regs->dram_inf.reg) {
>> +		ret = stm32_ddr_pmu_get_memory_type(pmu);
>> +		if (ret) {
>> +			perf_pmu_unregister(&pmu->pmu);
>> +			clk_disable_unprepare(pmu->clk);
>> +			return dev_err_probe(&pdev->dev, ret, "Failed to get memory type\n");
>> +		}
>> +
>> +		writel_relaxed(pmu->dram_type, pmu->membase + pmu->cfg->regs->dram_inf.reg);
>> +	}
>> +
>> +	clk_disable(pmu->clk);
>> +
>> +	return 0;
>> +}
> 
>> +static const struct stm32_ddr_pmu_regspec stm32_ddr_pmu_regspec_mp2 = {
>> +	.stop =		{ DDRPERFM_CTRL, CTRL_STOP },
>> +	.start =	{ DDRPERFM_CTRL, CTRL_START },
>> +	.status =	{ DDRPERFM_MP2_STATUS, MP2_STATUS_BUSY },
>> +	.clear_cnt =	{ DDRPERFM_CLR, MP2_CLR_CNT},
>> +	.clear_time =	{ DDRPERFM_CLR, MP2_CLR_TIME},
> 
> Spaces before } are missing
> There are a few others above that I'll not mention directly.

Ok thanks

> 
> 
>> +	.cfg0 =		{ DDRPERFM_MP2_CFG0 },
>> +	.cfg1 =		{ DDRPERFM_MP2_CFG1 },
>> +	.enable =	{ DDRPERFM_MP2_CFG5 },
>> +	.dram_inf =	{ DDRPERFM_MP2_DRAMINF },
>> +	.counter_time =	{ DDRPERFM_MP2_TCNT },
>> +	.counter_evt =	{
>> +				{ DDRPERFM_MP2_EVCNT(0) },
> Somewhat unusual formatting though neat I guess so fine if you
> really like it!.
> 	.counter_evt =	{
> 		{ DDRPERFM_MP2_EVCNT(0) },
> 
> would be what I'd normally expect.

I'll stick to normality, don't wanna be special here

>> +				{ DDRPERFM_MP2_EVCNT(1) },
>> +				{ DDRPERFM_MP2_EVCNT(2) },
>> +				{ DDRPERFM_MP2_EVCNT(3) },
>> +				{ DDRPERFM_MP2_EVCNT(4) },
>> +				{ DDRPERFM_MP2_EVCNT(5) },
>> +				{ DDRPERFM_MP2_EVCNT(6) },
>> +				{ DDRPERFM_MP2_EVCNT(7) },
>> +	},
>> +};
>> +
>> +static const struct stm32_ddr_pmu_cfg stm32_ddr_pmu_cfg_mp1 = {
>> +	.regs = &stm32_ddr_pmu_regspec_mp1,
>> +	.attribute = stm32_ddr_pmu_attr_groups_mp1,
>> +	.counters_nb = MP1_CNT_NB,
>> +	.evt_counters_nb = MP1_CNT_NB - 1, /* Time counter is not an event counter */
>> +	.time_cnt_idx = MP1_TIME_CNT_IDX,
>> +	.get_counter = stm32_ddr_pmu_get_event_counter_mp1,
>> +};
>> +
>> +static const struct stm32_ddr_pmu_cfg stm32_ddr_pmu_cfg_mp2 = {
>> +	.regs = &stm32_ddr_pmu_regspec_mp2,
>> +	.attribute = stm32_ddr_pmu_attr_groups_mp2,
>> +	.counters_nb = MP2_CNT_NB,
>> +	.evt_counters_nb = MP2_CNT_NB - 1, /* Time counter is an event counter */
>> +	.time_cnt_idx = MP2_TIME_CNT_IDX,
>> +	.get_counter = stm32_ddr_pmu_get_event_counter_mp2,
>> +};
>> +
>> +static const struct dev_pm_ops stm32_ddr_pmu_pm_ops = {
>> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, stm32_ddr_pmu_device_resume)
>> +};
> 
> static DEFINE_SIMPLE_DEV_PM_OPS() looks appropriate here.

Indeed, Thank you

> 
> 
>> +
>> +static const struct of_device_id stm32_ddr_pmu_of_match[] = {
>> +	{
>> +		.compatible = "st,stm32mp131-ddr-pmu",
>> +		.data = &stm32_ddr_pmu_cfg_mp1
>> +	},
>> +	{
>> +		.compatible = "st,stm32mp251-ddr-pmu",
>> +		.data = &stm32_ddr_pmu_cfg_mp2
>> +	},
>> +	{ },
> 
> No comma need after terminating entry.  Nice to make it hard
> to accidentally add entries after one of these!

Yes, I'll fix it

Best regards,
Clément
