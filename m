Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603BC3DEAD5
	for <linux-perf-users@vger.kernel.org>; Wed,  6 May 2026 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778056759; cv=none; b=XX9oPAshjSjAbObppBWbM1hW0aujxEijniDzf+iTeiNpeNmARG589FVrriWl/hQ7PzrmdXUCro/ogx08Oow/u/cM3zF1VtvkcUQVX1wRmZfZXIFbJYSnaeRwp7bc8qkVHT/Wd0LpkMlyR218R4q0yqtXLUmSKSjOFVh+b0ddr4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778056759; c=relaxed/simple;
	bh=jPnn5eOshVnTAE0HzHPeyZi1RtOw8h/dICMJs4ir8VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=slHQjWLg+6kFF8acr3nUXRWNZbnqd3Gp3lycWEcF8ft9WpSuvuuCGm9hy53Yh2xfLiwL8mKK766mMUYFe2kXqHGtTqUjXjB+uH+J25YnumwTapEBbuaFAA7NnzTFomeNjGd2aYNQZbBkMLzADFzLeZ20kAcRK4jUntvEmpxNb68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yyLyrIBZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yyLyrIBZ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48374014a77so72532915e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 May 2026 01:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778056757; x=1778661557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r56h6iHeav2WDOnQRjlv49afSUKkQLIIRf5+ICv8rrc=;
        b=yyLyrIBZYYdRmtHe704VGB36h2noo0H9Eg5l+kzBJoSf9J/RNuEFMnctH2JBECD1tb
         XYQ+/98E+cDyRoUcUPz8GBKSJZuJCJyFrZ2veZotWFbGz5I7LW4L8jslYKfutcO6OPC+
         0U0RnWHQ/lmuR+7EpYLAU1UZCuEz1Pm89cjvJBaeM/xgLgriAJpaW/ryCPLbxSRQCYnl
         E4/efP5+m/38YolrjdzuEq7cweqInDpzTeQsv/Dnm+ERWxnhPisn8mN7OE2IrudmL2yK
         4QlWn5b/hSGWSPSJCVw3JuE04VvXoko84YIGTk3B1RPTnhMArhpT8QhaI5tOOrvgBv7c
         lz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778056757; x=1778661557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r56h6iHeav2WDOnQRjlv49afSUKkQLIIRf5+ICv8rrc=;
        b=rSj5gGT1GEV9K4twWDvmdKBiB2OGcvaEP49PMVIvrsRtow60Y211AIs3bKZkL/If0e
         R5vGpsBB4J91DVepcZ093aWqg6AdlRgdcYfdGU/CuW1/sfjo2ngCQCZWa0Dd3ZK18axG
         DdTcWzPcmGsCi6sLvh9pt4R8hKj3UnyqEasoDjI1183x+cdI5j1IBWD8s4c8bFPf2fP8
         PfO6pKAfitFMocBmURrko+9kGiOEU0tGrzGR1w5v8CRmqOedo/HO92GznbTH3MuYtZYM
         E0slsCjTCp/qucwx4NiELgNHk2hsl2ZTioDRsOAmzJu57+Fzcb8QAnmsjHHZ4XOM5/76
         ol5g==
X-Gm-Message-State: AOJu0YwObVSD6wXroMILuH4j6xIUvUvU4OPPhAUOooKJcIFf1ZiBzhwh
	TSwh0RH6N5Gx62CCuucAZXB0Xc1ZwCUva4bM0Bz7Rzdl2nnZiw70VSPC832ozdg4PH0=
X-Gm-Gg: AeBDietwO5xoe7HmVKj5zt97+EBVt8e+gPE41Q78YyvkpLrY3wUd7U74In9Q38eKqDs
	XPJt8+WENszlx2sDP9vndoh1EGodj1TPw3vr2qRb2HtCcyJ+OdWAg8rINeKlWNAagfeppYFnGr1
	wN6smF33cEQiorVa7su37/CUEDSTCYMooqFfd+rdWQIIUnP1iY3TnEf9j3YeLqWiICoVhMhM6rQ
	DXht7VANIO/j8z1LxggP5KnrLnkdkwOkvQPFXYnq0pOFPFndS7Bh5whtcwPWUGPIEfHDYZn8JfD
	Q+0iRG4NwZeK6is+EL5tzOztL0rVim++TYFkkbEFTU7iCt4EQ95ogn0XCgbhBR1vpADSOKlfj3g
	X6FzotMNS1VJpiO1+Xg0ygGk3AuuIzyfTwypJFuee1RgBw8R5UQ+3nReujjeifX9Jp82q7H7tmt
	fenZd669k60oAkqLPnSO/DkqDVmoAEYJbJ1SHegfc=
X-Received: by 2002:a05:600c:4592:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-48e51f3c4e5mr42056335e9.21.1778056756748;
        Wed, 06 May 2026 01:39:16 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538acbfcsm28776935e9.8.2026.05.06.01.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 01:39:16 -0700 (PDT)
Message-ID: <1ab49484-b307-4568-a2af-60b015556e9a@linaro.org>
Date: Wed, 6 May 2026 09:39:15 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] perf arm_spe: Decode Arm N1 IMPDEF events
To: Arnaldo Carvalho de Melo <acme@kernel.org>, sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260414-james-spe-impdef-decode-v4-5-1dd30783a33b@linaro.org>
 <20260414155203.0B24CC19425@smtp.kernel.org> <afqTBBXcPmobSCu1@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <afqTBBXcPmobSCu1@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/05/2026 2:01 am, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 14, 2026 at 03:52:02PM +0000, sashiko-bot@kernel.org wrote:
>> Sashiko AI review found 1 potential issue(s):
>> - [Low] The relative include path `#include "../../arm64/include/asm/cputype.h"` is invalid and relies on accidental directory traversal through a compiler `-I` flag.
>> --
>>
>> commit 7fc153524fe60dc6d6f08fd73b7ea3f46e904e39
>> Author: James Clark <james.clark@linaro.org>
>>
>> perf arm_spe: Decode Arm N1 IMPDEF events
>>
>> This commit adds a framework to decode the N1 IMPDEF event for Arm SPE,
>> which isn't covered by the common list. It also increases the packet
>> description buffer size to accommodate more strings without falling back
>> to a hex dump.
>>
>> Link: https://developer.arm.com/documentation/100616/0401/Statistical-Profiling-Extension/implementation-defined-features-of-SPE
>>
>>> diff --git a/tools/perf/util/arm-spe-decoder/Build b/tools/perf/util/arm-spe-decoder/Build
>>> index ab500e0efe244..97a298d1e2791 100644
>>> --- a/tools/perf/util/arm-spe-decoder/Build
>>> +++ b/tools/perf/util/arm-spe-decoder/Build
>>> @@ -1 +1,3 @@
>>>   perf-util-y += arm-spe-pkt-decoder.o arm-spe-decoder.o
>>> +
>>> +CFLAGS_arm-spe-pkt-decoder.o += -I$(srctree)/tools/arch/arm64/include/ -I$(OUTPUT)arch/arm64/include/generated/
>>
>> [ ... ]
>>
>>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>>> index 67ca356100e53..b74f887a48f2a 100644
>>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
>>> @@ -15,6 +15,8 @@
>>>   
>>>   #include "arm-spe-pkt-decoder.h"
>>>   
>>> +#include "../../arm64/include/asm/cputype.h"
>>
>> Is this relative include path correct?
>>
>> It looks like this file is located in tools/perf/util/arm-spe-decoder/, so
>> the relative path resolves to tools/perf/arm64/include/asm/cputype.h,
>> which doesn't exist.
>>
>> It seems this only compiles because the newly added -I flag in the Build
>> file causes the preprocessor to resolve the include relative to
>> tools/arch/arm64/include/. The path then inadvertently evaluates back to the
>> correct file by traversing backwards out of the include directory and diving
>> back in.
>>
>> Could this be made less brittle by relying directly on the include flag,
>> using #include <asm/cputype.h> instead?
> 
> This is just a possible improvement and not strictly a problem as the -I
> is structured today, so lets not postpone processing this patchset
> because of this, this can be considered some other time.
> 
> - Arnaldo

Yeah, we also discussed it before here: 
https://lore.kernel.org/all/adiB0V6Unmo0-AkC@google.com/#t

I thought sashiko pulled previous patch versions and other context, it 
would be nice if it read the discussion threads too. Maybe one day it will.


