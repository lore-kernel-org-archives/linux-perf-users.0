Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9933148C2;
	Wed, 10 Sep 2025 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497400; cv=none; b=gSNcVwkZkrsuNRc9AT4INP4kn0gtMxO4T/FKsnIVRmLpL/19PQvt9jVRYcyr1HD/gjCojodbKxq9VF8tdLUl0ZdB/znzbJqgIS9JmTvPeLT6/rH1AUwZ846hhUTja6Ptxk7874fPAj0Q8UENN2lWSrV3GIMpGopX3Q2KAoQLCk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497400; c=relaxed/simple;
	bh=Qg4SnOajWTPp0F9yvDIVD6p+vbZ6EUUeIv6GZ9qy+bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gc1+z4rvJS1cbpOsE8D4ASk2+PrWc6xIOYa5qSBz7qmYVB/5puTwegRNfLAdbjuZ0KCKk2dqhQY977ZRj05dmihuziQePdeu0e+k1fIHMiP2tYzohiHqZfEXQOaLNry77y8K4JxHme0XL00a70A2wwehlNTWZBhqow7GZ3CAh2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCNZv6Py; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCNZv6Py"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45cb659e858so45699125e9.2;
        Wed, 10 Sep 2025 02:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757497396; x=1758102196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+Yb/IxxLIspa6tHUrNInqlVlxK+I+nsywpKyzMZIM8=;
        b=TCNZv6PyC56oz2eR1xLMpcRJMGdLr8JyYtqV8g4KW5icFcXxzQ9+u5MPPYCaPs0ImW
         5j6GR28NHkmt2R4ihcv7E+fLHoIOVAYnv1FNck3qC2BBAiKiYgTQuRaDx9w7Ta9ncD9E
         bLw9fN7kWqcnbULhNoD2sMs29wm+0IYXjilAFXQB8uMhSA/ku6xQjMWMyAbJUiqq/9yE
         aK5XC0sJgRMWJ1Mdm1gsOFCCONtItF0wBV3CUxYua/DeKG2yB5irYT1Dcp1xJj3oJiMf
         WHydKjaHhDxbla45146HygE80AcXgX2hBoGQqThIldEY+v+Ab5byMeBEY/J2kdvoG/jX
         lHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497396; x=1758102196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+Yb/IxxLIspa6tHUrNInqlVlxK+I+nsywpKyzMZIM8=;
        b=eMfh5fFy75Wdn/dlmkTMQp7bNa9+eoaV9KogCBTjwGW9JFtl1nuOrT+eDUI6Boroqu
         9EVW8/2TVSBU8CN3b6xVugKsvy3HYg7Gd2krBPsn9MgfjG5gs6Rsfkb01/GIs5AxMBx8
         j7DlimwdXe5uZu7KbxpW8/vGvldpJeCqmH2AoOmCQRM3POUvLoFgCEH1r4EMTP4eQpMT
         VB/1Pd046PwmP6L2MxijqHB/ysnz7CcnJAsP+AeGfvJLKCfL934M47T7aTN/ElkbocNn
         VTcCuhMUvefHIBth6rWpsge7NZ1NgcdHBP/RrQZgGtMoIHibe7k0Gw7rIV4fiaOBXWn2
         Lsmg==
X-Forwarded-Encrypted: i=1; AJvYcCV/hPq0g4wYTmWwgCihwAFkCgnEoQM6duq5752WKDmrN5aGFiDScsmwUGSBbsiQpmdtAHvh2utDZ+C8@vger.kernel.org, AJvYcCVOYYXV2iBrnSii5B0WxKZ90KzR54K4wGx5eNlZVsHMHgK54gvmsUm+lOu+K4NfQgNZD4W+rW/xj5rS@vger.kernel.org, AJvYcCVmrL+BEEdGoRGTlZYvt0Ccjpm3PZpA7lx6xCnQk5aEaXb85iM7bmQGCRse4s0DK/NV01GgRokAqfUxXKWY@vger.kernel.org, AJvYcCW6yDm5DXH6tNrwJJNEnWZ+qKj0EuPzT2NzDN5afDF0mU6OG7DZQwSlOHRpayFxq2GsliuB8APuRw0T2Zt67m6HYA==@vger.kernel.org, AJvYcCXu+1FJOkhJOYIp+1B/62AFR+ItMIzGMRpngK7S5QVLPW61VdKu/fEmbIE7EI2LMxEjslMxwHy4MXGE@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj2lJW3V2Q5OYmWSN6k1C8gHwj5F0wx9aKhwYTRnTqFnOdt6Gv
	WbwGQZyEoc14kBKIMRS20d2ItE0JQBwpnUeFytTJYZgIDEIyuFfn8VSG
X-Gm-Gg: ASbGnct1CPmEIgpj2WQ60QiouIpujeNxAriFpJDL4TVRVhZBQvgf1nOHNIYUG1JzWzG
	8Rx8DInLS8IxVRrFKh7vrNxEqYsbGPMvAfz+OcywdZ7d9k4ImmCsaSzX4kJ6gfB8CUbCsUqkK/Z
	jVg/CrI1iYzI9GwM8rJcpwkjVPleeiUKRKQHuW/4oXAFvRlEGmaovgypPPNtKq2dOzrtL+03Cwv
	el1brM/Y1jPjevHjII/i35qXAVrgwYns/x3Wfk5q3IED43tPwNqDrJtK+D8sRT93sJbykOjFGA6
	7dn4XElb7r5/xsliX8byDIweaCZUTG/1GVxRtcdgqmiBp3+cszpVyg+f0wVbEZao9urfIK4KyC3
	8yyVfZR0wM+HR3n3AqKd9yh1ynqv7fSje37at0cOTsWJe8gPu6bCDUy6S4yzlXYstzEq1W1t2Ls
	u0yiytm58jSiLOepInxkBQuYFiQhy4kfSb/+yqlOP42CZj0tXER6ebIo7thVanLeQbGDOYpIvRw
	7Oj
X-Google-Smtp-Source: AGHT+IG++5gaOV3PJKYuJ0A9nAeEycj+nF32F/RTHqK48mjNiX/HpSzosqAvPkjm4CBA9YvRx7JU+A==
X-Received: by 2002:a05:600c:c48e:b0:45b:6743:2242 with SMTP id 5b1f17b1804b1-45dddee9cc4mr128836755e9.22.1757497396149;
        Wed, 10 Sep 2025 02:43:16 -0700 (PDT)
Received: from ?IPV6:2a02:8440:7135:4f4c:c6d5:9a0c:a4c1:1e58? (2a02-8440-7135-4f4c-c6d5-9a0c-a4c1-1e58.rev.sfr.net. [2a02:8440:7135:4f4c:c6d5:9a0c:a4c1:1e58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df1ba282dsm25183485e9.5.2025.09.10.02.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 02:43:15 -0700 (PDT)
Message-ID: <22a485b9-1b86-41d3-a42c-f813eea94697@gmail.com>
Date: Wed, 10 Sep 2025 11:43:14 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/20] bus: firewall: move stm32_firewall header file
 in include folder
To: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Julius Werner <jwerner@chromium.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
References: <20250909-b4-ddrperfm-upstream-v6-0-ce082cc801b5@gmail.com>
 <20250909-b4-ddrperfm-upstream-v6-1-ce082cc801b5@gmail.com>
 <9a46c8a8-1d25-410c-9fa2-267eb4040390@foss.st.com>
 <19e664da-df4c-4bc0-84ce-41e4364f10bc@gmail.com>
 <7cfb167a-26df-4abf-a6ec-73813a1a0986@foss.st.com>
Content-Language: en-US
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
In-Reply-To: <7cfb167a-26df-4abf-a6ec-73813a1a0986@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/09/2025 10:42, Gatien CHEVALLIER wrote:
> 
> 
> On 9/10/25 09:47, Clément Le Goffic wrote:
>> On 09/09/2025 14:25, Gatien CHEVALLIER wrote:
>>>
>>>
>>> On 9/9/25 12:12, Clément Le Goffic wrote:
>>>> From: Clément Le Goffic <clement.legoffic@foss.st.com>
>>>>
>>>> Other driver than rifsc and etzpc can implement firewall ops, such as
>>>> rcc.
>>>> In order for them to have access to the ops and type of this framework,
>>>> we need to get the `stm32_firewall.h` file in the include/ folder.
>>>>
>>>> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
>>>> Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
>>>> ---
>>>>   drivers/bus/stm32_etzpc.c                       | 3 +--
>>>>   drivers/bus/stm32_firewall.c                    | 3 +--
>>>>   drivers/bus/stm32_rifsc.c                       | 3 +--
>>>>   {drivers => include/linux}/bus/stm32_firewall.h | 0
>>>>   4 files changed, 3 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/bus/stm32_etzpc.c b/drivers/bus/stm32_etzpc.c
>>>> index 7fc0f16960be..4918a14e507e 100644
>>>> --- a/drivers/bus/stm32_etzpc.c
>>>> +++ b/drivers/bus/stm32_etzpc.c
>>>> @@ -5,6 +5,7 @@
>>>>   #include <linux/bitfield.h>
>>>>   #include <linux/bits.h>
>>>> +#include <linux/bus/stm32_firewall.h>
>>>>   #include <linux/device.h>
>>>>   #include <linux/err.h>
>>>>   #include <linux/init.h>
>>>> @@ -16,8 +17,6 @@
>>>>   #include <linux/platform_device.h>
>>>>   #include <linux/types.h>
>>>> -#include "stm32_firewall.h"
>>>> -
>>>>   /*
>>>>    * ETZPC registers
>>>>    */
>>>> diff --git a/drivers/bus/stm32_firewall.c b/drivers/bus/ 
>>>> stm32_firewall.c
>>>> index 2fc9761dadec..ef4988054b44 100644
>>>> --- a/drivers/bus/stm32_firewall.c
>>>> +++ b/drivers/bus/stm32_firewall.c
>>>> @@ -5,6 +5,7 @@
>>>>   #include <linux/bitfield.h>
>>>>   #include <linux/bits.h>
>>>> +#include <linux/bus/stm32_firewall.h>
>>>>   #include <linux/bus/stm32_firewall_device.h>
>>>>   #include <linux/device.h>
>>>>   #include <linux/err.h>
>>>> @@ -18,8 +19,6 @@
>>>>   #include <linux/types.h>
>>>>   #include <linux/slab.h>
>>>> -#include "stm32_firewall.h"
>>>> -
>>>>   /* Corresponds to STM32_FIREWALL_MAX_EXTRA_ARGS + firewall ID */
>>>>   #define STM32_FIREWALL_MAX_ARGS (STM32_FIREWALL_MAX_EXTRA_ARGS + 1)
>>>> diff --git a/drivers/bus/stm32_rifsc.c b/drivers/bus/stm32_rifsc.c
>>>> index 4cf1b60014b7..643ddd0a5f54 100644
>>>> --- a/drivers/bus/stm32_rifsc.c
>>>> +++ b/drivers/bus/stm32_rifsc.c
>>>> @@ -5,6 +5,7 @@
>>>>   #include <linux/bitfield.h>
>>>>   #include <linux/bits.h>
>>>> +#include <linux/bus/stm32_firewall.h>
>>>>   #include <linux/device.h>
>>>>   #include <linux/err.h>
>>>>   #include <linux/init.h>
>>>> @@ -16,8 +17,6 @@
>>>>   #include <linux/platform_device.h>
>>>>   #include <linux/types.h>
>>>> -#include "stm32_firewall.h"
>>>> -
>>>>   /*
>>>>    * RIFSC offset register
>>>>    */
>>>> diff --git a/drivers/bus/stm32_firewall.h b/include/linux/bus/ 
>>>> stm32_firewall.h
>>>> similarity index 100%
>>>> rename from drivers/bus/stm32_firewall.h
>>>> rename to include/linux/bus/stm32_firewall.h
>>>>
>>
>> Hi Gatien
>>
>>> As the firewall header is moved to a dedicated firewall directory,
>>
>> I don't move it to a dedicated firewall directory just to the "bus" 
>> directory where the "stm32_firewall_device.h" header file is already 
>> located.
>>
> 
> Yes, my bad, I mixed my words there.
> 
>>> maybe it would be coherent to create the same kind of directory
>>> for the sources as non-buses drivers use it. I can test it on my
>>> side if you're willing to make the change.
>>
>> Do you mean create an include/linux/bus/firewall/ directory ?
>>
> 
> Rather include/linux/firewall/(stm32/). and a drivers/firewall/(stm32/)
> directory for the firewall files would be great. If that's not too much
> of a burden.

I thinks that's a bit too much for this one.
As you're the firewall maintainer I would need to modify your entry in 
the MAINTAINER file (and I just see that your entry is lacking the 
header file path).
For now I think it is not urgent neither mandatory.
Maybe in a next patch series ?
Even in the driver bus directory there is no vendor policy so adding a 
path like drivers/bus/{stm32/|firewall/}stm32_firewall.c is a bit 
overlapping as with the filename we already know it is ST and its firewall.
Let me know what you think !

BR,
Clément

