Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145B217BA6;
	Wed, 23 Jul 2025 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256025; cv=none; b=VFWLZSmJVbQtrTYOSjHRwDcf5sYPyAIfGPSNlVPmVc2iKr5iukOgAI5EDNbpamEaa817aurS3octhbpwTP0suzFRX0KXtNoTLWnJvskesPirOu8T/8H5LVl5pSgABX8o4X1JkW3g2E+cFI6K7yP48aQLei403dSX31LZ6wJoQHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256025; c=relaxed/simple;
	bh=HYqDBmZ+DIG4v85gnV0KAQmC5ntc6zltb032y65ohnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UpikBYHUBtDTWjmApQ/9g4MMggQBEdhHYVnO/USZzuFEf5k+dQ/FN3ooJaReJHN02T6G05Ptq9UbNkXAsVyDEPLTXijNj+ycMoFdUKAW02dFRL1ACc6NTGxQ9DmP7XMbKN9V5CABu/lBHjuZ8gIMLNAPh78WYbkzxUyY35CWo4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=QE9mJsJW; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="QE9mJsJW"
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N7Wjxn025289;
	Wed, 23 Jul 2025 09:33:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	OF2g8HL4znRWs7yyAJKVV9g93H6bltIAkBEQRriY5ak=; b=QE9mJsJW+BIaT3ge
	CfuDSWegwRTrkywKHn6W0YG93ypZfNqeS7e8ZayRMnzEGT7SYFbolmtM4E8MisWR
	aCwQ4JGQJpAMXkivdfGa/SE2XG0ni4nYyoTyPjA4ZmXcx7m86K+Vu5TCWrVbfL3n
	c1dx45BTqRtDAhn0fM6nLUDojXJodArYz66bwaY6LDEybVWhCXIKdej6Ib23lFr0
	kKfIFH80LJLqFFuOjo/MUtpCcAn+R5JgJFa+FkfylcX6IxoqLlpC8Uys6X9f8Pav
	uP5j+u3SvKrYBbic8FwMTCXT5HsdGCJjpeGB75nfCM8arIn5f9H1gNpeJd5BYw2C
	PnDKcA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4800g8t6nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 09:33:25 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 249E640046;
	Wed, 23 Jul 2025 09:32:06 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 14599768F12;
	Wed, 23 Jul 2025 09:30:48 +0200 (CEST)
Received: from [10.48.86.185] (10.48.86.185) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 09:30:47 +0200
Message-ID: <3e59d670-ee96-4ff2-a6c6-99d8a030e16c@foss.st.com>
Date: Wed, 23 Jul 2025 09:30:46 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/19] dt-bindings: memory: introduce DDR4
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
 <20250722-ddrperfm-upstream-v3-6-7b7a4f3dc8a0@foss.st.com>
 <CAODwPW_7aYdEzdUJ7b2nT4-zS9bu_hbNqjc7+_wSHbedXZXJ=Q@mail.gmail.com>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <CAODwPW_7aYdEzdUJ7b2nT4-zS9bu_hbNqjc7+_wSHbedXZXJ=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01

Hi Julius,

On 7/22/25 23:57, Julius Werner wrote:
>> +      - pattern: "^ddr4-[0-9a-f]{2},[0-9a-f]{4}$"
> 
> This pattern doesn't really make sense when DDR4 doesn't have the same
> manufacturer ID / revision ID format as LPDDR. You could either only
> leave the fallback constant for now, or define a new auto-generated
> format that matches what DDR4 SPD provides (which I believe, if I read
> Wikipedia right, is a two byte manufacturer ID and then an up to 20
> character ASCII part number string -- so it could be
> `^ddr4-[0-9a-f{2},[0-9A-Za-z]{1,20}$`).

Oh ok I didn't catch that it should be from the SPD.
I'll propose something.

Best regards,
Clément
