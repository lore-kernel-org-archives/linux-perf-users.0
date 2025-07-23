Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55188272E5A;
	Wed, 23 Jul 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278668; cv=none; b=ofkmYbHwsKASv13tpVAjJImWT+ZjS6jpQxm1MOTILGgxGI0AN2TjGdfUXif7e2EuzvorBSOinZ+A2Q9+vmRtAL2KNMnlJsmJ50Z855tiPoIJ3EdBprIYWT3Z/8At4Fw67PbsgX6uKJy7zI4ppZIskCRSmHsA4iInQnfVQlPbX30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278668; c=relaxed/simple;
	bh=dIiv0aLQ0QlrHF0awO/NYiUWxmeSgiy7474StiPrxrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XDCI6GITHRMutOhbSsMEHtXaC1W1qv/hNT8aqySmCSRd7aY36PM8son/JuQzpkBMrbf0DlhgDnfl+ZE14etyj1wJE5GpucgOy4+ReVic5O8DYMM0nprET0NkUY/aervvEcA1S5plyYtd2rDuX7M4waLbnjMO9x43ZBIhhtx04ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=uvEohgRV; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="uvEohgRV"
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NDEqHF005546;
	Wed, 23 Jul 2025 15:50:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	XdmtswUaNr7oJjimezjiXJoD/ZylkFXiGJCOd1EELY0=; b=uvEohgRVKt/NpkRA
	2i/LYLEavOHikPFmlWpRLubh47aTWuYUcAsWdGcrUlsIggOJk3nTEnTfSXiQ6Daq
	B397w3Fh+nhhWLrDXVVdDFbt458tDWAUTHZ58FMU+8tXuK4pSOpfQBtJqEgJCw6r
	513Jw9+03JgYy+PYBtQo1wGTKt68un91GsKESvT5TG0nYIw1d02PmjbMqrNvrS0x
	Ypa2hmlpQcecePuRJZIJcWv1afeUgNqHW2zrIfArB4cr+xbrUXqBBbkiJ2n56iQV
	Zy+D7YHaP3JFEzm4WfXxPTpOnFKUFmpjtC+6uIvZppe2H+Ti6lIA5vivoAgn0hVA
	vcadow==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 480mx4saep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 15:50:45 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 594BC4006F;
	Wed, 23 Jul 2025 15:49:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E9763778896;
	Wed, 23 Jul 2025 15:49:08 +0200 (CEST)
Received: from [10.48.86.185] (10.48.86.185) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 15:49:07 +0200
Message-ID: <a9505893-c762-4cc9-b20e-4fccda7c1ac1@foss.st.com>
Date: Wed, 23 Jul 2025 15:49:07 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/20] dt-bindings: stm32: stm32mp25: add
 `access-controller-cell` property
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
        Julius Werner <jwerner@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20250723-ddrperfm-upstream-v4-0-1aa53ca319f4@foss.st.com>
 <20250723-ddrperfm-upstream-v4-2-1aa53ca319f4@foss.st.com>
 <20250723134148.GA2136293-robh@kernel.org>
Content-Language: en-US
From: Clement LE GOFFIC <clement.legoffic@foss.st.com>
In-Reply-To: <20250723134148.GA2136293-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-23_01,2025-03-28_01

Hi Rob,

On 7/23/25 15:41, Rob Herring wrote:
> On Wed, Jul 23, 2025 at 03:05:46PM +0200, Clément Le Goffic wrote:
>> RCC is able to check the availability of a clock.
>> Allow to query the RCC with a firewall ID.
> 
> The subject is wrong. There is no such "access-controller-cell"
> property.

I found it here though:
Documentation/devicetree/bindings/access-controllers/access-controllers.yaml

And want to use it like here:
Documentation/devicetree/bindings/bus/st,stm32-etzpc.yaml:41

Oh I see I might need to add the #.

Best regards,
Clément
