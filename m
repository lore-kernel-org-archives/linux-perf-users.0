Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8838538736E
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126811; cv=none; b=WB0nnGwvupZCP7UfJz3DfvuP6rPxwEkP/RgWe/ZmH07Q7b4NtAoca2Jx44UE/goMe3+oBpsNhPswzagjtR8/jHvE9/bdcBrxJegvfAvulTULm7SSoyTfnH/Ksvm3fa94cYgkM5P+hl1HzmnyY8EYvR+dT7YJAmvCFvOIM7va1eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126811; c=relaxed/simple;
	bh=mo64BaUYAihjdcVVKQcSfM6eK8LWt+arXGZ+s8lWgfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxvfMtOIIMtlvBRQdxuu6DyiIS9Jv7Ee1vGAxujwQpX9+rggSEkUFQPKrLBl3rG9ojFjGDJjDgX1tEK7jgCXzk+xofdyYFURIts0UlY+RsAaNMScmBlaj+WyfYfpf3YLE7zsh7n1m8AtJI353HEFYJ62vdm7gUQ3cU0HR5tHJYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wm0338i7; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wm0338i7"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15e592da74so682306066b.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784126806; x=1784731606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xqdxpiRH6Z2ScU/4HRU79Jz4czUFiYR0vIxP6WbDz1c=;
        b=Wm0338i7irtGkRSuNQvmQHZWfN4mOL3eE83FtdJlP4x0/0bjfgwPnPYeP4cCxPrkk6
         rrV+2wOtsOwaWdLfJOurOKJqcORt89jQGO3kQ4DLMVAI/RhTujm+H4zmR3IINt71swvR
         R6TAbD+jLK9uUW4wvWyQT73zhNPj6OQd3WjLGsYtDmuB0SXmCB9OwZSbQ+gTphqOtCBe
         BW+iy6+1d2vuvJFq901J32wk81APqGB2n7ItuDJk8lRhG7sn/S9IO/uebkXfMOIen1QR
         RjPxgarqxgmirS5yXXCr70dXq7pXuyI8df3ftS0ojqzC2gUdv6J6Y/lnVOCoDhCUc6XT
         x92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784126806; x=1784731606;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xqdxpiRH6Z2ScU/4HRU79Jz4czUFiYR0vIxP6WbDz1c=;
        b=GLnbyrWENIz3+nohMWP+/m3c2dR1bTfP8v54XI2HyzVK6qth+tmZCmmajNfrFmX8lo
         /gnUooACNnEmWnh8/lWRmw+/OSm1ELL6ZpVyp2bbyeDyWegkWeSz/yrZZm2WshhcbFuc
         fhuFcr3+lXpisPL+894cFtX3vX+mjn9aVfT4axXivi9OQ1DfoIbUWxC2JPoCA35nUOJF
         qln6HH1jpCWsXOGnJRqFGstE6jMi7EUTSb9itfkDdKCWUYb9kOZrKhlXiu9Yem9fuHUu
         d5hjKT2tKaxjNhotFlbLd7b6HptZYfd71tccU0g/hrkPlUd/js9henR+/NR8LXSqzYbb
         SKvw==
X-Gm-Message-State: AOJu0YwNGrkpVCeID6HLaqiyrBnoNOYIpliVDidXVctl9yhiQjFdLx4V
	qhgJPbLjajXlx49RlBgfbz9qAstlif6f/GyenkMDyD5bjkghkeRW0tGoYmvZTHO2pNw=
X-Gm-Gg: AfdE7cmX+4IKTPqGRsOe59FvsO6CnIXWItdHiDWYDRUgX0D/s9y8f7gWOsHTcmY21t8
	Foswau5JsqiNdXfzqQ4xIFaIcSfE0F096mGjxZq0Q9g8wNEhOEEbrawg5j0MZ1oqk/C1rxr+X4Y
	io5a4n+i53i7GOo0fXjzsrQsWqv9+uL8wpy+A5C9K87zED1clPWDwn37xQpJg3VVnSYCkX7438Y
	oesAXQcy5qqxK3rDJjdKuntFaeNLK8mAOA7Pp/wTTcsasObjpMK2IZgm5M7xgfp+hIeYFuCUBJ8
	05NRuXGt00RM8eiJmiN0X82Uag4Y931EoQxAVpLXXQeyAfxkzg6BTOEcNoTjVwQpQfQn2Z7qBOw
	ORagGusbAI9lIYirpBW/Sl54+tF1rmACWgQHs+11gxFpPT8AMV9cUE034EqSSqnsHzcMUptZfJW
	xAnh+e4EidqUeLjTAeEN4yozU=
X-Received: by 2002:a17:907:9451:b0:c16:7402:1abc with SMTP id a640c23a62f3a-c167949a4ccmr216570466b.47.1784126805726;
        Wed, 15 Jul 2026 07:46:45 -0700 (PDT)
Received: from [172.27.236.118] ([212.187.182.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c16873187absm45796466b.38.2026.07.15.07.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 07:46:45 -0700 (PDT)
Message-ID: <617b1d89-35f5-4dee-9aeb-eac7a0d34d38@linaro.org>
Date: Wed, 15 Jul 2026 15:46:44 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] tools/build: selftests: Allow versioning LLVM lld
To: sashiko-reviews@lists.linux.dev, Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
References: <20260715-james-perf-llvm-version-v3-0-8854bfe5af7e@linaro.org>
 <20260715-james-perf-llvm-version-v3-4-8854bfe5af7e@linaro.org>
 <20260715124513.8DA9E1F000E9@smtp.kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260715124513.8DA9E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/07/2026 13:45, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Bypassing Clang's internal linker path resolution causes silent linker version mismatches for out-of-path toolchains.
> - [Low] Unbalanced parenthesis in the `USE_LD_ERR` error messages.
> --
> 
> --- Patch [4]: [PATCH v3 4/5] tools/build: selftests: Allow versioning LLVM lld ---
> commit cdccb2d14502b0641ebfd4e8ddb945bdb605ed46
> Author: James Clark <james.clark@linaro.org>
> 
> tools/build: selftests: Allow versioning LLVM lld
> 
> This commit updates the BPF selftests Makefile to use the LLD variable
> from Makefile.include to ensure consistency with the rest of the LLVM
> toolchain. It explicitly resolves paths to the linker via shell commands
> and passes the result to clang's -fuse-ld flag.
> 
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -264,30 +264,34 @@ $(OUTPUT)/%:%.c
>>   
>>   # LLVM's ld.lld doesn't support all the architectures, so use it only on x86
>>   ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 riscv))
>> -LLD := lld
>> +USE_LD := $(shell command -v $(LLD))
> 
> [Severity: Medium]
> Will this shell resolution cause silent linker version mismatches if a user
> builds with an out-of-path compiler (e.g., CLANG=/path/to/clang) without
> setting LLVM= or modifying the system PATH?
> 
> Previously, passing -fuse-ld=lld allowed clang to natively resolve the ld.lld
> binary relative to its own executable path. Bypassing clang's internal linker
> path resolution with `shell command -v` might cause the build to pick up a
> system linker (like /usr/bin/ld.lld) instead of the bundled one.
> 

I can just drop this patch. I assumed $LLD should behave like the other 
tools, but it's only used here where the compiler already picks it's 
sibling linker with the correct version.

>> +USE_LD_ERR = linker '$(LLD)' not found - add it to PATH, or pass LLVM=/path/ or LLD=/abs/ld.lld)
> 
> [Severity: Low]
> Is there an extra closing parenthesis at the end of this error message string?
> 
>>   else
>> -LLD := $(shell command -v $(LD))
>> +USE_LD := $(shell command -v $(LD))
>> +USE_LD_ERR = linker '$(LD)' not found - add it to PATH, or pass LLVM=/path/ or LD=/abs/ld)
> 
> [Severity: Low]
> Is there also an unbalanced closing parenthesis here?
> 
>>   endif
> 

