Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664562E9EB2;
	Wed,  2 Jul 2025 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465746; cv=none; b=pLWc7OHIb+aFdkPAThZIZHtamQY0sd2DjKXy/qlR0W6LW/S7BfuXSWpE13Ue/2o2jL5uHqCdGuc9caKt5bFOoVsSHH1z9sF04oNFfv9pBo7phDArEXBNAQO54IzMQrBNdOICaW5+D/CziL5n+ZN56WqZDsSUOqbNp1mL2Mc4tuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465746; c=relaxed/simple;
	bh=AjSA6Bdq5vB9w+D1KK5HtFTazyanZB6oZ2EEmsWUSP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VTGVPIFfOOVdqbzO4v8ClVYej6Ew7nMLCnL3cYlbCum4yVzVu2F2wUrLEWCuuShkDYVDvfOLZ9J9MgM6ZYCQR0wCS5uMPTyyjBq7+pO9fwEGIIEE00Q+sv+PWoetGBpQnW+3XBg75Wg1tRK74NMvVp7M/Rki+lbLgfJs/VDJNzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=dBDQHoEX; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="dBDQHoEX"
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562DIwPT009778;
	Wed, 2 Jul 2025 16:15:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	VR6E01Xg6J6Izs0olt9dR6pYp+S5ROquFthL7GlUqPs=; b=dBDQHoEXqF/md8Ai
	OKxTINMTwYY9+MXakIisn2u4OHsDwVaws4+1VieBQiNXPftGP0VE8IKDZH79YV9C
	gDu+8iKUecC6lTA5ex8FURzdpDRCP4m/LQweQkCWaJTIbkrTllzw7aH+Rxeuwntn
	utlstZrXHzSVULtL2Cc2OeUtYOrfnxH6LYJk/mWHDIEXpYkQRK9ktb31DLmb16v8
	IQ4M7f9TAHR4Q0aCT0gLzcFyIT99ZXhPfBCV/NcxixuYXHjqrUI8h1A2+IEiQK0n
	OkuVflyw9cWVeufHcOel2SUgz5K4BtxO8qghv8cKOOkUm6NRS9TCAHbMDBGTCt8h
	+QRk2A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47j5tmb9wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jul 2025 16:15:22 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 46F9340050;
	Wed,  2 Jul 2025 16:14:05 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 22C18BB2448;
	Wed,  2 Jul 2025 16:13:50 +0200 (CEST)
Received: from [10.48.86.185] (10.48.86.185) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Jul
 2025 16:13:49 +0200
Message-ID: <164e93e7-b9b1-45ff-8418-3a381b2bc781@foss.st.com>
Date: Wed, 2 Jul 2025 16:13:48 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] perf: stm32: introduce DDRPERFM driver
To: Philipp Zabel <p.zabel@pengutronix.de>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Gatien
 Chevallier <gatien.chevallier@foss.st.com>,
        Michael Turquette
	<mturquette@baylibre.com>,
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
 <5d4cf5bff7733421c8a031493742ba6a21e98583.camel@pengutronix.de>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <5d4cf5bff7733421c8a031493742ba6a21e98583.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_02,2025-07-02_01,2025-03-28_01

Hi Philip

On 6/30/25 10:38, Philipp Zabel wrote:
> On Mo, 2025-06-23 at 11:27 +0200, Clément Le Goffic wrote:
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
>> ---
>>   drivers/perf/Kconfig         |  11 +
>>   drivers/perf/Makefile        |   1 +
>>   drivers/perf/stm32_ddr_pmu.c | 893 +++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 905 insertions(+)
>>
> [...]
>> diff --git a/drivers/perf/stm32_ddr_pmu.c b/drivers/perf/stm32_ddr_pmu.c
>> new file mode 100644
>> index 000000000000..c0bce1f446a0
>> --- /dev/null
>> +++ b/drivers/perf/stm32_ddr_pmu.c
>> @@ -0,0 +1,893 @@
> [...]
>> +	if (of_property_present(pdev->dev.of_node, "resets")) {
>> +		rst = devm_reset_control_get(&pdev->dev, NULL);
> 
> Use devm_reset_control_get_optional_exclusive() instead. It returns
> NULL if the device tree doesn't contain a resets property.

Ok I will have a look, thank you

> 
>> +		if (IS_ERR(rst)) {
>> +			dev_err(&pdev->dev, "Failed to get reset\n");
> 
> Please consider using dev_err_probe() instead.

Ok

>> +			ret = PTR_ERR(rst);
>> +			goto err_clk;
>> +		}
>> +		reset_control_assert(rst);
>> +		reset_control_deassert(rst);
> 
> These can be done unconditionally, as they are no-ops for rst == NULL.

Indeed

Best regards,
Clément
