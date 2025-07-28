Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574AF265621;
	Mon, 28 Jul 2025 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708573; cv=none; b=IJesbKCz8e2yIMHK5Zs2If3UBkbTWU7bCdCMu3Hr1V4IzQNx7lRC2f0/jVhOcpcyQghD7sTDyL5l8mxcwTW/fxng/L3a+cvtxBGYhKyBPxEjBYHjMfPdr8/eW8nhL9owZ6ChutEz80wIg7yponTX5FLQS0mBea8+WPkGJY6ohso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708573; c=relaxed/simple;
	bh=W+HdYTcs/B9LyLPL42PUNlOvNmUrXUKGfHZ9d1aOnWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iTdKCmJDkEgGH3FOmj4Vv9GCxrBuZtuv3mm52aHcAFpOuOY8KzfnX6eKkVkw5gx9+aW+9sUuVSKE0ji50f3bI+y1361OsGde/MyTN7SwNXSfwJhkKbJ0OgX/NhC2H7VrYCloHGjLI4OfFu9DnicF9XuO/YjKshDfhFJueA0pGM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=BO0GX2YI; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="BO0GX2YI"
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SCmIZY020685;
	Mon, 28 Jul 2025 15:15:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	kLBhveJQnl8m3PppqLbOwkmepYRNmUTrNGuqfx0S5N0=; b=BO0GX2YIvdvzkDS8
	ZgLPuGdA6WGl6NtJ6/xQvARzA7FDTBuGpl2k/0Qe88TTGB7pnIHxmoiSSisOV32g
	UPiaPFmPKvtiX3XhLTfQmiPWWhAf9mhUbsxt+Qr5vXr+/xmOe8AI+GP0Tf55h+zN
	AFsqv8MDszq5GkCQzzPwvL5oMkRwBOJCrayjtLqCoOJvpNLWhq4S434nD6ImKdRB
	72VdlL6sQWIW34oobe/U/QH4wcbMN4ZdhzkhC81oilbCnC/pNvViJ6nfNqbMdD1i
	EIeVOm26ibQEre65vm7otTMzzWKq1lvbLirBMolEWRX1Hn8E7BM9qTwCIDk13yj3
	LKIF2A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 484pc28cgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 15:15:27 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C3CB64005A;
	Mon, 28 Jul 2025 15:13:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BDC18768ABE;
	Mon, 28 Jul 2025 15:12:40 +0200 (CEST)
Received: from [10.252.23.100] (10.252.23.100) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 15:12:39 +0200
Message-ID: <a0c0e255-32c6-466d-a2ea-694a4f074de3@foss.st.com>
Date: Mon, 28 Jul 2025 15:12:38 +0200
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
 <20250725115655.00002304@huawei.com> <20250725115908.000074d7@huawei.com>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <20250725115908.000074d7@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01

On 7/25/25 12:59, Jonathan Cameron wrote:
>>> +
>>> +	platform_set_drvdata(pdev, pmu);
>>> +	pmu->dev = &pdev->dev;
>>> +
>>> +	pmu->cfg = device_get_match_data(pmu->dev);
>>> +
>>> +	pmu->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>>> +	if (IS_ERR(pmu->membase))
>>> +		return PTR_ERR(pmu->membase);
>>> +
>>> +	if (of_property_present(pmu->dev->of_node, "access-controllers")) {
>>> +		ret = stm32_firewall_get_firewall(pmu->dev->of_node, &firewall, 1);
>>
>> Jiri is busy driving dev_fwnode() thorugh to get rid of all the directly references
>> to of_node.  Probably better to use that here from the start.
>>
> Need more coffee. Ignore this one, you still need an of_node here.
Ack

> 
>>
>>> +		if (ret)
>>> +			return dev_err_probe(pmu->dev, ret, "Failed to get firewall\n");
>>> +		ret = stm32_firewall_grant_access_by_id(&firewall, firewall.firewall_id);
>>> +		if (ret)
>>> +			return dev_err_probe(pmu->dev, ret, "Failed to grant access\n");
>>> +	}
>>> +

