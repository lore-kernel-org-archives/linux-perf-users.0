Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9CE2727F8;
	Thu, 24 Jul 2025 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345059; cv=none; b=N/y8fTzNd8SoJ1gV7C5a0nhsMuMrXgEQ5RZfAJLISdKahVkO05IYSXojySnw+zpPdZsE03CP3uMskUTuQppiLApdpfG4e0SNZ3V2NAmvlu5tK8DDYaktwPPmo+k418URopzNQQWnVv4cKR6RrwFWkVw2t7uYhRuyuTvsuW8uZnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345059; c=relaxed/simple;
	bh=we1YYbfJeCX1MPflf2l+IOI1BZGajSbOOSun4mUg1RU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hsBKMB+kj+iekkDeAHEPA3yJZl7rcPC/bE65snBzWKQFTMsoJkR5PlN4+hacLxUakn+NCW7THHRyitoULoQs4aA9lO1BKBlIMiNJIY89O0MtuFvnexx0bBGVW8eMXfdbuHYsg2CWq1x2QJgJQjfHIWOkwMzuFEsowkPd+/T/OY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=3xJHwG0+; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="3xJHwG0+"
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O7xYXJ019443;
	Thu, 24 Jul 2025 10:17:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	7kzT0Hpl/NFWqdqEQ0wKSVcFU9pNYe2twdBPGJnr/8o=; b=3xJHwG0+iD9m/4QN
	rbFCod58Hm2lUpPt6E8AILpoUlGTdQX14xlcdHd0rAdE1Qdfn8FbSay3IhXbCyzC
	Ea9Kfe3UIySUfRXHvSgtpRFa5RSue6d+0t9SiMuTqc75O3nINnaSFUAwPihCBHwG
	AkRBgHAFolujHveqkRgwzzee0cIxOEtlkMMBFnsmn9W7tIUB6m4IF+gwJ8i28fhi
	TcjRlFZX6i8zMOgLJ66dh2U4opER27vPA7m3LpejdCOr3Dc12wer/PfyC1UEKw7u
	D/6RbrmfrVgRaVv0bh7c8ur44zDZK+/rgjCvAECMHwG6Ed3kc/GE9x7d3OHgUxif
	rTaqPw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 480mx4w9y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 10:17:02 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E75BB40049;
	Thu, 24 Jul 2025 10:15:32 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 560CB781E01;
	Thu, 24 Jul 2025 10:14:13 +0200 (CEST)
Received: from [10.48.86.185] (10.48.86.185) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Jul
 2025 10:14:12 +0200
Message-ID: <204401b4-b483-47e2-ae73-0994b39bd30c@foss.st.com>
Date: Thu, 24 Jul 2025 10:14:11 +0200
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
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <CAODwPW_kex5Agqxg_i-XC308scEpUJU0me55G7iZ8nB9LC0acg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01

Hi Julius,

On 7/23/25 23:48, Julius Werner wrote:
>> +      Compatible strings can be either explicit vendor names and part numbers
>> +      (e.g. elpida,ECB240ABACN), or generated strings of the form
>> +      (lp)?ddrX-Y,Z where X, Y and Z are in lower case hexadecimal with leading
>> +      zeroes and :
>> +        - X is the SDRAM version (2, 3, 4, etc.)
>> +        - for LPDDR :
>> +          - Y is the manufacturer ID (from MR5), 2 bytes
>> +          - Z is the revision ID (from MR6 and MR7), 4 bytes
> 
> It's actually one byte manufacturer, two bytes revision. The YY,ZZZZ
> is supposed to represent the amount of hex digits needed.

Oh yes I see my error..

> 
>> +        - for DDR4 with SPD, according to JEDEC SPD4.1.2.L-6 :
>> +          - Y is the manufacturer ID, 2 bytes, from bytes 320 and 321
>> +          - Z is the revision ID, 1 byte, from byte 349
> 
> I don't think this will identify a part unambiguously, I would expect
> the DDR revision ID to be specific to the part number. (In fact, we're
> also not sure whether manufacturer+revision identifies LPDDR parts
> unambiguously for every vendor, we just didn't have anything more to
> work with there.) I would suggest to use either `ddrX-YYYY,AAA...,ZZ`
> or `ddrX-YYYY,ZZ,AAA...` (where AAA... is the part number string from
> SPD 329-348 without the trailing spaces). The first version looks a
> bit more natural but it might get confusing on the off chance that
> someone uses a comma in a part number string.

The first one seems better indeed.
If the manufacturer put a comma in the part number we should handle it 
at a software level to me and if it is a devicetree error it is up to 
the devicetree writer to fix it.
What do you think ?

> 
>> +      The latter form can be useful when SDRAM nodes are created at runtime by
>> +      boot firmware that doesn't have access to static part number information.
> 
> nit: This text slightly doesn't make sense anymore when in the DDR
> case we do actually have the part number. I guess the real thing the
> bootloader wouldn't have access to is the JEDEC manufacturer ID to
> name mapping.

Yes I will update it.

> 
>> +      SDRAM revision ID:
>> +        - LPDDR SDRAM, decoded from Mode Register 6 and 7.
>> +        - DDR4 SDRAM, decoded from the SPD from bytes 349 according to
>> +          JEDEC SPD4.1.2.L-6.
> 
> nit: Clarify that this is always two bytes for LPDDR and always one
> byte for DDR.

Ok

> 
>> +      Density of SDRAM chip in megabits:
>> +        - LPDDR SDRAM, decoded from Mode Register 8.
>> +        - DDR4 SDRAM, decoded from the SPD from bytes 322 to 325 according to
>> +          JEDEC SPD4.1.2.L-6.
> 
> Are these numbers correct? I downloaded SPD4.1.2.L-6 now and it looks
> like 322 is manufacturing location and 323-324 are manufacturing date.
> (Also, I think all of these are specific to DDR4 (and possibly 5?),
> but not to earlier versions. I don't think we need to list it for
> every version, but we should at least be specific what it applies to.)

I just reopen the doc and you are right, didn't have my glasses on I guess.
Accordingly to SPD4.1.2.L-6 it the info seems in the byte 4 on bits 3~0.

Best regards,
Clément
