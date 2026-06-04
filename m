Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231214014A9
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576834; cv=none; b=EZIdsspZU9Rwkn1A8ZZZlXK5XHBgwFpofem8ynvE2Ebn68F5Ulu4AVg9sv5gzg8DgfU1+1CTNZQk5aPvu/9RIC/NVCLZv2D2bmvJn+9sYuuU+aQkhVxHwWtYCy8HG/u0cj9EEfWypKuQtsVXy3lDH8Sa+IE+stOGOoNL4yAgTHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576834; c=relaxed/simple;
	bh=Ftd+YG3sEeWMP78XhG0ocT+UAv8kkpARDu1rkCQwGaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajAZJBnnSIXLgMQQakErLcqxpj6gZ8NYbR3qLtbY5oFpxhhv7qrXIBJ2urjqH5Q9K1K/EmEgoQWvasmR8yVBkB4wFU0ulP7NNKUWqY85lCfNr9+GzksDix73o2RKcCe3VuRIZ1SkgssmzfENtnW4zp/Ti+kZbmRbWYZbrO0mITs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UwrMX6By; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UwrMX6By"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bec43ee8ff0so91929566b.1
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 05:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780576830; x=1781181630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7nepo+Dy1VgfNR5G5jDP69Ut+DDs0u8dlV5QSB+0g0=;
        b=UwrMX6ByQERSp5Wxn/Wg3OuDrhUZ11iI7xmSbY+vIxn5xcPDzwCpIpERerQ9C/E8u3
         DFjq97+6O1cf2GEfMqT9YozCvbC58S6dEQ5yapOD9PeeEFeyvpRllcXWAGoqGE1HXPhx
         fHDyubU28TVSookkE/O8pn5Sj7NzwBc5uWvdwQS7Kpc6PJdp/tduWCQ4rjn1JZj0ZYou
         PxkdXeEbz5QzOpPnQkqguwLEtFVoRdgUEv3IXwCJyyyaX9r2h9oUNd8izgvDkRjQOKo2
         1Q6Pqh9sssRyUNHHB3G+NTG+5BSXhCPbtftViRsenbwDfXZ0JJVpWqE77/wTxUs0ldLZ
         UdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780576830; x=1781181630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7nepo+Dy1VgfNR5G5jDP69Ut+DDs0u8dlV5QSB+0g0=;
        b=XLJAiQ4zlYvAF+Ffw8u/tv+WnsQgFgHr+7M65csEduXnlNm9969T0kxC04fDPhDlga
         veEXBauyXL8N0lSlnDEvxgBA0TB7lV9Q6Y3TkmYKHvlOiarS61YBfYypG0drPl5XGD2u
         c/pJXj3cPKgibGuUcQNpM6XQuPFkVgGjeCkBmzff9+ngJR2Yj8htaLb54DMFwM5JB5it
         yhM0RnVRHxIsBXGwGXLibIjnBdWWpKaDjCl73Y5Tc4a953NeY4w20zt4wA6Ifq0r1tpg
         pY7tfYZI89okJm7UxzaM/Gy+MpqrubrPtK9YUp1iFhafsFc5BzvD26RmYT0xnXhfT4dp
         wlmA==
X-Gm-Message-State: AOJu0YxDcmozog0vAwn1PigfR+rK+4dQbXxklgKtDZJ5lgKgGo7yOhDS
	GFzerf+wfu88oIAhZ0K5JR9W3kmbXsAdXPE0zafpjyG94bNGlTnKqgOwS5CgN+DNDdUXYv2SDxu
	/GRp97oo=
X-Gm-Gg: Acq92OFrH6BavvfVwEBSG2y1JUAeJWTeRJHqhvKeR0FKJGVWKpqXFVbdrnmI5qEsIB2
	aX3Msh2RZSwGPZaxneRM2LngTrBF/ZbromU3n2YfY4vfixrcpJ3UhheBZY/6Bm/JUgTcFk6kavl
	BUonK1qLwtxgglyp1Hqms4ZA/+dd8hUAMWrF6S4YsvXM87ThO7w4+/AUPmRFl02B7jxqbW19+ID
	G/BXUDx3GvXb/CVq8KVsnggVNXkJw26Kz6Vcfd9XmG+TZhhvKgm1Hc+SNvRTE0eJQ0OdaTEsz2g
	/p6s6sWzsE244X0laidA9TCiWjb7aI0UobU1BLNBJOhA/we4ng9odE39nPDrSyWJgoxd4Be+Hk5
	LLw8GzqRd9Yan3AaI5zeCvdvYUkWQiJ+LScejurMC9H+3uOUpKCiHQMsaXw4g0emRTx6R3GipX4
	a3lrY+x7Bddu3DMNr1tQY+KvQDskD/4lVrZBxxnW0KwSYnIBCbug==
X-Received: by 2002:a17:907:8d8e:b0:bec:4799:3ee9 with SMTP id a640c23a62f3a-bf1d159d3f1mr177831566b.5.1780576830383;
        Thu, 04 Jun 2026 05:40:30 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051c8d3f1sm304115066b.17.2026.06.04.05.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 05:40:29 -0700 (PDT)
Message-ID: <7e740cb7-f832-40da-8e37-9824dbf88e72@linaro.org>
Date: Thu, 4 Jun 2026 13:40:28 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/19] perf test: Add deterministic workload
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260603-james-cs-context-tracking-fix-v3-5-c392945d9ed5@linaro.org>
 <20260603102459.1DA691F00893@smtp.kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260603102459.1DA691F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/06/2026 11:24 am, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Signed integer overflow in 'dt_work' multiplications.
> --
> 
> commit 89c17c87c140a5545531995cc6d206a8c6fffd71
> Author: James Clark <james.clark@linaro.org>
> 
> perf test: Add deterministic workload
> 
> This commit adds a deterministic workload to the perf test suite for testing
> CPU trace decoding. It introduces a new test file that performs repeated
> multiplications on a global variable to ensure a predictable execution path.
> 
>> diff --git a/tools/perf/tests/workloads/deterministic.c b/tools/perf/tests/workloads/deterministic.c
>> new file mode 100644
>> index 0000000000000..3caea8564043c
>> --- /dev/null
>> +++ b/tools/perf/tests/workloads/deterministic.c
>> @@ -0,0 +1,39 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <linux/compiler.h>
>> +#include "../tests.h"
>> +
>> +int dt_work = 1234;
> 
> [Severity: Medium]
> Will this signed integer overflow during the repeated multiplications?
> 
> Since dt_work is a 32-bit signed integer initialized to 1234 and is multiplied
> by 7 repeatedly across deterministic(), function1(), and function2(), the 8th
> multiplication operation attempts to evaluate to 7,113,764,434.
> 
> This exceeds the maximum signed 32-bit integer limit of 2,147,483,647 and
> triggers undefined behavior in C.
> 
> Could dt_work be declared as an unsigned int instead? If the perf tools are
> compiled with Undefined Behavior Sanitizer enabled, this signed integer
> overflow will cause the test workload to crash.
> 
> [ ... ]
> 

Will change to +=


