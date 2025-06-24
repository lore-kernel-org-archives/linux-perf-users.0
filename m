Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14FB2222AF;
	Tue, 24 Jun 2025 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750761982; cv=none; b=uzLW4ZmBhwxZ+hFvOxi8npnETTEXbZ0cdsUV+H/TIFSCA76rmVsRyxN9u58kpV5Z1BzUSEHmHD6sL7kduebL5bQMNN2a3Fecs3kJSWTs/DWDooPS7vnVBDQAyqxQlanNMTpPkdQJgJiVjB2xmTyfHE+6Tb6gV2walcOBz7Mrq2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750761982; c=relaxed/simple;
	bh=UqWYnkZxIfBxNvrN3q062W40OjIAoDQnWRibvmyYYHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T+2wEurBlASl80nuAwqjQnDIn1C3ZflY+S8FT59TXUEZtEStEophwD6Ed+lsSlHNnJcPU2NLvYcLOfw98yvVeQWxaa+8JRuJAbDBgvI2ksNIPGAKWCe+OU1JS2k47NYQCBPmCFMp8n9rEY8Y1gdQQpSHJVCfsJxRi3TM92/W1yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NW+9A/iY; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NW+9A/iY"
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O89PlW018562;
	Tue, 24 Jun 2025 12:45:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	LowxC1XeO1Q3ptnV100NCfbZE/+FCacaRTlFDEZ7nw4=; b=NW+9A/iYDBIYOudx
	bupDVw7fFsOUiF1POCQhkWRdtrMnA2SQEgn3ffTStQz7psNYYvO1bykZpdgutoWy
	1WzDPo1HfRDTujMzGceUmoFF9dI3csRqk+OrSjX2U1Q82AHPZk0yuR9GirUQWEuY
	0uTXBDmqmhreOATOMkPOrAg+HFRtqZZO74LR/Kz8sUH5woYThZWMJktOCzrRuZP5
	jloxRIqQkKw51725g6fIFcIyiDtijqkG3NSDKgTMgLLmmSM6OD0+OHlCDgC/T3aL
	OBE2cZ+Obv2dvhAJpM9vhApHeFKzbOlpzSn/muvTc+F8R53Tnl46alaOILvOrx/r
	WA2Mzw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47dkmjm6bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 12:45:45 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5B79640046;
	Tue, 24 Jun 2025 12:44:24 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 974C5B51BAB;
	Tue, 24 Jun 2025 12:43:10 +0200 (CEST)
Received: from [10.48.86.185] (10.48.86.185) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 12:43:09 +0200
Message-ID: <5044c733-8836-43bd-85d7-0f552b000fb1@foss.st.com>
Date: Tue, 24 Jun 2025 12:43:08 +0200
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
 definitions=2025-06-24_04,2025-06-23_07,2025-03-28_01

On 6/23/25 11:45, Krzysztof Kozlowski wrote:
[...]

Hi Krzysztof,

Sorry I forgot to address comments below.

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

Ok so I assume this comes with your comment in the bindings and 
basically don't get you point here.
Can you please be more precise ?

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

Yes Indeed.
I'll also fix the pm pointer by using "pm_sleep_ptr".

Best regards,
Clément

> 
> 
> 
> Best regards,
> Krzysztof

