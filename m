Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACF8275B05;
	Wed, 25 Jun 2025 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750840608; cv=none; b=spKLMAwMQkVsyzXeVHut6OBwLIkYRoAc8kX6Gi0Wj+MPfhbPZlTkivwqJFXTzPh+LKFt3VCSHr28RomHohMsKDDbLuUyzb0hmonJVigvBMgLgG/i4G3zWtXD/kXc2YCdiWNJT1mOXlINy2Mrg9DeBce6v+bYISFnCuHFnNVzm28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750840608; c=relaxed/simple;
	bh=EbK0U+OP5CIqfg71sOAF4oAM+5LmkeILjjLQ3geqK5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EChmczUceWR1raU8nR5IZ0qXJdPftEdCibO9qbERnSwR6k4SC7aou3g7N0uWtN+RTuK3f3CeXIDm/0bkBFmpVrO2rVGUM6Zw6n5jSilw2jkrWVLjl9y3ZO1ILbNa41GVmRjkrLqPI2YH0moHxlRdS+kxIaVOBtumfsKFvG1y+v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=SqHnV/Gq; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="SqHnV/Gq"
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P6nksJ008379;
	Wed, 25 Jun 2025 10:36:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	5iWKPTMFpX+lonpPcbekR/V8/MBsHrjUivVDN79opdU=; b=SqHnV/GqxnozxlFn
	ObEanHvfEI2F+FZtdB/7rtcovax1mQOyY1mVLlQ1BSYzN3yIdeS4b9QiEoUlf22n
	cTk3tMwbAYEgr0NzY+C6Hu4ePlqFtc4ohf3c5cI1MVAtveM2SqSkuPOgaXVJl9t2
	lNCnLxNPGVWfXjSSFjGP4wGMV2SqlxyIdFceC6pGRDWYwmmr/huHgqdJtS0AtyK8
	zzxhKbVp4Gp7CwnIsip3EpIf8VWMfTaCJeNLMvIY5aPom3oUeQlg0pEMpwG3qDpL
	WCHhLTWw5LXNeUKngpRNl/Swhe1B9upvwpikOj5INAqO+91z2RN6R3qE/iQ39qUX
	HZIp/w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47dkmjrekf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 10:36:23 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A845540047;
	Wed, 25 Jun 2025 10:35:03 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 36FE8B0C401;
	Wed, 25 Jun 2025 10:33:50 +0200 (CEST)
Received: from [10.48.86.185] (10.48.86.185) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 10:33:49 +0200
Message-ID: <e2400615-f21e-40bf-84f8-384242632193@foss.st.com>
Date: Wed, 25 Jun 2025 10:33:48 +0200
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
 <5044c733-8836-43bd-85d7-0f552b000fb1@foss.st.com>
 <49483568-b287-45ca-a66c-1e0ad0490225@kernel.org>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <49483568-b287-45ca-a66c-1e0ad0490225@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_01,2025-06-23_07,2025-03-28_01

On 6/25/25 08:35, Krzysztof Kozlowski wrote:
> On 24/06/2025 12:43, Clement LE GOFFIC wrote:
>> On 6/23/25 11:45, Krzysztof Kozlowski wrote:
>> [...]
>>
>> Hi Krzysztof,
>>
>> Sorry I forgot to address comments below.
>>
>>>> +
>>>> +static const struct stm32_ddr_pmu_cfg stm32_ddr_pmu_cfg_mp1 = {
>>>> +	.regs = &stm32_ddr_pmu_regspec_mp1,
>>>> +	.attribute = stm32_ddr_pmu_attr_groups_mp1,
>>>> +	.counters_nb = MP1_CNT_NB,
>>>> +	.evt_counters_nb = MP1_CNT_NB - 1, /* Time counter is not an event counter */
>>>> +	.time_cnt_idx = MP1_TIME_CNT_IDX,
>>>> +	.get_counter = stm32_ddr_pmu_get_event_counter_mp1,
>>>> +};
>>>> +
>>>> +static const struct stm32_ddr_pmu_cfg stm32_ddr_pmu_cfg_mp2 = {
>>>> +	.regs = &stm32_ddr_pmu_regspec_mp2,
>>>> +	.attribute = stm32_ddr_pmu_attr_groups_mp2,
>>>> +	.counters_nb = MP2_CNT_NB,
>>>> +	.evt_counters_nb = MP2_CNT_NB - 1, /* Time counter is an event counter */
>>>> +	.time_cnt_idx = MP2_TIME_CNT_IDX,
>>>> +	.get_counter = stm32_ddr_pmu_get_event_counter_mp2,
>>>> +};
>>>> +
>>>> +static const struct dev_pm_ops stm32_ddr_pmu_pm_ops = {
>>>> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, stm32_ddr_pmu_device_resume)
>>>> +};
>>>> +
>>>> +static const struct of_device_id stm32_ddr_pmu_of_match[] = {
>>>> +	{
>>>> +		.compatible = "st,stm32mp131-ddr-pmu",
>>>> +		.data = &stm32_ddr_pmu_cfg_mp1
>>>> +	},
>>>> +	{
>>>> +		.compatible = "st,stm32mp151-ddr-pmu",
>>>> +		.data = &stm32_ddr_pmu_cfg_mp1
>>>
>>> So devices are compatible, thus express it correctly and drop this.
>>
>> Ok so I assume this comes with your comment in the bindings and
>> basically don't get you point here.
>> Can you please be more precise ?
> 
> Express compatibility in the bindings, like 90% of SoCs are doing, so
> with proper fallback and drop this entry in the table. My comment was
> pretty precise, because this is completely standard pattern, also used
> already in stm32.
> 

Ok I remember your discussion with Alex in my V1 of pinctrl-hdp :
https://lore.kernel.org/all/1de58672-5355-4b75-99f4-c48687017d2f@kernel.org/

Does it suits you :
In the SoC DT:
MP13: compatible = "st,stm32mp131-ddr-pmu", "st,stm32mp1-ddr-pmu";
MP15: compatible = "st,stm32mp151-ddr-pmu", "st,stm32mp1-ddr-pmu";
MP25: compatible = "st,stm32mp251-ddr-pmu";

In the bindings:
properties:
   compatible:
     enum:
       - st,stm32mp1-ddr-pmu
       - st,stm32mp131-ddr-pmu
       - st,stm32mp151-ddr-pmu
       - st,stm32mp251-ddr-pmu

In the driver:
static const struct of_device_id stm32_ddr_pmu_of_match[] = {
	{
		.compatible = "st,stm32mp1-ddr-pmu",
		.data = &stm32_ddr_pmu_cfg_mp1
	},
	{
		.compatible = "st,stm32mp251-ddr-pmu",
		.data = &stm32_ddr_pmu_cfg_mp2
	},
	{ },
};

Best regards,
Clément

> Best regards,
> Krzysztof

