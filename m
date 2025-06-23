Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3C072624;
	Mon, 23 Jun 2025 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691125; cv=none; b=nekQ2cfKj/SamdhfofCRl5iJiiIm8FpyR8e4DYIh9eLOMeHw8itE04cWnrJggAxRhvAtIOmZhClf9P4lBsUcUpPC+BP6y+IepDFQccdLqNYzF6gpEqpYVYsj69QbUK0ELQwlTpjYv5KL7K7MmbN3Dk6983O6UCTPy+YcbUQhqY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691125; c=relaxed/simple;
	bh=xGs+xuT9ZbXSNcZb6r49Mqj6bJ/rNc5SZFKZhnRHrMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jGSyEk68e4JebI6fO8yx014JAKcmC900fRYR8h2/x1H3cm571/nPZL9n+ST0GPLGh6kw4TVGxQe7fBfUqhDCm+p2su7Ko3+sLkgOKG5cMRnKSUOXKoCx6G3tMEt3hFYr8OgQXKYOtANeeho7siSAMBkEKSZ93B9aEin0JqIyMLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=bF9yI8JI; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="bF9yI8JI"
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NDdLVH024335;
	Mon, 23 Jun 2025 17:05:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	6sv5OcOQ4mLQLuHevh2cUvXQ88huIlXGlWQaz3Py6wY=; b=bF9yI8JIFqs7ioUx
	YDyxrekrSZ47ndzO65fgYVA9fiqdJhb4A1AjRQpK8A6JPvobiX40RBvpbQICsGZy
	KBEKyV8Nutp2vooUtufi6oc0aFIm3JnPIyEC0r4FpzFHsn9wPHB3mdk4CC3i0ySp
	dVG+isuNuslqinodqBJo57SAui7QgB1Bu7WUx+AAYYE7Ei9Zr3IYwwyivPnOgD0g
	NLyaqsS2+nIOxbGUoSJWY3H5t9f/gQnx84a3CpWq1xyJoKFdEOdehH2E7z2ID5QJ
	ZCF7Imh3wriuEBkharNBQkUpD7+qm/hJwoArih2kgBsZskd63sl/XG1gzuA/EUtb
	fL7yXQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47e6a6e021-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 17:05:05 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 37F7440044;
	Mon, 23 Jun 2025 17:03:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BAD61B52149;
	Mon, 23 Jun 2025 17:02:26 +0200 (CEST)
Received: from [10.252.18.29] (10.252.18.29) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 17:02:25 +0200
Message-ID: <1ff31bd6-08e0-46da-a1b0-c60dbb1e3cb8@foss.st.com>
Date: Mon, 23 Jun 2025 17:02:22 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] perf: stm32: introduce DDRPERFM driver
To: Krzysztof Kozlowski <krzk@kernel.org>, Will Deacon <will@kernel.org>,
        Mark
 Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Gatien Chevallier
	<gatien.chevallier@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Gabriel Fernandez
	<gabriel.fernandez@foss.st.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20250623-ddrperfm-upstream-v1-0-7dffff168090@foss.st.com>
 <20250623-ddrperfm-upstream-v1-6-7dffff168090@foss.st.com>
 <9cb1575e-ae27-4a78-adb7-8a9e7072375e@kernel.org>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <9cb1575e-ae27-4a78-adb7-8a9e7072375e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01

On 6/23/25 11:45, Krzysztof Kozlowski wrote:
> On 23/06/2025 11:27, Clément Le Goffic wrote:
>> +	if (of_property_present(pmu->dev->of_node, "access-controllers")) {
>> +		ret = stm32_firewall_get_firewall(pmu->dev->of_node, &firewall, 1);
>> +		if (ret) {
>> +			dev_err(pmu->dev, "Failed to get firewall\n");
>> +			return ret;
>> +		}
>> +		ret = stm32_firewall_grant_access_by_id(&firewall, firewall.firewall_id);
>> +		if (ret) {
>> +			dev_err(pmu->dev, "Failed to grant access\n");
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	if (of_property_present(pmu->dev->of_node, "clocks")) {
> 
> No, don't open-code get clk optional.

Ok

> 
>> +		pmu->clk = devm_clk_get_prepared(pmu->dev, NULL);
>> +		if (IS_ERR(pmu->clk)) {
>> +			dev_err(pmu->dev, "Failed to get clock\n");
>> +			return PTR_ERR(pmu->clk);
>> +		}
>> +	}
>> +
>> +	clk_enable(pmu->clk);
>> +
>> +	if (of_property_present(pdev->dev.of_node, "resets")) {
>> +		rst = devm_reset_control_get(&pdev->dev, NULL);
>> +		if (IS_ERR(rst)) {
>> +			dev_err(&pdev->dev, "Failed to get reset\n");
>> +			ret = PTR_ERR(rst);
>> +			goto err_clk;
>> +		}
>> +		reset_control_assert(rst);
>> +		reset_control_deassert(rst);
>> +	}
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
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Couldn't register DDRPERFM driver as a PMU\n");
>> +		goto err_clk;
>> +	}
>> +
>> +	if (pmu->cfg->regs->dram_inf.reg) {
>> +		ret = of_property_read_u32(pdev->dev.of_node, "st,dram-type", &pmu->dram_type);
>> +		if (ret) {
>> +			dev_err(&pdev->dev, "Missing device-tree property 'st,dram-type'\n");
>> +			perf_pmu_unregister(&pmu->pmu);
>> +
>> +			return ret;
>> +		}
>> +
>> +		writel_relaxed(pmu->dram_type, pmu->membase + pmu->cfg->regs->dram_inf.reg);
>> +	}
>> +
>> +	clk_disable(pmu->clk);
> 
> Why do you keep clock prepared? This device does not know what sort of
> clock it gets, so you end up with clock always active for example and
> this being no-op.

Ok will disable_unprepare

>> +
>> +	return 0;
>> +
>> +err_clk:
>> +	clk_disable_unprepare(pmu->clk);
>> +
>> +	return ret;
>> +}
>> +
>> +static void stm32_ddr_pmu_device_remove(struct platform_device *pdev)
>> +{
>> +	struct stm32_ddr_pmu *stm32_ddr_pmu = platform_get_drvdata(pdev);
>> +
>> +	perf_pmu_unregister(&stm32_ddr_pmu->pmu);
>> +}
>> +
>> +static int __maybe_unused stm32_ddr_pmu_device_resume(struct device *dev)
>> +{
>> +	struct stm32_ddr_pmu *pmu = dev_get_drvdata(dev);
>> +
>> +	clk_enable(pmu->clk);
>> +	writel_relaxed(pmu->dram_type, pmu->membase + pmu->cfg->regs->dram_inf.reg);
>> +	clk_disable(pmu->clk);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct stm32_ddr_pmu_regspec stm32_ddr_pmu_regspec_mp1 = {
>> +	.stop =		{ DDRPERFM_CTRL, CTRL_STOP },
>> +	.start =	{ DDRPERFM_CTRL, CTRL_START },
>> +	.enable =	{ DDRPERFM_CFG },
>> +	.cfg =		{ DDRPERFM_CFG },
>> +	.status =	{ DDRPERFM_STATUS, MP1_STATUS_BUSY },
>> +	.clear_cnt =	{ DDRPERFM_CLR, MP1_CLR_CNT},
>> +	.clear_time =	{ DDRPERFM_CLR, MP1_CLR_TIME},
>> +	.counter_time =	{ DDRPERFM_TCNT },
>> +	.counter_evt =	{
>> +				{ DDRPERFM_EVCNT(0) },
>> +				{ DDRPERFM_EVCNT(1) },
>> +				{ DDRPERFM_EVCNT(2) },
>> +				{ DDRPERFM_EVCNT(3) },
>> +	},
>> +};
>> +
>> +static const struct stm32_ddr_pmu_regspec stm32_ddr_pmu_regspec_mp2 = {
>> +	.stop =		{ DDRPERFM_CTRL, CTRL_STOP },
>> +	.start =	{ DDRPERFM_CTRL, CTRL_START },
>> +	.status =	{ DDRPERFM_MP2_STATUS, MP2_STATUS_BUSY },
>> +	.clear_cnt =	{ DDRPERFM_CLR, MP2_CLR_CNT},
>> +	.clear_time =	{ DDRPERFM_CLR, MP2_CLR_TIME},
>> +	.cfg0 =		{ DDRPERFM_MP2_CFG0 },
>> +	.cfg1 =		{ DDRPERFM_MP2_CFG1 },
>> +	.enable =	{ DDRPERFM_MP2_CFG5 },
>> +	.dram_inf =	{ DDRPERFM_MP2_DRAMINF },
>> +	.counter_time =	{ DDRPERFM_MP2_TCNT },
>> +	.counter_evt =	{
>> +				{ DDRPERFM_MP2_EVCNT(0) },
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
>> +
>> +static const struct of_device_id stm32_ddr_pmu_of_match[] = {
>> +	{
>> +		.compatible = "st,stm32mp131-ddr-pmu",
>> +		.data = &stm32_ddr_pmu_cfg_mp1
>> +	},
>> +	{
>> +		.compatible = "st,stm32mp151-ddr-pmu",
>> +		.data = &stm32_ddr_pmu_cfg_mp1
> 
> So devices are compatible, thus express it correctly and drop this.
> 
>> +	},
>> +	{
>> +		.compatible = "st,stm32mp251-ddr-pmu",
>> +		.data = &stm32_ddr_pmu_cfg_mp2
>> +	},
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, stm32_ddr_pmu_of_match);
>> +
>> +static struct platform_driver stm32_ddr_pmu_driver = {
>> +	.driver = {
>> +		.name = DRIVER_NAME,
>> +		.pm = &stm32_ddr_pmu_pm_ops,
>> +		.of_match_table = of_match_ptr(stm32_ddr_pmu_of_match),
> 
> Drop of_match_ptr, you have here warnings.
> 
> 
> 
> Best regards,
> Krzysztof

