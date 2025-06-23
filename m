Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07E117A318;
	Mon, 23 Jun 2025 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671962; cv=none; b=mcpBXWnTiicNwkzx1en/gZd/DU05jCoulOEicwjSzsZAg4SSTFTMKpqKnpHd9tXVql89qFbjX7zZlJyC8YPfoNWxBTPU2rBuXViZn2xmTCm+MoDImPQP5P19WDcV+Ty3l3+9/wI9I5QgvODBYQOYn4PdFVa4pB8CGqc8XsCX6SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671962; c=relaxed/simple;
	bh=IXHCJoWMn6t0vuB+CqKs2zgjVDxkVwBIUruHUkwEJL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1vSSS4CcnrllaHkeNP7OcXGhjscHUBIgqeeuvnXDfRnPT9gLvwJxkhioQchlfVY9wsCzGtmMEoIkHg6yx42jiCUbKwrE0wx9wYu9lNQNuMOLGnmWrSfc5wFlTtqRrhEIXCglWBWsjWM59l1yllIJ7xhc44emS/t8zd2xUiJRP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQK6XKaZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQK6XKaZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD6BC4CEEA;
	Mon, 23 Jun 2025 09:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750671962;
	bh=IXHCJoWMn6t0vuB+CqKs2zgjVDxkVwBIUruHUkwEJL4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OQK6XKaZ3SgxAoBcvh46QDZ/jPhUumeA/Ka7NMNlcrqTKHve8WKl/71rkimvULhX/
	 dFdTle+i4DeJguB+bdIFSen1dXz30rzfshPHdwfB4cmkxcp4iWn4+fwx3TSkZWVg9N
	 tTuejgKBPxqs11/yKnHm3cuC+KXej4TgBLq0NESolo/dfSElBO+JnN6lyp6voJ31tm
	 pQCdNIB03yRoTRK+ek0tIiKGqBIudJkDQzJPufqGlaLxV+CmOrZ+v4127U4W6eeZfy
	 ClklJmh+F+JYjZk9/bB5ChtkM+x28DCId/RTol+B4yrnbp6UgtZfms1E40u3FJa/vD
	 zr286BKeHQ+EA==
Message-ID: <9cb1575e-ae27-4a78-adb7-8a9e7072375e@kernel.org>
Date: Mon, 23 Jun 2025 11:45:55 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] perf: stm32: introduce DDRPERFM driver
To: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20250623-ddrperfm-upstream-v1-0-7dffff168090@foss.st.com>
 <20250623-ddrperfm-upstream-v1-6-7dffff168090@foss.st.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250623-ddrperfm-upstream-v1-6-7dffff168090@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/06/2025 11:27, Clément Le Goffic wrote:
> +	if (of_property_present(pmu->dev->of_node, "access-controllers")) {
> +		ret = stm32_firewall_get_firewall(pmu->dev->of_node, &firewall, 1);
> +		if (ret) {
> +			dev_err(pmu->dev, "Failed to get firewall\n");
> +			return ret;
> +		}
> +		ret = stm32_firewall_grant_access_by_id(&firewall, firewall.firewall_id);
> +		if (ret) {
> +			dev_err(pmu->dev, "Failed to grant access\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (of_property_present(pmu->dev->of_node, "clocks")) {

No, don't open-code get clk optional.

> +		pmu->clk = devm_clk_get_prepared(pmu->dev, NULL);
> +		if (IS_ERR(pmu->clk)) {
> +			dev_err(pmu->dev, "Failed to get clock\n");
> +			return PTR_ERR(pmu->clk);
> +		}
> +	}
> +
> +	clk_enable(pmu->clk);
> +
> +	if (of_property_present(pdev->dev.of_node, "resets")) {
> +		rst = devm_reset_control_get(&pdev->dev, NULL);
> +		if (IS_ERR(rst)) {
> +			dev_err(&pdev->dev, "Failed to get reset\n");
> +			ret = PTR_ERR(rst);
> +			goto err_clk;
> +		}
> +		reset_control_assert(rst);
> +		reset_control_deassert(rst);
> +	}
> +
> +	pmu->poll_period = ms_to_ktime(POLL_MS);
> +	hrtimer_setup(&pmu->hrtimer, stm32_ddr_pmu_poll, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +
> +	for (int i = 0; i < MP2_CNT_NB; i++)
> +		INIT_LIST_HEAD(&pmu->counters[i]);
> +
> +	pmu->selected_set = -1;
> +
> +	pmu->pmu = (struct pmu) {
> +		.task_ctx_nr = perf_invalid_context,
> +		.start = stm32_ddr_pmu_event_start,
> +		.stop = stm32_ddr_pmu_event_stop,
> +		.add = stm32_ddr_pmu_event_add,
> +		.del = stm32_ddr_pmu_event_del,
> +		.read = stm32_ddr_pmu_event_read,
> +		.event_init = stm32_ddr_pmu_event_init,
> +		.attr_groups = pmu->cfg->attribute,
> +		.module = THIS_MODULE,
> +	};
> +
> +	ret = perf_pmu_register(&pmu->pmu, DRIVER_NAME, -1);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Couldn't register DDRPERFM driver as a PMU\n");
> +		goto err_clk;
> +	}
> +
> +	if (pmu->cfg->regs->dram_inf.reg) {
> +		ret = of_property_read_u32(pdev->dev.of_node, "st,dram-type", &pmu->dram_type);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Missing device-tree property 'st,dram-type'\n");
> +			perf_pmu_unregister(&pmu->pmu);
> +
> +			return ret;
> +		}
> +
> +		writel_relaxed(pmu->dram_type, pmu->membase + pmu->cfg->regs->dram_inf.reg);
> +	}
> +
> +	clk_disable(pmu->clk);

Why do you keep clock prepared? This device does not know what sort of
clock it gets, so you end up with clock always active for example and
this being no-op.

> +
> +	return 0;
> +
> +err_clk:
> +	clk_disable_unprepare(pmu->clk);
> +
> +	return ret;
> +}
> +
> +static void stm32_ddr_pmu_device_remove(struct platform_device *pdev)
> +{
> +	struct stm32_ddr_pmu *stm32_ddr_pmu = platform_get_drvdata(pdev);
> +
> +	perf_pmu_unregister(&stm32_ddr_pmu->pmu);
> +}
> +
> +static int __maybe_unused stm32_ddr_pmu_device_resume(struct device *dev)
> +{
> +	struct stm32_ddr_pmu *pmu = dev_get_drvdata(dev);
> +
> +	clk_enable(pmu->clk);
> +	writel_relaxed(pmu->dram_type, pmu->membase + pmu->cfg->regs->dram_inf.reg);
> +	clk_disable(pmu->clk);
> +
> +	return 0;
> +}
> +
> +static const struct stm32_ddr_pmu_regspec stm32_ddr_pmu_regspec_mp1 = {
> +	.stop =		{ DDRPERFM_CTRL, CTRL_STOP },
> +	.start =	{ DDRPERFM_CTRL, CTRL_START },
> +	.enable =	{ DDRPERFM_CFG },
> +	.cfg =		{ DDRPERFM_CFG },
> +	.status =	{ DDRPERFM_STATUS, MP1_STATUS_BUSY },
> +	.clear_cnt =	{ DDRPERFM_CLR, MP1_CLR_CNT},
> +	.clear_time =	{ DDRPERFM_CLR, MP1_CLR_TIME},
> +	.counter_time =	{ DDRPERFM_TCNT },
> +	.counter_evt =	{
> +				{ DDRPERFM_EVCNT(0) },
> +				{ DDRPERFM_EVCNT(1) },
> +				{ DDRPERFM_EVCNT(2) },
> +				{ DDRPERFM_EVCNT(3) },
> +	},
> +};
> +
> +static const struct stm32_ddr_pmu_regspec stm32_ddr_pmu_regspec_mp2 = {
> +	.stop =		{ DDRPERFM_CTRL, CTRL_STOP },
> +	.start =	{ DDRPERFM_CTRL, CTRL_START },
> +	.status =	{ DDRPERFM_MP2_STATUS, MP2_STATUS_BUSY },
> +	.clear_cnt =	{ DDRPERFM_CLR, MP2_CLR_CNT},
> +	.clear_time =	{ DDRPERFM_CLR, MP2_CLR_TIME},
> +	.cfg0 =		{ DDRPERFM_MP2_CFG0 },
> +	.cfg1 =		{ DDRPERFM_MP2_CFG1 },
> +	.enable =	{ DDRPERFM_MP2_CFG5 },
> +	.dram_inf =	{ DDRPERFM_MP2_DRAMINF },
> +	.counter_time =	{ DDRPERFM_MP2_TCNT },
> +	.counter_evt =	{
> +				{ DDRPERFM_MP2_EVCNT(0) },
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
> +static const struct stm32_ddr_pmu_cfg stm32_ddr_pmu_cfg_mp1 = {
> +	.regs = &stm32_ddr_pmu_regspec_mp1,
> +	.attribute = stm32_ddr_pmu_attr_groups_mp1,
> +	.counters_nb = MP1_CNT_NB,
> +	.evt_counters_nb = MP1_CNT_NB - 1, /* Time counter is not an event counter */
> +	.time_cnt_idx = MP1_TIME_CNT_IDX,
> +	.get_counter = stm32_ddr_pmu_get_event_counter_mp1,
> +};
> +
> +static const struct stm32_ddr_pmu_cfg stm32_ddr_pmu_cfg_mp2 = {
> +	.regs = &stm32_ddr_pmu_regspec_mp2,
> +	.attribute = stm32_ddr_pmu_attr_groups_mp2,
> +	.counters_nb = MP2_CNT_NB,
> +	.evt_counters_nb = MP2_CNT_NB - 1, /* Time counter is an event counter */
> +	.time_cnt_idx = MP2_TIME_CNT_IDX,
> +	.get_counter = stm32_ddr_pmu_get_event_counter_mp2,
> +};
> +
> +static const struct dev_pm_ops stm32_ddr_pmu_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, stm32_ddr_pmu_device_resume)
> +};
> +
> +static const struct of_device_id stm32_ddr_pmu_of_match[] = {
> +	{
> +		.compatible = "st,stm32mp131-ddr-pmu",
> +		.data = &stm32_ddr_pmu_cfg_mp1
> +	},
> +	{
> +		.compatible = "st,stm32mp151-ddr-pmu",
> +		.data = &stm32_ddr_pmu_cfg_mp1

So devices are compatible, thus express it correctly and drop this.

> +	},
> +	{
> +		.compatible = "st,stm32mp251-ddr-pmu",
> +		.data = &stm32_ddr_pmu_cfg_mp2
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, stm32_ddr_pmu_of_match);
> +
> +static struct platform_driver stm32_ddr_pmu_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.pm = &stm32_ddr_pmu_pm_ops,
> +		.of_match_table = of_match_ptr(stm32_ddr_pmu_of_match),

Drop of_match_ptr, you have here warnings.



Best regards,
Krzysztof
