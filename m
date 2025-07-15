Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA2422CBEC;
	Tue, 15 Jul 2025 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752568958; cv=none; b=mfpve+w2C95vKqCbvIiXM9rpKYRNYlsvKbhwAGKfYgQacamLEQjhOkaYIiSmRz+Y611eMMmaqWM9WNAMSE2BCjHip8B92QYXhAgki0q+IoCxgCtnVJax+PYqMoKKgTJMtpACI5rhuooo3tOmjnPPzxpWH2/5Wd3osd7+KjAegyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752568958; c=relaxed/simple;
	bh=uZ6Ya2KZ1HXXgqRNVc7h7JAZfY02zVSZpWKOZxupJqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g/JCIvWZbq3fdAzPkxmRV4FCorF+O6Rhzej71NyGvFYEpaSDg4Uw/MI+25SQE21TVT3Y4+ZTC55S+/zMad+NkhlGk1B9xokUw8jtPSSl30/cvX2VfTM1fw3d27pRZXsQqGKUnVPETJtnT0eIC79PbMLtopbLURCWb9PsR2dr0VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=frANLRL/; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="frANLRL/"
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F8GPxQ012267;
	Tue, 15 Jul 2025 10:42:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Mr1pLyz9BvSAR5yjnoGZ7OEkVotMBP2RsFtH4ZIuR4Y=; b=frANLRL/vezuJ7nx
	79QOJfNg+ci9dQV7bhQZRltly51Ji+djlNm9feefndwEMHxSS/MTRwFlS9QEk2/S
	tgh6u5R+21UvSPexZZ3YiRvurVFs0EyJS5TSenfvPRNJ+IP4cUsjLIwlBIUVNIZK
	u2gsUnIfxE0NSHkgJY6fzw8Xz13cB2OTXl3XovGVdlg3I3w9BA+jolg9e9Pqb9dN
	J4IWgz0YA72zdYpO2g3XTzJB//awG26ubXFrhruQiZZt/aHu3Pg/BGxuIGqxchGr
	lCjn4sN1GFlYhBej+ruBwqZT+5iZgldLjZYOa7OpnWx1ysXDaZ8zF2lr2wv6qWRr
	O288iw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47ucu9c0wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 10:42:22 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5BED14004B;
	Tue, 15 Jul 2025 10:40:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 55B52AE6FCB;
	Tue, 15 Jul 2025 10:40:15 +0200 (CEST)
Received: from [10.48.87.141] (10.48.87.141) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 10:40:14 +0200
Message-ID: <a1d1970c-da5d-4b4a-a69a-bf9da7a07be2@foss.st.com>
Date: Tue, 15 Jul 2025 10:40:13 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] dt-bindings: stm32: stm32mp25: add
 `access-controller-cell` property
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?=
	<clement.legoffic@foss.st.com>,
        Will Deacon <will@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Gabriel Fernandez
	<gabriel.fernandez@foss.st.com>,
        Le Goffic <legoffic.clement@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20250711-ddrperfm-upstream-v2-0-cdece720348f@foss.st.com>
 <20250711-ddrperfm-upstream-v2-2-cdece720348f@foss.st.com>
 <20250715031717.GA4144523-robh@kernel.org>
 <765eccdc-7d51-42c6-bcba-07813077fc1d@foss.st.com>
 <20250715-belligerent-savvy-marten-fbd1a5@krzk-bin>
Content-Language: en-US
From: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
In-Reply-To: <20250715-belligerent-savvy-marten-fbd1a5@krzk-bin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01



On 7/15/25 10:19, Krzysztof Kozlowski wrote:
> On Tue, Jul 15, 2025 at 09:37:00AM +0200, Gatien CHEVALLIER wrote:
>> Hello Rob,
>>
>> On 7/15/25 05:17, Rob Herring wrote:
>>> On Fri, Jul 11, 2025 at 04:48:54PM +0200, Clément Le Goffic wrote:
>>>> RCC is able to check the availability of a clock.
>>>> Allow to query the RCC with a firewall ID.
>>>
>>> If it is tied to a clock, do we need another provider? We have the
>>> "protected clocks" thing, but that might be a bit different.
>>>
>>
>> I couldn't find any reference to "protected-clocks" outside of qcom
>> related code, is there a documentation? (Couldn't find it in
>> clocks.yaml).
> 
> Huh? protected-clocks is in clocks.yaml... It is there with an explanation.
> 
> Best regards,
> Krzysztof
> 

Ah, I was looking at Rob's repo, my bad.
