Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB2E2FFDE1;
	Fri, 22 Aug 2025 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871200; cv=none; b=L8LQpr0JcJHB85wO4iPum2wh7SOI2B09JDu3krb1CdcoQHepdpdZKIWDPsyrBHE96p12RAjnE+7QTJ9h3O4/YnoPmXz/BRIEEkrH9PL+LBGBz2JGuovO7ja65lneVAT8ILM9E5+SiOfhyxfeGWNXNfkkD7y41qZwD0sc0M18HfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871200; c=relaxed/simple;
	bh=ooBVDyCPVijQzqFh2YdlTtUqe8TbMbgu6QzXF734j6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4QaSEDMg4j0f4rBIgOXXsP61gz9we+lsBGsAgIT7T3DNnCXp2XZBuFM1XjSEpbl6ZM7Dv2eYKCVajdvOKfvOEPwwUexvCcGTCj/+dsrAMss92d7pBC1vf3sF6OgmyqWY8XJ77dlOfOMH3VYo9xR5uKKWoZBTgt9/bmpzMwjRFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CY01tBhL; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY01tBhL"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb78d5e74so356961166b.1;
        Fri, 22 Aug 2025 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755871197; x=1756475997; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V014dFiaSCDPs2i3+HfkIg6rp9m74x/8h2rQVVO+dUk=;
        b=CY01tBhLtmiJRYe2yuSbNFEB4OM7tvUO+EbpHgHTsEp+ZrWzCu94d40cE6UfiuArmh
         JsoOtShJIukVqvFMZTeQ3RFHSqrwQG5BDLouHbLfzesiAqt3rjr9FhLyL3EKDSW1Y8nQ
         s/dJote3zySfWAcMA9Nx1poquTqgz4sU8LB1gfKMzAM+wJAQmnncKv8bvEjmRN04x112
         xOzyk4vdsfdowUYF/rSUxldH0eMtodcjTqql3b1G3IrIXgJ76Xr0TSv51GhFIZ6Mi/u0
         Q+Q0FjG9XYt6lCf9asuR7CLRpAEC8GHC/l+0jcbFSyPR8oYIfGbULWCe2uRS6dfOtAAl
         h8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755871197; x=1756475997;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V014dFiaSCDPs2i3+HfkIg6rp9m74x/8h2rQVVO+dUk=;
        b=Kv60hQPRgs1lFVKOfbi8zIX14mX9L95jvG807o1OkvvLP7dJc24WXQCREiwvSgH6fh
         02pE5ohPLXlIJU6dc6DBdvDpZqzoRvwdFPgtJP+R7SVOSB8xHq3ihvPsZbyH3cQxvJ1O
         0YwqERhaQUEEyPaR/B7pMpcNwZQOTh4CWqfm50aaRcadoY3ugU/6SsJ/A+HKyzBSbnLM
         iSRNSAqOWsoWmB1JX/BF0/TDI7KtyY2N6HnEhv9/7A7amQDtdcvXUKDu742lsNYUsziZ
         Su0SCIW/UOoawHmiXUr51+0qS0MKW0c+aaoVFZlZEgQL+OOel8slzcL7lF83LYxMDqyT
         yBIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD+czqgMrsxCmj4Wusb+S1b11vY5F4U4gr/GiVGtCwBp0QB2wvwOI5mC80rCpfRGCkWfe+4CTbxTNVLHxhxcQuSg==@vger.kernel.org, AJvYcCUOLDP7dM468thK8gWpFAC3xv1lcM6rVLi0Y6VfPC7FVdht1H++tN9scG9heTxI1ym/Wq0PV6fN5qRl@vger.kernel.org, AJvYcCUXt74T4U1Asdf21wqCJaBOmLZZprrn3uaFpr3U3DjfHbUxbhSGzYPy6RIePel7JmZrSoaXsxhAEO2G@vger.kernel.org, AJvYcCWDx1zYNzUyJYhrm5VhsroKh7GAsi2ubwGrW2dXK3BzPOd7NjkZ4/c3+Np0JC5Ty9NL7W3tL2oFOi2skAA2@vger.kernel.org, AJvYcCX7OH2G91unIT0xpWBlK8TmJFP+Bv2kM0EFgfZna0BLm5mTIhxpYJS17vDKeuk3+CUwyec/s0k3bkNL@vger.kernel.org
X-Gm-Message-State: AOJu0YxK7gB9GLN+21tFYw6eODWeHMi75EMMQo0X9+NOaVoGyX78FXAd
	NcSMLegBjQVFYR5HV3B5QlJoNzLaXpJTTa8fozGUqPS29nJmpSClw6br
X-Gm-Gg: ASbGncvKzXuKjiw4d5psX+u1qKOgplRtuk401qBs1MwL6IB7WXVajg0nllJNPzOZxi9
	ioMWmgNm++Xg9HZudppRz06k3ocOK/WCLQeB5oeTg6sqo8OnObVoXUizsX07ZusqAwCgE4GoImy
	21v4jOwtSNxIaj/1mim7+ktrZ33xvPd3tYVR55ALILxLZ6Hft5d9h9cwpCMoZixtzMrwr9CcBLi
	16BlKwlZONqGxFRngI6H8VfKpZbJIEHg0mm37FHNSiw7WjWOnBh1OKdk3OngzCLvObFTAptqMtY
	iP78AwitIfDw5Rxy+NyLhsO2iGdIWdMXVLnIif8UhCZqMlb+vgdiDQwzXGBWCAw/cRiGg2r4kJ8
	yqMvIsZiQLG4sryr/qbzV6dnfM8D5vpeB4joOy1xGQtW1F78fi7vCOg4oI5mPtxFTV2JG3bsVsP
	VCFQnqIKc30zv/7XCRSJ6kkIFxUqpIFZvqBipHXim84UfrIHYYB0vTyEx/6ZVZ2UyvkpLywYWGw
	qvU
X-Google-Smtp-Source: AGHT+IEf+0iTczeJWYRvKTzbPjuHcrR0Q/vZbiX0S4rQLygBrUblykK/q9qnm/yelo9JpR8nUFhBWw==
X-Received: by 2002:a17:907:60d3:b0:af9:e3d3:a450 with SMTP id a640c23a62f3a-afe28f77734mr245587666b.6.1755871197072;
        Fri, 22 Aug 2025 06:59:57 -0700 (PDT)
Received: from ?IPV6:2a02:8440:714a:ca26:61e9:f2d7:67f6:fe9d? (2a02-8440-714a-ca26-61e9-f2d7-67f6-fe9d.rev.sfr.net. [2a02:8440:714a:ca26:61e9:f2d7:67f6:fe9d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded4796f3sm607923666b.61.2025.08.22.06.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 06:59:56 -0700 (PDT)
Message-ID: <6a10616b-3234-4336-aff6-4e60047ebcb6@gmail.com>
Date: Fri, 22 Aug 2025 15:59:53 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/20] dt-bindings: memory: introduce DDR4
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Julius Werner <jwerner@chromium.org>, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
References: <20250728-ddrperfm-upstream-v5-0-03f1be8ad396@foss.st.com>
 <20250728-ddrperfm-upstream-v5-6-03f1be8ad396@foss.st.com>
 <20250730211151.GA1749004-robh@kernel.org>
 <da8578ae-3f79-4082-b0fb-760553004c93@gmail.com>
 <fb5083ff-4bee-4a0f-8774-54b492cd9a6d@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
In-Reply-To: <fb5083ff-4bee-4a0f-8774-54b492cd9a6d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

On 17/08/2025 09:19, Krzysztof Kozlowski wrote:
> On 14/08/2025 16:42, Clément Le Goffic wrote:
>> Hi Rob,
>>
>> On 30/07/2025 23:11, Rob Herring wrote:
>>> On Mon, Jul 28, 2025 at 05:29:37PM +0200, Clément Le Goffic wrote:
>>>> Introduce JEDEC compliant DDR bindings, that use new memory-props binding.
>>>>
>>>> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
>>>> ---
>>>>    .../memory-controllers/ddr/jedec,ddr4.yaml         | 34 ++++++++++++++++++++++
>>>>    1 file changed, 34 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr4.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr4.yaml
>>>> new file mode 100644
>>>> index 000000000000..f457066a2f8b
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr4.yaml
>>>> @@ -0,0 +1,34 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,ddr4.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: DDR3 SDRAM compliant to JEDEC JESD79-4D
>>>> +
>>>> +maintainers:
>>>> +  - Krzysztof Kozlowski <krzk@kernel.org>
>>>> +
>>>> +allOf:
>>>> +  - $ref: jedec,sdram-props.yaml#
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    items:
>>>> +      - pattern: "^ddr4-[0-9a-f]{2},[0-9a-f]{1}$"
>>>
>>> Shouldn't this be 'jedec,ddr4-...'
>>
>> That's not the case for lpddr bindings, I wanted both lpddr and ddr
>> bindings to be similar but this can change.
> 
> For LPDDR Julius introduced in commit 686fe63b2280 ("dt-bindings:
> memory: Add numeric LPDDR compatible string variant") ddr4-VENDORID
> pattern to distinguish individual manufacturers.
> 
> Jedec is not really the vendor here.
> 
> Is it the same case in DDR? You have a defined list of vendor IDs (also
> 1 byte)?

There is no defined list of vendor IDs.
The way the compatible string is created is explained in
jedec,sdram-props.yaml file which is created in patch 5 of this series.

Best regards,
Clément
