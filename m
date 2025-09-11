Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A3F1A9FA8;
	Thu, 11 Sep 2025 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757584609; cv=none; b=J6+tjfUyIIoOWFh9+fPwgvxWMj0zNb5UgpO5QO9Sgif2EfIl+cEwRxLKKgvvXrnpo6n6415YYET58NiZs6beWCiRTewXbwkANN0EVq3r7xzI41CV9ES+poGmzkx82yC6WMlMBZfOYWb1o4D/l1NYX0ms/jyrFw+6kcrNAHqBtCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757584609; c=relaxed/simple;
	bh=NNRDzEMyXb7z9BvX+5iCWZ1jzriJYgVNyQVrmXGPbQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rAbo1Ge5iww7HaAc6IwZZQVoPSIgb4IAvCEnqYH26D/HlNvPx71SzG7YGcNPCgOFiuU17YYDLwJQNlD9hHNhXM4hwbYfKuI1BkF59XsdI0JeeUE/n1fj/oA1QNl51YdUntQbbf0T1ftaslbXJHYi7+gLk+sPkNrq9k0En5qA6nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/TKvTcF; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/TKvTcF"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3e7428c4cbdso393712f8f.0;
        Thu, 11 Sep 2025 02:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757584606; x=1758189406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+gFz16OXxdVWNpZ+XAvrYshRDoVNNNdGGCZgE4lW13o=;
        b=F/TKvTcFwyf2sK9KPMaysB23sEG6gik6YcJEQb8QADBuoBgi5xrlLKbzG7OdjxS+zP
         0Ay4DGoEFrw36K+LRsc1r68JdKbTtKDdMekb9LgMvV//yNlJ88+pDmMdEU5/ou19Ez2f
         eL0qWFnFD5mWkbV7wXSYFyAgI6hajcSaN4h5hb5boLIh8x5DdUgW5+x/SQMGRMo+49TM
         Fjfm6Laa/5j/VUKA4VNKxGyp+xOxY8Rb0Zau8t47IML5PDGf8dJs/JFKZeUwB2hvHDJH
         kI/zy9JWVhWRwIV6CAGWeQlLLAVIPxwyUpHa8DkzfHSk5DO2Q5c+9RUIqq4JfUCI+Exh
         G9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757584606; x=1758189406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gFz16OXxdVWNpZ+XAvrYshRDoVNNNdGGCZgE4lW13o=;
        b=IEI2lfqouZpFovxQ53nn9oEe2Hs8xaoyXHjvsKDES04zs/kMVTsN5FJAu82rEaGJog
         w0QhZBjolQsoDjo9i/I2AuS7OehGCgj2Xh+UK5YVwf3ObfBz+SSdvjknMoh5zMPaE83s
         xJqJqdUoMkDa9mmngtvZJ2SlDBi62ZIW3msGRDBZLuTfVBiMauOTlf4CAptG05bX2dYI
         aAfiQc5EQpVnNEJVdMja4XqInhiTA2czjw5Kb0nGVfqRJYyRww11EgeZO1Jou19F50vh
         iQBfGzyjV0l4Tk4kiHZt4840NkozGNB+EuOBrzmopDDVNhFHP7NShdCrvohwy1oDdmQW
         /vZA==
X-Forwarded-Encrypted: i=1; AJvYcCUbggr7IZQVcyh7W0mpJKsz2wC74H8YIXoFFOJmJqKpPs30VfRTIedXYwLoBc5UCgZzVSm7yzynpbZa@vger.kernel.org, AJvYcCVgQjrBSH+hjhvap9UeE4ZUH7oauOwx6Dd16XNozjdlecELm9agAFUx3/3c8bH/EsfK3ODPV301x/irTosMPsYy2A==@vger.kernel.org, AJvYcCWGS+nRK5Xe0ONY667hmnr3treGllh/lcOkWdSR3GSTOKG93EFEJy2OXaJoeh8fmdOvYpmT5xFU8CkD@vger.kernel.org, AJvYcCWwlgasxvWeFgBvmOe5OBnsPK5EgaQ071Z9dgJbEvHs0eOeuZHttR7ikE325QKeiOnOtcidME3WAWlvOOrO@vger.kernel.org, AJvYcCXWqRmAi/fKJx9ePFVGXpkFPs5NHNuNIwoKzrDAtzctWwSbyfL58vlgH056Lyuc8TuvFzzLQH4wTCrd@vger.kernel.org
X-Gm-Message-State: AOJu0YwgOCk4/a/BYuTKHLOasvKxHo46pzRoO+ReuZOrKKj4wUFrKAtO
	1Lo8GbW9y2YR3U2jprWDSZx7TEBWUpyEi08vKUGXC3zScfImOAFLWY6x
X-Gm-Gg: ASbGncvmUo38E+XBL1Db8MdOCUMKPMagkgQls3PJRqFmUIjeN510YzJ1GBFCjBwslr/
	jh9zcSMrOhNe9GCt8fv3gskVugpOWE31cBrwKLv1OXJVZJ3MnP2vx5ZFCemSt2C3TSHHb1vNkCY
	72rPXvFFBX6Zizb1BCjt/lGQ46+GmoJOXH2XIAL38sXSQy/jZ4B3sVW1EE0pk3sqjorcFot1FuL
	ZrtSnfPBVt19wIW71j9cbIPrBx17j1nvzYVOZxbWe1IFNOQhMKkfgiWFNCJZT7NkTTW5tl06i5h
	YWZGE4n8K7D8EnjsDg9wkKsVUTldiJXDE8BUI4cZj3H91NxfPbQOGFGXY3O0uAtCxJjcgyRy2M7
	JzM5OAh/Wn+qDv4YDo5aYmkNVRaeK5dQLYgVpFkAmJZQWl9ElKvzrWeeXPTdFo1mK/AmIJq5Y8D
	gstgXUHZjkKRK9YtF6JHnl7p+tWcPrTEsnt/28540/txByhK9NFvCNgkdNMe1IgCG9/A==
X-Google-Smtp-Source: AGHT+IFsyOKmEcChP9t0DqmtXOvTU/RBxiKR0aH0FNUztPJysvQ4Mcixg7qVyb6OlqpSIPNKJ5m26Q==
X-Received: by 2002:a05:6000:1a8b:b0:3c2:d7f0:9c4e with SMTP id ffacd0b85a97d-3e75e0fadc1mr2058003f8f.8.1757584605567;
        Thu, 11 Sep 2025 02:56:45 -0700 (PDT)
Received: from ?IPV6:2a02:8440:714e:6956:5ea7:44db:f723:be79? (2a02-8440-714e-6956-5ea7-44db-f723-be79.rev.sfr.net. [2a02:8440:714e:6956:5ea7:44db:f723:be79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607d7c02sm1803049f8f.52.2025.09.11.02.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 02:56:45 -0700 (PDT)
Message-ID: <1a9ddd04-7877-4b4b-b746-0f3cf6ce0d8b@gmail.com>
Date: Thu, 11 Sep 2025 11:56:41 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/20] perf: stm32: introduce DDRPERFM driver
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Julius Werner <jwerner@chromium.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
References: <20250909-b4-ddrperfm-upstream-v6-0-ce082cc801b5@gmail.com>
 <20250909-b4-ddrperfm-upstream-v6-13-ce082cc801b5@gmail.com>
 <20250910102627.00007a40@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
In-Reply-To: <20250910102627.00007a40@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/09/2025 11:26, Jonathan Cameron wrote:
> On Tue, 09 Sep 2025 12:12:20 +0200
> Clément Le Goffic <legoffic.clement@gmail.com> wrote:
> 
>> From: Clément Le Goffic <clement.legoffic@foss.st.com>
>>
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
>> Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
> Hi Clément
> 
> A quick drive by review,
> 

Hi Jonathan,

Thank you for the review, below are my answers

> 
>> diff --git a/drivers/perf/stm32_ddr_pmu.c b/drivers/perf/stm32_ddr_pmu.c
>> new file mode 100644
>> index 000000000000..38328663d2c5
>> --- /dev/null
>> +++ b/drivers/perf/stm32_ddr_pmu.c
>> @@ -0,0 +1,897 @@
> 
>> +
>> +#define MP1_CLR_CNT		GENMASK(3, 0)
>> +#define MP1_CLR_TIME		BIT(31)
>> +#define MP2_CLR_CNT		GENMASK(7, 0)
>> +#define MP2_CLR_TIME		BIT(8)
>> +
>> +/* 4 event counters plus 1 dedicated to time */
>> +#define MP1_CNT_NB		(4 + 1)
> 
> This is never used so I would drop it and rename the MP2_CNT_NB
> to indicate it is the max value for any devices supported.

It is used in the stm32_ddr_pmu_cfg_mp1 struct which is the device 
platform data.
> 
> 
>> +/* Index of the time dedicated counter */
>> +#define MP1_TIME_CNT_IDX	4
>> +
>> +/* 8 event counters plus 1 dedicated to time */
>> +#define MP2_CNT_NB		(8 + 1)
> ...
> 
>> +struct stm32_ddr_pmu {
>> +	struct pmu pmu;
>> +	void __iomem *membase;
>> +	struct device *dev;
>> +	struct clk *clk;
>> +	const struct stm32_ddr_pmu_cfg *cfg;
>> +	struct hrtimer hrtimer;
>> +	ktime_t poll_period;
>> +	int selected_set;
>> +	u32 dram_type;
>> +	struct list_head counters[];
> The absence of a __counted_by() marking made me wonder how
> we ensured that this wasn't overrun.  I see below that's because
> size is always the same.  So
> 	struct list_head counters[MP2_CNT_NB];
> If you do want to make it dynamic then that is fine but added
> a local variable for the size and the __counted_by() marking so
> the various analysis tools can check for buffer overruns.

Oh I didn't know about this __counted_by compiler attribute.
I'll have a look and try to use it.
The array shouldn't have the same size basically it should depends on 
the platform counters number.
There is definitely something to rework regarding the allocation.
Thank you for pointing it.

> 
>> +};
> 
> 
> 
>> +static void stm32_ddr_pmu_event_del(struct perf_event *event, int flags)
>> +{
>> +	struct stm32_ddr_pmu *pmu = to_stm32_ddr_pmu(event->pmu);
>> +	struct stm32_ddr_cnt *counter = event->pmu_private;
>> +	bool events = true;
> 
> Always set before use, so don't set it here.  I'd move this into the
> scope of the for loop to make this more obvious.

Right, i'll remove the assignation.

> 
>> +
>> +	stm32_ddr_pmu_event_stop(event, PERF_EF_UPDATE);
>> +
>> +	stm32_ddr_pmu_free_counter(pmu, counter);
>> +
>> +	for (int i = 0; i < pmu->cfg->counters_nb; i++) {
>> +		events = !list_empty(&pmu->counters[i]);
>> +		if (events) /* If there is activity nothing to do */
>> +			return;
>> +	}
>> +
>> +	hrtimer_cancel(&pmu->hrtimer);
>> +	stm32_ddr_stop_counters(pmu);
>> +
>> +	pmu->selected_set = -1;
>> +
>> +	clk_disable(pmu->clk);
>> +}
> 
>> +
>> +#define STM32_DDR_PMU_EVENT_ATTR(_name, _id)			\
>> +	PMU_EVENT_ATTR_ID(_name, stm32_ddr_pmu_sysfs_show, _id)
>> +
>> +static struct attribute *stm32_ddr_pmu_events_attrs_mp[] = {
>> +	STM32_DDR_PMU_EVENT_ATTR(perf_op_is_rd, PERF_OP_IS_RD),
> 
> Prefixing perf events with perf_ seems unnecessary.
> 
> I guess perf_op_is_rd is counting all reads?  Is so why not call it simply 'reads'
> or something else short like that?  If it's cycles when a read is going on then
> maybe a more complex is needed, but perf_op_is_rd doesn't convey that to me.

Here I just extracted the name of each event from the datasheet and for 
some of them there are prefixed by "perf_".
I do not have enough knowledge of the HW to just rename it read and let 
other event with their "scientific name".
To me I should stick to a policy either rename all the events with 
understandable names or keep all event names like this.
And I'm unable to find an understandable name for each event.

> 
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
>> +	NULL
>> +};
> 
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
> 
> If using a fixed number of counters why not put it in the struct
> definition and simplify the code?  I agree it is probably not
> worth making this dynamic given small sizes but I don't mind
> if you do want to do this.  The only thing that isn't a good idea
> is this dynamic, but not really, current situation.

Yes something need reworks here as said above in your first comment.
I will try to find the best solution.

> 
>> +	if (!pmu)
>> +		return -ENOMEM;
> 
> 
> 
>> +static DEFINE_SIMPLE_DEV_PM_OPS(stm32_ddr_pmu_pm_ops, NULL, stm32_ddr_pmu_device_resume);
>> +
>> +static const struct of_device_id stm32_ddr_pmu_of_match[] = {
>> +	{
>> +		.compatible = "st,stm32mp131-ddr-pmu",
>> +		.data = &stm32_ddr_pmu_cfg_mp1
> 
> Trivial but if you are spinning again, normal convention is trailing commas
> in cases like this because maybe other fields will get set later.
Yes this is something I should keep in mind each time I init a struct.
I'll fix it for the next version.

> 
>> +	},
>> +	{
>> +		.compatible = "st,stm32mp251-ddr-pmu",
>> +		.data = &stm32_ddr_pmu_cfg_mp2
>> +	},
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, stm32_ddr_pmu_of_match);
>> +
>> +static struct platform_driver stm32_ddr_pmu_driver = {
>> +	.driver = {
>> +		.name = DRIVER_NAME,
>> +		.pm = pm_sleep_ptr(&stm32_ddr_pmu_pm_ops),
>> +		.of_match_table = stm32_ddr_pmu_of_match,
>> +	},
>> +	.probe = stm32_ddr_pmu_device_probe,
>> +	.remove = stm32_ddr_pmu_device_remove,
>> +};
>> +
>> +module_platform_driver(stm32_ddr_pmu_driver);
>> +
>> +MODULE_AUTHOR("Clément Le Goffic");
>> +MODULE_DESCRIPTION("STMicroelectronics STM32 DDR performance monitor driver");
>> +MODULE_LICENSE("GPL");
>>
> 

Best regards,
Clément

