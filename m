Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656F32DD5F6;
	Wed, 10 Sep 2025 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493225; cv=none; b=Bq+nBFTmMzPZnCLgPeP2sERQNGmCmYF+SYYdUTRKdTDH8V5oyMUwjuRbilQEjzsdedNO7blmTxfdIYo6p3+BzV+PtR5OGJ+iPXU2UFZxf3rawx7Fmd78O2JKwNjEEgK2+DRPfkinnu2dsIr5Ew8fAGhHYGU4c24TlTmdYA/z3lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493225; c=relaxed/simple;
	bh=QEVdoZxES7x73H4Mp5RFBH4QFpvezZhffON9ysK2E+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DhjTwKEjW7t4zya2Zez3zAsYaUr4OzDwNdMrtIk4c+aW4bJbyo9BZ012xRtR6xxFNh3F3f/3q+N2yrcIbesQ+iRtiS3O8SkEodioj6fpXboeLWmAK8/3PGsw+cyyO+NYe+08jwHO+rH3p3P8RS8c8RukFgb97MeYI/K66tfxIUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7hQbCKv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7hQbCKv"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45df656889cso6216395e9.1;
        Wed, 10 Sep 2025 01:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757493222; x=1758098022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EHfbo0BKomkvlXOhBVfB/0eAcoO1X0ualN2+zvtl7Uc=;
        b=X7hQbCKvdXYi5YeMnIELei1GWbEcwBnn0xFHWKtrvyHuTfqTL94ZMHRiDGi6HIpmLo
         +1G7vYsv3vpf4BwIdGtwve1yj79Qh/eyBWPjTRx+JFXEAzscC9ofoP35a5istDOrKZ3t
         zUdA+SivZNFtZvo+aFR5Kv7IEfv6N0NU0QXTMl1WJFR7A68GIyzSlzR5RGLc0htEqlC4
         TNfrvbxF9uo5nPDxTp8jo3SmTfgzX3FE3545JRSEcv7rGYoFewkRoYdeaYOXri+pKsUY
         0a5qet6OrZwRVIrRjjcHUy+srDmm+8vwk+1Ge5ods3uS0t5bu3ui640cHm75b9OOua7Y
         aWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757493222; x=1758098022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHfbo0BKomkvlXOhBVfB/0eAcoO1X0ualN2+zvtl7Uc=;
        b=buCSdkPsNX8rqgbsCCKhqodCSbXo1bxs2PamkpdNxlLvjUIwSbNQxMbFWjPMPIT7HC
         WTwOJdK/QFaNc7g3MMXojS7DxNgh+zWWFjFgyVx9lvEu+egpk3M1HrEqaBh8Oi0SI8QV
         FCGc4WroIGFzl+Xv+FpzMkQ+1pyjdLjOUHZTpx1mKpgt2lrVnTP+HGwEKZPfJDQOHsBc
         FrQp7Gr0gshfzyBOmznq0JNxbr3NfKEzY0zvMX3a5EUSyTvuERh7/+LQc67vjvSv+L/w
         grla2wWpeNeJ822P+4qyscmG0PIaEfJ/yTRIYOyM7SP08fR/1yuOQNzS7NvdoBoSYqhz
         XB3g==
X-Forwarded-Encrypted: i=1; AJvYcCU9LZjGyDFGgnHO68t6R5MXlZ1stdmT7hxBuKR3YjSrcg+ulWqjSj2uLjRzwhCaztmiQmGkSqLGnZft2n6z@vger.kernel.org, AJvYcCV3rSYIvifVbdMurEiwv+Q4kCAF1xa5AqXoGtroIxBrpj974UyMixeFKTpNuagdl2YOtU7d/+GyS1XF@vger.kernel.org, AJvYcCV868gorA8A7hy0VloKiCiGqQsRa9BlJaIEATDMpqnPANgAzmpJ424qi7rR0gaSnKN2O3JWaD9wes9X@vger.kernel.org, AJvYcCWEmKWaN4LiaOMo6IjS4M5uk1dpUnlgebI4Z3tGrE8M0JDUCrjwNWLH4qKLEMdpkFNWNWnkZsYbpr0SivK1lQTkZg==@vger.kernel.org, AJvYcCWylH/eqervKodNXspPM50mlSpYs8AvfYX1cOU0k63zWtPNT0sh3TQF1ei+dFNbky1qD/qCMmj4NT3m@vger.kernel.org
X-Gm-Message-State: AOJu0YxhglmP2jokD2WgzNfFnotVfgQMlDw9D8zw5ZHgRk7+k6ywIALt
	e1DJ1RXh4dMLAqBbbq5o8X6fAuFV14A5aHvxIpXHM1cxUcnxjkGZAl1t
X-Gm-Gg: ASbGnct3FIrJEs9LrJ8Gm6n1b/hmMC6TZJYxEQqyXCwo3/IlAXqQUnnKX92NZJMjrRF
	jN3PcZmGLc+3asu7B6LFE+J8ia71Gh1s2MFxRN1seSPn7ROc7G0s2WTd/uATVxpyxeqH/cBOnfF
	8bnG2vAYzcm7t7JzwAeyOSZ3ZAvl+Zn+L9dMCCZZsXRjpgb0+R6asKOdcn3NjjBTA/YQ8SGSJOw
	NlJE+a9d9owezRGTv5YVuKNHz57toU27odNOvNdXVtOsAk/+AG89ebOpJFDNqMlkiSwl++0CvnA
	u8L56fQFAVXF8SWoby68RejIEdHxSj4ffWr6FirKf3R6RF7kNY7/afazjcmz6WD5WtuOGcicX5z
	dE6WBOykSP63o+UHZ+lsEtAxe2SxB0jAEOqq5cZDLuIGfhgdsTnFB/zucaTxIbcFW9NEH10jCS8
	tZOsNwUrBqldLYfQtOsrhwB7uo0FJ8HIkS0wvwZNfYlg7GuX0dLLsZ0piHXosXGCI=
X-Google-Smtp-Source: AGHT+IERWBLoDJYJTftiCvvL8rJvicVn7K1El1ceydxmfro3VBEiw0JoaM94eFug5LOT1WRGb+/cOg==
X-Received: by 2002:a05:600c:a05:b0:45d:d5c6:97b4 with SMTP id 5b1f17b1804b1-45ded2fb475mr46947715e9.9.1757493221488;
        Wed, 10 Sep 2025 01:33:41 -0700 (PDT)
Received: from ?IPV6:2a02:8440:7135:4f4c:9000:7072:695b:3ef? (2a02-8440-7135-4f4c-9000-7072-695b-03ef.rev.sfr.net. [2a02:8440:7135:4f4c:9000:7072:695b:3ef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521c9a2esm6376513f8f.14.2025.09.10.01.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 01:33:41 -0700 (PDT)
Message-ID: <7c9eadf3-6b71-48ba-99ad-bca5b8bc40e6@gmail.com>
Date: Wed, 10 Sep 2025 10:33:39 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/20] dt-bindings: perf: stm32: introduce DDRPERFM
 dt-bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Julius Werner <jwerner@chromium.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
References: <20250909-b4-ddrperfm-upstream-v6-0-ce082cc801b5@gmail.com>
 <20250909-b4-ddrperfm-upstream-v6-12-ce082cc801b5@gmail.com>
 <20250910-adamant-hospitable-firefly-ae30c5@kuoka>
Content-Language: en-US
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
In-Reply-To: <20250910-adamant-hospitable-firefly-ae30c5@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/09/2025 09:57, Krzysztof Kozlowski wrote:
> On Tue, Sep 09, 2025 at 12:12:19PM +0200, Clément Le Goffic wrote:
>> From: Clément Le Goffic <clement.legoffic@foss.st.com>
>>
>> DDRPERFM is the DDR Performance Monitor embedded in STM32MPU SoC.
>> It allows to monitor DDR events that come from the DDR Controller
>> such as read or write events.
>>
>> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
>> Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
>> ---
>>   .../devicetree/bindings/perf/st,stm32-ddr-pmu.yaml | 94 ++++++++++++++++++++++
>>   1 file changed, 94 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml b/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml
>> new file mode 100644
>> index 000000000000..1d97861e3d44
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/perf/st,stm32-ddr-pmu.yaml
>> @@ -0,0 +1,94 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/perf/st,stm32-ddr-pmu.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +maintainers:
>> +  - Clément Le Goffic <legoffic.clement@gmail.com>
>> +
>> +title: STMicroelectronics STM32 DDR Performance Monitor (DDRPERFM)
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - const: st,stm32mp131-ddr-pmu
>> +      - items:
>> +          - enum:
>> +              - st,stm32mp151-ddr-pmu
>> +          - const: st,stm32mp131-ddr-pmu
>> +      - items:
>> +          - const: st,stm32mp251-ddr-pmu
> 
> You did not implement Rob's comment.

Indeed I miss it. Will fix it for the next version.

Best regards,
Clément
