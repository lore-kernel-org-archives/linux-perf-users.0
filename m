Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D033D8130
	for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369388; cv=none; b=elks/UEG/nQ3+uoLKAiI9E6npmLskmeHqXvoH/q2JxwbVA0xzqSKfuvK33agCJ+xlLLWqWzjX/cYJlOsophixKDoy0jtcFnEuA1PIB10NBwtw3/Jh2Xx0ZC3ZIxq05/cZGp0wj2jy7y5bWteOsRQRV85fjfywewMWbPQYUOKVX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369388; c=relaxed/simple;
	bh=SaPZiPenwdTzqGiHu7Uj+sL3JfcCMs0SGRnnVz4i/yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VzgXkzcQ/+HR3NShQs9jE78BO09yHcGXBcDOGLNbDlDrW1uY9GtOhJyIGQCunYD9vscofj9Hj7fCwEorVSTC/uBvOg1hCmHhlAk0PR7/nFGrQ4NdJ37NqXHoGoebroWhmD7a0TMjzlcAO79gYKvJvZHgaMyzmLJ6/sRBrr/uH0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nId4Y6+i; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nId4Y6+i"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bd11a3729e8so966173666b.0
        for <linux-perf-users@vger.kernel.org>; Thu, 21 May 2026 06:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779369385; x=1779974185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RqVGYnj73pC8tzdaFr6gsyXtunlM26AM6XUG51yicB0=;
        b=nId4Y6+iuVJiUKUZVsYGDDRF+POui5/LWGoUhN4nVQyf+jbFs9i+JJ8lYxr+QDKP6z
         RMljv/X9d4TDsd+BEfHXNjecU8ieeePM5JPiu7xo1CvBJTPiqS08/Qy39opzi3uOCUgf
         oy9IbK1qppoUdh2YJmVoSV2DJqYPSijJ298XmAZNlQlIvUYIpXtPbqq+AQKOr26q7Vly
         QG52VeEdL/ez4J7u0Pe8f6uErkwzaP3SWcfOhJ5vx4n0sl7ZQEKWO6K+by9OBAut6Eta
         M5ipzH0zcCxXpJkswih9Ee3K9vPlpbHSjwnXzpQLxvUQbY67nCzIKnYOZ6S9jirqtQa4
         FVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369385; x=1779974185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RqVGYnj73pC8tzdaFr6gsyXtunlM26AM6XUG51yicB0=;
        b=Dea8QfYVV1oYaDeSB1Y2fhPdztH0WjP1pOLW+IucKOu0KFzXo0AtaCV2ntojEdcYjo
         xeM5yM58FGhMk6X9zWEsW8TFUjOSPY67LTVNBcdyJ7YYqNFyYg3nwrxLvZeu6/QgQkDR
         FSYfh2LI0gSTHyosCheA2kSd6amCHxtZTCh7xf4di3qhCE+JBUdRYZ67ANuZdRoCUXlC
         1SJeVE5N5nBPZ7vdID68ZtEWoLXxIPjyM3OZPC6bum7Z5TjSfyFMHoW+0fD/VMNBnqj4
         mjlNGcEuEKqKN/vvlq13Q6L6+/BND9i4pW0a95VcHPQoeTBIFapW0Ahj7ki+G4YQEamN
         DFjg==
X-Forwarded-Encrypted: i=1; AFNElJ/5Gll5BOlKkYzUVx7xEJLgZhHUoBokT2Kr7nAGBtUvShSbCQYS2N9A1Aku8VrLIUv0llYPLhn+wbX4lWlEuMFn@vger.kernel.org
X-Gm-Message-State: AOJu0YwubWa9ApxZkm3wlgunZLl2FaS/YKQQTNRC32deO2wbEJ+0VnOo
	Sb/o7d233/+GERxfarC1ZJ3pYv0QjgbzWGGo0fFXlQE39XhcIDdzJD1RY5yNvNORRUM=
X-Gm-Gg: Acq92OGLKMOfqLhwEtbppEXJCI0gJztH/0JAiv1iNjLa6PaaXu2/IjOYZADCecuf7O7
	4QIaM5hPEGUeEPBYJzsoVxxOmXCMGJKw5HzuZvivoSCSKXfmIy7xJGkvnsAwlRagaOFXMsE3Bc9
	+lEspqjiKaRMOeMFdI9llTJhNK87WrP35puFnWRfriEpKxAucTrLJHQeniIIj7BB55eZZ8ILOVX
	Zi0btn0qnMgbapcHgXblnJdAOjntqBf5zRBu2V9zvcb9Yy3chqKZL1IwXs+D41aDlyN80KW4MW1
	ZNvjYznJ2KMqbhT5Fz2XLkn3E4YTHgCq4Yf0D29mBemTUT4cBwjBr0QjLON6uY4pW5ks4UkReyw
	3z2beFNCQq/T2J2zdo96NOhVKUePx5vl9yteVZDZdjOhdh5nvkb8gN9P2p/bNHp/VD1i3xsqMEU
	SQmItiJOHm+YDxE2U/PVZygMYqhk91WuQNK3Wws2M=
X-Received: by 2002:a17:906:5a41:b0:bd0:6dbe:22b1 with SMTP id a640c23a62f3a-bdc121ba82amr126088266b.12.1779369384498;
        Thu, 21 May 2026 06:16:24 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa92de9asm2799089f8f.17.2026.05.21.06.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 06:16:24 -0700 (PDT)
Message-ID: <e060c4cf-59fe-42f0-bb05-adb520a6c80a@linaro.org>
Date: Thu, 21 May 2026 14:16:23 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] tools/build: selftests: Allow versioning LLVM lld
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: sashiko-reviews@lists.linux.dev, dmitry.torokhov@gmail.com,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 linux-input@vger.kernel.org
References: <20260518-james-perf-llvm-version-v2-5-f12cc4f031d8@linaro.org>
 <20260518093237.90640C2BCC6@smtp.kernel.org>
 <ef5688a7-3e1d-47be-aca7-cc6e564e059c@linaro.org> <ag4QkPOCQ5LWy-U3@x1>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <ag4QkPOCQ5LWy-U3@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/05/2026 8:50 pm, Arnaldo Carvalho de Melo wrote:
> On Mon, May 18, 2026 at 10:47:53AM +0100, James Clark wrote:
>>
>>
>> On 18/05/2026 10:32 am, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>> - [Medium] Empty USE_LD variable causes clang build failure in selftests when ld.lld is not in PATH.
>>> --
>>>
>>> commit 371ca22c55bb0fa6502ac06f7b33d63418ad16ff
>>> Author: James Clark <james.clark@linaro.org>
>>>
>>> tools/build: selftests: Allow versioning LLVM lld
>>>
>>> This commit adds an LLD variable to Makefile.include to allow versioning of
>>> LLVM's linker, keeping it consistent with the rest of the LLVM toolchain. It
>>> modifies the BPF selftests Makefile to resolve the full path of the linker
>>> using the command -v shell utility.
>>>
>>>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>>>> index 6ef6872adbc3e..836e783f0170e 100644
>>>> --- a/tools/testing/selftests/bpf/Makefile
>>>> +++ b/tools/testing/selftests/bpf/Makefile
>>>
>>> [ ... ]
>>>
>>>> @@ -245,9 +245,9 @@ $(OUTPUT)/%:%.c
>>>>    # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
>>>>    ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
>>>> -LLD := lld
>>>> +USE_LD := $(shell command -v $(LLD))
>>>
>>> Does this cause the build to fail if the toolchain directory is not in the
>>> system PATH?
>>>
>>> If a user explicitly specifies the compiler using an absolute path like
>>> CLANG=/path/to/clang, but does not add the toolchain directory to their PATH,
>>> the command -v utility will return an empty string.
>>
>> If they don't use LLVM= and use CLANG= with an absolute path then they need
>> to set all the tools with an absolute path. That's the problem that setting
>> the path with a prefix for all tools with LLVM= solved.
>>
>> I suppose this could _technically_ be a regression, but so could adding any
>> new build rule that added a new tool that wouldn't be set in someones
>> existing build command. Being that strict would mean we can't ever add new
>> tools so I don't think this is an issue. And I don't think there's a way to
>> solve this and also respect the documented rules of LLVM=
> 
> Hey, this touches several tools and libs, did you get acks besides the
> one from Ian?
> 
> - Arnaldo

Only the build bpf failure report from Ihor on V1 but nothing from 
anyone on V2. Ihor did you get a chance to look at this version?

Thanks
James

