Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196382882CA;
	Wed, 25 Jun 2025 08:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841324; cv=none; b=OLPTvxqx34BWqTy2gZIkD31DVnhSVeqCvhD3HIb+T2wvWEWYyvomXD3zby/icqu6u4XzyT+T1dx7ILw9BkrozqAh4eg8dllzq3QJ9oDJZUasRPXJn7DsqzeXV2i2FQ8hHyv7aM3Tz5SHtYhnPh5WK3plCyRsNAlwQOlqIQABqnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841324; c=relaxed/simple;
	bh=MHBZGoaoMcLa2LG0Yh6EdemoDEGT5KReqDlcQpZb7Xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ezcuW3X+PKqlmMj+ppR89j0jsNOqeN9JlP3TQrgzp3Yew28zTEszisDpZJLosEQrVOWLl/gcAKtoe6bTkecx6WBGkKSl3GK30v5HC+EX2ZvyVm7VFodZcy5c6W5WEhBySHcXoaTcHZp6BTE/D1Q2YDwxbe3ZDOVzyLdSjzQBjf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWAAHgBT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWAAHgBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B63C4CEEA;
	Wed, 25 Jun 2025 08:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750841323;
	bh=MHBZGoaoMcLa2LG0Yh6EdemoDEGT5KReqDlcQpZb7Xg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QWAAHgBTocPEPd/QUDnRrg7PlySkZ+mQhXIeVrFkmWrj5XE11rF7T36Plj0XN1/id
	 IkRmnuYv2lw9HBhciUlgXnHZRGcmHblYt2TW0epifrKqWg3Defzq1QJO+WZ1CiGUPB
	 vguNkoOI8gIJpuJZV7ydp6QaseiOAcYE2QiKnixOUadthVBSu0WQJJdX30tNmdC6wl
	 8/+7/F3AYHLgBdjYB5vz6dzTX5or7it4vijSy89ppsJ9O2JoOUSjbjA8HAniDHr0F2
	 rab/uipHpePrfAjSZ31xUsLf1Xl/p/n2jjOhK7R+AybOtr4itGmQ9igOP9+l3UcK5l
	 lh3Ix3Pj0c9vw==
Message-ID: <a6440cbf-f7b5-4bce-8e2b-8aa3ec4d2342@kernel.org>
Date: Wed, 25 Jun 2025 10:48:37 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] perf: stm32: introduce DDRPERFM driver
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>,
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
 <9cb1575e-ae27-4a78-adb7-8a9e7072375e@kernel.org>
 <5044c733-8836-43bd-85d7-0f552b000fb1@foss.st.com>
 <49483568-b287-45ca-a66c-1e0ad0490225@kernel.org>
 <e2400615-f21e-40bf-84f8-384242632193@foss.st.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <e2400615-f21e-40bf-84f8-384242632193@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/06/2025 10:33, Clement LE GOFFIC wrote:
> On 6/25/25 08:35, Krzysztof Kozlowski wrote:
>> On 24/06/2025 12:43, Clement LE GOFFIC wrote:
>>> On 6/23/25 11:45, Krzysztof Kozlowski wrote:
>>> [...]
>>>
>>> Hi Krzysztof,
>>>
>>> Sorry I forgot to address comments below.
>>>
>>>>> +
>>>>> +static const struct stm32_ddr_pmu_cfg stm32_ddr_pmu_cfg_mp1 = {
>>>>> +	.regs = &stm32_ddr_pmu_regspec_mp1,
>>>>> +	.attribute = stm32_ddr_pmu_attr_groups_mp1,
>>>>> +	.counters_nb = MP1_CNT_NB,
>>>>> +	.evt_counters_nb = MP1_CNT_NB - 1, /* Time counter is not an event counter */
>>>>> +	.time_cnt_idx = MP1_TIME_CNT_IDX,
>>>>> +	.get_counter = stm32_ddr_pmu_get_event_counter_mp1,
>>>>> +};
>>>>> +
>>>>> +static const struct stm32_ddr_pmu_cfg stm32_ddr_pmu_cfg_mp2 = {
>>>>> +	.regs = &stm32_ddr_pmu_regspec_mp2,
>>>>> +	.attribute = stm32_ddr_pmu_attr_groups_mp2,
>>>>> +	.counters_nb = MP2_CNT_NB,
>>>>> +	.evt_counters_nb = MP2_CNT_NB - 1, /* Time counter is an event counter */
>>>>> +	.time_cnt_idx = MP2_TIME_CNT_IDX,
>>>>> +	.get_counter = stm32_ddr_pmu_get_event_counter_mp2,
>>>>> +};
>>>>> +
>>>>> +static const struct dev_pm_ops stm32_ddr_pmu_pm_ops = {
>>>>> +	SET_SYSTEM_SLEEP_PM_OPS(NULL, stm32_ddr_pmu_device_resume)
>>>>> +};
>>>>> +
>>>>> +static const struct of_device_id stm32_ddr_pmu_of_match[] = {
>>>>> +	{
>>>>> +		.compatible = "st,stm32mp131-ddr-pmu",
>>>>> +		.data = &stm32_ddr_pmu_cfg_mp1
>>>>> +	},
>>>>> +	{
>>>>> +		.compatible = "st,stm32mp151-ddr-pmu",
>>>>> +		.data = &stm32_ddr_pmu_cfg_mp1
>>>>
>>>> So devices are compatible, thus express it correctly and drop this.
>>>
>>> Ok so I assume this comes with your comment in the bindings and
>>> basically don't get you point here.
>>> Can you please be more precise ?
>>
>> Express compatibility in the bindings, like 90% of SoCs are doing, so
>> with proper fallback and drop this entry in the table. My comment was
>> pretty precise, because this is completely standard pattern, also used
>> already in stm32.
>>
> 
> Ok I remember your discussion with Alex in my V1 of pinctrl-hdp :
> https://lore.kernel.org/all/1de58672-5355-4b75-99f4-c48687017d2f@kernel.org/
> 
> Does it suits you :
> In the SoC DT:
> MP13: compatible = "st,stm32mp131-ddr-pmu", "st,stm32mp1-ddr-pmu";
> MP15: compatible = "st,stm32mp151-ddr-pmu", "st,stm32mp1-ddr-pmu";

No, because I did not say to change other entry in the table. Please
read again what I asked: drop this. "This" means ONLY this entry. "Drop
this" does not mean "change something else". Do not change other entries
by introducing some generic compatible. That's not the pattern ever
endorsed by DT maintainers. Add front compatible and you are done,
smallest amount of changes, most obvious code.

Best regards,
Krzysztof
