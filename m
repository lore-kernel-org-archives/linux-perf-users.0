Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EA022333B;
	Wed, 10 Sep 2025 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757490429; cv=none; b=Y89cPWMVwu5+QySGN4r+2I2vhYyvaKz5C9gYRVUGncK41ShJyiUdmjR/+6C/2zKANpC+cRQzlWdvYduwdbApIxab16MmfNQME+A4/edVF+EsiANjnoBaC0IT0h0XnesE6jix8XlOd3mLn2kx+11P5ROI1AZi6KElQdNlpuTT1ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757490429; c=relaxed/simple;
	bh=liVmnk8QHJ8DU7cSnweepl2EzqreCFPaY8VRfmTnkmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjSkMpYGpvBaQpSmr3Ztxix8AMBp8u/0ONavtf61161eSh9NI74QxpV1K4N3/ON56LKoLP95qPuB0v/Hz0R9HZDyH2oW5U7Qk2hpErgK10RkWYnLsc+xDVxmHrHU7HNZ4pt5CWWGO4K6lufpbBzpzHOm/WTQjvRCAnjCQKsBffI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDeaDYDj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDeaDYDj"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso33222395e9.2;
        Wed, 10 Sep 2025 00:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757490426; x=1758095226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+WG/fOgOed7F+q/vykBWwKRqhGGU2/L6CsAzZkzcjHA=;
        b=jDeaDYDjz8xjZHCBMizgQ4BkC70nHP7JimHG4M+0u/AMZnABpkhXdr6ABNI2GPpl1k
         e8xfK/OkH70QCIjL509W7c3y9P0vvXgW2TapfMMAxdrTe6cG0IBJiRykd7EaHCCl9DhF
         oe1MvjmJakn2bmboZCjAR07KnqEsHBkeLPv08M4b1nVmTn9gsmUOo7KgAM8M/aCMU0Ia
         KfWgsdCmXUtOCe8aVLn4ORA9nnOEMUEeKoxBLjAK1FKcRpF2g1qLUcuT/WBz4m/MxNt/
         MyfTWGoJdOnpkIYMzliRHtB4OImKdEALAEWztjAsnk9TTrNpUVCKMSXQlL+qGP7Ns1mz
         Z+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757490426; x=1758095226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+WG/fOgOed7F+q/vykBWwKRqhGGU2/L6CsAzZkzcjHA=;
        b=g/xMFhr/Q17GQjpB/zN9VGlxAR1cLr4KAzXc86HGHyv/zacEPkCfZgpxe3FiqTzLMX
         5/t4oYQy3oO5r4//TYYeAj9Hw7TH4CQ2ONRYcoX9ng0HKBhXf8yMhGyvlMLGY2KkMars
         Zv30qUf1NM8AtHpO3PR7EbQieKvkfp90GDkl2ILmaKoHOksj1BUoPc+b28xKYeQ6M3oA
         UoZiq9SRNGEEgFQbbhNRiOYgoIb7QxnuJKbyTmAW+3i+SU/YEsTWF21+7vrhh4hTdDKA
         52Q6qTpwX9+l51jo7k6Qc6WfFYygpPsEojXaJzxJ2b4xpMp8xKhTEuMp67KPwjYnFchA
         ZiBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHslPSRcc/NBBqOc97+o+nPYuyRrj1rWy4LQqjmLoXdu3CkLVAQr84GvRx+TubKqZxEyWAj5kjWYV4@vger.kernel.org, AJvYcCX4OJeK6NTc4jKPUpsWrEOTD2JYH3Wbh0s+DO4e9Lc/mDGKDQKqB9aYhOFssHCMt6v752M8/5cK/d1A@vger.kernel.org, AJvYcCXCDnfB49Dqck08tl3lnUs4WCuoCujA44ogLDoqjhGLeBu83GJyReE4OgBryZg7pTRfynOmJXULajSateA7rnnfQw==@vger.kernel.org, AJvYcCXlfJSHpkaOrS/Zo5fMhFq5+aGfBJnzbUjfmOyW1rJI5vBfdBg6WLS3YlpQfwwvTRAxS2zhyzpiXW4u@vger.kernel.org, AJvYcCXqOFGvihM2RqL3H/ZsWwCnKQHKtaUGsLSkcVQsrOyIP8SLHm7zCUfKAUdv7yzZHI0BlOotTpsUhAE072Ca@vger.kernel.org
X-Gm-Message-State: AOJu0YztD7RD+86t3u6lhCapc0A9WrHeGDPPfAtqiU6O8Y+kadbrw1Aw
	KSTPlJvDr9NjFT6qp1AnmB+/yjqgkfrZ/HziG6cLnQPsPCNkfoeIseqY
X-Gm-Gg: ASbGnctDWZAiWa9N1BMSjVz5T/XbG9B3wFbHmyeKU0QkJH+rXr5LM4o9ezawsp4fdK/
	+Ap7xYpcvyySH2uXcVBe9ZTCoO2I3EfDc2VuO9Q37tPfHDM7bPS1CjGhhzYrmv7Zz6xmuDRoE5Q
	iDAIfVnSfI2QJHkg9f1bQBI21zoDzjPtFC9aKBYd86795Y7ezlTbHxiGn4wm2UgThBrLyUE5g5f
	r7j9DeDDtReP7AxkQvm/+HWhWbu5fLDvq1gQgueECzFDqveFrktM0AS7GM3IdBWpb5G7GAJ9/eB
	VD5Riv3IWJdhwUYvr7edtOhAeDSp47zrTQKdr531/0kMu8ufmPUGqil3Zf3ntqn+hLFZwqJ9hXj
	tsAuL2uu0MNoR7nW9zTUJqla06elM5ITy8/+qndf2SFYhrjqlnLZ/Xm8SKGhcyG243hWOUT5+7L
	QpM/b5d9QiZSW4uF/G9qbOhm/fqcXZCYxaVO1gEL/XV2fTb6w1smqV25eXWbSvtyM5rMibNyUn8
	w==
X-Google-Smtp-Source: AGHT+IHCQlyEGA4dQJ+eF6cYPq/TcQfhp+X5TSRzHZoqn+jcag/Ng+LaHLBRVKb0m1OSVaCN+kNKcA==
X-Received: by 2002:a05:600c:4f91:b0:45b:88d6:8db5 with SMTP id 5b1f17b1804b1-45ddde82fc0mr127441425e9.12.1757490425798;
        Wed, 10 Sep 2025 00:47:05 -0700 (PDT)
Received: from ?IPV6:2a02:8440:7135:4f4c:9000:7072:695b:3ef? (2a02-8440-7135-4f4c-9000-7072-695b-03ef.rev.sfr.net. [2a02:8440:7135:4f4c:9000:7072:695b:3ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df821f714sm17367435e9.16.2025.09.10.00.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 00:47:05 -0700 (PDT)
Message-ID: <19e664da-df4c-4bc0-84ce-41e4364f10bc@gmail.com>
Date: Wed, 10 Sep 2025 09:47:03 +0200
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
Content-Language: en-US
From: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
In-Reply-To: <9a46c8a8-1d25-410c-9fa2-267eb4040390@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/09/2025 14:25, Gatien CHEVALLIER wrote:
> 
> 
> On 9/9/25 12:12, Clément Le Goffic wrote:
>> From: Clément Le Goffic <clement.legoffic@foss.st.com>
>>
>> Other driver than rifsc and etzpc can implement firewall ops, such as
>> rcc.
>> In order for them to have access to the ops and type of this framework,
>> we need to get the `stm32_firewall.h` file in the include/ folder.
>>
>> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
>> Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
>> ---
>>   drivers/bus/stm32_etzpc.c                       | 3 +--
>>   drivers/bus/stm32_firewall.c                    | 3 +--
>>   drivers/bus/stm32_rifsc.c                       | 3 +--
>>   {drivers => include/linux}/bus/stm32_firewall.h | 0
>>   4 files changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/bus/stm32_etzpc.c b/drivers/bus/stm32_etzpc.c
>> index 7fc0f16960be..4918a14e507e 100644
>> --- a/drivers/bus/stm32_etzpc.c
>> +++ b/drivers/bus/stm32_etzpc.c
>> @@ -5,6 +5,7 @@
>>   #include <linux/bitfield.h>
>>   #include <linux/bits.h>
>> +#include <linux/bus/stm32_firewall.h>
>>   #include <linux/device.h>
>>   #include <linux/err.h>
>>   #include <linux/init.h>
>> @@ -16,8 +17,6 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/types.h>
>> -#include "stm32_firewall.h"
>> -
>>   /*
>>    * ETZPC registers
>>    */
>> diff --git a/drivers/bus/stm32_firewall.c b/drivers/bus/stm32_firewall.c
>> index 2fc9761dadec..ef4988054b44 100644
>> --- a/drivers/bus/stm32_firewall.c
>> +++ b/drivers/bus/stm32_firewall.c
>> @@ -5,6 +5,7 @@
>>   #include <linux/bitfield.h>
>>   #include <linux/bits.h>
>> +#include <linux/bus/stm32_firewall.h>
>>   #include <linux/bus/stm32_firewall_device.h>
>>   #include <linux/device.h>
>>   #include <linux/err.h>
>> @@ -18,8 +19,6 @@
>>   #include <linux/types.h>
>>   #include <linux/slab.h>
>> -#include "stm32_firewall.h"
>> -
>>   /* Corresponds to STM32_FIREWALL_MAX_EXTRA_ARGS + firewall ID */
>>   #define STM32_FIREWALL_MAX_ARGS        
>> (STM32_FIREWALL_MAX_EXTRA_ARGS + 1)
>> diff --git a/drivers/bus/stm32_rifsc.c b/drivers/bus/stm32_rifsc.c
>> index 4cf1b60014b7..643ddd0a5f54 100644
>> --- a/drivers/bus/stm32_rifsc.c
>> +++ b/drivers/bus/stm32_rifsc.c
>> @@ -5,6 +5,7 @@
>>   #include <linux/bitfield.h>
>>   #include <linux/bits.h>
>> +#include <linux/bus/stm32_firewall.h>
>>   #include <linux/device.h>
>>   #include <linux/err.h>
>>   #include <linux/init.h>
>> @@ -16,8 +17,6 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/types.h>
>> -#include "stm32_firewall.h"
>> -
>>   /*
>>    * RIFSC offset register
>>    */
>> diff --git a/drivers/bus/stm32_firewall.h b/include/linux/bus/ 
>> stm32_firewall.h
>> similarity index 100%
>> rename from drivers/bus/stm32_firewall.h
>> rename to include/linux/bus/stm32_firewall.h
>>

Hi Gatien

> As the firewall header is moved to a dedicated firewall directory,

I don't move it to a dedicated firewall directory just to the "bus" 
directory where the "stm32_firewall_device.h" header file is already 
located.

> maybe it would be coherent to create the same kind of directory
> for the sources as non-buses drivers use it. I can test it on my
> side if you're willing to make the change.

Do you mean create an include/linux/bus/firewall/ directory ?

Best regards,
Clément
