Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE74F1F1311;
	Fri, 25 Jul 2025 07:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427401; cv=none; b=ECdUs7knAHm7spQhDcGBcc+sShbhTD+zxPRMiMArW5KHazdQ2w3GxMv8Cm0dQx2KSi/Ddym8S6p4+bHEC8v2zIuZXhtAVrjCeOJuiJr8rVWOPLLIoXOFu2NvaFhUo0vS3lFobTrN+pkKyRAbLvAQGala3uXvj0BkCK6aXRrh334=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427401; c=relaxed/simple;
	bh=JL30bk1jn1jV9pISqgo+bWdb/5RDGbJ7aIr53ikjD6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PAkZSrYxsD+3hLDT9Jwz6D0ULPbNJkscx9VakEkk/BQHphQOeGFJm56lDthZ4SCzgGewLz5hc3nDbm6PYPj28yYWOGXpGB0+2LNVjzN7upfz+DZP987mNBhq5Xq8lLUMV6dw53zA8zU1Wm9gCWEvJiEZCRCX43xP7BskAC/isG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=vEY7oeG+; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="vEY7oeG+"
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P61XZi009176;
	Fri, 25 Jul 2025 09:09:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	LzqH02+hJ/0E8n+RTM+yEwFitfKa/gSQdkGVRRTXJhc=; b=vEY7oeG+pNnop6/X
	Y9urlffHn9wPzkQ2Is/FDs6FmFPNXT3zTb3jyMz3lmY7QPMwpHHlMXBmXHaer/PU
	0K0P0ulWgakiEqWGw1l11dPWR/0Is+mSEQnefGwkZ3l/7cXUl6SA3HJ2CRdoyG1I
	FdmL8tUHYqCtB98XPDPWNBGYyLXEwDmWXM7P+PtbfkAkPayNHbYAgdZ3XfNJ2Zbc
	CmgC/QaDxklOmCvKhJ7nMI4NpBlPKOB2X2y39VEgc7AEaz1kO+m3wWAhQP0OsPLr
	FY38beWUv0pV94PWCAt8crCejpNCdBfw4cLvaHFaeaNLHLfxgTQP0XVsBJXJZTO6
	L/feBQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 483w5rsn0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 09:09:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4812F40044;
	Fri, 25 Jul 2025 09:07:57 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8B10578175F;
	Fri, 25 Jul 2025 09:06:35 +0200 (CEST)
Received: from [10.48.86.185] (10.48.86.185) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 09:06:34 +0200
Message-ID: <ce0cb3ba-2373-479f-a8f3-3a89ffb0a1b1@foss.st.com>
Date: Fri, 25 Jul 2025 09:06:33 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/20] dt-bindings: memory: factorise LPDDR props into
 SDRAM props
To: Julius Werner <jwerner@chromium.org>
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
References: <20250723-ddrperfm-upstream-v4-0-1aa53ca319f4@foss.st.com>
 <20250723-ddrperfm-upstream-v4-5-1aa53ca319f4@foss.st.com>
 <CAODwPW_kex5Agqxg_i-XC308scEpUJU0me55G7iZ8nB9LC0acg@mail.gmail.com>
 <204401b4-b483-47e2-ae73-0994b39bd30c@foss.st.com>
 <CAODwPW9drKEAMfQvQHV8eMTyf5KCHB4SN400JiUs0pgjoXy=sw@mail.gmail.com>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <CAODwPW9drKEAMfQvQHV8eMTyf5KCHB4SN400JiUs0pgjoXy=sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01

Hi Julius,

On 7/25/25 00:33, Julius Werner wrote:
>>> I don't think this will identify a part unambiguously, I would expect
>>> the DDR revision ID to be specific to the part number. (In fact, we're
>>> also not sure whether manufacturer+revision identifies LPDDR parts
>>> unambiguously for every vendor, we just didn't have anything more to
>>> work with there.) I would suggest to use either `ddrX-YYYY,AAA...,ZZ`
>>> or `ddrX-YYYY,ZZ,AAA...` (where AAA... is the part number string from
>>> SPD 329-348 without the trailing spaces). The first version looks a
>>> bit more natural but it might get confusing on the off chance that
>>> someone uses a comma in a part number string.
>>
>> The first one seems better indeed.
>> If the manufacturer put a comma in the part number we should handle it
>> at a software level to me and if it is a devicetree error it is up to
>> the devicetree writer to fix it.
>> What do you think ?

I meant exactly what you are stating below :-)

> 
> Not sure what you mean by "handle it at a software level"? Using comma
> characters in the part number is not illegal according to the SPD
> spec, as far as I can tell.
> 
> That said, it is still possible to disambiguate this as long as the
> revision number is always there, you just have to look for the last
> comma from the end (so e.g. the string `ddr4-1234,some,part,567,89`
> could be unambiguously parsed as manufacturer ID 0x1234, part number
> `some,part,567` and revision ID 0x89, the parsing code just needs to
> be a bit careful). So maybe this is not actually a problem.

Best regards,
Clément
