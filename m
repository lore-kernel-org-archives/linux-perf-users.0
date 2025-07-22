Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF02C158F;
	Tue, 22 Jul 2025 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753169894; cv=none; b=nNPh4qNJ2yfU7FLah1vPKr24FGotdHCErj90fQoEQmKInAUjcQ9bSTTY/Bytqw+n3YatbqumaJQcemSa62PIoeWgOXOE87rk4EKLKw3D7eE1G2PkFS9NSDhQ+3UUT9edTA/jknfGmprjX4y4kH7M+rvkV5HdXlz3XVjnxdyHlhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753169894; c=relaxed/simple;
	bh=tU/hC7YARMy7oCIo5NRGQiO3UOJ8Lk4XsFZ1nZnZ9NA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SfoinEAHeLSxYvUD+61WAkl0RdHNhU2cfoW6oOzLGJNUdWVvZpR1LBqZK6rsZWlf3FznAQX5Q3hiw7TsLOvQmeZ812gUnV7BxQRAockWeMLgcoPyVXTmKnm4XnOZKWzoAGaI+P8kcX+/j6N03YH5KD8gEx/w24EOVlNKX4LoMS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=6eOnM2ju; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="6eOnM2ju"
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M7YcI1017113;
	Tue, 22 Jul 2025 09:37:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	0zlU1QEnD+GWl8jLtn5YK4PZ5fpcfWzBw9uHGSBFh90=; b=6eOnM2juSbRcr0EU
	IFyVZkojXeQ6Q+YR1EBl3sKBCrityklC8iGDAreH+nVxIlQpGGJ1de2LWFwc4l+l
	GHdzI1aEcjrUG02EEdibktt04EsuROdoHalxZc6A/VFGiV2d32zsW/LP3ZkEoX8L
	ed7/sijJ7vkE5DhE2qQgYCwZk7ehjOBdHFYiVBGxRKng/BGeMgMSFprH5ze62kZr
	rdI9euM21E3mDHLQTqM0HE2BU2fY7b1L1YSL/0CRLPYRX5Nqjz+RIPRaUovQk6Au
	arroznHHnk0RY1lQ6URTxAejKDuzunNFX2iACfiTmpBsv3BZltL9HBZqRv3WTZUo
	DVCk5Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 480mx4hq09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 09:37:50 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 571CB4005B;
	Tue, 22 Jul 2025 09:36:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1132476DC2F;
	Tue, 22 Jul 2025 09:35:09 +0200 (CEST)
Received: from [10.48.86.185] (10.48.86.185) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Jul
 2025 09:35:07 +0200
Message-ID: <ed0efd83-8471-4fce-9745-54d85d6268f9@foss.st.com>
Date: Tue, 22 Jul 2025 09:35:06 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] dt-bindings: memory: add jedec,ddr[3-4]-channel
 binding
To: Rob Herring <robh@kernel.org>
CC: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
References: <20250711-ddrperfm-upstream-v2-0-cdece720348f@foss.st.com>
 <20250711-ddrperfm-upstream-v2-5-cdece720348f@foss.st.com>
 <20250721200926.GA1179079-robh@kernel.org>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <20250721200926.GA1179079-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01

Hi Rob,

On 7/21/25 22:09, Rob Herring wrote:
> On Fri, Jul 11, 2025 at 04:48:57PM +0200, Clément Le Goffic wrote:
>> Introduce as per jedec,lpddrX-channel binding, jdec,ddr[3-4]-channel
>> binding.
>>
>> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
>> ---
>>   .../memory-controllers/ddr/jedec,ddr-channel.yaml  | 53 ++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr-channel.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr-channel.yaml
>> new file mode 100644
>> index 000000000000..31daa22bcd4a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr-channel.yaml
>> @@ -0,0 +1,53 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,ddr-channel.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: DDR channel with chip/rank topology description
>> +
>> +description:
>> +  A DDR channel is a logical grouping of memory chips that are connected
>> +  to a host system. The main purpose of this node is to describe the
>> +  overall DDR topology of the system, including the amount of individual
>> +  DDR chips.
>> +
>> +maintainers:
>> +  - Clément Le Goffic <legoffic.clement@gmail.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - jedec,ddr3-channel
>> +      - jedec,ddr4-channel
>> +
>> +  io-width:
>> +    description:
>> +      The number of DQ pins in the channel. If this number is different
>> +      from (a multiple of) the io-width of the DDR chip, that means that
>> +      multiple instances of that type of chip are wired in parallel on this
>> +      channel (with the channel's DQ pins split up between the different
>> +      chips, and the CA, CS, etc. pins of the different chips all shorted
>> +      together).  This means that the total physical memory controlled by a
>> +      channel is equal to the sum of the densities of each rank on the
>> +      connected DDR chip, times the io-width of the channel divided by
>> +      the io-width of the DDR chip.
>> +    enum:
>> +      - 8
>> +      - 16
>> +      - 32
>> +      - 64
>> +      - 128
> 
> This is duplicating what's in jedec,lpddr-channel.yaml. Refactor or add
> to it rather than duplicating.

Yes I wanted something unique as "jedec,lpddr-channel.yaml" is 
specifically for lpddr.
I think I'll refactor and rename it "jedec,memory-channel.yaml" so it is 
more generic.

> Is there some reason regular DDR3/4 doesn't have ranks? I'm pretty sure
> it can...

Yes it does but I wasn't needing it and they are not required in case of 
lpddr. It will be fixed by refactoring jedec,lpddr-channel.yaml binding.

Best regards,
Clément



