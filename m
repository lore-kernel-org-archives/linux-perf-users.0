Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DE51F1313;
	Thu, 10 Jul 2025 07:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133645; cv=none; b=ukvihr+nSkMgX2Z8sNoZeEC/NFUK9l/iqOmsALsutMXtj5rBvlF1lLKK7u78+3ufJJIn2MGCfWM37Qn0bDYtOmhybNIbplVOPO3K1/epNHhkKFcBSvu1tSxlrObVJC6wg0bofh/Wa6vX6q2wWsFbzXKmOHRROIm+CQ8+ifpYgIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133645; c=relaxed/simple;
	bh=UqvmjkgZiJytd1q6ZQs8e6B+QvTW5XkRmxayF8Sjnls=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dcmCSOfTZHJpqgeE8aVDdk7WcikqNoZ1IIwWQ4w0f2HUj19IofhSYxcRP3mrOJ75qp8TWdMKCZmq8uB38gj54D53Q82UDmvnGyF7u8XfE3lipQE+doBoGEp1vWAxxF9wY3OU+QLAVd8xzY8b9USRg2aPyTq7jmvkxg6TVneN3j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VhSXHgvk; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VhSXHgvk"
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A6nMQ4020561;
	Thu, 10 Jul 2025 09:27:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	FteJQilrWBfBvhIiChMigkGkPT4QD1u6xypvpY95TU0=; b=VhSXHgvkoCKjL0PB
	yLPzLljS9EtzmH6qBo4MWrhd/pumsuUD8+ON95lET7nmSmqFrQnoRVupBYdYAlfu
	djGjVlo43TAdWUmsXUZgnroiJwMw47odRN0mNYABKDiOZ51Bt/EJzZNDPzmhBCJ0
	CMbstpvVa2BWVI2D8EppAjFvYXVZ4ZhxSrngbuZELHV/aY6bFeDQ35BAlp1S7N2x
	GeJfMjn0DSAq3a6zy8jnfueD2KysLIEasSHwMmzGQLS15g1t/eLo25EJf82KRv5d
	sp1MjzM+BSKvkf8g6WMx0/jPp6e9fRSs21UvN8PDDjbqKUdd6eMSNQ0AzEYvOb8v
	L38+Tg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47ptxjf7w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Jul 2025 09:27:59 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CC7DF40048;
	Thu, 10 Jul 2025 09:26:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 81309AE9D80;
	Thu, 10 Jul 2025 09:26:06 +0200 (CEST)
Received: from [10.48.86.185] (10.48.86.185) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 09:26:05 +0200
Message-ID: <cadb2bcc-9a2a-447a-ac03-459f3e37a173@foss.st.com>
Date: Thu, 10 Jul 2025 09:26:05 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] dt-bindings: memory: add jedec,ddr[3-4]-channel
 binding
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Mark
 Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20250626-ddr-bindings-v1-0-cae30933c54c@foss.st.com>
 <20250626-ddr-bindings-v1-1-cae30933c54c@foss.st.com>
 <e016efd6-891b-467e-8a4e-9ea53b7006a9@kernel.org>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <e016efd6-891b-467e-8a4e-9ea53b7006a9@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_05,2025-07-09_01,2025-03-28_01

Hi Krzysztof,

On 7/9/25 20:27, Krzysztof Kozlowski wrote:
> On 26/06/2025 21:48, Clément Le Goffic wrote:
>> Introduce as per jdec,lpddrX-channel binding, jdec,ddr[3-4]-channel
> 
> s/jdec/jedec/

Right thanks

> 
>> binding.
>>
>> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
>> ---
> 
> 
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    ddr_channel: ddr3-channel@0 {
>> +        compatible = "jedec,ddr3-channel";
>> +        io-width = <16>;
> 
> Missing reg... or not? What was your intention

Indeed no reg.
I'll drop the "@0" for the next version.

> 
> 
>> +    };
>>
> 
> 
> Best regards,
> Krzysztof

