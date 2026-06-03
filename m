Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7807C480DEC
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492242; cv=none; b=gjeo1PBT7xaF2OzoboF0yiqdi3+Ydn8/bESmu2iNKcZkU3F/q1Ubqi1mPoCSXKd/6GpYCgrA8J75LjHbeUnFJ9UR1ClcYAcIiq/Troi8GU9nz1hv7fM0tkhq+OgkzbK+LHlgDoDAjkZMfCaY2dA4tpiBw0Bo4pJE926Ds04cWZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492242; c=relaxed/simple;
	bh=DA2FW+m2bWueyUDMLsGb7KZj+YBbfbYQwznE2VUZHeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=arf2aJhmc0sEPjjIc1UXz2e0rdAabRUVfvAHItTeutdOLq4mc88zhOjo2s6TiOvF5Is726/x1sEFryMelnejRGETI4JO7cS1T1TI3ihFtyXZ+umYZ4AlFwSorIfGLHPyyusZjqMR7vYkFkqj7OYBHBNSMKA3CtjHXJZSJO2+NjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tzOZ5zSw; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tzOZ5zSw"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bec43ee8ff0so111247366b.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 06:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780492239; x=1781097039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X1Ude0q8UJNEq/jv9daxrUZHrb0trlAcIj1CVfNsKe4=;
        b=tzOZ5zSwVVEsQSIcpKmLO1Z47lE42mK5pFQSe8jtORpBnPY/hute9iWahmsiIAmGV1
         OrjVeFrqPgaSXPXiV92pmUj/Kc67Wo9wK0E9asWP0yJf05LrbFM4CHFX6+wjKIKb8d+e
         v/paP1p/I4CiwvoAt7lSnAIYXHBamY8cOSqgYFu2+2Pg8XVnQWbUDWtNKiZmVM8aLAuS
         Ef6/InC8nNsu2D4ZSmR0R4FzQNUmefTb8reqLWDfJQ6GqKnHfjbQZxM2guWOZyy5umnL
         H6xg313ByCl+bsbcneWHPVae38sEMxokG1iwSsvlOjsNYLlhgqqaZ6Qb3Ka0Tq4gcrwA
         E+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780492239; x=1781097039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1Ude0q8UJNEq/jv9daxrUZHrb0trlAcIj1CVfNsKe4=;
        b=nQyzVdLF4Ps1lRDEtC0krFGze4pfqvzaBUfpnRM68I9BFWPiYgX0W0meLihNb1Pd4x
         D/v4Wk1eiYVO7Bll1qVfRIKELHe78Q+GojKdrl6b8S98Z5TXKHiQkKopUGS0MkRvIJan
         1zVNhXusDmcgwdef/xxjW8Y4bkmDYWR+zDW0pYG4s0IOZH+LQH7QvxH5cUC9tdvwkRrX
         Fa/w0pe8iwQkx8nImKUyxgeVPjWvfn0KFc3o8+eWZF7Od1l2JGTxWRB45bHyrg/f3ziS
         kE1nEmJaJ2isycYCp0vsTGOf/FRXZTqvdWbNa79yjIgJ4ybbypIadr5MSxZgthU2BYss
         Lj6w==
X-Forwarded-Encrypted: i=1; AFNElJ/ZhQA+ktey+btdg0KwIvh5tc5o4qUS9wIuGQ/t5MuW7ZzckZfqttNj1OZTEUEJaOMzRFFMhodGhoQ4yyQXDZAj@vger.kernel.org
X-Gm-Message-State: AOJu0YyAVGmWCxVoQ18J1bSaDbZcwEKgHQJUBOnBUUMv7spDAb1EBfFQ
	pglFn4cdfx0lTFkgOrAiHad2w+47FOpHyFRiS5ptkbnz8UVN3ndFqvrF2YlX8rKcQU8=
X-Gm-Gg: Acq92OERj/PuWlNoyGBZlJn9fJlXyHp0+BEvB+eBg4x9btyf0ojhY0edsCKssEmtfc3
	hrpqzs7pp21Leydx9IdTgPM3KG7kCytFItSK/jfNO/zghklLv6E/bQuxA2Gm43riV8dR/WFGsEX
	ilUI3EwfgOnR3qk7sEh0Oa0yepih0VY79gQqR8GBGp34gl/hTTETsNV9m7e+kRplEXOGzHw5Z4y
	9j+3Yh23imO/I0M1FLRxSOvsFQxXq7Z2RtYPT4b0/MFWkUNls2wDmgn6Vd4wVzf8MAvRUCR6Qil
	hKXk+Lj2y7m/Ky8ukyFp55xkd0xt+i6suePznfGh5JXKGjvLlPbKIy7xoFr8spXwXpJrRkefuaC
	DhSOJYsN8F0VmSC8mFJHq9efINUJzfE654LJCm5kEbGwbG+ZpQpMGdVNtsC2kpOTxSnsmIMfMZk
	CJFlonMaMlXacDoIwTy/LUW3kMFlPrX1O04synSgA=
X-Received: by 2002:a17:907:c783:b0:beb:4d05:9a0a with SMTP id a640c23a62f3a-bf09ea5e71fmr166944866b.15.1780492238789;
        Wed, 03 Jun 2026 06:10:38 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0517714c5sm155160966b.2.2026.06.03.06.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 06:10:38 -0700 (PDT)
Message-ID: <b4836fe9-49cf-44c3-96a9-548e890cee29@linaro.org>
Date: Wed, 3 Jun 2026 14:10:37 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/18] perf test: Add deterministic workload
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Paschalis Mpeis <Paschalis.Mpeis@arm.com>, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-5-85b5ce6f55c6@linaro.org>
 <20260603112742.GT101133@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260603112742.GT101133@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/06/2026 12:27 pm, Leo Yan wrote:
> On Tue, Jun 02, 2026 at 03:26:47PM +0100, James Clark wrote:
> 
> [...]
> 
>> @@ -22,3 +23,4 @@ CFLAGS_brstack.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>>   CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>>   CFLAGS_traploop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>>   CFLAGS_inlineloop.o       = -g -O2
>> +CFLAGS_deterministic.o    = -g -O0
> 
> I have no strong opinion for using 'noinline' in source or using the
> global option '-fno-inline', just thought this is not easy to follow
> up if anyone (likely myself) will write a new workload for disabling
> inline. Could we have consistent style for this?
> 
> For the patch itself:
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>

Actually it's a fair question why some have -fno-inline and others do it 
in the code, it could just be copied from when these were built by their 
shell script tests. From a quick look I would say we can easily drop the 
-fno-inline and do it in the code, and it's better to only noinline 
what's needed rather than everything. But that's probably a change for 
another time.

That leaves the only custom build options as the ones that force -O0 
(which also requires U_FORTIFY_SOURCE), or force -O2.

