Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE9A2741A6;
	Wed, 23 Jul 2025 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753258696; cv=none; b=qL23ndRD02IsjDDd8hlrJvWOa0bdNWBOp7LnU9Z/hInhek1gTfv8gnbiqWPzNUE1AYAxY+/xnTbHubsWcdP1VW1AS97m8H5+S27pCmRg6K8mB3p33syQW7ZAJLG0VisWzGxUkELxeSqK9m+n2/OR7VBLXEqGEBzoZH+vfu2nquI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753258696; c=relaxed/simple;
	bh=u8b9NrDtrkTJmCDfzQLkjEJup2g0BAZVNmjnCMTEi18=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZuTbKo17sm7fFW4iF9WnMRgyw8NKJ9bH0gnnIFzQIckeJ/RJasXgHocy3k3B2xrb0LGzl5Wx7p6w7FQcfE9mB1kLr8YHmDUVFy4zdAE8Jm2nmJjOJjhpzasp7N5xtbeWSDxZaDnyiz/KOkX/DoZvisOuR65E99XwVBvcwBTaB04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=7LyBg3mn; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="7LyBg3mn"
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N86QWh016187;
	Wed, 23 Jul 2025 10:16:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	+MKQXarGCwBm0S142kCJOF3CcZkaaOJ02owWJnuaHs8=; b=7LyBg3mnPfT2VgiA
	fHngcWAXD8G0Wco2vdmSMTzSLd10TPCwYv18jwdscGMMgxKC+/s7uK3iYYZjQqpk
	0UPFaSNoKoB84PbHn2zJ0hlOV2MlmCC4cwJeJrFX127acHlfdiZXG1W1amLW7ZUp
	tqqROpCJnJOvmG08d1eYB030RFRoXyB82Zc8J7A2z0W5YtlRZs/6HsY5Viiz9xzm
	NsY8BwyljR/gDzhkN/dDY3QWXlNISV3Mjhr+oRwBpz2ZAZ0mea12oO0h6g4CMJGc
	Z5f7n+7AHjlbpa9HMHGevkbZAuY4hE1C9gwFuXOZNL6fjchG/Fa8PvezbB697Ltj
	327TEw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4800sm35kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 10:16:47 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0333040052;
	Wed, 23 Jul 2025 10:15:25 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4550876DBF4;
	Wed, 23 Jul 2025 10:14:14 +0200 (CEST)
Received: from [10.48.86.185] (10.48.86.185) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 10:14:13 +0200
Message-ID: <608d03ef-1017-4f82-b7b0-a461c35b59a2@foss.st.com>
Date: Wed, 23 Jul 2025 10:14:12 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/19] dt-bindings: memory: factorise LPDDR channel
 binding into memory channel
To: Krzysztof Kozlowski <krzk@kernel.org>
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
        Le Goffic <legoffic.clement@gmail.com>,
        Julius Werner <jwerner@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20250722-ddrperfm-upstream-v3-0-7b7a4f3dc8a0@foss.st.com>
 <20250722-ddrperfm-upstream-v3-7-7b7a4f3dc8a0@foss.st.com>
 <20250723-zealous-turtle-of-perfection-e67aee@kuoka>
 <5ca3ba94-27b3-4cda-aba4-e2935acbe55c@kernel.org>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <5ca3ba94-27b3-4cda-aba4-e2935acbe55c@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01

Hi,

On 7/23/25 09:06, Krzysztof Kozlowski wrote:
> On 23/07/2025 08:57, Krzysztof Kozlowski wrote:
>> On Tue, Jul 22, 2025 at 04:03:24PM +0200, Clément Le Goffic wrote:
>>> LPDDR and DDR channels exist and share the same properties, they have a
>>> compatible, ranks, and an io-width.
>>
>> Maybe it is true for all types of SDRAM, like RDRAM and eDRAM, but I
> 
> 
> Although these were not JEDEC probably...

Hmm so no "sdram-channel" ?
I don't get your point here.

> 
>> don't think all memory types do.
>>
>> I think this should be renamed to sdram-channel.
> ... yet still JEDEC also has some standards for SRAM, EPROM, HBM and
> SGRAM (graphics), see:
> https://www.jedec.org/category/technology-focus-area/memory-configurations-jesd21-c

In a more generic point of view we can think compatible, density and io- 
width as common for all sort of memory no ?

> 
> Best regards,
> Krzysztof

