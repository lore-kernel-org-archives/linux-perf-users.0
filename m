Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E027E278170;
	Wed, 23 Jul 2025 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257454; cv=none; b=Y0Wrj7i/JESTvKoUbIHCmVMkmN6CJHSuhKMG1m+1ZGJ/zpjeYwgdi6l901fLf24gadmMfDEPOVZVNwqpwg38EtK3XtiLqhzIgyqqr267wRDGYvkQuX75Z8rT+QaomuSXD9NeYa+bt4xOp7WGzBBI8hS4TWI9wtjtq/2GkXbp1L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257454; c=relaxed/simple;
	bh=QhDnKGjwEhHMl6idHmkSOMX1SylBY5WebPXnw4irZ9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WTNaJbm3nRLyb6txzvsrVBI1a/8YCA8v+5RO2wOdH2cYR24V2tzfJ/WP6gZrVaUX5oF9rHGdn7M0E2eRJN9uW6Rd5WOmOQqaYm+5bhg3qHENaotcVjuzb1dBoBWDkxJqgBVf7WN0o2mw/kdkr9RKx9V0/OYVHVnDDOSqVxYLYP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=di8j4sub; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="di8j4sub"
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N7qgYZ031584;
	Wed, 23 Jul 2025 09:57:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	B9CGQSY2Py+TZMZxIwRcfvLPf3wajH5A3vCs0pp3i9Q=; b=di8j4sub3XTf9LsH
	X3dV4EP7HD0tF4hOkMzn7by90Vv+bnZ5O/eS2q7mX0dzb+5Z+3EI9uKK417Nvut0
	HAut6dDHExdJRkhXw/hVUHj1nPUY0vSgbcIX/Tv8aB6IIy4jsAturVe4pFr8jJam
	QJR6cRH7YRTfk0rZDL74wL1QYCCYPfMZ7LbftKm9bS/BVIg3YtAUjv1mewRUQoox
	M5Ls81AP09y/0lwCpD6kIrOJbbUtCBcwHTFRTuhywhxRNyQBzyMueaqDtwxh48g+
	oVJvJg2Dq5WRioKvQaUVZ/x/ybQmwrQxFlfx5sazxaBcOUpMAEl1izE6Fwm55F5O
	OLZfXA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4800g8tc0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 09:57:15 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3848D40048;
	Wed, 23 Jul 2025 09:55:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5064A6BAAD0;
	Wed, 23 Jul 2025 09:54:33 +0200 (CEST)
Received: from [10.48.86.185] (10.48.86.185) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 09:54:32 +0200
Message-ID: <d9432ec2-7075-4fef-ab39-aa93f4e91eb9@foss.st.com>
Date: Wed, 23 Jul 2025 09:54:31 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/19] dt-bindings: memory: factorise LPDDR channel
 binding into memory channel
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
References: <20250722-ddrperfm-upstream-v3-0-7b7a4f3dc8a0@foss.st.com>
 <20250722-ddrperfm-upstream-v3-7-7b7a4f3dc8a0@foss.st.com>
 <CAODwPW-kVcnVtVakXs7aBcwb_nv0bLTaK5PKNo4zmJaJ=VC8Wg@mail.gmail.com>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <CAODwPW-kVcnVtVakXs7aBcwb_nv0bLTaK5PKNo4zmJaJ=VC8Wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01

On 7/22/25 23:58, Julius Werner wrote:
>> +  purpose of this node is to overall memory topology of the system, including the
> 
> nit: Might take the opportunity to fix the typo here (missing words:
> "is to describe the overall memory topology").

Yes true.

> 
>>     - Julius Werner <jwerner@chromium.org>
> 
> Why remove me? (Although I'm also not really sure why I'm maintainer
> for this file and Krzysztof for all the others, tbh.)

I didn't remove you. It is just the minus of the maintainer list :-)

> 
>>   examples:
>>     - |
> 
> I think that's a load-bearing pipe character you're removing here?

Didn't remove either. There are spaces before so it it is not the git 
minus char.

> 
>> -    lpddr-channel0 {
>> +    memory-channel0 {
> 
> Just to double-check, the name of this node doesn't really mean
> anything and isn't directly interpreted by the kernel, right? I'm fine
> with changing the example here to fit better with the new expanded
> scope of the schema, but we have existing firmware that generates
> nodes with the `lpddr-channel0` name, I want to make sure that it
> won't break from making changes here.

Oh ok didn't know about that and didn't find it though.
For now no pattern has been defined for the node name so it shouldn't 
break anything.

Best regards,
Clément
