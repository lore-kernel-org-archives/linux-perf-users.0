Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8861B268C55;
	Mon, 28 Jul 2025 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708566; cv=none; b=TzhGMyNaDV2YsdqJOLSodJOPoj5nIg512b28yA1HPPEEOGHqIQCUJLWbeYq97n9/fppw9jvDtAfdZPIo1iU4J5QFaRWs28q44MBUP3PuxRJSM19v+7bCfdxUQkSCUj8RbKMuO/NQdS9a/DzAeSav82vHi38NJLTVX4sod1/nDX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708566; c=relaxed/simple;
	bh=W+KZZXncins1T9GC8mCt4jsiJpGpKp81eBfzguGPl9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s4wuBx+1qfLoZ06WJoVMGTQWvlxUglb2M1tqorCnedJ/zaMjD2LcxOgRA5tf/zzJIUkU5EQBo8kVjPIpK7oD45voq2qBgJoaWap3sRFnJb0CulOp0K4H4VqKW03+AkVr5uAx4UpxvnRkax+M+WY6zvK001SBUympzjUV3ojrYV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=nXLFmQf0; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="nXLFmQf0"
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SD78TP018548;
	Mon, 28 Jul 2025 15:15:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	6ozDjiR1DVr/3HRBmHIYQGBx0Ek2Vvu4LxeRw9hd+a0=; b=nXLFmQf0lGgLF+X9
	gLaWXmG2IiruQBxDjVB3d0J9Ofg68aZEG/2O2+ed85NLa0ZUIb38INT2yw99xAha
	GeWHUQUbt9Ee9sBaFLbw0iV/iylfIbXTpieHZ5iRxvZuPYBbNhWhsftdqVMTq2kA
	qO47UfA862g9kGKb8NK1f5lMnbAg6DH0LirQxfuGPtNyn2QGyKdomZF10fINxa4N
	c58PWHscY3P7erPOeAhAqQCbcZZwIu8sAV3/dXtKh9i7y0PRVectbVhOv0pxvfym
	WNZY0Hh69RNseI6BCwCaLQ1OkIuuX6pYQ8bmP2+kiT1a3eGUqRcYNsiqYHzbM9Fp
	kVfLKg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 484m5906v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 15:15:27 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0285640055;
	Mon, 28 Jul 2025 15:13:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A04F177E309;
	Mon, 28 Jul 2025 15:12:24 +0200 (CEST)
Received: from [10.252.23.100] (10.252.23.100) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 15:12:23 +0200
Message-ID: <2ceafbbe-064e-4227-8b44-edc67d22f6b4@foss.st.com>
Date: Mon, 28 Jul 2025 15:12:22 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/19] perf: stm32: introduce DDRPERFM driver
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
        Julius Werner <jwerner@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20250722-ddrperfm-upstream-v3-0-7b7a4f3dc8a0@foss.st.com>
 <20250722-ddrperfm-upstream-v3-12-7b7a4f3dc8a0@foss.st.com>
 <20250725115655.00002304@huawei.com>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <20250725115655.00002304@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01

Hi Jonathan

On 7/25/25 12:56, Jonathan Cameron wrote:
> On Tue, 22 Jul 2025 16:03:29 +0200
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
> Hi Clément,
> 
> Minor comments inline.,
> 
> Thanks,
> 
> Jonathan
> 
>> --- /dev/null
>> +++ b/drivers/perf/stm32_ddr_pmu.c
>> @@ -0,0 +1,896 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2025, STMicroelectronics - All Rights Reserved
>> + * Author: Clément Le Goffic <clement.legoffic@foss.st.com> for STMicroelectronics.
>> + */
>> +
>> +#include <linux/bus/stm32_firewall_device.h>
>> +#include <linux/clk.h>
>> +#include <linux/hrtimer.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of_platform.h>
> Why?
For of_device_id and platform_device structs
> Looks like of.h is needed so you should include that directly.
> 
> Check all your headers.  mod_devicetable.h should be here
> for instance.

mod_devicetable.h is already included in of_platform.h but imagine it 
should be directly include as I do not use any symbol from of_platform.h

Thank you for pointing this out.
I'll have a look on other includes.

Do you have any method to include directly what you need ?
As of here symbols were available through other include but this is not 
correct.
Is there any tool nor tips to find the right include directly and easily ?

>> +#include <linux/perf_event.h>
>> +#include <linux/reset.h>
> 
>> +
>> +static void stm32_ddr_pmu_event_del(struct perf_event *event, int flags)
>> +{
>> +	struct stm32_ddr_pmu *pmu = to_stm32_ddr_pmu(event->pmu);
>> +	struct stm32_ddr_cnt *counter = event->pmu_private;
>> +	bool events = true;
>> +
>> +	stm32_ddr_pmu_event_stop(event, PERF_EF_UPDATE);
>> +
>> +	stm32_ddr_pmu_free_counter(pmu, counter);
>> +
>> +	for (int i = 0; i < pmu->cfg->counters_nb; i++)
>> +		events = !list_empty(&pmu->counters[i]);
> What is this trying to do?  It seems to be only setting
> 	events = !list_empty(&pmu->counters[pmu->cfg_counters_nb - 1]);
> 
> If so just check that but my guess it you care if there is anything
> in any of them lists.

Indeed the test must be in the for loop, thanks.
The idea here is to loop over the counters and check if one of them is 
still active so we don't stop the HW.

I'll do:
	for (int i = 0; i < pmu->cfg->counters_nb; i++) {
		events = !list_empty(&pmu->counters[i]);
		if (events) /* If there is activity nothing to do */
			return;
	}

> 
>> +
>> +	/* If there is activity nothing to do */
>> +	if (events)
>> +		return;
>> +
>> +	hrtimer_cancel(&pmu->hrtimer);
>> +	stm32_ddr_stop_counters(pmu);
>> +
>> +	pmu->selected_set = -1;
>> +
>> +	clk_disable(pmu->clk);
>> +}
> 
> 
>> +static int stm32_ddr_pmu_get_memory_type(struct stm32_ddr_pmu *pmu)
>> +{
>> +	struct platform_device *pdev = to_platform_device(pmu->dev);
>> +	struct device_node *memchan;
>> +
>> +	memchan = of_parse_phandle(pdev->dev.of_node, "memory-channel", 0);
>> +	if (!memchan)
>> +		return dev_err_probe(&pdev->dev, -EINVAL,
>> +				     "Missing device-tree property 'memory-channel'\n");
>> +
>> +	if (of_device_is_compatible(memchan, "jedec,lpddr4-channel"))
> 
> Random thought, feel free to ignore.
> I wonder if it's worth using an of_device_id match table here?
I don't think it would be worth it but if wanted I can switch.
>
>> +		pmu->dram_type = STM32_DDR_PMU_LPDDR4;
>> +	else if (of_device_is_compatible(memchan, "jedec,lpddr3-channel"))
>> +		pmu->dram_type = STM32_DDR_PMU_LPDDR3;
>> +	else if (of_device_is_compatible(memchan, "jedec,ddr4-channel"))
>> +		pmu->dram_type = STM32_DDR_PMU_DDR4;
>> +	else if (of_device_is_compatible(memchan, "jedec,ddr3-channel"))
>> +		pmu->dram_type = STM32_DDR_PMU_DDR3;
>> +	else
>> +		return dev_err_probe(&pdev->dev, -EINVAL, "Unsupported memory channel type\n");
>> +
>> +	if (pmu->dram_type == STM32_DDR_PMU_LPDDR3)
>> +		dev_warn(&pdev->dev,
>> +			 "LPDDR3 supported by DDRPERFM but not supported by DDRCTRL/DDRPHY\n");
>> +
>> +	return 0;
>> +}
> 
>> +static struct attribute *stm32_ddr_pmu_events_attrs_mp[] = {
>> +	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_rd, PERF_OP_IS_RD),
>> +	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_wr, PERF_OP_IS_WR),
>> +	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_activate, PERF_OP_IS_ACTIVATE),
>> +	STM32_DDR_PMU_EVENT_ATTR(ctl_idle, CTL_IDLE),
>> +	STM32_DDR_PMU_EVENT_ATTR(perf_hpr_req_with_no_credit, PERF_HPR_REQ_WITH_NO_CREDIT),
>> +	STM32_DDR_PMU_EVENT_ATTR(perf_lpr_req_with_no_credit, PERF_LPR_REQ_WITH_NO_CREDIT),
>> +	STM32_DDR_PMU_EVENT_ATTR(cactive_ddrc, CACTIVE_DDRC),
>> +	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_enter_powerdown, PERF_OP_IS_ENTER_POWERDOWN),
>> +	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_refresh, PERF_OP_IS_REFRESH),
>> +	STM32_DDR_PMU_EVENT_ATTR(perf_selfresh_mode, PERF_SELFRESH_MODE),
>> +	STM32_DDR_PMU_EVENT_ATTR(dfi_lp_req, DFI_LP_REQ),
>> +	STM32_DDR_PMU_EVENT_ATTR(perf_hpr_xact_when_critical, PERF_HPR_XACT_WHEN_CRITICAL),
>> +	STM32_DDR_PMU_EVENT_ATTR(perf_lpr_xact_when_critical, PERF_LPR_XACT_WHEN_CRITICAL),
>> +	STM32_DDR_PMU_EVENT_ATTR(perf_wr_xact_when_critical, PERF_WR_XACT_WHEN_CRITICAL),
>> +	STM32_DDR_PMU_EVENT_ATTR(dfi_lp_req_cpy, DFI_LP_REQ),  /* Suffixed '_cpy' to allow the
>> +								* choice between sets 2 and 3
>> +								*/
>> +	STM32_DDR_PMU_EVENT_ATTR(time_cnt, TIME_CNT),
>> +	NULL,
> 
> No trailing comma for a terminating entry like this.  You got the other cases
> so I guess this one just got missed.

Ack.

>> +};
> 
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
>> +	pmu->cfg = device_get_match_data(pmu->dev);
>> +
>> +	pmu->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>> +	if (IS_ERR(pmu->membase))
>> +		return PTR_ERR(pmu->membase);
>> +
>> +	if (of_property_present(pmu->dev->of_node, "access-controllers")) {
>> +		ret = stm32_firewall_get_firewall(pmu->dev->of_node, &firewall, 1);
> 
> Jiri is busy driving dev_fwnode() thorugh to get rid of all the directly references
> to of_node.  Probably better to use that here from the start.
> 
> 
>> +		if (ret)
>> +			return dev_err_probe(pmu->dev, ret, "Failed to get firewall\n");
>> +		ret = stm32_firewall_grant_access_by_id(&firewall, firewall.firewall_id);
>> +		if (ret)
>> +			return dev_err_probe(pmu->dev, ret, "Failed to grant access\n");
>> +	}
>> +
>> +	pmu->clk = devm_clk_get_optional_enabled(pmu->dev, NULL);
>> +	if (IS_ERR(pmu->clk))
>> +		return dev_err_probe(pmu->dev, PTR_ERR(pmu->clk), "Failed to get prepare clock\n");
> 
> Comment doesn't match code. This is going to enabled, not just prepared.
Indeed.

>> +
>> +	rst = devm_reset_control_get_optional_exclusive(pmu->dev, NULL);
>> +	if (IS_ERR(rst))
>> +		return dev_err_probe(pmu->dev, PTR_ERR(rst), "Failed to get reset\n");
> 
>> +}

Best regards,
Clément
