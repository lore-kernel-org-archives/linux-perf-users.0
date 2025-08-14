Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B3D1DE3B5;
	Thu, 14 Aug 2025 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182570; cv=none; b=p+rHp5u56gcu5cINPQpL0EXtrOsPMCwbHOFB+YvxjAoOacSSvfk0ZEeOGXgwwwIrBOJHT5/ylvbD8MKBXdNyfOssDXzGM2ufMieuUPcaXnP6KYlo9C8XtHTZbFYtpowdLmq6GmjOdOaUnLG0TGL2Jni2Ln7iWrK21vt1ZDlOMaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182570; c=relaxed/simple;
	bh=MobfB4SZ6VjZKXzrXbLomGeTlLEdXpJz0vuRlj/n+Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8z+vLXmujltHJU88qAgGujoJcRK4QLJ/FyMuBMBociupQN8UScy3To2ihldyacYZJX8S8WHvznTNfHrAxhKlXW4fJghwfVUA4mI5yLBpK/ohXs/R34/xt2Hb/lNaGkrRatst9MXMSjBUHa+FfYldxGtMkJZqc9ZimHbfjz4Hfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lACj2DGd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lACj2DGd"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b004a31so7024685e9.0;
        Thu, 14 Aug 2025 07:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755182567; x=1755787367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p2VPK+LGzPHiwIqFk3Ohj/RoTK5gsaz46bIEazLhBRA=;
        b=lACj2DGdF6YwEyiWB+E+cAgkbqQeGIURjoHZi+Vc8Cwvc7BOX5Rj37X7cRVRzyUrwC
         2yOLO3GtcA7gYkbIcLUWX0ZG/WligU6Q6oh3dPGLed8s3BmYGLSOYkvoJ9hxXUkuuGmT
         tuq6QBO6Z+QgKCaYLZeIUgErJiGmStxTVVMzX7mk2sQiiKCg+BvaKwUmlw+bfFrTkQDx
         /vsa7DSb6ppZpAkoveCTFQw1xBZH5QJKxrfJ9gkdqD/J3H54nOck4NDUvmjpE3H4lWv+
         F3GZBq0phxKS1ICxruwuweD7UA1Mmetm9kW1/g0xfPPmfLKuoXH0XxKGi1HdpYRYGPB9
         1kbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755182567; x=1755787367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p2VPK+LGzPHiwIqFk3Ohj/RoTK5gsaz46bIEazLhBRA=;
        b=mFAjcqRV95tcLVWiICk2Xz9gOtLdkcH/yuVBwgWiY4nZgFSIwCg4JgRCQvBNALNhF9
         l1Hq90wLjktnbIbdT/hcLFr3yTpSEFVQbS0Bztyj/1fWM/DclGoxqzmm5hK6ss0JePap
         7F0rVwmQVQ2R+L1/FuWsGmAPmDiXToSF8WksYYPccIxIK2+mOrWv7ZFzesgzFIHyb8og
         4h7mHL8mG6tXUKbdxC4+gaLSZshD64pgpUsIXWVZx+L5iAOoh5qhW+aRoT56e7Eh7Egj
         h5BYm/rYilz4Qfstt4tqElIyEh70KUDFA3Q4/+ePUS2WqkEW7oCGQM9Buh5Z407xOfbT
         4c+g==
X-Forwarded-Encrypted: i=1; AJvYcCUjK5T6oOGriTjWZ6SREBpSoXhAY9QXpZGeqbhN0930tK367/fpVYapVuQy9NKGezbMV1xbw9LxL6tq@vger.kernel.org, AJvYcCVNSmH5Wfu6URIXsucvJX/z7SSK1mgp7pr4mpmyD1fZvUegCUSIu2AdQ+V9DJ9yGBpKL1YY4yUfTgCwEKodx+22eA==@vger.kernel.org, AJvYcCVSropR0Cl+fwoQFwIq3daJg7zCUsOnBbNWDVGPZFKJU9Pq7gBg+WgtYH8IiY7bPyeFOV1XRfHWVLCb@vger.kernel.org, AJvYcCVwzBpwQVAHsfHBg+S5jq7ydUftLB+X7Ykn9o20mhPZayhoAhr1+HWQPsyn06FdGsU1J6dMdgGz1X126uwl@vger.kernel.org, AJvYcCWw65ZP+Bl+iEMSmCfvsyGr0cCodufTgUvsr+cMwsXeWR4HGwlMYFwhvN5s0BCzWEksJOwtVOtqkoia@vger.kernel.org
X-Gm-Message-State: AOJu0YzATodbTaqvU8jbB4bQjkQr3m/56WXNTl8b5G0tzY8mlwQRo177
	hro/Q2eFoReoCIMmFyZStrnA7i7pAMrUwMbixhetAB4J/eLTMQEmIGnK
X-Gm-Gg: ASbGncskHf6A28yLvJKrlWB8b7Wx93wl0XTQ8apx/7wOGFpf1/DqG2wrVfr7j7++hEd
	DfnljX0VqrwspoIgrDhbO/m+ozdAQYC8uziY+80L+W7DVyZkQ1AQ1DoxKO4l2DAKoEOv9UAIJqJ
	GtO2SiiKt2CqkXF3e+jvcywmCaUBaxqrIYHKl+WOU/GAaLX0mbUQUFOi7rNR1jWP06tozXIe1bu
	9me5Gr30hJ8rSeIDTb75GoLSafULYpXYee8CGpy80AqGqs0Pn0gH6Rh52r+W4bD77P00i9OcDlc
	uhFCE+8agsl5gyjEVcc3z2QVayWMPRktcb7HshKUOqOGduke8kacglZoWxPBbY2KfACsg+idzwL
	YxR5PczYWIZcKrE87XFMIT7/7QMgVrjL4NgY+xiaHWiMPdv5LqK+TbS6AYf6Y1SAKseKWppPGGT
	oSmceIoTU1vNdX5W9YYHvGAbVvvuH0dqfUh3Q0Y88Ziquqj6octTNQ5yzFvzBX66O6H5tQFGhLa
	po=
X-Google-Smtp-Source: AGHT+IFhCWJEojvA7i+pME+fago4vJDtFzuQD2e2yOvIROciTuu5CIqY7MvPDw7EgLATDPP7poH6og==
X-Received: by 2002:a05:600c:4f49:b0:440:6a1a:d89f with SMTP id 5b1f17b1804b1-45a1fe78624mr4900695e9.4.1755182567395;
        Thu, 14 Aug 2025 07:42:47 -0700 (PDT)
Received: from ?IPV6:2a01:cb08:941b:4c00:f383:4db2:82a:81e9? (2a01cb08941b4c00f3834db2082a81e9.ipv6.abo.wanadoo.fr. [2a01:cb08:941b:4c00:f383:4db2:82a:81e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c718769sm24256305e9.30.2025.08.14.07.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 07:42:46 -0700 (PDT)
Message-ID: <da8578ae-3f79-4082-b0fb-760553004c93@gmail.com>
Date: Thu, 14 Aug 2025 16:42:45 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/20] dt-bindings: memory: introduce DDR4
To: Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Gatien Chevallier <gatien.chevallier@foss.st.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Julius Werner <jwerner@chromium.org>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20250728-ddrperfm-upstream-v5-0-03f1be8ad396@foss.st.com>
 <20250728-ddrperfm-upstream-v5-6-03f1be8ad396@foss.st.com>
 <20250730211151.GA1749004-robh@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
In-Reply-To: <20250730211151.GA1749004-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rob,

On 30/07/2025 23:11, Rob Herring wrote:
> On Mon, Jul 28, 2025 at 05:29:37PM +0200, Clément Le Goffic wrote:
>> Introduce JEDEC compliant DDR bindings, that use new memory-props binding.
>>
>> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
>> ---
>>   .../memory-controllers/ddr/jedec,ddr4.yaml         | 34 ++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr4.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr4.yaml
>> new file mode 100644
>> index 000000000000..f457066a2f8b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr4.yaml
>> @@ -0,0 +1,34 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,ddr4.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: DDR3 SDRAM compliant to JEDEC JESD79-4D
>> +
>> +maintainers:
>> +  - Krzysztof Kozlowski <krzk@kernel.org>
>> +
>> +allOf:
>> +  - $ref: jedec,sdram-props.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - pattern: "^ddr4-[0-9a-f]{2},[0-9a-f]{1}$"
> 
> Shouldn't this be 'jedec,ddr4-...'

That's not the case for lpddr bindings, I wanted both lpddr and ddr 
bindings to be similar but this can change.

> 
>> +      - const: jedec,ddr4
>> +
>> +required:
>> +  - compatible
>> +  - density
>> +  - io-width
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    ddr {
>> +        compatible = "ddr4-ff,f", "jedec,ddr4";
>> +        density = <8192>;
>> +        io-width = <8>;
>> +    };
>>
>> -- 
>> 2.43.0
>>

Best regards,
Clément
